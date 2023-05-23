import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/user.dart';
import 'login_screen.dart';
import 'package:ecommrece_app/registration_api_connection/api_connection/api_connection.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  validateUserEmail()async
  {
    try{

     var response =  await http.post(
        Uri.parse(API.validateEmail),
        body: {
          "user_email": emailController.text.trim(),
        },
      );

     if(response.statusCode == 200) // connection of flutter app with api to server is success

     {
       var responseBodyValidation = jsonDecode(response.body);

       if(responseBodyValidation["emailexist"]== true){ // emailexist is key at the validate_email.php file
         Fluttertoast.showToast(msg:"Email is already in someone else use, add other email");

       }else{

         //register and save data in database
         registerAndsaveUserRecord() ;
       }

     }

    }catch(e){
      Fluttertoast.showToast(msg:e.toString());
      print(e.toString());
    }


  }


  registerAndsaveUserRecord()async{
    User userModel = User(
      1,
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim()

    );

    try{
      var response = await http.post(
        Uri.parse(API.signUp),
        body: userModel.toJson(),
      );

      if(response.statusCode == 200){
       var responseBodyregister= jsonDecode(response.body);
       if(responseBodyregister["success"]== true) {
          // success is key at the signup.php file
          Fluttertoast.showToast(msg: "Registration completed successfully");

          setState(() {
            nameController.clear();
            emailController.clear();
            passwordController.clear();
          });
        } else{
         Fluttertoast.showToast(msg:"Registration Error, Try again");

       }
      }
    }catch(e){
      Fluttertoast.showToast(msg:e.toString());
print(e.toString());
    }


  }
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
                  //SignUpScreen Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 18, 8, 8),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: Image.asset('assets/images/SignUp.png'),
                    ),
                  ),

                  //SignUpScreen signin form

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
                                  //Name
                                  TextFormField(
                                    controller: nameController,
                                    validator: (val)=> val == '' ? 'Please write Your Name' : null ,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      hintText: 'Name',
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
                                                onTap: ()
                                                {
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
                                      onTap: (){
                                        if(formKey.currentState!.validate()){
                                          //validate the email
                                          //must be unique
                                          validateUserEmail();
                                        }



                                      },borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 20,
                                        ),
                                        child:Text(
                                          'SignUp',
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

                            //Text for login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('I have an Account'
                                ),
                                TextButton(onPressed: (){
                                  Get.to(LoginScreen());



                                },child: const Text('Login ',style: TextStyle(color:Colors.purpleAccent,
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
      ) ,
    );
  }
}
