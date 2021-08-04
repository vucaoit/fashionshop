import 'package:fashionshop/business_logic/dialog/loadingDialog.dart';
import 'package:fashionshop/business_logic/dialog/msgDialog.dart';
import 'package:fashionshop/views/ui/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fashionshop/business_logic/blocs/login_Bloc.dart';
import 'package:fashionshop/business_logic/blocs/register_Bloc.dart';
import 'package:fashionshop/views/ui/page/widget/widget.dart';
import 'package:image_picker/image_picker.dart';

import '../routes.dart';
class RegisterFormWidget{
  Widget RegisterForm(TextEditingController nameController,TextEditingController phoneController,TextEditingController emailController, TextEditingController passwordController ,RegisterBloc registerBloc,BuildContext context){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30))),
      padding: EdgeInsets.only(
          top: 40, bottom: 20, left: 30, right: 30),
      child: Form(
        child: Column(
          children: [
            StreamBuilder(
                stream: registerBloc.nameStream,
                builder: (context, snapshot) {
                  return CustomWidget().customTextFormField(
                      "Enter your name",
                      nameController,
                      snapshot,
                      Icons.person,
                      false);
                }),
            StreamBuilder(
                stream: registerBloc.phoneStream,
                builder: (context, snapshot) {
                  return CustomWidget().customTextFormField(
                      "Enter your phone number",
                      phoneController,
                      snapshot,
                      Icons.phone,
                      false);
                }),
            StreamBuilder(
                stream: registerBloc.emailStream,
                builder: (context, snapshot) {
                  return CustomWidget().customTextFormField(
                      "Enter your email",
                      emailController,
                      snapshot,
                      Icons.email,
                      false);
                }),
            StreamBuilder(
                stream: registerBloc.passwordStream,
                builder: (context, snapshot) {
                  return CustomWidget().customTextFormField(
                      "Enter your password",
                      passwordController,
                      snapshot,
                      Icons.lock,
                      true);
                }),
            Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 10),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.red,
                    onPressed: () {
                      _clickRegister(context,registerBloc,nameController,phoneController,emailController,passwordController);
                    },
                    child: Container(
                      child: Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ))),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {Navigator.pushNamed(context, login_route);},
                      child: Text("Back to Login")),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  _clickRegister(BuildContext context,RegisterBloc registerBloc,TextEditingController nameController,TextEditingController phoneController,TextEditingController emailController, TextEditingController passwordController) {
    if (registerBloc.isValidInfo(nameController.text,phoneController.text, emailController.text, passwordController.text)) {
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      registerBloc.Register(nameController.text, phoneController.text,
          emailController.text, passwordController.text, () {
            LoadingDialog.hideLoadingDialog(context);
            Navigator.pushNamed(context, home_route);
          }, (msg) {
            LoadingDialog.hideLoadingDialog(context);
            MsgDialog.showMsgDialog(context, "Register", msg);
            // show msg dialog
          });
    }
  }

}