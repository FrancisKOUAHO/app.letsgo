import 'package:LetsGo/views/login/reset_password.dart';
import 'package:LetsGo/views/login/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:LetsGo/theme/LetsGo_theme.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../widgets/custom_app_bar/custom_return_appbar.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }

  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: CustomReturnAppBar('', Colors.transparent, LetsGoTheme.black),
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/SignIn3.png',
                    width: 381,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: 350,
                    height: 300,
                    decoration: const BoxDecoration(),
                    child: const Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 40),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                            child: Text(
                              'Connexion',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(40, 60, 40, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TextField(
                        controller: emailController,
                        cursorColor: LetsGoTheme.lightGrey,
                        cursorWidth: 2,
                        obscureText: false,
                        style: TextStyle(color: LetsGoTheme.black),
                        decoration: InputDecoration(
                          focusColor: LetsGoTheme.main,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: LetsGoTheme.main),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:
                                BorderSide(color: LetsGoTheme.lightGrey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:
                                BorderSide(color: LetsGoTheme.lightGrey),
                          ),
                          hintText: 'Adresse mail',
                          disabledBorder: null,
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          prefixIcon: const Icon(Icons.email_outlined,
                              color: Colors.grey),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: passwordController,
                        cursorColor: Colors.white,
                        cursorWidth: 2,
                        obscuringCharacter: '*',
                        obscureText: passwordVisible,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          focusColor: LetsGoTheme.main,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(color: LetsGoTheme.main),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:
                                BorderSide(color: LetsGoTheme.lightGrey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:
                                BorderSide(color: LetsGoTheme.lightGrey),
                          ),
                          hintText: 'Mot de passe',
                          disabledBorder: null,
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          prefixIcon: const Icon(Icons.lock_outlined,
                              color: Colors.grey),
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(passwordVisible
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            },
                            color: LetsGoTheme.main,
                          ),
                          alignLabelWithHint: false,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(40, 15, 40, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ResetPassword()));
                      },
                      child: Text(
                        'Mot de passe oublié ?',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: LetsGoTheme.main,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 45,
                  width: 200,
                  child: Consumer<AuthenticationProvider>(
                      builder: (context, auth, child) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {});
                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          LetsGoTheme.main,
                        ),
                        elevation: MaterialStateProperty.all(6),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        'Se connecter',
                        style: TextStyle(
                          fontFamily: 'Late',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: LetsGoTheme.white,
                        ),
                      ),
                      onPressed: () {
                        if (emailController.text.isEmpty ||
                            passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Veuillez remplir tous les champs'),
                            ),
                          );
                        } else {
                          auth.loginUser(
                              context: context,
                              email: emailController.text.trim(),
                              password: passwordController.text.trim());
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Vous n\'avez pas de compte ?',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: Text(
                          'Enregistrez-vous',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: LetsGoTheme.main,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
