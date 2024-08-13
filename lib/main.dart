import 'package:ecommercebyhninpwintwai/ui/screens/product_screen.dart';
import 'package:ecommercebyhninpwintwai/ui/screens/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(options: const FirebaseOptions(
        apiKey: "AIzaSyCdKKvdZ2WoC5fnN6aWdyzXH4WlB0LsJXc",
        authDomain: "ecommerce-by-hnin-pwint-wai.firebaseapp.com",
        projectId: "ecommerce-by-hnin-pwint-wai",
        storageBucket: "ecommerce-by-hnin-pwint-wai.appspot.com",
        messagingSenderId: "637588243550",
        appId: "1:637588243550:web:24f6a57425732317baa0cf"));
  } else{
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => ProductScreen(),
      },
    );
  }
}
