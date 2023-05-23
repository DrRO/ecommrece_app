import 'dart:convert';

import 'package:ecommrece_app/registration_api_connection/users/authentication/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../api_connection/api_connection.dart';
import '../model/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, cons){
          return ConstrainedBox(constraints: BoxConstraints(
            minHeight: cons.maxHeight,

          ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //LoginScreen Header
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 285,
                    child: Image.asset('assets/images/login.png'),
                  ),

                  //LoginScreen signin form

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration:const BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),

                          ),
                          boxShadow: [BoxShadow(
                            blurRadius: 8,
                            color: Colors.black12,
                            offset: Offset(0,-3),

                          )]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                        child: Column(
                          children: [
                            Form(
                              key: formKey,
                              child: Column(
                                children: [

                                  //Email
                                  TextFormField(
                                    controller: emailController,
                                    validator: (val)=> val == '' ? 'Please write email' : null ,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                      hintText: 'Email',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.white60
                                          )
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.white60
                                          )
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.white60
                                          )
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.white60
                                          )
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),


                                  ),
                                  const SizedBox(height: 20,),
                                  //password
                                  Obx(
                                          () => TextFormField(
                                        controller: passwordController,
                                        obscureText: isObsecure.value,
                                        validator: (val)=> val == '' ? 'Please write password' : null ,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Icons.vpn_key_sharp,
                                            color: Colors.black,
                                          ),
                                          suffixIcon: Obx(
                                                  ()=> GestureDetector(
                                                onTap: () {
                                                  isObsecure.value =!isObsecure.value;
                                                },
                                                child: Icon(
                                                  isObsecure.value ? Icons.visibility_off : Icons.visibility,
                                                  color: Colors.black,
                                                ),
                                              )
                                          ),


                                          hintText: 'Password',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: Colors.white60
                                              )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: Colors.white60
                                              )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: Colors.white60
                                              )
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30),
                                              borderSide: const BorderSide(
                                                  color: Colors.white60
                                              )
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 6,
                                          ),
                                          fillColor: Colors.white,
                                          filled: true,
                                        ),


                                      )),
                                  const SizedBox(height: 20,),

                                  //button
                                  Material(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: () {
                                        loginUser();
                                      },borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 20,
                                        ),
                                        child:Text(
                                          'Login',
                                          style: TextStyle(color:Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),

                                  )

                                ],
                              ),

                            ),
                            SizedBox(height: 16,),

                            //Text for Register
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an Account'
                                ),
                                TextButton(onPressed: (){
                                  Get.to(SignUpScreen());
                                },child: const Text('Register Now ',style: TextStyle(color:Colors.purpleAccent,
                                    fontSize: 18),
                                ),)
                              ],

                            ),
                            const Text('OR ',style: TextStyle(color:Colors.white60,
                                fontSize: 16)
                            ),

                            //Admin
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Are you an Admin?'
                                ),
                                TextButton(onPressed: (){

                                },child: const Text('click Here ',style: TextStyle(color:Colors.purpleAccent,
                                    fontSize: 18),
                                ),)
                              ],

                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  loginUser() async {
    var response = await http.post(Uri.parse(API.login), body: {
      "user_email": emailController.text.trim(),
      "user_password": passwordController.text.trim(),
    });
    if (response.statusCode == 200) {
      var responseBodyLogin = jsonDecode(response.body);

      if (responseBodyLogin["success"] == true) {
        // success is key at the signup.php file
        Fluttertoast.showToast(msg: "login completed successfully");

        User userInfo = User.fromJson(responseBodyLogin["userData"]);
      } else {
        Fluttertoast.showToast(
            msg: "Write the correct Email Or Password, Please");
      }
    }
  }
}
