import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:mail_client/services/email_api.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmailProvider extends ChangeNotifier {

  List<Map<String, dynamic>> _emails = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get emails => _emails;
  bool get isLoading => _isLoading;

  final EmailApi _emailService = EmailApi();

  Future<void> fetchEmails() async {
    _isLoading = true;
    notifyListeners();
    try {
      _emails = await _emailService.fetchEmails();
    } catch (e) {
      // Handle errors here
      print(e);
    }
    _isLoading = false;
    notifyListeners();
  }

  bool isSending = false;
  bool isSuccess = false;

  // SMTP server configuration
  final String smtpHost = 'smtp.gmail.com';
  final int smtpPort = 587;
  final String smtpUsername = 'harinatraj204@gmail.com';
  final String smtpPassword = 'dfpk mrxi wxpf maxp';

  Future<void> sendEmail(String recipient, String subject, String body, List<File>? attachments) async {
    isSending = true;
    notifyListeners();

    try {
      // Configure SMTP server
      final smtpServer = SmtpServer(
        smtpHost,
        port: smtpPort,
        username: smtpUsername,
        password: smtpPassword,
        ssl: false,
        allowInsecure: true, // Use with caution in production
      );

      // Create a message for the email
      final message = Message()
        ..from = Address(smtpUsername, 'Your Name')
        ..recipients.add(recipient)
        ..subject = subject
        ..text = body;

      // Add attachments if available
      if (attachments != null && attachments.isNotEmpty) {
        for (var attachment in attachments) {
          message.attachments.add(FileAttachment(attachment));
        }
      }

      // Send the email via SMTP
      await send(message, smtpServer);
      isSuccess = true;
      print('Message sent successfully');

      // Call the API to store email information
      await _storeEmailInfo(recipient, body, subject, attachments);
    } catch (e) {
      print('Error sending email: $e');
      isSuccess = false;
    } finally {
      isSending = false;
      notifyListeners();
    }
  }


  Future<void> _storeEmailInfo(String recipient, String body, String subject, List<File>? attachments) async {
    final url = Uri.parse('http://192.168.174.209:8080/api/v1/auth/mail/add');

    List<String?> base64Attachments = [];
    if (attachments != null && attachments.isNotEmpty) {
      for (var attachment in attachments) {
        // Read the file as bytes and then base64 encode it
        List<int> fileBytes = await attachment.readAsBytes(); // Read file bytes asynchronously
        String base64Attachment = base64Encode(fileBytes); // Encode to base64
        base64Attachments.add(base64Attachment); // Store base64 string
      }
    }

    // Prepare the API payload
    final Map<String, dynamic> emailData = {
      "recipient": recipient,
      "msgBody": body,
      "subject": subject,
      "attachments": base64Attachments // Send a list of base64 strings
    };

    try {
      // Send POST request to the API
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(emailData),
      );

      if (response.statusCode == 200) {
        print('Email info stored successfully');
      } else {
        print('Failed to store email info: ${response.body}');
      }
    } catch (e) {
      print('Error storing email info: $e');
    }
  }

}
