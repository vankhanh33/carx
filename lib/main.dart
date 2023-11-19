// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:carx/view/login/bloc/auth_bloc.dart';
import 'package:carx/view/login/bloc/auth_event.dart';
import 'package:carx/view/login/bloc/auth_state.dart';
import 'package:carx/firebase_options.dart';

import 'package:carx/service/auth/firebase_auth_provider.dart';
import 'package:carx/utilities/app_colors.dart';
import 'package:carx/utilities/app_routes.dart';
import 'package:carx/utilities/notification/firebase_messaging_service.dart';
import 'package:carx/view/login/login_view.dart';

import 'package:carx/view/login/register_view.dart';
import 'package:carx/view/main_view.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      theme: ThemeData(
        backgroundColor: Color(0xffe5e5e5),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          elevation: 2,
          shadowColor: Color(0xffe0e3e7),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const MyApp(),
      routes: Routes.pages,
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessagingService _messagingService = FirebaseMessagingService();
  @override
  void initState() {
    _messagingService.configureFirebaseMessaging();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc(FirebaseAuthProvider())..add(const AuthEventInitalize()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateLoggedIn) {
            return MainView();
          } else if (state is AuthStateLoggedOut) {
            return LoginView();
          } else if (state is AuthStateRegistering) {
            return RegisterView();
          } else {
            return Scaffold(
              appBar: AppBar(title: Text('XCar')),
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
