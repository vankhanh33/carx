// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:carx/bloc/auth/auth_bloc.dart';
import 'package:carx/bloc/auth/auth_event.dart';
import 'package:carx/bloc/auth/auth_state.dart';
import 'package:carx/loading/loading_screen.dart';
import 'package:carx/service/auth/firebase_auth_provider.dart';
import 'package:carx/view/login/login_view.dart';

import 'package:carx/view/login/register.dart';
import 'package:carx/view/main_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      theme: ThemeData(
        backgroundColor: Color(0xffe5e5e5),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.yellow[700],
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: BlocProvider(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const MyApp(),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitalize());
    return BlocConsumer<AuthBloc, AuthState>(
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
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
              context: context,
              text: state.loadingText ?? 'Please wait a moment');
        } else {
          LoadingScreen().hide();
        }
      },
    );
  }
}
