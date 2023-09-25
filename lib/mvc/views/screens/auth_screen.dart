import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gamefinity/generated/l10n.dart';
import 'package:gamefinity/mvc/controllers/auth_provider.dart';
import 'package:gamefinity/mvc/controllers/settings_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  GlobalKey<FormState> _formKey = GlobalKey();
  bool isLogin = true;

  void toggleState() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    void onSubmitForm() {}

    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                key: _formKey,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: isLogin ? 160 : 240,
                  child: ListView(
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
                        ),
                    ],
                  ),
                ),
              ),
              if (isLogin)
                RichText(
                  text: TextSpan(
                    text: S.of(context).haveNoAccount,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                          text: S.of(context).createAccount,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = toggleState),
                    ],
                  ),
                ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false)
                      .signUpWithFirebaseUsingEmail(
                    'therealhassan@gmail.com',
                    '123456',
                  );
                },
                child: Text(
                  isLogin ? S.of(context).signIn : S.of(context).signUp,
                ),
              ),
              if (!isLogin)
                TextButton(
                  onPressed: toggleState,
                  child: Text(
                    S.of(context).signIn,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
