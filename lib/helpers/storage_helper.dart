import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:status/main.dart';
import 'package:status/routes/routes_name.dart';

class StorageHelper {
  StorageHelper._();
  static final StorageHelper storageHelper = StorageHelper._();

  factory StorageHelper (){
    return storageHelper;
  }

  late SharedPreferences _pref;

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<void> clear({String? routeName}) async{
    // try{
    //   if(StorageHelper().getUserLogInType() == 'google'){
    //     await GoogleSignIn().signOut();
    //   }
    //   else if (StorageHelper().getUserLogInType() == 'Apple'){
    //     await FirebaseAuth.instance.signOut();
    //   }
    // }catch (e){
    //   printValue(tag: 'Error while signout && clear data:=====> ',e.toString());
    // }
    _pref.clear();
    Navigator.pushNamedAndRemoveUntil(navigatorKey.currentContext!, routeName??RouteName.logIn, (route) => false);
    debugPrint("LOGOUT ISSUE: clearing local pref");
  }


  void setIsFirstLaunch({value}){_pref.setBool("isLoginYes", value ?? true);}
  bool getIsFirstLaunch(){return _pref.getBool('isLoginYes')??false;}

  void setIsRemember(){_pref.setBool("setIsRememberYes", false);}
  bool getIsRemember(){return _pref.getBool('setIsRememberYes')??false;}


  void setDeviceId(String id) {_pref.setString('device_id', id);}
  String getDeviceId()  {return _pref.getString('device_id')??"";}

  void setDeviceType(String type) {_pref.setString('device_Type', type);}
  String getDeviceType()  {return _pref.getString('device_Type')??"";}


  void setProfileImage(String type) {_pref.setString('profilePic', type);}
  String getProfileImage()  {return _pref.getString('profilePic')??"";}



  void setDefaultLocation(String defaultLocation){_pref.setString("user_default_location", defaultLocation);}
  String getDefaultLocation(){return _pref.getString('user_default_location')??'';}

  void setDefaultLocationId(String defaultLocationId){_pref.setString("user_default_location_id", defaultLocationId);}
  String getDefaultLocationId(){return _pref.getString('user_default_location_id')??'';}

  void setDefaultLocationZipCode(String zipcode){_pref.setString("user_default_location_zipcode", zipcode);}
  String getDefaultLocationZipCode(){return _pref.getString('user_default_location_zipcode')??'';}

  void setUserName(String userName) {_pref.setString('user_name', userName);}
  String getUserName() {return _pref.getString('user_name')??"";}

  void setUserBearerToken(String token) {_pref.setString('user_token', token);}
  String getUserBearerToken()  {return _pref.getString('user_token')??"";}

  void setUserId(String userId) {_pref.setString('user_id', userId);}
  String getUserId()  {return _pref.getString('user_id')??"";}

  void setUserEmail(String email) {_pref.setString('user_email', email);}
  String getUserEmail() {return _pref.getString('user_email')??"";}

  void setUserMobileNumber(String mobileNumber) {_pref.setString('user_mobile_number', mobileNumber);}
  String getUserMobileNumber() {return _pref.getString('user_mobile_number')??"";}

  void setUserCountryCode(String countryCode)  {_pref.setString('user_country_code', "($countryCode)");}
  String getUserCountryCode() {return _pref.getString('user_country_code')??"";}

  void setUserLogInType(String type) {_pref.setString('user_login_type', type);}
  String getUserLogInType() {return _pref.getString('user_login_type')??"";}

  void setCharityId(String id) {_pref.setString('user_charity_id', id);}
  String getCharityId() {return _pref.getString('user_charity_id')??"";}

  void setCharityName(String name) {_pref.setString('user_charity_name', name);}
  String getCharityName() {return _pref.getString('user_charity_name')??"";}



  void setTutorialCoachMark() {_pref.setBool('tutorial_coach_mark', false);}
  bool getTutorialCoachMark() {return _pref.getBool('tutorial_coach_mark')??true;}




}