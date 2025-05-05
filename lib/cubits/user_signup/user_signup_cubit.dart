import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status/cubits/user_signup/user_signup_state.dart';
import 'package:status/helpers/string_helper.dart';
import '../../helpers/storage_helper.dart';
import '../../network_manager/rest_client.dart';
import '../../routes/routes_name.dart';
import '../../utils/connectivity.dart';
import '../../utils/toast_message.dart';

class UserSignupCubit extends Cubit<UserSignupState> {
  UserSignupCubit() : super(UserSignupInitial());


  userSignUp (BuildContext context,
      String fullName ,
      String email,
      String password,
      String mobileNumber) async {
    if(!await isNetworkAvailable()){
      toastMessage(AppString.connectYourInternet);
    }else{

      emit(UserSignupLoading());

      // String fcmToken = await PushNotification().getDeviceToken();


      var params = json.encode(
          {
            "name": fullName,
              "email":email,
              "password":password,
              "phoneNumber":mobileNumber,
              "countryCode": "",
              // "deviceToken": fcmToken,
              "deviceId": StorageHelper().getDeviceId(),
              "deviceType": Platform.isIOS ? 'iOS' : 'Android'
            }
      );
      RestClient.userSignUp(params).then((value){
        emit(UserSignupLoaded());
        if(value.success == true){
          Map userSignupData = {
          "name": fullName,
          "email":email,
          "password":password,
          "countryCode": "",
          "phoneNumber":mobileNumber,
          // "deviceToken":fcmToken,
          "deviceId": StorageHelper().getDeviceId(),
          "deviceType": Platform.isIOS ? 'iOS' : 'Android'
          };

          StorageHelper().setUserEmail(value.data?.email??"");
          StorageHelper().setUserMobileNumber(value.data?.phoneNumber.toString()??"");
          StorageHelper().setUserName(value.data?.name.toString()??"");
          Navigator.pushNamed(context, RouteName.verificationCode,
              arguments: {
                'userSignupData': userSignupData,
              });
        }else{
          toastMessage(AppString.somethingWentWrong);
        }
        //----showing otp here --------
        toastMessage('Please use otp for verification : ${value.data?.otp??""}');

      }).onError((error, stackTrace){
        emit(UserSignupError());
      });
    }
  }
}
