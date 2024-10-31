import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_proved/Controller/auth_controller.dart';
import 'package:news_proved/View/Screens/auth/sign_up.dart';

class SignInPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());  // Using Get.put to ensure instance creation
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => authController.isLoading.value
            ? const Center(child: CircularProgressIndicator()) // Shows loading when processing
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Email Input Field
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextField(
                          controller: email,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email',
                          )),
                    ),
                    const SizedBox(height: 10),
                    
                    // Password Input Field
                    TextField(
                        obscureText: true,
                        controller: password,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Password',
                        )),
                    const SizedBox(height: 20),
                    
                    // Sign In Button
                    InkWell(
                      onTap: () {
                        authController.userLogin(email.text, password.text);
                      },
                      child: Container(
                          color: Colors.red,
                          height: 40,
                          child: const Center(
                              child: Text(
                            "Sign In",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                    ),
                    const SizedBox(height: 40),
                    
                    // Sign Up Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? "),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )));
  }
}
