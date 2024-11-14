import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mail_client/providers/email_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class SendMailScreen extends StatefulWidget {
  const SendMailScreen({Key? key}) : super(key: key);

  @override
  _SendMailScreenState createState() => _SendMailScreenState();
}

class _SendMailScreenState extends State<SendMailScreen> {
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _msgBodyController = TextEditingController();
  List<File> _attachments = [];

  // Method to pick files from the device
  Future<void> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        setState(() {
          _attachments = result.paths.map((path) => File(path!)).toList();
        });
      }
    } catch (e) {
      print("Error picking files: $e");
    }
  }

  // Method to remove an attachment
  void _removeAttachment(File file) {
    setState(() {
      _attachments.remove(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    final emailProvider = Provider.of<EmailProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('Recipient', _recipientController),
              const SizedBox(height: 20),
              _buildTextField('Subject', _subjectController),
              const SizedBox(height: 20),
              _buildTextField('Message Body', _msgBodyController, maxLines: 5),
              const SizedBox(height: 20),
              _buildFilePicker(context),
              const SizedBox(height: 20),
              emailProvider.isSending
                  ? const Center(child: CircularProgressIndicator())
                  : _buildSendButton(emailProvider),
            ],
          ),
        ),
      ),
    );
  }

  // Build each text field with decoration
  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }

  // Build file picker widget for the attachment
  Widget _buildFilePicker(BuildContext context) {
    return GestureDetector(
      onTap: _pickFiles,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _attachments.isNotEmpty ? 'Attachments (${_attachments.length})' : 'Select Attachment',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            ..._attachments.map((file) => _buildAttachmentItem(file)).toList(),
            const SizedBox(height: 5),
            const Icon(Icons.attach_file, color: Colors.deepPurple),
          ],
        ),
      ),
    );
  }

  // Build individual attachment item
  Widget _buildAttachmentItem(File file) {
    return GestureDetector(
      onTap: () => _removeAttachment(file),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(file.path.split('/').last)),
            const Icon(Icons.remove_circle, color: Colors.red),
          ],
        ),
      ),
    );
  }

  // Build styled send button
  Widget _buildSendButton(EmailProvider emailProvider) {
    return GestureDetector(
      onTap: () async {
        // Call the API to send email
        await emailProvider.sendEmail(
          _recipientController.text,
          _subjectController.text,
          _msgBodyController.text,
          (_attachments.isNotEmpty ? _attachments : null) as List<File>?, // Pass null if no attachments
        );

        // Show success/failure based on status
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              emailProvider.isSuccess ? 'Email sent successfully!' : 'Failed to send email',
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Send',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
