import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepository {
  Future<fb.User?> signIn(String email, String password);
  Future<fb.User?> signUp(String email, String password, String name);
  Future<fb.User?> signInWithGoogle();
  Future<void> signOut();
}

class FirebaseAuthRepository implements AuthRepository {
  final fb.FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirebaseAuthRepository({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  // Email password login

  @override
  Future<fb.User?> signIn(String email, String password) async {
    final cred = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return cred.user;
  }


  // Email signup + save user in firestore

  @override
  Future<fb.User?> signUp(String email, String password, String name) async {
    final cred = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = cred.user;
    if (user == null) return null;

    // Save user profile in Firestore
    await firestore.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'name': name,
      'email': email,
      'profilePic': null,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return user;
  }


  // Google signin + save user in firestore (only first time)

  @override
  Future<fb.User?> signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final auth = await googleUser.authentication;

    final credential = fb.GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );

    final cred = await firebaseAuth.signInWithCredential(credential);
    final user = cred.user;
    if (user == null) return null;

    // Check if user already exists in Firestore
    final doc = await firestore.collection('users').doc(user.uid).get();

    if (!doc.exists) {
      // Store Google account data
      await firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': user.displayName ?? "",
        'email': user.email ?? "",
        'profilePic': user.photoURL,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return user;
  }

  // Logout

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }
}
