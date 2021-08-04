import 'package:fashionshop/business_logic/blocs/change_password_bloc.dart';
import 'package:fashionshop/business_logic/dialog/loadingDialog.dart';
import 'package:fashionshop/business_logic/dialog/msgDialog.dart';
import 'package:fashionshop/views/ui/page/routes.dart';
import 'package:fashionshop/views/ui/page/widget/widget.dart';
import 'package:flutter/material.dart';
class ChangePasswordPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _changePasswordPage();
  }
}
class _changePasswordPage extends State<ChangePasswordPage>{
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();
  ChangePasswordBloc _changePasswordBloc = new ChangePasswordBloc();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child:
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 50,left: 20,right: 20),
            child: Column(
              children: [
                CustomWidget().customText("CHANGE PASSWORD", FontWeight.bold, 30, Colors.cyan),
                StreamBuilder(
                  stream: _changePasswordBloc.oldPasswordStream,
                  builder: (context,snapshot){
                    return CustomWidget().customTextFormField("Enter your old passowrd", _oldPasswordController, snapshot, Icons.lock_open, false);
                  },
                ),
                StreamBuilder(
                  stream: _changePasswordBloc.oldPasswordStream,
                  builder: (context,snapshot){
                    return CustomWidget().customTextFormField("Enter your old passowrd", _newPasswordController, snapshot, Icons.lock_outline, true);
                  },
                ),
                StreamBuilder(
                  stream: _changePasswordBloc.confirmNewPasswordStream,
                  builder: (context,snapshot){
                    return CustomWidget().customTextFormField("Enter your old passowrd", _confirmNewPasswordController, snapshot, Icons.lock_outline, true);
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
                          _clickChange(context,_oldPasswordController.text, _newPasswordController.text, _confirmNewPasswordController.text);
                        },
                        child: Container(
                          child: Text(
                            "Change now",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )))
              ],
            ),
          ),
        ),
      ),
    );
  }
_clickChange(BuildContext context,String oldpass,String newpass,String confirmpass){
    if(_changePasswordBloc.isvalidform(oldpass, newpass, confirmpass)){
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      _changePasswordBloc.changepassword(context,oldpass,newpass,confirmpass,() {
        LoadingDialog.hideLoadingDialog(context);Navigator.pushNamed(context, edit_profile_route);},(msg) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "ChangePass", msg);
        // show msg dialog
      });
    }
}
}