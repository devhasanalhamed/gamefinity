import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> test() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        log('user id from authStateChanges: ${user.uid}');
      }
    });

    // final userCredential =
    //     await FirebaseAuth.instance.signInWithCredential(credential);
    // final user = userCredential.user;
    // log('${user?.uid}');

    if (auth.currentUser != null) {
      log('current user from instance: ${auth.currentUser?.uid}');
    }
  }

  Future<void> signUpWithFirebaseUsingEmail(
      String emailAddress, String password) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      log('$credential');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log('$e');
    }
  }

  Future<void> signInWithFirebaseUsingEmail(
      String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      log('$credential');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOutWithFirebase() async {
    await FirebaseAuth.instance.signOut();
  }
}
