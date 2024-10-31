import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_proved/Controller/auth_controller.dart';
import 'package:news_proved/View/Screens/auth/sing_in.dart';

class SignUpPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => authController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator()) // Loading indicator
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    const SizedBox(height: 10),
                    // Name Input Field
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextField(
                          controller: name,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Name',
                          )),
                    ),
                    const SizedBox(height: 10),

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

                    // Sign Up Button
                    InkWell(
                      onTap: () {
                        authController.userRegistration(
                            email.text,
                            password.text,
                            name.text,
                            authController.profile_Pic);
                      },
                      child: Container(
                          color: Colors.red,
                          height: 40,
                          child: const Center(
                              child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))),
                    ),
                    const SizedBox(height: 40),

                    // Sign In Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                          },
                          child: const Text(
                            'Sign In',
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
