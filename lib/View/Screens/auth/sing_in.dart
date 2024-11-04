

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_proved/Controller/auth_controller.dart';
import 'package:news_proved/View/Screens/auth/sign_up.dart';
import 'package:news_proved/constant.dart';

class SignInPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController name = TextEditingController();

  SignInPage({super.key});

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
                    Text("N-Proved",style: TextStyle(color: buttonColor,fontWeight: FontWeight.bold,fontSize: 60 ),),
                    const Text('Create a new account',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w500,fontSize: 20)),
                    const Text('it\'s easy & quick ',style: TextStyle(color: Colors.white60,fontSize: 15)),
                    const SizedBox(height: 40,),

                    const SizedBox(height: 20),

                    // Email Input Field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                          controller: email,
                          decoration: const InputDecoration(
                            border:OutlineInputBorder() ,
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
                            border:OutlineInputBorder() ,
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Password',
                          )),
                    ),
                    const SizedBox(height: 30),

                    // Sign Up Button
                    InkWell(
                      onTap: () {
                        authController.userLogin(email.text, password.text);
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
                              "Sign In",
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
                        const Text("Don't have an account? ",style: TextStyle(color: Colors.white70,fontSize: 16),),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()));
                          },
                          child: const Text(
                            ' Sign Up',
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













// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:news_proved/Controller/auth_controller.dart';
// import 'package:news_proved/View/Screens/auth/sign_up.dart';

// class SignInPage extends StatelessWidget {
//   final AuthController authController = Get.put(AuthController());  // Using Get.put to ensure instance creation
//   final TextEditingController email = TextEditingController();
//   final TextEditingController password = TextEditingController();

//   SignInPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Obx(() => authController.isLoading.value
//             ? const Center(child: CircularProgressIndicator()) // Shows loading when processing
//             : SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Email Input Field
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: TextField(
//                           controller: email,
//                           decoration: const InputDecoration(
//                             prefixIcon: Icon(Icons.email),
//                             labelText: 'Email',
//                           )),
//                     ),
//                     const SizedBox(height: 20),
                    
//                     // Password Input Field
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: TextField(
//                           obscureText: true,
//                           controller: password,
//                           decoration: const InputDecoration(
//                             border:OutlineInputBorder() ,
//                             prefixIcon: Icon(Icons.lock),
//                             labelText: 'Password',
//                           )),
//                     ),
//                     const SizedBox(height: 20),
                    
//                     // Sign In Button
//                     InkWell(
//                       onTap: () {
//                         authController.userLogin(email.text, password.text);
//                       },
//                       child: Container(
//                           color: Colors.red,
//                           height: 40,
//                           child: const Center(
//                               child: Text(
//                             "Sign In",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ))),
//                     ),
//                     const SizedBox(height: 40),
                    
//                     // Sign Up Link
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Don't have an account? "),
//                         InkWell(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SignUpPage()));
//                           },
//                           child: const Text(
//                             'Sign Up',
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red),
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               )));
//   }
// }
