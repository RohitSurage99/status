import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status/helpers/string_helper.dart';
import '../../helpers/storage_helper.dart';
import '../../network_manager/rest_client.dart';
import '../../utils/connectivity.dart';
import '../../utils/toast_message.dart';
import '../../routes/routes_name.dart';
part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(VerifyOtpInitial());

  verifyOtp (BuildContext context, Map userSignupData, int otp, bool isForgot) async {

    if(!await isNetworkAvailable()){
      toastMessage(AppString.connectYourInternet);
    }else{
      emit(VerifyOtpLoading());

      var params = json.encode(
          {
            "email":userSignupData['email'],
            "otp":otp
          }
      );

      RestClient.verifyOtp(params).then((value){

        emit(VerifyOtpLoaded());

        StorageHelper().setUserBearerToken(value?.data?.token??"");
        StorageHelper().setUserId(value?.data?.user?.sId??"");
        StorageHelper().setIsFirstLaunch();

        if (isForgot == true){
          Navigator.pushReplacementNamed(context, RouteName.resetPassword, arguments: {"data": "email"});
        }else {
          // Navigator.pushReplacementNamed(context, RouteName.syncWatchData);
        }
      }).onError((error, stackTrace){
        emit(VerifyOtpError());
      });
    }
  }
}
