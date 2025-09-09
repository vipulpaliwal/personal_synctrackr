import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synctrackr/admin/models/help_message_model.dart';

class HelpController extends GetxController {
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();
  final messageController = TextEditingController();

  final RxList<MessageModel> messages = <MessageModel>[
    MessageModel(
      sender: 'Michael Wright',
      message: 'Good Morning! How can I help you?',
      time: '10:16 AM',
      isMe: false,
    ),
    MessageModel(
      sender: 'You',
      message:
          'I\'ve tried logging out and back in, but the issue persists. Please check if it\'s a role permission issue or a browser compatibility problem.',
      time: '10:17 AM',
      isMe: true,
    ),
  ].obs;

  void sendMessage() {
    final text = messageController.text.trim();
    if (text.isNotEmpty) {
      messages.add(MessageModel(
        sender: 'You',
        message: text,
        time: '10:18 AM',
        isMe: true,
      ));
      messageController.clear();
    }
  }

  @override
  void onClose() {
    subjectController.dispose();
    descriptionController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
