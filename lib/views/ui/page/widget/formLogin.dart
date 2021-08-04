import 'package:fashionshop/business_logic/dialog/loadingDialog.dart';
import 'package:fashionshop/business_logic/dialog/msgDialog.dart';
import 'package:fashionshop/business_logic/services/firebase/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:fashionshop/business_logic/blocs/login_Bloc.dart';
import 'package:fashionshop/views/ui/page/widget/widget.dart';

import '../routes.dart';

class FormLoginWidget {
  Widget LoginForm(
      TextEditingController emailController,
      TextEditingController passwordController,
      LoginBloc loginBloc,
      BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      padding: EdgeInsets.only(top: 40, bottom: 20, left: 30, right: 30),
      child: Form(
        child: Column(
          children: [
            StreamBuilder(
                stream: loginBloc.emailStream,
                builder: (context, snapshot) {
                  return CustomWidget().customTextFormField("Enter your email",
                      emailController, snapshot, Icons.email, false);
                }),
            StreamBuilder(
                stream: loginBloc.passwordStream,
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
                      _clickLogin(context, loginBloc, emailController,
                          passwordController);
                    },
                    child: Container(
                      child: Text(
                        "LOGIN",
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
                      onPressed: () {Navigator.pushNamed(context, forgot_password_route);}, child: Text("Forgot your password ?")),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, register_route);
                      },
                      child: Text("Create account now"))
                ],
              ),
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlatButton(
                      onPressed: () {},
                      height: 45,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.red,
                      child: Text("Sign in with Google",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal)))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _clickLogin(
      BuildContext context,
      LoginBloc loginBloc,
      TextEditingController emailController,
      TextEditingController passwordController) {
    if (loginBloc.isValidInfo(emailController.text, passwordController.text)) {
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      loginBloc.Login(emailController.text, passwordController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.pushNamed(context, home_route);
      }, (msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Login", msg);
        // show msg dialog
      });
    }
  }
}
