// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:synctrackr/admin/controllers/checkout_controller.dart';
// import 'package:synctrackr/admin/utils/colors.dart';
// import 'package:synctrackr/admin/widgets/common_header.dart';

// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({super.key});

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   final CheckoutController controller = Get.put(CheckoutController());

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         const SliverAppBar(
//           pinned: true,
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.white54,
//           elevation: 0,
//           scrolledUnderElevation: 0.0,
//           flexibleSpace: CommonHeader(title: "Checkout"),
//         ),
//         SliverList(
//           delegate: SliverChildListDelegate(
//             [
//               Padding(
//                 padding: const EdgeInsets.all(24.0),
//                 child: Center(
//                   child: Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(color: AppColors.primary),
//                         color: AppColors.background,
//                         borderRadius: BorderRadius.circular(20)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Payment Details',
//                             style: TextStyle(
//                                 fontSize: 24, fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             'All transactions are secure and encrypted',
//                             style: TextStyle(
//                                 color: Colors.grey[600], fontSize: 14),
//                           ),
//                           const SizedBox(height: 20),
//                           _buildPlanDetailsCard(),
//                           const SizedBox(height: 30),
//                           _buildInputField('Full Name'),
//                           const SizedBox(height: 20),
//                           _buildPhoneInputField(),
//                           const SizedBox(height: 20),
//                           _buildInputField('Email Id'),
//                           const SizedBox(height: 20),
//                           _buildPaymentMethods(),
//                           const SizedBox(height: 20),
//                           _buildTermsAndConditions(),
//                           const SizedBox(height: 30),
//                           _buildBottomButtons(),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPlanDetailsCard() {
//     return Stack(
//       children:[
//          Container(
//           padding: const EdgeInsets.all(3),
//           decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [
//                   Colors.blue,
//                   Colors.lightBlue,

//                   Colors.pink,

//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(12),
//             ), // Border thickness
//         child: Container(
//           decoration: BoxDecoration(
//             color: AppColors.background,
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Text(
//                     'Standard Plan',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF4C6FFF),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       padding:
//                           const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       elevation: 0,
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           CupertinoIcons.eye,
//                           color: Colors.white,
//                         ),
//                         SizedBox(
//                           width: 3,
//                         ),
//                         const Text('View Features',
//                             style: TextStyle(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 '₹1,599/month',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'Designed for growing businesses with multi-device support and advanced visitor validation.',
//                 style: TextStyle(color: Colors.grey[600], fontSize: 12),
//               ),
//               // const Divider(height: 40, thickness: 1),
//               SizedBox(height: 15,),
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           const Text(
//                             '20% off Discount',
//                             style: TextStyle(fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(width: 4),
//                           Text(
//                             '(Billed Yearly)',
//                             style: TextStyle(color: Colors.grey[500], fontSize: 12),
//                           ),
//                         ],
//                       ),
//                       const Text(
//                         '-₹2,400.00',
//                         style: TextStyle(fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   DottedLine(
//                     dashLength: 6,
//                     dashGapLength: 4,
//                     lineThickness: 1,
//                     dashColor: Colors.grey,
//                   ),
//                   SizedBox(height: 5,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Text(
//                         'Total per year',
//                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         '₹8,300.00',
//                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//       ]
//     );
//   }

//   Widget _buildInputField(String label) {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: TextStyle(color: Colors.grey[600]),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: Color(0xFF4C6FFF)),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//       ),
//     );
//   }

//   Widget _buildPhoneInputField() {
//     return Row(
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.grey.shade300),
//           ),
//           child: const Text('+91',
//               style: TextStyle(color: Colors.black, fontSize: 16)),
//         ),
//         const SizedBox(width: 10),
//         Expanded(
//           child: TextFormField(
//             decoration: InputDecoration(
//               labelText: 'Phone',
//               labelStyle: TextStyle(color: Colors.grey[600]),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: BorderSide(color: Colors.grey.shade300),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//                 borderSide: const BorderSide(color: Color(0xFF4C6FFF)),
//               ),
//               filled: true,
//               fillColor: Colors.white,
//               contentPadding:
//                   const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPaymentMethods() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Image.network(
//           'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/1200px-Visa_Inc._logo.svg.png',
//           height: 15,
//         ),
//         const SizedBox(width: 15),
//         Image.network(
//           'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/UPI-Logo-vector.svg/1200px-UPI-Logo-vector.svg.png',
//           height: 15,
//         ),
//         const SizedBox(width: 15),
//         Image.network(
//           'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Rupay-Logo.png/1200px-Rupay-Logo.png',
//           height: 15,
//         ),
//         const SizedBox(width: 15),
//         Image.network(
//           'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/1200px-Mastercard_2019_logo.svg.png',
//           height: 15,
//         ),
//         const SizedBox(width: 15),
//         Image.network(
//           'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/American_Express_logo_%282018%29.svg/1200px-American_Express_logo_%282018%29.svg.png',
//           height: 15,
//         ),
//       ],
//     );
//   }

//   Widget _buildTermsAndConditions() {
//     return Obx(() => Row(
//           children: [
//             SizedBox(
//               width: 24,
//               height: 24,
//               child: Checkbox(
//                 value: controller.isTermsAccepted.value,
//                 onChanged: (bool? value) {
//                   controller.toggleTerms();
//                 },
//                 activeColor: const Color(0xFF4C6FFF),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//               ),
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//               child: RichText(
//                 text: TextSpan(
//                   text: 'I agree to the ',
//                   style: TextStyle(color: Colors.grey[600]),
//                   children: [
//                     TextSpan(
//                       text: 'Terms & conditions',
//                       style: const TextStyle(
//                         color: Color(0xFF4C6FFF),
//                         fontWeight: FontWeight.bold,
//                       ),
//                       recognizer: TapGestureRecognizer()
//                         ..onTap = () {
//                           // ignore: avoid_print
//                           print('Terms & conditions clicked');
//                         },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ));
//   }

//   Widget _buildBottomButtons() {
//     return Row(
//       children: [
//         Expanded(
//           child: OutlinedButton(
//             onPressed: controller.onExit,
//             style: OutlinedButton.styleFrom(
//               foregroundColor: const Color(0xFF4C6FFF),
//               side: BorderSide(color: Colors.grey.shade300),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//             ),
//             child: const Text('Exit',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           ),
//         ),
//         const SizedBox(width: 20),
//         Expanded(
//           child: ElevatedButton(
//             onPressed: controller.onPayNow,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF4C6FFF),
//               foregroundColor: Colors.white,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               padding: const EdgeInsets.symmetric(vertical: 16),
//             ),
//             child: const Text('Pay Now',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/checkout_controller.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/widgets/common_header.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CheckoutController controller = Get.put(CheckoutController());
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0.0,
            flexibleSpace: CommonHeader(title: "Checkout"),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isDarkMode
                                ? adminAppColors.secondary
                                : adminAppColors.primary),
                        color: isDarkMode
                            ? adminAppColors.darkCard
                            : adminAppColors.background,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Payment Details',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode
                                    ? adminAppColors.darkTextPrimary
                                    : adminAppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'All transactions are secure and encrypted',
                              style: TextStyle(
                                color: isDarkMode
                                    ? adminAppColors.darkTextSecondary
                                    : adminAppColors.textSecondary,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildPlanDetailsCard(isDarkMode),
                            const SizedBox(height: 30),
                            _buildInputField('Full Name', isDarkMode),
                            const SizedBox(height: 20),
                            _buildPhoneInputField(isDarkMode),
                            const SizedBox(height: 20),
                            _buildInputField('Email Id', isDarkMode),
                            const SizedBox(height: 20),
                            _buildPaymentMethods(),
                            const SizedBox(height: 20),
                            _buildTermsAndConditions(isDarkMode),
                            const SizedBox(height: 30),
                            _buildBottomButtons(isDarkMode),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildPlanDetailsCard(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        gradient: isDarkMode
            ? const LinearGradient(
                colors: [Color(0xFF8C52FF), Color(0xFF5CE1E6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [Colors.blue, Colors.lightBlue, Colors.pink],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          color:
              isDarkMode ? adminAppColors.darkCard : adminAppColors.background,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: isDarkMode
                  ? adminAppColors.darkBorder
                  : Colors.grey.shade200),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Standard Plan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode
                        ? adminAppColors.darkTextPrimary
                        : adminAppColors.textPrimary,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDarkMode
                        ? adminAppColors.darkPrimary
                        : const Color(0xFF4C6FFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        CupertinoIcons.eye,
                        color: isDarkMode ? Colors.black : Colors.white,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        'View Features',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.black : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '₹1,599/month',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode
                    ? adminAppColors.darkTextPrimary
                    : adminAppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Designed for growing businesses with multi-device support and advanced visitor validation.',
              style: TextStyle(
                color: isDarkMode
                    ? adminAppColors.darkTextSecondary
                    : adminAppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 15),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '20% off Discount',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: isDarkMode
                                ? adminAppColors.darkTextPrimary
                                : adminAppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(Billed Yearly)',
                          style: TextStyle(
                            color: isDarkMode
                                ? adminAppColors.darkTextSecondary
                                : adminAppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '-₹2,400.00',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: isDarkMode
                            ? adminAppColors.darkTextPrimary
                            : adminAppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                DottedLine(
                  dashLength: 6,
                  dashGapLength: 4,
                  lineThickness: 1,
                  dashColor: isDarkMode
                      ? adminAppColors.darkTextSecondary
                      : Colors.grey,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total per year',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? adminAppColors.darkTextPrimary
                            : adminAppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '₹8,300.00',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode
                            ? adminAppColors.darkTextPrimary
                            : adminAppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, bool isDarkMode) {
    return TextFormField(
      style: TextStyle(
          color: isDarkMode
              ? adminAppColors.darkTextPrimary
              : adminAppColors.textPrimary),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
            color: isDarkMode
                ? adminAppColors.darkTextSecondary
                : adminAppColors.textSecondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color:
                  isDarkMode ? adminAppColors.primary : Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color:
                  isDarkMode ? adminAppColors.primary : Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
              color: isDarkMode
                  ? adminAppColors.primary
                  : const Color(0xFF4C6FFF)),
        ),
        filled: true,
        fillColor: isDarkMode ? adminAppColors.darkSidebar : Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      ),
    );
  }

  Widget _buildPhoneInputField(bool isDarkMode) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            color: isDarkMode ? adminAppColors.darkSidebar : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color:
                    isDarkMode ? adminAppColors.primary : Colors.grey.shade300),
          ),
          child: Text(
            '+91',
            style: TextStyle(
              color: isDarkMode
                  ? adminAppColors.darkTextPrimary
                  : adminAppColors.textPrimary,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            style: TextStyle(
                color: isDarkMode
                    ? adminAppColors.darkTextPrimary
                    : adminAppColors.textPrimary),
            decoration: InputDecoration(
              labelText: 'Phone',
              labelStyle: TextStyle(
                  color: isDarkMode
                      ? adminAppColors.darkTextSecondary
                      : adminAppColors.textSecondary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: isDarkMode
                        ? adminAppColors.primary
                        : Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: isDarkMode
                        ? adminAppColors.primary
                        : Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: isDarkMode
                        ? adminAppColors.primary
                        : const Color(0xFF4C6FFF)),
              ),
              filled: true,
              fillColor: isDarkMode ? adminAppColors.darkSidebar : Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/1200px-Visa_Inc._logo.svg.png',
          height: 15,
          color: mainController.isDarkMode.value ? Colors.white : null,
          colorBlendMode: BlendMode.srcIn,
        ),
        const SizedBox(width: 15),
        Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/UPI-Logo-vector.svg/1200px-UPI-Logo-vector.svg.png',
          height: 15,
          color: mainController.isDarkMode.value ? Colors.white : null,
          colorBlendMode: BlendMode.srcIn,
        ),
        const SizedBox(width: 15),
        Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Rupay-Logo.png/1200px-Rupay-Logo.png',
          height: 15,
          color: mainController.isDarkMode.value ? Colors.white : null,
          colorBlendMode: BlendMode.srcIn,
        ),
        const SizedBox(width: 15),
        Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Mastercard_2019_logo.svg/1200px-Mastercard_2019_logo.svg.png',
          height: 15,
          color: mainController.isDarkMode.value ? Colors.white : null,
          colorBlendMode: BlendMode.srcIn,
        ),
        const SizedBox(width: 15),
        Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/American_Express_logo_%282018%29.svg/1200px-American_Express_logo_%282018%29.svg.png',
          height: 15,
          color: mainController.isDarkMode.value ? Colors.white : null,
          colorBlendMode: BlendMode.srcIn,
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions(bool isDarkMode) {
    return Obx(() => Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Checkbox(
                value: controller.isTermsAccepted.value,
                onChanged: (bool? value) {
                  controller.toggleTerms();
                },
                activeColor: isDarkMode
                    ? adminAppColors.darkPrimary
                    : const Color(0xFF4C6FFF),
                checkColor: isDarkMode ? Colors.black : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: 'I agree to the ',
                  style: TextStyle(
                    color: isDarkMode
                        ? adminAppColors.darkTextSecondary
                        : adminAppColors.textSecondary,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms & conditions',
                      style: TextStyle(
                        color: isDarkMode
                            ? adminAppColors.darkPrimary
                            : const Color(0xFF4C6FFF),
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // ignore: avoid_print
                          print('Terms & conditions clicked');
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildBottomButtons(bool isDarkMode) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: controller.onExit,
            style: OutlinedButton.styleFrom(
              backgroundColor: isDarkMode
                  ? adminAppColors.darkStatCard
                  : adminAppColors.secondary,
              foregroundColor: isDarkMode
                  ? adminAppColors.darkTextPrimary
                  : const Color(0xFF4C6FFF),
              side: BorderSide(
                  color: isDarkMode
                      ? adminAppColors.secondary
                      : Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'Exit',
              style:
                  GoogleFonts.lexend(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ElevatedButton(
            onPressed: controller.onPayNow,
            style: ElevatedButton.styleFrom(
              backgroundColor: isDarkMode
                  ? adminAppColors.darkMainButton
                  : const Color(0xFF4C6FFF),
              foregroundColor: isDarkMode ? Colors.black : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'Pay Now',
              style:
                  GoogleFonts.lexend(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ],
    );
  }
}
