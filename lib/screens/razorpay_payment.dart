import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayScreen extends StatefulWidget {
  const RazorpayScreen({
    super.key,
    required this.price,
  });

  final String price;

  @override
  State<RazorpayScreen> createState() {
    return _RazorpayScreenState();
  }
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  late Razorpay _razorpay;

  void openCheckout(amount) async {
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_SJGMpWGTMXuMIe',
      'amount': amount,
      'name': 'Coolthrow',
      'prefill': {
        'contact': '7388651515',
        'email': 'test@gmail.com',
        'external': {
          'wallets': ['paytm']
        }
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

    void handlePaymentSuccess(PaymentSuccessResponse response) {
      print('Payment Successful${response.paymentId}');
    }

    void handlePaymentFailure(PaymentFailureResponse response) {
      print('Payment fail${response.message}');
    }

    void handleExternalWallet(ExternalWalletResponse response) {
      print('External Wallet${response.walletName}');
    }

    @override
    void dispose() {
      super.dispose();
      _razorpay.clear();
    }

    @override
    void initState() {
      super.initState();
      _razorpay = Razorpay();
      _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
      _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentFailure);
      _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            openCheckout(2);
          },
          child: const Padding(
            padding: EdgeInsets.all(2),
            child: Text('Pay now'),
          ),
        )
      ],
    );
  }
}
