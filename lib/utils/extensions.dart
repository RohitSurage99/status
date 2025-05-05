extension ExtendedString on String{
  String get capsFirst{
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}





