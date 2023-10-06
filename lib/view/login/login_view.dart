import 'package:carx/bloc/auth/auth_bloc.dart';
import 'package:carx/bloc/auth/auth_event.dart';
import 'package:carx/bloc/auth/auth_state.dart';
import 'package:carx/service/auth/auth_exceptions.dart';
import 'package:carx/utilities/dialog/error_dialog.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginView> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late bool _hiddenPassword;

  @override
  void initState() {
    _hiddenPassword = true;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context: context, text: 'Invalid email');
          } else if (state.exception is InvalidLoginCredentialsAuthException) {
            await showErrorDialog(
                context: context, text: 'Invalid login credential');
          } else if (state.exception is MissingPasswordAuthException) {
            await showErrorDialog(context: context, text: 'Missing Passwrord');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
                context: context, text: 'Authentication error');
          } else if (state.exception
              is UserCancelLoginWithGoogleAuthException) {
            await showErrorDialog(context: context, text: 'User cancels login');
          }
        }
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Login'),
        ),
        backgroundColor: Color(0xffe5e5e5),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                      width: (MediaQuery.of(context).size.width) / 2,
                      child: Image.asset(
                        'assets/images/xcar-195x195-black.png',
                        fit: BoxFit.contain,
                      )),
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _emailController,
                    autocorrect: false,
                    cursorColor: Colors.grey,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12),
                        ),
                        borderSide: BorderSide(width: 1, color: Colors.black54),
                      ),
                      prefixIconColor: Colors.grey,
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    cursorColor: Colors.grey,
                    obscureText: _hiddenPassword,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock_person_outlined),
                        semanticCounterText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _hiddenPassword = !_hiddenPassword;
                            });
                          },
                          icon: Icon(
                            _hiddenPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 24,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black54),
                        ),
                        prefixIconColor: Colors.grey,
                        suffixIconColor: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot password',
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width) * (2 / 3),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow[700],
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              AuthEventLogIn(
                                  email: _emailController.text,
                                  password: _passwordController.text),
                            );
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  const Text(
                    'Or continues with',
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              elevation: 1,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(999)))),
                          label: const Text(
                            'Facebook',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          icon: Image.asset(
                            'assets/images/facebook.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            context
                                .read<AuthBloc>()
                                .add(const AuthEventLogInWithGoogle());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              elevation: 1,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(999)))),
                          label: const Text(
                            'Google',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          icon: Image.asset(
                            'assets/images/google.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have account',
                      ),
                      TextButton(
                          onPressed: () {
                            context
                                .read<AuthBloc>()
                                .add(const AuthEventShouldRegister());
                          },
                          child: const Text(
                            'Register',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ))
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
