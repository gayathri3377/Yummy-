import 'package:flutter/material.dart';
import 'package:sizzle/pages/home_page.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  //register method
  void register() async {
    //authentication here

    //get auth service
    final _authService = AuthService();

    //check if passwords match -> create user
    if(passwordController.text == confirmPasswordController.text) {
      //try creating user
      try {
        await _authService.signUpWithEmailPassword(
            emailController.text,
            passwordController.text,
        );
      }
      
      //display any errors
      catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }

    //if passwords don't match -> show error
    else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords don't match!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.fastfood_outlined,
              size: 100,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),

            const SizedBox(height: 25),

            //message app slogan
            Text(
              "Let's create an account for you",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),

            const SizedBox(height: 25),

            //email text-field
            MyTextField(
              controller: emailController,
              hintText: "E-mail",
              obscureText: false,
            ),

            const SizedBox(height: 10),

            //password text-field
            MyTextField(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),

            //confirm password text-field
            MyTextField(
              controller: confirmPasswordController,
              hintText: "Confirm Password",
              obscureText: true,
            ),

            const SizedBox(height: 25),

            //sign up button
            MyButton(
              text: "Sign Up",
              onTap: register,
            ),

            const SizedBox(height: 25),

            //already have an account? Login here
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Login now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}