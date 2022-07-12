import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/app/auth_widget.dart';
import 'package:flutter_todo_app/app/pages/home.dart';
import 'package:flutter_todo_app/app/pages/sign_in_page.dart';
import 'package:flutter_todo_app/firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

Future main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthWidget(
          signedInBuilder: (context) => const Home(),
          nonSignedInBuilder: (_) => const SignInPage()),
    );
  }
}
