import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class EmailApi {
  final String baseUrl = 'http://192.168.174.209:8080/api/v1/auth/mail';

  Future<List<Map<String, dynamic>>> fetchEmails() async {
    final response = await http.get(Uri.parse('$baseUrl/emails'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((email) => email as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load emails');
    }
  }
  }
  
  // Future<void> sendmail() async {
  //   Directory directory = await getTemporaryDirectory();
  //   String filePath = '${directory.path}/example.csv';
  //   File file = File(filePath);
  //   // Assuming csv content is ready to be written
  //   await file.writeAsString("name,age\nAlice,25\nBob,30");
  //   Email email = Email(
  //       body: 'Please find the attached file.',
  //       subject: 'File Attachment Example',
  //       recipients: ['example@example.com'],
  //       attachmentPaths: [file.path],
  //       isHTML: false);
  //   await FlutterEmailSender.send(email);
  //   // Optionally, delete the file after sending
  //   await file.delete();
  // }


