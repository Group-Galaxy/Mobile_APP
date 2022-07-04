import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentController2 extends GetxController {
  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: true,
          googlePay: true,
          testEnv: true,
          merchantCountryCode: 'US',
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));
        displayPaymentSheet();
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  Future addpaymentDataToDb(
      {required String userName,
      // required String serviceProviderID,
      required String discount,
      required String date,
      required String balance,
      required String inspectionValue,
      required String serviceProviderName,
      required String vehicleFault,
      // required String delivery_fee,
      // required String contactNo,
      // required String address,
      required String DocID,
      required bool is_paid}) async {
    Map<String, dynamic> body = {
      "is_paid": is_paid,
      "balance": balance,
      "date": date,
      "discount": discount,
      "inspectionValue": inspectionValue,
      "serviceProviderName": serviceProviderName,
      "userName": userName,
      "vehicleFault": vehicleFault,
    };
    try {
      // await FirebaseFirestore.instance
      //     .collection('payments')
      //     .doc('DocID')
      //     .update({'is_paid': true});
      await FirebaseFirestore.instance
          .collection('payments')
          .doc(DocID)
          .set(body);
    } catch (e) {
      print('error');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar('Payment', 'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51LDqSTEHLxB2oFbTEcOFy9yRzgpjZdAwEgPsbc2Y5xJsmeOBOeYhDcqq1PoKVR0SYOA0IOEU2Hh1Vw1I0YCLdIEW00uciG4RLv',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
