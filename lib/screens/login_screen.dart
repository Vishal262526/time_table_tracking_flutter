import 'package:flutter/material.dart';
import 'package:time_table_tracker_flutter/screens/register_screen.dart';
import 'package:time_table_tracker_flutter/servies/auth.dart';
import 'package:time_table_tracker_flutter/widgets/snackbar.dart';

import '../utils/colors.dart';
import '../utils/text_styles.dart';
import '../widgets/primary_button.dart';
import '../widgets/primary_input.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      final Map loginStatus = await Auth().loginUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      if (loginStatus['success']) {
        navigateToHomeScreen();
      } else {
        showSnackBar(context, loginStatus['err']);
      }
    } else {
      showSnackBar(context, "All Fields are Required");
    }
  }

  void navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "LOG IN",
              style: kHeadingTextStyle,
            ),
            const SizedBox(
              height: 30,
            ),
            PrimaryInput(
              controller: _emailController,
              placeholder: "Email",
            ),
            const SizedBox(
              height: 16,
            ),
            PrimaryInput(
              securetTextEntry: true,
              controller: _passwordController,
              placeholder: "Password",
            ),
            const SizedBox(
              height: 16,
            ),
            PrimaryButton(
              prefixIcon: Icons.done,
              title: "LOG IN",
              onTap: login,
            ),
            const SizedBox(
              height: 16,
            ),
            PrimaryButton(
              backgroundColor: kSecondaryColor,
              prefixIcon: Icons.add,
              title: "SIGN UP",
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
