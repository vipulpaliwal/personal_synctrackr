// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:synctrackr/admin/controllers/help_controller.dart';
// import 'package:synctrackr/admin/models/help_message_model.dart';
// import 'package:synctrackr/admin/utils/colors.dart';

// class HelpScreen extends StatelessWidget {
//   HelpScreen({super.key});

//   final HelpController controller = Get.put(HelpController());

//   @override
//   Widget build(BuildContext context) {
//     return Opacity(
//       opacity: 0.9,
//       child: Container(
//         padding: const EdgeInsets.all(24),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildSupportCard(context),
//               const SizedBox(height: 24),
//               _buildCreateTicketCard(context),
//               const SizedBox(height: 24),
//               _buildConversationCard(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCard({required Widget child}) {
//     return Container(
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         color: AppColors.background,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: AppColors.primary),
//       ),
//       child: child,
//     );
//   }

//   Widget _buildSupportCard(BuildContext context) {
//     return _buildCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Support Center',
//             style: GoogleFonts.lexend(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xFF212529)),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             "Get emails to find out what's going on when you're not online.",
//             style: TextStyle(color: Colors.grey.shade600),
//           ),
//           const SizedBox(height: 16),
//           _buildSupportOptions(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildSupportOptions(BuildContext context) {
//     return Column(
//       children: [
//         _buildSupportItem(
//           context,
//           icon: Icons.shield_outlined,
//           title: 'Safety Center',
//           subtitle: 'Get in touch incase of immediate danger',
//           actionText: 'Call emergency services',
//         ),
//         const Divider(color: Color(0xFFE9ECEF)),
//         _buildSupportItem(
//           context,
//           icon: Icons.support_agent,
//           title: 'Ticket Support',
//           subtitle: 'Reach out to our dedicated support team,',
//           actionText: 'Reply within 24hrs',
//         ),
//         const Divider(color: Color(0xFFE9ECEF)),
//         _buildSupportItem(
//           context,
//           icon: Icons.integration_instructions_outlined,
//           title: 'How SyncTrackr Works',
//           subtitle:
//               'SyncTrackr automates registration, approval, and secure check-out.',
//         ),
//         const Divider(color: Color(0xFFE9ECEF)),
//         _buildSupportItem(
//           context,
//           icon: Icons.quiz_outlined,
//           title: 'Frequently Asked Questions',
//           subtitle: 'Search frequently asked questions about SyncTrackr',
//         ),
//       ],
//     );
//   }

