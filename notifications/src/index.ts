import {setGlobalOptions} from "firebase-functions/v2";
import {
  onDocumentCreated,
  onDocumentUpdated,
} from "firebase-functions/v2/firestore";

import {onSchedule} from "firebase-functions/v2/scheduler";

import * as admin from "firebase-admin";

admin.initializeApp();
setGlobalOptions({maxInstances: 10});

export const orderPlacedFirestoreNotification =
  onDocumentCreated(
    "orders/{orderId}",
    async (event) => {
      const order = event.data?.data();
      if (!order) {
        return;
      }
      const orderId = event.params.orderId;
      const userId = order.userId;
      if (!userId) {
        return;
      }

      const userDoc = await admin
        .firestore()
        .collection("users")
        .doc(userId)
        .get();

      if (!userDoc.exists) {
        return;
      }

      const token = userDoc.data()?.fcmToken;
      if (!token) {
        return;
      }

      await admin.messaging().send({
        token: token,
        notification: {
          title: "Order Placed",
          body:
            `Your order #${orderId} has been confirmed. ` +
            `Total amount ₹${order.totalAmount}. ` +
            "Expected delivery in 3-5 days.",
        },

        data: {
          route: "/orders",
        },
      });

      await admin
        .firestore()
        .collection("users")
        .doc(userId)
        .collection("notifications")
        .add({
          title: "Order Placed",
          body:
            `Your order #${orderId} has been confirmed. ` +
            `Total amount ₹${order.totalAmount}. ` +
            "Expected delivery in 3-5 days.",
          route: "/orders",
          isRead: false,
          createdAt: admin.firestore.FieldValue.serverTimestamp(),
        });

      console.log(
        `Notification sent to ${userId}`,
      );
    },
  );

export const offerNotification =
  onDocumentCreated(
    "offers/{offerId}",
    async (event) => {
      const offer = event.data?.data();

      if (!offer) {
        return;
      }

      await admin.messaging().send({
        topic: "offers",

        notification: {
          title: offer.title,
          body: offer.body,
        },

        data: {
          route: "/offers",
        },
      });

      console.log(
        `Offer notification sent: ${offer.title}`
      );
    }
  );

export const cartReminderNotification =
onSchedule(
  {
    schedule: "every 24 hours",
    region: "asia-east1",
  },

  async () => {
    const usersSnapshot =
      await admin.firestore()
        .collection("users")
        .get();

    for (const userDoc of usersSnapshot.docs) {
      const userData = userDoc.data();

      const token =
        userData.fcmToken;

      if (!token) continue;

      const cartSnapshot =
        await admin.firestore()
          .collection("users")
          .doc(userDoc.id)
          .collection("cart")
          .get();

      if (cartSnapshot.empty) {
        continue;
      }

      await admin.messaging().send({
        token,

        notification: {
          title:
            "Items waiting in your cart",
          body:
                `You have ${
                  cartSnapshot.docs.length
                } item(s) waiting in your cart. ` +
                 "Complete your purchase now.",
        },

        data: {
          route: "/cart",
        },
      });

      await admin.firestore()
        .collection("users")
        .doc(userDoc.id)
        .collection("notifications")
        .add({
          title:
            "Items waiting in your cart",

          body:
              `You have ${
                cartSnapshot.docs.length
              } item(s) waiting in your cart. ` +
               "Complete your purchase now.",

          route: "/cart",

          isRead: false,

          createdAt:
            admin.firestore
              .FieldValue
              .serverTimestamp(),
        });
    }
  }
);

export const orderShippedNotification =
  onDocumentUpdated(
    "orders/{orderId}",
    async (event) => {
      const before =
          event.data?.before.data();

      const after =
          event.data?.after.data();

      if (
        before?.status !== "Shipped" &&
          after?.status === "Shipped"
      ) {

        // send notification
      }
    }
  );

