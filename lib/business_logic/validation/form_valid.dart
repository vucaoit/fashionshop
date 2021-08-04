class FormValid{
  bool isEmail(String email){
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (email.length == 0) {
      return false;
    }
    else if (!regExp.hasMatch(email)) {
      return false;
    }
    return true;
  }
  bool isPassword(String password){
    if(password.isNotEmpty&&password.length>5)return true;
    return false;
  }
  bool isName(String name){
    if(name.isNotEmpty&&name.length>5)return true;
    return false;
  }

  bool isPhoneNumber(String phoneNumber){
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (phoneNumber.length == 0) {
      return false;
    }
    else if (!regExp.hasMatch(phoneNumber)) {
      return false;
    }
    return true;
  }
}