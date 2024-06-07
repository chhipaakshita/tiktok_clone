import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:tiktok_clone/authentication/register_screen.dart';
import 'package:tiktok_clone/widgets/input_text_widget.dart';
import 'package:get/get.dart';

import '../model/authentication_controller.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showProgressBar = false;
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
              Image.asset("images/tiktok.png",width: 200,),
              Text("Welcome",style:GoogleFonts.acme(
                fontSize: 34,
                color:Colors.grey,
                  fontWeight:FontWeight.bold
              )),
              Text("Glad to See You!! ",style:GoogleFonts.acme(
                  fontSize: 34,
                  color:Colors.grey,
                  //fontWeight:FontWeight.bold
              )),
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


                        if(email.text.isNotEmpty && password.text.isNotEmpty){
                          setState(() {
                            showProgressBar = true;
                          });
                          authenticationController.logInUser(
                              email.text,
                              password.text
                          );
                        }
                      },
                      child: Center(
                        child: Text("Login",style: TextStyle(
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
                      Text("Don't have an account?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey
                        ),),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: (){
                          Get.to(RegisterScreen());
                          //send user to signup screen
                        },
                        child: Text(" SignUp Now",
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
      )
    );
  }
}
