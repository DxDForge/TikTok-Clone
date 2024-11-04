import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_proved/Controller/auth_controller.dart';
import 'package:news_proved/View/Screens/auth/sing_in.dart';
import 'package:news_proved/constant.dart';

class SignUpPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Obx(() => authController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator()) // Loading indicator
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "N-Proved",
                      style: TextStyle(
                          color: buttonColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 60),
                    ),
                    const Text('Create a new account',
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                            fontSize: 20)),
                    const Text('it\'s easy & quick ',
                        style: TextStyle(color: Colors.white60, fontSize: 15)),
                    const SizedBox(
                      height: 40,
                    ),
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 65,
                          backgroundImage: NetworkImage(
                              'https://as1.ftcdn.net/v2/jpg/05/60/26/08/1000_F_560260880_O1V3Qm2cNO5HWjN66mBh2NrlPHNHOUxW.jpg'),
                        ),
                        Positioned(
                          right: -10,
                          bottom: 10,
                          child: IconButton(
                            onPressed: () => authController.pickImage(),
                            icon: const Icon(Icons.image),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Name Input Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Name',
                          )),
                    ),
                    const SizedBox(height: 20),

                    // Email Input Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                          controller: email,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email),
                            labelText: 'Email',
                          )),
                    ),
                    const SizedBox(height: 20),

                    // Password Input Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                          obscureText: true,
                          controller: password,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Password',
                          )),
                    ),
                    const SizedBox(height: 30),

                    // Sign Up Button
                    InkWell(
                      onTap: () {
                        authController.userRegistration(
                            email.text,
                            password.text,
                            name.text,
                            authController.profile_pic);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.red,
                            ),
                            height: 60,
                            child: const Center(
                                child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ))),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Sign In Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                          },
                          child: const Text(
                            ' Sign In',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )));
  }
}
