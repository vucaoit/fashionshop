import 'package:fashionshop/business_logic/blocs/resetpassword_bloc.dart';
import 'package:fashionshop/business_logic/dialog/loadingDialog.dart';
import 'package:fashionshop/business_logic/dialog/msgDialog.dart';
import 'package:fashionshop/views/ui/page/routes.dart';
import 'package:fashionshop/views/ui/page/widget/widget.dart';
import 'package:flutter/material.dart';
class ForgetPasswordPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _forgotPassword();
  }

}
class _forgotPassword extends State<ForgetPasswordPage> {
  ResetPasswordBloc _resetPasswordBloc = new ResetPasswordBloc();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(top: 40),
            child: Column(
                children: [
                CustomWidget().customText("RESET PASSWORD",FontWeight.bold, 20, Colors.cyan),
                  StreamBuilder(
                    stream: _resetPasswordBloc.emailStream,
                    builder: (context,snapshot){
                      return CustomWidget().customTextFormField("Enter your email", _emailController, snapshot, Icons.email, false);
                    },
                  ),
                  Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.only(top: 10),
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.red,
                          onPressed: () {
                            _clickSend(_emailController.text);
                          },
                          child: Container(
                            child: Text(
                              "Send request",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))),
                  Container(
                      height: 50,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      margin: EdgeInsets.only(top: 10),
                      child: FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.red,
                          onPressed: () {
                            Navigator.pushNamed(context, login_route);
                          },
                          child: Container(
                            child: Text(
                              "Back to login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )))
            ]),
      ),
    ),);
  }
  _clickSend(String email){
    if(_resetPasswordBloc.isvalidemail(email)){
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      _resetPasswordBloc.sendEmail(email,() {
        LoadingDialog.hideLoadingDialog(context);Navigator.pushNamed(context, login_route);},(msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "ChangePass", msg);
        // show msg dialog
      });
    }
  }
}