import 'package:flutter/material.dart';
import 'package:mail_client/providers/auth_provider.dart';
import 'package:mail_client/providers/email_provider.dart';
import 'package:mail_client/screens/home_screen.dart';
import 'package:mail_client/screens/login_screen.dart';
import 'package:mail_client/screens/signup_screen.dart';
import 'package:mail_client/utils/shared_prefs.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await SharedPrefs.getToken(); // Retrieve token from SharedPreferences
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EmailProvider()),
      ],
      child: MyApp(token: token),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: token == null ? '/signup' : '/home', // Decide initial route based on token
      routes: {
        '/signup': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
