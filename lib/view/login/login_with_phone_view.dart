import 'dart:async';

import 'package:flutter/material.dart';


class LoginWithPhoneView extends StatefulWidget {
  const LoginWithPhoneView({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginWithPhoneView> {
  late bool _hiddenPassword;
  int _secondsRemaining = 60;
  bool _isSend = false;

  @override
  void initState() {
    super.initState();
    _hiddenPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      backgroundColor: Color(0xffe5e5e5),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
                width: (MediaQuery.of(context).size.width) / 2,
                child: Image.asset(
                  'assets/images/xcar-195x195-black.png',
                  fit: BoxFit.contain,
                )),
            const Text(
              'Login by phone number',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            const TextField(
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                hintText: 'Phone number or email',
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
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 220,
                child: TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                      hintText: 'Verify code',
                      prefixIcon: const Icon(Icons.countertops_rounded),
                      suffixIcon: TextButton(
                        child: Text(_isSend ? '$_secondsRemaining' : 'Send'),
                        onPressed: () {
                          Timer.periodic(Duration(seconds: 1), (timer) {
                            setState(
                              () {
                                if (_secondsRemaining <= 0) {
                                  _isSend = false;
                                } else {
                                  _isSend = true;
                                }
                                _secondsRemaining--;
                              },
                            );
                          });
                        },
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
                        borderSide: BorderSide(width: 1, color: Colors.black54),
                      ),
                      prefixIconColor: Colors.grey,
                      suffixIconColor: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow[700],
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                ),
                onPressed: () {},
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'You have an account',
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Login',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ))
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
