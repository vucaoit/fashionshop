import 'package:fashionshop/views/ui/page/widget/bottomNavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fashionshop/business_logic/blocs/login_Bloc.dart';
import 'package:fashionshop/views/ui/page/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fashionshop/views/ui/page/widget/formLogin.dart';
import '../page/widget/widget.dart';
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginBloc _loginBloc = new LoginBloc();
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
                            InkWell(
                              onTap: (){Navigator.pushNamed(context, home_route);},
                              child: Container(//image logo
                                height: 100,
                                width: 100,
                                child: SvgPicture.asset(
                                  "assets/images/log.svg",
                                ),
                              ),
                            ),
                            Container(//title header
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "WELCOME TO MY SHOP",
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
                      child: FormLoginWidget().LoginForm(_emailController, _passwordController, _loginBloc, context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
