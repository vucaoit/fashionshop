import 'package:fashionshop/views/ui/page/widget/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fashionshop/business_logic/blocs/register_Bloc.dart';
import 'package:fashionshop/views/ui/page/widget/formRegister.dart';
class RegisterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterPage();
  }

}
class _RegisterPage extends State<RegisterPage>{
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final RegisterBloc _registerBloc = new RegisterBloc();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarWidget().bottomNavBar(context,"profile"),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(//header start
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(//image logo
                              height: 100,
                              width: 100,
                              child: SvgPicture.asset(
                                "assets/images/log.svg",
                              ),
                            ),
                            Container(//title header
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "REGISTER",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "Please fill out\nthe form below",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  ),//header end
                  Expanded(//form login
                      flex: 8,
                      child: RegisterFormWidget().RegisterForm(_nameController,_phoneController,_emailController, _passwordController, _registerBloc, context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}