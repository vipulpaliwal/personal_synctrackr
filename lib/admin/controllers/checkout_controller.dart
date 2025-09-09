import 'package:get/get.dart';


class CheckoutController extends GetxController {
  final isTermsAccepted = false.obs;

 
  void toggleTerms() {
    isTermsAccepted.value = !isTermsAccepted.value;
  }

  void onPayNow() {
    print('Pay Now button pressed');
  }

  void onExit() {
    
    print('Exit button pressed');
  }
}
