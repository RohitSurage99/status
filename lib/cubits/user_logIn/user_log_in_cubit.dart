import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status/helpers/string_helper.dart';
import '../../helpers/storage_helper.dart';
import '../../network_manager/rest_client.dart';
import '../../routes/routes_name.dart';
import '../../utils/connectivity.dart';
import '../../utils/toast_message.dart';
part 'user_log_in_state.dart';

class UserLogInCubit extends Cubit<UserLogInState> {
  UserLogInCubit() : super(UserLogInInitial());


  userLogIn (BuildContext context, String email, String password, bool rememberMe) async {
    if(!await isNetworkAvailable()){toastMessage(AppString.connectYourInternet);
    }else{
      emit(UserLogInLoading());

      // String fcmToken = await PushNotification().getDeviceToken();

      var params = json.encode(
          {
            "email":email,
            "password": password,
            "deviceToken": '',
            "deviceId": StorageHelper().getDeviceId(),
            "deviceType": Platform.isIOS ? 'iOS' : 'Android'
          }
      );

print("login params ========> ${params}");

      RestClient.userLogIn(params).then((value){
        if(value.success == true){
          StorageHelper().setUserBearerToken(value.data?.token??"");
          StorageHelper().setUserId(value.data?.updatedUser?.sId??"");
          StorageHelper().setUserEmail(value.data?.updatedUser?.email??"");
          StorageHelper().setUserMobileNumber(value.data?.updatedUser?.phoneNumber.toString()??"");
          StorageHelper().setUserName(value.data?.updatedUser?.name.toString()??"");
          StorageHelper().setProfileImage(value.data?.updatedUser?.profilePicture.toString()??"");
          rememberMe == true ? StorageHelper().setIsFirstLaunch() : StorageHelper().setIsFirstLaunch(value: false);
          // Navigator.pushNamedAndRemoveUntil(context, RouteName.syncWatchData, (route) => false);

          emit(UserLogInLoaded());

        }else{
          toastMessage(AppString.somethingWentWrong);
          emit(UserLogInError());
        }


      }).onError((error, stackTrace){
        emit(UserLogInError());
      });
    }
  }
}
