import 'package:status/models/auth_model/registration_model.dart';
import 'package:status/models/auth_model/resend_otp_model.dart';
import 'package:status/models/auth_model/verify_otp_model.dart';
import 'package:status/models/auth_model/sign_in_model.dart';
import 'package:status/models/get_api_model.dart';


import 'api_constant.dart';
import 'http_helper.dart';

class RestClient {
  static final RestClient getInstance = RestClient._internal();
  RestClient._internal();

  factory RestClient() {
    return getInstance;
  }

  static final HttpHelper _httpHelper = HttpHelper();



  static Future<RegistrationModel> userSignUp(String reqBody) async {
    var result = await _httpHelper.post(url: ApiConstant.signUp, body: reqBody);
    return RegistrationModel.fromJson(result);
  }

  static Future<VerifyOTPModel> verifyOtp(String reqBody) async {
    var result = await _httpHelper.post(url: ApiConstant.verifyOTP, body: reqBody);
    return VerifyOTPModel.fromJson(result);
  }

  static Future<ResendOTPModel> resendOtp(String reqBody) async {
    var result = await _httpHelper.post(url: ApiConstant.resendOTP, body: reqBody);
    return ResendOTPModel.fromJson(result);
  }

  static Future<SignInModel> userLogIn(String reqBody) async {
    var result = await _httpHelper.post(url: ApiConstant.logIn, body: reqBody);
    return SignInModel.fromJson(result);
  }


  static Future<dynamic> getApi() async {
    var result = await _httpHelper.get(url: ApiConstant.getApi,isRequireAuthorization: false);
    return result;
  }






}