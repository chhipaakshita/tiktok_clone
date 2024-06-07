import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tiktok_clone/authentication/login_screen.dart';
import 'package:tiktok_clone/model/authentication_controller.dart';

import '../widgets/input_text_widget.dart';
import 'global.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  var authenticationController = AuthenticationController.instanceAuth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),

                Text("Create Account",style:GoogleFonts.acme(
                    fontSize: 34,
                    color:Colors.grey,
                    fontWeight:FontWeight.bold
                )),
                Text("to get started Now! ",style:GoogleFonts.acme(
                  fontSize: 34,
                  color:Colors.grey,
                  //fontWeight:FontWeight.bold
                )),

                SizedBox(
                  height: 16,
                ),
                //profile avatar
                GestureDetector(
                  onTap: (){
                    //allow user to choose image
                    authenticationController.captureImageWithCamera();
                  },
                  child: const CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("images/profile.jpg"),
                    backgroundColor: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                //user name input
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: InputTextWidget(
                      textEditingController: username,
                      labelString: "Username",
                      isObscure: false,
                      iconData: Icons.person_outline
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: InputTextWidget(
                      textEditingController: email,
                      labelString: "Email",
                      isObscure: false,
                      iconData: Icons.email_outlined
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child:  InputTextWidget(
                    textEditingController: password,
                    labelString: "password",
                    isObscure: true,
                    iconData:Icons.lock_outline ,),
                ),
                SizedBox(
                  height: 30,
                ),
                //login button
                showProgressBar == false ?
                Column(
                  children: [
                    //signup button
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 54,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: InkWell(
                        onTap: (){
                          print("signup");
                         if(authenticationController.profileImage != null
                             && email.text.isNotEmpty &&
                             username.text.isNotEmpty &&
                             password.text.isNotEmpty){
                           print("inside condition");
                           //create account for new user
                           setState(() {
                             print("progress bar");
                             showProgressBar = true;
                           });
                           authenticationController.createAccountForNewUser(
                               authenticationController.profileImage!,
                               username.text,
                               email.text,
                               password.text
                           );
                         }
                        },
                        child: Center(
                          child: Text("Sign Up",style: TextStyle(
                              fontSize: 20,
                              color: Colors.black ,
                              fontWeight: FontWeight.w700
                          ),),
                        ),
                      ),
                    ),
                    //not have account => signup button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey
                          ),),
                        SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(LoginScreen());
                            //send user to signup screen
                          },
                          child: Text(" Login Now",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                        )
                      ],
                    )
                  ],
                ) : Container(
                  child: SimpleCircularProgressBar(
                    progressColors: [
                      Colors.green,
                      Colors.blueAccent,
                      Colors.red,
                      Colors.amber,
                      Colors.purpleAccent
                    ],
                    animationDuration: 3,
                    backColor: Colors.white38,
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
