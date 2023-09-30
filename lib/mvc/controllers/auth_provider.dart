import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamefinity/mvc/models/users_model.dart';
import 'package:gamefinity/mvc/utils/alert_dialog.dart';
import 'package:gamefinity/network/api_exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  final alertDialog = CustomAlertDialog();

  void checkException(DioException error, BuildContext context) {
    ApiExceptions exceptions = ApiExceptions();
    List<String> errorMessage = exceptions.getExceptionMessage(error);

    alertDialog.showCustomAlert(
      context: context,
      title: errorMessage[0],
      content: errorMessage[1],
    );
  }

  Stream<UsersModel?> get user {
    return auth.authStateChanges().map((User? user) => (user != null)
        ? UsersModel(
            id: user.uid,
            email: user.email,
            password: user.phoneNumber,
            name: user.displayName,
            role: user.tenantId,
            avatar: user.tenantId,
            creationAt: null,
            updatedAt: null)
        : null);
  }

  Future<void> signInUserWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      await auth.signInWithCredential(credential);
    } catch (e) {
      log('error sign in using google: $e');
    }
  }

  Future<void> createUserWithEmail(String emailAddress, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password);

      log('$userCredential');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signInUserWithEmail(
      String emailAddress, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      log('$credential');
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        log('show time');
        alertDialog.showCustomAlert(
          context: context,
          title: e.code,
          content: e.message!,
        );
      }
      log(e.code);
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOutUser() async {
    try {
      auth.signOut();
    } catch (e) {
      log('error login out: $e');
    }
  }
}