//   Widget _buildSupportItem(
//     BuildContext context, {
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     String? actionText,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: Row(
//         children: [
//           Icon(icon, color: const Color(0xFF4C6FFF), size: 24),
//           const SizedBox(width: 16),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color: Color(0xFF212529),
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 RichText(
//                   text: TextSpan(
//                     style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                     children: [
//                       TextSpan(text: subtitle),
//                       if (actionText != null)
//                         TextSpan(
//                           text: ' $actionText',
//                           style: const TextStyle(color: Color(0xFF4C6FFF)),
//                         ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
//         ],
//       ),
//     );
//   }

//   Widget _buildCreateTicketCard(BuildContext context) {
//     return _buildCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Create Ticket',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 18,
//               color: Color(0xFF212529),
//             ),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             'Describe your issue for support team',
//             style: TextStyle(color: Colors.grey[600], fontSize: 14),
//           ),
//           const SizedBox(height: 24),
//           _buildTextField(
//             controller: controller.subjectController,
//             hintText: 'Subject',
//           ),
//           const SizedBox(height: 16),
//           _buildTextField(
//             controller: controller.descriptionController,
//             hintText: 'Description',
//             maxLines: 4,
//           ),
//           const SizedBox(height: 24),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               OutlinedButton(
//                 onPressed: () {
//                   controller.subjectController.clear();
//                   controller.descriptionController.clear();
//                 },
//                 style: OutlinedButton.styleFrom(
//                   foregroundColor: const Color(0xFF212529),
//                   side: const BorderSide(color: Color(0xFFADB5BD)),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 16,
//                   ),
//                 ),
//                 child: const Text('Cancel'),
//               ),
//               const SizedBox(width: 12),
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle submit
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF4C6FFF),
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 16,
//                   ),
//                 ),
//                 child: const Text('Submit'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String hintText,
//     int maxLines = 1,
//   }) {
//     return TextField(
//       controller: controller,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: const TextStyle(color: Color(0xFF6C757D)),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Color(0xFFDEE2E6)),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Color(0xFFDEE2E6)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Color(0xFF4C6FFF)),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 12,
//         ),
//       ),
//     );
//   }

//   Widget _buildConversationCard(BuildContext context) {
//     return _buildCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildTicketHeader(),
//           const SizedBox(height: 16),
//           Text(
//             "I'm unable to take action (Accept/Decline/Reschedule) on a visitor appointment assigned to me. The buttons are grayed out and not responsive. I've tried logging out and back in, but the issue persists. Please check if it's a role permission issue or a browser compatibility problem.",
//             style:
//                 TextStyle(color: Colors.grey[800], fontSize: 14, height: 1.5),
//           ),
//           const SizedBox(height: 24),
//           _buildChatBox(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildTicketHeader() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Flexible(
//               child: Text(
//                 'Unable to Accept/Decline Visitor Request',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                   color: Color(0xFF212529),
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//               decoration: BoxDecoration(
//                 color: Colors.green.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: const Row(
//                 children: [
//                   Icon(Icons.circle, color: Colors.green, size: 8),
//                   SizedBox(width: 4),
//                   Text(
//                     'Open',
//                     style: TextStyle(color: Colors.green, fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Row(
//           children: [
//             Text(
//               'Created By: Google LLP (SYCTR547465)',
//               style: TextStyle(color: Colors.grey[600], fontSize: 12),
//             ),
//             const Spacer(),
//             Text(
//               'Ticket ID: ST-100245',
//               style: TextStyle(color: Colors.grey[600], fontSize: 12),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildChatBox(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFF8F9FA),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: const Color(0xFFE9ECEF)),
//       ),
//       child: Column(
//         children: [
//           _buildChatHeader(),
//           const Divider(height: 1, color: Color(0xFFE9ECEF)),
//           _buildMessageList(),
//           const Divider(height: 1, color: Color(0xFFE9ECEF)),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }

//   Widget _buildChatHeader() {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             radius: 16,
//             backgroundImage: AssetImage('assets/images/avatar1.png'),
//           ),
//           const SizedBox(width: 8),
//           const Text(
//             'Michael Wright',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(width: 4),
//           Text(
//             'Support',
//             style: TextStyle(color: Colors.grey[600], fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageList() {
//     return Obx(
//       () => Container(
//         height: 250,
//         padding: const EdgeInsets.all(8.0),
//         child: ListView.builder(
//           reverse: true,
//           itemCount: controller.messages.length,
//           itemBuilder: (context, index) {
//             final msg =
//                 controller.messages[controller.messages.length - 1 - index];
//             return Align(
//               alignment:
//                   msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
//               child: _buildMessageBubble(msg),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildMessageBubble(MessageModel message) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment:
//           message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         if (!message.isMe)
//           const CircleAvatar(
//             radius: 12,
//             backgroundImage: AssetImage('assets/images/avatar2.png'),
//           ),
//         if (!message.isMe) const SizedBox(width: 8),
//         Flexible(
//           child: Container(
//             margin: const EdgeInsets.symmetric(vertical: 4),
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: message.isMe ? const Color(0xFF4C6FFF) : Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 if (!message.isMe)
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 3,
//                   )
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   message.message,
//                   style: TextStyle(
//                       color: message.isMe ? Colors.white : Colors.black87),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   message.time,
//                   style: TextStyle(
//                     color: message.isMe ? Colors.white70 : Colors.grey[600],
//                     fontSize: 10,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         if (message.isMe) const SizedBox(width: 8),
//         if (message.isMe)
//           const CircleAvatar(
//             radius: 12,
//             backgroundImage: AssetImage('assets/images/avatar3.png'),
//           ),
//       ],
//     );
//   }

//   Widget _buildMessageInput() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       color: Colors.white,
//       child: Row(
//         children: [
//           IconButton(
//             icon:
//                 const Icon(Icons.attachment_outlined, color: Color(0xFF6C757D)),
//             onPressed: () {},
//           ),
//           Expanded(
//             child: TextField(
//               controller: controller.messageController,
//               decoration: const InputDecoration(
//                 hintText: 'Type your message here...',
//                 border: InputBorder.none,
//                 hintStyle: TextStyle(color: Color(0xFF6C757D)),
//               ),
//             ),
//           ),
//           IconButton(
//             icon: const Icon(Icons.send, color: Color(0xFF4C6FFF)),
//             onPressed: controller.sendMessage,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synctrackr/admin/controllers/help_controller.dart';
import 'package:synctrackr/admin/models/help_message_model.dart';
import 'package:synctrackr/admin/utils/colors.dart';
import 'package:synctrackr/admin/controllers/main_controller.dart';

class HelpScreen extends StatelessWidget {
  HelpScreen({super.key});

  final HelpController controller = Get.put(HelpController());
  final MainController mainController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDarkMode = mainController.isDarkMode.value;
      return Opacity(
        opacity: 0.9,
        child: Container(
          // color: isDarkMode ? AppColors.darkMainBackground : AppColors.background,
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSupportCard(context, isDarkMode),
                const SizedBox(height: 24),
                _buildCreateTicketCard(context, isDarkMode),
                const SizedBox(height: 24),
                _buildConversationCard(context, isDarkMode),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCard({required Widget child, required bool isDarkMode}) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDarkMode
            ? adminAppColors.darkSidebar.withOpacity(0.9)
            : adminAppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color:
                isDarkMode ? adminAppColors.secondary : adminAppColors.primary),
      ),
      child: child,
    );
  }

  Widget _buildSupportCard(BuildContext context, bool isDarkMode) {
    return _buildCard(
      isDarkMode: isDarkMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Support Center',
            style: GoogleFonts.lexend(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : const Color(0xFF212529),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Get emails to find out what's going on when you're not online.",
            style: GoogleFonts.lexend(
                color: isDarkMode ? Colors.white70 : Colors.grey.shade600),
          ),
          const SizedBox(height: 16),
          _buildSupportOptions(context, isDarkMode),
        ],
      ),
    );
  }

  Widget _buildSupportOptions(BuildContext context, bool isDarkMode) {
    return Column(
      children: [
        _buildSupportItem(
          context,
          isDarkMode: isDarkMode,
          icon: Icons.shield_outlined,
          title: 'Safety Center',
          subtitle: 'Get in touch incase of immediate danger',
          actionText: 'Call emergency services',
        ),
        Divider(
            color: isDarkMode
                ? adminAppColors.secondary
                : const Color(0xFFE9ECEF)),
        _buildSupportItem(
          context,
          isDarkMode: isDarkMode,
          icon: Icons.support_agent,
          title: 'Ticket Support',
          subtitle: 'Reach out to our dedicated support team,',
          actionText: 'Reply within 24hrs',
        ),
        Divider(
            color: isDarkMode
                ? adminAppColors.secondary
                : const Color(0xFFE9ECEF)),
        _buildSupportItem(
          context,
          isDarkMode: isDarkMode,
          icon: Icons.integration_instructions_outlined,
          title: 'How SyncTrackr Works',
          subtitle:
              'SyncTrackr automates registration, approval, and secure check-out.',
        ),
        Divider(
            color: isDarkMode
                ? adminAppColors.secondary
                : const Color(0xFFE9ECEF)),
        _buildSupportItem(
          context,
          isDarkMode: isDarkMode,
          icon: Icons.quiz_outlined,
          title: 'Frequently Asked Questions',
          subtitle: 'Search frequently asked questions about SyncTrackr',
        ),
      ],
    );
  }

  Widget _buildSupportItem(
    BuildContext context, {
    required bool isDarkMode,
    required IconData icon,
    required String title,
    required String subtitle,
    String? actionText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(icon,
              color:
                  isDarkMode ? adminAppColors.primary : const Color(0xFF4C6FFF),
              size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.lexend(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isDarkMode ? Colors.white : const Color(0xFF212529),
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.lexend(
                        color: isDarkMode ? Colors.white70 : Colors.grey[600],
                        fontSize: 14),
                    children: [
                      TextSpan(text: subtitle),
                      if (actionText != null)
                        TextSpan(
                          text: ' $actionText',
                          style: GoogleFonts.lexend(
                              color: isDarkMode
                                  ? adminAppColors.primary
                                  : const Color(0xFF4C6FFF)),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios,
              color: isDarkMode ? Colors.white54 : Colors.grey, size: 16),
        ],
      ),
    );
  }

  Widget _buildCreateTicketCard(BuildContext context, bool isDarkMode) {
    return _buildCard(
      isDarkMode: isDarkMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Ticket',
            style: GoogleFonts.lexend(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: isDarkMode ? Colors.white : const Color(0xFF212529),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Describe your issue for support team',
            style: GoogleFonts.lexend(
                color: isDarkMode ? Colors.white70 : Colors.grey[600],
                fontSize: 14),
          ),
          const SizedBox(height: 24),
          _buildTextField(
            controller: controller.subjectController,
            hintText: 'Subject',
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 16),
          _buildTextField(
            controller: controller.descriptionController,
            hintText: 'Description',
            maxLines: 4,
            isDarkMode: isDarkMode,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () {
                  controller.subjectController.clear();
                  controller.descriptionController.clear();
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor:
                      isDarkMode ? Colors.white : const Color(0xFF212529),
                  side: BorderSide(
                      color: isDarkMode
                          ? adminAppColors.secondary
                          : const Color(0xFFADB5BD)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  // Handle submit
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode
                      ? adminAppColors.primary
                      : const Color(0xFF4C6FFF),
                  foregroundColor: isDarkMode ? Colors.black : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
                child: Text('Submit', style: GoogleFonts.lexend()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool isDarkMode,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.lexend(color: isDarkMode ? Colors.white : Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.lexend(
            color: isDarkMode ? Colors.white54 : const Color(0xFF6C757D)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: isDarkMode
                  ? adminAppColors.primary
                  : const Color(0xFFDEE2E6)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: isDarkMode
                  ? adminAppColors.primary
                  : const Color(0xFFDEE2E6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
              color: isDarkMode
                  ? adminAppColors.primary
                  : const Color(0xFF4C6FFF)),
        ),
        filled: true,
        fillColor:
            isDarkMode ? adminAppColors.darkMainBackground : Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }

  Widget _buildConversationCard(BuildContext context, bool isDarkMode) {
    return _buildCard(
      isDarkMode: isDarkMode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTicketHeader(isDarkMode),
          const SizedBox(height: 16),
          Text(
            "I'm unable to take action (Accept/Decline/Reschedule) on a visitor appointment assigned to me. The buttons are grayed out and not responsive. I've tried logging out and back in, but the issue persists. Please check if it's a role permission issue or a browser compatibility problem.",
            style: GoogleFonts.lexend(
                color: isDarkMode ? Colors.white : Colors.grey[800],
                fontSize: 14,
                height: 1.5),
          ),
          const SizedBox(height: 24),
          _buildChatBox(context, isDarkMode),
        ],
      ),
    );
  }

  Widget _buildTicketHeader(bool isDarkMode) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                'Unable to Accept/Decline Visitor Request',
                style: GoogleFonts.lexend(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isDarkMode ? Colors.white : const Color(0xFF212529),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.green.withOpacity(0.2)
                    : Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.circle,
                      color: isDarkMode ? Colors.greenAccent : Colors.green,
                      size: 8),
                  const SizedBox(width: 4),
                  Text(
                    'Open',
                    style: GoogleFonts.lexend(
                        color: isDarkMode ? Colors.greenAccent : Colors.green,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              'Created By: Google LLP (SYCTR547465)',
              style: GoogleFonts.lexend(
                  color: isDarkMode ? Colors.white54 : Colors.grey[600],
                  fontSize: 12),
            ),
            const Spacer(),
            Text(
              'Ticket ID: ST-100245',
              style: GoogleFonts.lexend(
                  color: isDarkMode ? Colors.white54 : Colors.grey[600],
                  fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChatBox(BuildContext context, bool isDarkMode) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? adminAppColors.darkMainBackground
            : const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isDarkMode
                ? adminAppColors.secondary
                : const Color(0xFFE9ECEF)),
      ),
      child: Column(
        children: [
          _buildChatHeader(isDarkMode),
          Divider(
              height: 1,
              color: isDarkMode
                  ? adminAppColors.secondary
                  : const Color(0xFFE9ECEF)),
          _buildMessageList(isDarkMode),
          Divider(
              height: 1,
              color: isDarkMode
                  ? adminAppColors.secondary
                  : const Color(0xFFE9ECEF)),
          _buildMessageInput(isDarkMode),
        ],
      ),
    );
  }

  Widget _buildChatHeader(bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/images/avatar1.png'),
          ),
          const SizedBox(width: 8),
          Text(
            'Michael Wright',
            style: GoogleFonts.lexend(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black),
          ),
          const SizedBox(width: 4),
          Text(
            'Support',
            style: GoogleFonts.lexend(
                color: isDarkMode ? Colors.white54 : Colors.grey[600],
                fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(bool isDarkMode) {
    return Obx(
      () => Container(
        height: 250,
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          reverse: true,
          itemCount: controller.messages.length,
          itemBuilder: (context, index) {
            final msg =
                controller.messages[controller.messages.length - 1 - index];
            return Align(
              alignment:
                  msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: _buildMessageBubble(msg, isDarkMode),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMessageBubble(MessageModel message, bool isDarkMode) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!message.isMe)
          const CircleAvatar(
            radius: 12,
            backgroundImage: AssetImage('assets/images/avatar2.png'),
          ),
        if (!message.isMe) const SizedBox(width: 8),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: message.isMe
                  ? (isDarkMode
                      ? adminAppColors.darkSecondaryBackground
                      : const Color(0xFF4C6FFF))
                  : (isDarkMode
                      ? adminAppColors.darkSecondaryBackground
                      : Colors.white),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                if (!message.isMe)
                  BoxShadow(
                    color: isDarkMode
                        ? Colors.transparent
                        : Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                  )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.message,
                  style: GoogleFonts.lexend(
                      color: message.isMe
                          ? Colors.white
                          : (isDarkMode ? Colors.white : Colors.black87)),
                ),
                const SizedBox(height: 4),
                Text(
                  message.time,
                  style: GoogleFonts.lexend(
                    color: message.isMe
                        ? Colors.white70
                        : (isDarkMode ? Colors.white54 : Colors.grey[600]),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (message.isMe) const SizedBox(width: 8),
        if (message.isMe)
          const CircleAvatar(
            radius: 12,
            backgroundImage: AssetImage('assets/images/avatar3.png'),
          ),
      ],
    );
  }

  Widget _buildMessageInput(bool isDarkMode) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: isDarkMode ? adminAppColors.darkMainBackground : Colors.white,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.attachment_outlined,
                color: isDarkMode ? Colors.white54 : const Color(0xFF6C757D)),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: controller.messageController,
              style: GoogleFonts.lexend(color: isDarkMode ? Colors.white : Colors.black),
              decoration: InputDecoration(
                hintText: 'Type your message here...',
                border: InputBorder.none,
                hintStyle: GoogleFonts.lexend(
                    color:
                        isDarkMode ? Colors.white54 : const Color(0xFF6C757D)),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send,
                color: isDarkMode
                    ? adminAppColors.primary
                    : const Color(0xFF4C6FFF)),
            onPressed: controller.sendMessage,
          ),
        ],
      ),
    );
  }
}
