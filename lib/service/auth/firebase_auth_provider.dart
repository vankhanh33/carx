// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:carx/service/api/api_service.dart';
import 'package:http/http.dart' as http;

import 'package:carx/firebase_options.dart';
import 'package:carx/model/user.dart';

import 'package:carx/service/auth/auth_exceptions.dart';
import 'package:carx/service/auth/auth_provider.dart';
import 'package:carx/service/auth/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null)
      return AuthUser.fromFirebase(user);
    else
      return null;
  }

  @override
  Future<AuthUser> createUserWithEmail({
    required String email,
    required String password,
    required String name,
    required String confirmPassword,
  }) async {
    if (name.isEmpty) throw NotInputUserNameException();
    if (password != confirmPassword) throw PasswordIncorrectException();

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user != null) {
        await ApiService.fromApi()
            .createUser(id: user.id, name: name, email: email);
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<AuthUser> loginWithEmail(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-login-credentials') {
        throw InvalidLoginCredentialsAuthException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else if (e.code == 'missing-password') {
        throw MissingPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }

  @override
  Future<AuthUser> loginWithPhone({required String phone}) {
    // TODO: implement loginWithPhone
    throw UnimplementedError();
  }

  @override
  Future<void> sendPasswordResetWithEmail({required String email}) {
    // TODO: implement sendPasswordResetWithEmail
    throw UnimplementedError();
  }

  @override
  Future<void> sendPasswordResetWithPhone({required String phone}) {
    // TODO: implement sendPasswordResetWithPhone
    throw UnimplementedError();
  }

  @override
  Future<AuthUser> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      final user = currentUser;
      final userAuth = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await ApiService.fromApi().createUserWithGoogle(
          id: user.id,
          email: user.email,
          image: userAuth?.photoURL,
          name: userAuth?.displayName,
        );
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on PlatformException catch (_) {
      throw UserCancelLoginWithGoogleAuthException();
    } on FirebaseAuthException catch (_) {
      throw GenericAuthException();
    } catch (e) {
      throw GenericAuthException();
    }
  }
}
