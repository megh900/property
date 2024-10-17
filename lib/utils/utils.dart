class Utils {
  static final _emailRegex = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final _passwordRegex = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@%!#*?&])(?=.*\W)");
  static final _areaRegex = RegExp(r"\b(\d+(\.\d+)?)\s*(?:sq\s*ft|ft\s*²|square\s*feet)\b");

  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  static bool isValidPassword(String password){
    return _passwordRegex.hasMatch(password);
  }

  static bool isValidContact(String contact){
    return contact.length == 10;
  }

  static bool isValidarea(String area) {
    return _areaRegex.hasMatch(area);
  }

}
