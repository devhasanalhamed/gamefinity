import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gamefinity/generated/l10n.dart';
import 'package:gamefinity/mvc/controllers/auth_provider.dart';
import 'package:gamefinity/mvc/controllers/settings_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:particles_flutter/particles_flutter.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  late GlobalKey<FormState> formKey;
  bool isLogin = true;

  void toggleState() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  void initState() {
    formKey = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    // final screenSize = MediaQuery.of(context).size;
    final formData = {};
    void onSubmitForm() {
      formKey.currentState!.save();
      log("${formData['username']}, ${formData['password']}");
      if (isLogin) {
        provider.signInUserWithEmail(
          formData['username'],
          formData['password'],
          context,
        );
      } else {
        provider.createUserWithEmail(
          formData['username'],
          formData['password'],
        );
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(S.of(context).title),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton.outlined(
            onPressed: () {
              final x =
                  Provider.of<SettingsProvider>(context, listen: false).local;
              Provider.of<SettingsProvider>(context, listen: false)
                  .updateLocal(x == 'ar' ? 'en' : 'ar');
            },
            icon: const Icon(LucideIcons.languages),
          ),
        ],
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) => CircularParticle(
              key: UniqueKey(),
              awayRadius: 80,
              numberOfParticles: 200,
              speedOfParticles: -1,
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              onTapAnimation: false,
              particleColor: Colors.grey,
              awayAnimationDuration: const Duration(milliseconds: 600),
              maxParticleSize: 2,
              isRandSize: true,
              isRandomColor: true,
              randColorList: [
                Colors.red.withAlpha(210),
                Colors.orange.withAlpha(210),
              ],
              awayAnimationCurve: Curves.easeInOutBack,
              enableHover: true,
              hoverColor: Colors.white,
              hoverRadius: 90,
              connectDots: false, //not recommended
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: kToolbarHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: kToolbarHeight,
                    ),
                    child: LottieBuilder.asset(
                      'assets/animations/fire.json',
                      width: 250,
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: isLogin ? 160 : 240,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          TextFormField(
                            key: UniqueKey(),
                            decoration: InputDecoration(
                              label: Text(S.of(context).email),
                              floatingLabelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.orange,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onSaved: (newValue) =>
                                formData.addAll({'username': newValue}),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            key: UniqueKey(),
                            decoration: InputDecoration(
                              label: Text(S.of(context).password),
                              floatingLabelStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.orange,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onSaved: (newValue) =>
                                formData.addAll({'password': newValue}),
                          ),
                          const SizedBox(height: 16),
                          if (!isLogin)
                            TextFormField(
                              key: UniqueKey(),
                              decoration: InputDecoration(
                                label: Text(S.of(context).confirmPassword),
                                floatingLabelStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.orange,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onSaved: (newValue) => formData
                                  .addAll({'confirmPassword': newValue}),
                            ),
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: isLogin
                          ? S.of(context).haveNoAccount
                          : S.of(context).haveAnAccount,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: isLogin
                                ? S.of(context).createAccount
                                : S.of(context).signIn,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = toggleState),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onSubmitForm,
                    child: Text(
                      isLogin ? S.of(context).signIn : S.of(context).signUp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
