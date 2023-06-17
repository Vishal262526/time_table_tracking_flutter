import 'package:flutter/material.dart';
import 'package:time_table_tracker_flutter/screens/home_screen.dart';
import 'package:time_table_tracker_flutter/screens/login_screen.dart';
import 'package:time_table_tracker_flutter/servies/auth.dart';
import 'package:time_table_tracker_flutter/utils/colors.dart';
import 'package:time_table_tracker_flutter/utils/text_styles.dart';
import 'package:time_table_tracker_flutter/widgets/primary_button.dart';
import 'package:time_table_tracker_flutter/widgets/primary_input.dart';
import 'package:time_table_tracker_flutter/widgets/snackbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void signUp() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      final registerStatus = await Auth().signupWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      if (registerStatus['success']) {
        navigateToHomeScreen();
      }else{
        showSnackBar(context, registerStatus['err']);
      }
    }else{
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
              "SIGN UP",
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
                prefixIcon: Icons.add, title: "Create Account", onTap: signUp),
            const SizedBox(
              height: 16,
            ),
            PrimaryButton(
              prefixIcon: Icons.arrow_back,
              title: "Go Back",
              backgroundColor: kSecondaryColor,
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen(),),);
              },
            )
          ],
        ),
      ),
    );
  }
}
