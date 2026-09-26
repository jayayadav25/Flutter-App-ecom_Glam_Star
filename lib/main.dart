import 'src/bootstrap.dart';
import 'src/app/app.dart';

Future<void> main() async {
  await bootstrap(const App());
}



// exports.createOrder = functions.https.onCall(
// async (data, context) => {
// console.log("CREATE ORDER HIT");
// console.log("AUTH =>", context.auth);
// console.log("DATA =>", data);
//
// return {
// success: true,
// amount: data.amount,
// receipt: data.receipt,
// };
// }
// );
//exports.createOrder = functions.https.onCall(
//  async (data, context) => {
//  console.log("========== CREATE ORDER ==========");
//  console.log("AUTH =>", context.auth);
//  console.log("DATA =>", data);
//    try {
//      const amount = Number(data.amount);
//      const receipt = data.receipt;
//      console.log(
//        "CREATE ORDER REQUEST",
//        data
//      );
//       console.log(
//         "AMOUNT",
//          amount
//       );
//       console.log(
//        "RECEIPT",
//        receipt );
//
//      if (!amount || amount <= 0) {
//        throw new functions.https.HttpsError(
//          "invalid-argument",
//          "Valid amount is required"
//        );
//      }
//
//      // TEMPORARY TEST KEYS
//      // Replace YOUR_TEST_SECRET with your Razorpay Test Secret
//      const razorpay = new Razorpay({
//        key_id: "rzp_test_SzzzBbB0N1PAGB",
//        key_secret: "yQVKEp76A4UZlk30D7ysdzVq",
//      });
//
//      const order = await razorpay.orders.create({
//        amount: Math.round(amount * 100),
//        currency: "INR",
//        receipt: receipt || `ORDER_${Date.now()}`,
//      });
//
//      return {
//        success: true,
//        orderId: order.id,
//        amount: amount,
//        currency: order.currency,
//        receipt: order.receipt,
//      };
//    } catch (error) {
//      console.error("Create Order Error:", error);
//
//      throw new functions.https.HttpsError(
//        "internal",
//        error.message || "Failed to create order"
//      );
//    }
//  }
//);
