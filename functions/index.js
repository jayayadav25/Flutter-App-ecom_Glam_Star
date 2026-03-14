// functions/index.js
const functions = require('firebase-functions');
const admin = require('firebase-admin');
const sharp = require('sharp');
const os = require('os');
const path = require('path');
const fs = require('fs');

admin.initializeApp();
const db = admin.firestore();
const storage = admin.storage();

const THUMB_PREFIX = 'thumb_';
const THUMB_WIDTH = 400; // px, adjust for your thumbnail size
const THUMB_QUALITY = 80; // jpeg quality

/**
 * Helper: build a publicly consumable URL for a storage object
 * (works when storage rules allow read or when clients call getDownloadURL()).
 * We build the "alt=media" URL; note this returns the file content directly.
 */
function buildPublicUrl(bucketName, filePath) {
  return `https://firebasestorage.googleapis.com/v0/b/${bucketName}/o/${encodeURIComponent(filePath)}?alt=media`;
}

/**
 * 1) Storage trigger: create thumbnail on image upload
 *    - Trigger: functions.storage.object().onFinalize
 *    - Behavior:
 *        - Ignore files that are already thumbnails (detect by prefix)
 *        - Only process files under /products/{category}/{productId}/...
 *        - Create a thumbnail file named thumb_{originalName} in same folder
 *        - Set caching metadata
 *        - Update Firestore product doc products/{productId} -> set thumbnailPath and thumbnailUrl (if possible)
 */
exports.generateThumbnailOnUpload = functions
  .runWith({ memory: '512MB', timeoutSeconds: 120 })
  .storage.object()
  .onFinalize(async (object) => {
    const fileBucket = object.bucket; // The Storage bucket that contains the file.
    const contentType = object.contentType; // e.g. image/jpeg
    const filePath = object.name; // e.g. products/women/abcd123/hero.jpg

    // If no filePath or not an image, exit.
    if (!filePath || !contentType || !contentType.startsWith('image/')) {
      console.log('File is not an image, or no filePath/contentType.', filePath, contentType);
      return null;
    }

    // Avoid re-processing thumbnails
    const baseName = path.basename(filePath);
    if (baseName.startsWith(THUMB_PREFIX)) {
      console.log('Already a thumbnail, exiting.', filePath);
      return null;
    }

    const parts = filePath.split('/');
    // Expect: ['products','{categorySlug}','{productId}','{imageName}']
    if (parts.length < 4 || parts[0] !== 'products') {
      console.log('File not in products folder, skipping:', filePath);
      return null;
    }

    const categorySlug = parts[1];
    const productId = parts[2];
    const imageName = parts.slice(3).join('/'); // in case nested folders or multiple path segments
    const thumbFileName = `${THUMB_PREFIX}${imageName}`;
    const thumbPath = `products/${categorySlug}/${productId}/${thumbFileName}`;

    const bucket = storage.bucket(fileBucket);
    const tempLocalFile = path.join(os.tmpdir(), imageName);
    const tempLocalThumbFile = path.join(os.tmpdir(), thumbFileName);

    try {
      // Download original image to temp
      await bucket.file(filePath).download({ destination: tempLocalFile });
      console.log('Image downloaded to', tempLocalFile);

      // Resize and create thumbnail using sharp
      await sharp(tempLocalFile)
        .resize({ width: THUMB_WIDTH, withoutEnlargement: true })
        .jpeg({ quality: THUMB_QUALITY })
        .toFile(tempLocalThumbFile);
      console.log('Thumbnail created at', tempLocalThumbFile);

      // Upload thumbnail
      const metadata = {
        contentType: 'image/jpeg',
        cacheControl: 'public, max-age=31536000', // cache for 1 year for thumbnails
      };

      await bucket.upload(tempLocalThumbFile, {
        destination: thumbPath,
        metadata,
      });
      console.log('Thumbnail uploaded to', thumbPath);

      // Compose a public URL (clients can also call getDownloadURL())
      const bucketName = bucket.name;
      const thumbUrl = buildPublicUrl(bucketName, thumbPath);

      // Update Firestore product doc (if exists) with thumbnailPath and thumbnailUrl
      const productRef = db.collection('products').doc(productId);
      const productSnap = await productRef.get();
      if (productSnap.exists) {
        // only set thumbnail if not already present (or override if you prefer)
        await productRef.update({
          thumbnailPath: thumbPath,
          thumbnailUrl: thumbUrl,
          updatedAt: admin.firestore.FieldValue.serverTimestamp(),
        });
        console.log('Product doc updated with thumbnail info for productId=', productId);
      } else {
        console.log('Product doc not found for productId=', productId, ', still uploaded thumbnail.');
      }

      // clean temp files
      fs.unlinkSync(tempLocalFile);
      fs.unlinkSync(tempLocalThumbFile);
      return null;
    } catch (err) {
      console.error('Error creating thumbnail for', filePath, err);
      // attempt to clean up temp files if they exist
      try { if (fs.existsSync(tempLocalFile)) fs.unlinkSync(tempLocalFile); } catch(e){}
      try { if (fs.existsSync(tempLocalThumbFile)) fs.unlinkSync(tempLocalThumbFile); } catch(e){}
      throw err;
    }
  });

/**
 * 2) Firestore trigger: cleanup storage images when a product doc is deleted
 *    - Trigger: functions.firestore.document('products/{productId}').onDelete
 *    - Behavior:
 *        - Read imagePaths and thumbnailPath fields from deleted doc
 *        - Delete each corresponding storage file if exists
 */
exports.cleanupStorageOnProductDelete = functions
  .runWith({ memory: '256MB', timeoutSeconds: 60 })
  .firestore.document('products/{productId}')
  .onDelete(async (snap, context) => {
    const deletedData = snap.data() || {};
    const productId = context.params.productId;
    const imagePaths = deletedData.imagePaths || [];
    const thumbnailPath = deletedData.thumbnailPath ? [deletedData.thumbnailPath] : [];
    const allPaths = [...imagePaths, ...thumbnailPath];

    if (!allPaths.length) {
      console.log('No image paths to delete for productId=', productId);
      return null;
    }

    const bucket = storage.bucket(); // uses default bucket
    const deletionPromises = allPaths.map(async (p) => {
      try {
        console.log('Deleting file:', p);
        await bucket.file(p).delete();
        console.log('Deleted:', p);
      } catch (err) {
        // If the file doesn't exist, ignore
        console.warn('Failed deleting', p, 'error:', err.message || err);
      }
    });

    await Promise.all(deletionPromises);
    console.log('Cleanup complete for productId=', productId);
    return null;
  });
