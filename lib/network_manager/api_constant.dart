class ApiConstant {
  ApiConstant._();
  static final ApiConstant apiConstant = ApiConstant._();

  factory ApiConstant (){
    return apiConstant;
  }


  static String apiBaseUrl = '/api';
  static  String imageUrlBaseUrl = '/files/';

  /// API Urls
  static String signUp = '$apiBaseUrl/auth/registration';
  static String verifyOTP = '$apiBaseUrl/auth/verifyOtp';
  static String resendOTP = '$apiBaseUrl/auth/resendOtp';
  static String logIn = '$apiBaseUrl/auth/login';
  static String resetPassword = '$apiBaseUrl/auth/resetPassword';

  //---get api
  static String getApi = 'https://jsonplaceholder.typicode.com/posts';







}