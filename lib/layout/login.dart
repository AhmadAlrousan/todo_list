
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var fromKey = GlobalKey<FormState>();
  var passwordC = TextEditingController();
  var emailC = TextEditingController();
  bool isv=true;
  bool isv2=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //       Login page created
      appBar: AppBar(
        backgroundColor: Colors.black54,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            // SingleChildScrollView protects against overflow in the app
              child: Form(
                  key: fromKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                      buildTextFormField(context , "email"),
                      // Here call method to create a TextFormField
                      SizedBox(
                    height: 10,
                  ),
                  buildTextFormField(context , "password"),

                      SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              if(fromKey.currentState!.validate()){

                Navigator.of(context).pushNamed("HomeLayout");

              }else{
                print(emailC);
                print(passwordC);
              }

            },
            child: Text("Login"),
            style: ElevatedButton.styleFrom(
              primary: Colors.black54,
              fixedSize: Size(double.maxFinite, 50),
            ),
          ),

          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("dont have an account? "),
              SizedBox(
                width: 10,
              ),
              TextButton(onPressed: () {}, child: Text("Register Now"))
            ],
          )
          ],
        ),
      ),
    ),
    ),
    ),
    );
  }

  TextFormField buildTextFormField(BuildContext context , String name) {
    return TextFormField(
                  controller: name == "password" ? passwordC : emailC,
          // Here each TextField controller gives its own
                  decoration: InputDecoration(
                      label: Text(name),
                      prefixIcon: Icon(name == "password" ? Icons.lock :
                      Icons.email),
                      // Here the icon changes according to the name of the TextField

                      suffixIcon: name == "password" ?IconButton(onPressed:(){
                        setState(() {
                          isv=!isv;
                        });
                      }
                      , icon: Icon(isv ? Icons.visibility: Icons.visibility_off ),) : null,
                      // Change the icon according to the show of the Password
                      enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.8),
                )
                  ),
            obscureText: name == "password" ? isv : isv2,
          // Here to show or hide the password
            validator:
                (val) {
                  // validator Shows some notifications under the TextFormField
              if (val!.isEmpty) {
                // Here, if the TextFormField is empty, it gives an alert
                return "$name is Empty";
              }else if(name=="password"){
                if(val.length < 8){
                  // Here, if the password is less than 8 characters, an alert is given
                  return "$name is less than 8 characters";
                }else {
                 bool resultCapital = validateCapital(val);
                 bool resultSmall = validateSmall(val);
                 bool resultNum = validate_Num(val);
                 bool resultSpecial = validate_Special(val);
                 // Here, a set of if statement to show some alerts in case the password is not typed correctly

                 if (!resultCapital && !resultSmall && !resultNum && !resultSpecial) {
                    return " Please enter Capital & Small character & number & special character ";
                  }else   if (!resultCapital  && !resultNum && !resultSpecial  ){
                    return " Please enter Capital character & number & special character ";
                  }
                 else if (!resultCapital  && !resultSmall  && !resultNum  ){
                   return " Please enter Capital & Small character & number";
                 }
                 else if (!resultCapital  && !resultSmall  && !resultSpecial  ){
                   return "Please enter Capital & Small character & special character";
                 }
                 else if ( !resultSmall && !resultNum  && !resultSpecial  ){
                   return "Please enter Small character & number & special character";
                 }
                 else if ( !resultNum  && !resultSpecial  ){
                   return "Please enter number & special character";
                 }
                 else if ( !resultCapital  && !resultSmall  ){
                   return "Please enter Capital & Small character";
                 }
                 else if ( !resultCapital  && !resultSpecial ){
                   return "Please enter Capital character & special character";
                 }
                 else if ( !resultCapital  && !resultNum  ){
                   return "Please enter Capital character & number";
                 }
                 else if ( !resultSmall  && !resultNum  ){
                   return "Please enter Small character & number";
                 }
                 else if ( !resultSmall  && !resultSpecial  ){
                   return "Please enter Small character & special character";
                 }
                 else if ( !resultCapital  ){
                   return "Please enter Capital character";
                 }
                 else if ( !resultSmall ){
                   return "Please enter Small character";
                 }
                 else if ( !resultNum ){
                   return "Please enter number";
                 }
                 else if (!resultSpecial  ){
                   return "Please enter special character";
                 }

                }
              }else {
                bool result = validateEmail(val);
                if(result){
                  return null;
                }else {

                  return "Check is a correct email expression.";
                }
              }
            });
  }


  // RegExp pass_valid = RegExp
  //   (r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  //
  // bool validatePassword(String pass){
  //   String _password = pass.trim();
  //   if(pass_valid.hasMatch(_password)){
  //     return true;
  //   } else{
  //     return false;
  //   }
  // }

  /// Regular expressions is a Class used to find a matching entry

  RegExp pass_valid_Capital = RegExp
    (r"(?=.*[A-Z])");

  bool validateCapital(String pass){
    String _password = pass.trim();
    if(pass_valid_Capital.hasMatch(_password)){
      return true;
    }else{
      return false;
    }
  }
  RegExp pass_valid_Small = RegExp
    (r"(?=.*[a-z])");

  bool validateSmall(String pass){
    String _password = pass.trim();
    if(pass_valid_Small.hasMatch(_password)){
      return true;
    }else{
      return false;
    }
  }


  RegExp pass_valid_Num = RegExp
    (r"(?=.*\d)");

  bool validate_Num(String pass){
    String _password = pass.trim();
    if(pass_valid_Num.hasMatch(_password)){
      return true;
    }else{
      return false;
    }
  }

  RegExp pass_valid_Special = RegExp
    (r"(?=.*\W)");

  bool validate_Special(String pass){
    String _password = pass.trim();
    if(pass_valid_Special.hasMatch(_password)){
      return true;
    }else{
      return false;
    }
  }
 ///........................................
  RegExp email_valid = RegExp
    ( r"(@)(.)");

  bool validateEmail(String pass){
    String _email = pass.trim();
    if(email_valid.hasMatch(_email)){
      return true;
    }else{
      return false;
    }
  }
}

