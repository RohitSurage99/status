import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status/helpers/string_helper.dart';
import '../../network_manager/rest_client.dart';
import '../../utils/connectivity.dart';
import '../../utils/toast_message.dart';
part 'resend_otp_state.dart';

class ResendOtpCubit extends Cubit<ResendOtpState> {
  ResendOtpCubit() : super(ResendOtpInitial());

  resendOtp (String email, BuildContext context) async {
    if(!await isNetworkAvailable()){
      toastMessage(AppString.connectYourInternet);
    }else{
      emit(ResendOtpLoading());

      var params = json.encode({"email":email});
      RestClient.resendOtp(params).then((value){
        emit(ResendOtpLoaded());
        toastMessage(value.message??"");
        toastMessage('Please use otp for verification : ${value.data?.otp??""}');

      }).onError((error, stackTrace){
        emit(ResendOtpError());
      });
    }
  }
}
