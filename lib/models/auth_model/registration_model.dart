class RegistrationModel {
  bool? success;
  int? status;
  String? message;
  Data? data;

  RegistrationModel({this.success, this.status, this.message, this.data});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? name;
  String? email;
  int? otp;
  String? otpExpiry;
  bool? isEmailVerified;
  String? password;
  String? countryCode;
  int? phoneNumber;
  bool? isDeleted;
  bool? isOnline;
  bool? isDeactivated;
  bool? isNotificationsEnabled;
  String? lastLogin;
  List<Devices>? devices;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
        this.name,
        this.email,
        this.otp,
        this.otpExpiry,
        this.isEmailVerified,
        this.password,
        this.countryCode,
        this.phoneNumber,
        this.isDeleted,
        this.isOnline,
        this.isDeactivated,
        this.isNotificationsEnabled,
        this.lastLogin,
        this.devices,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    otp = json['otp'];
    otpExpiry = json['otpExpiry'];
    isEmailVerified = json['isEmailVerified'];
    password = json['password'];
    countryCode = json['countryCode'];
    phoneNumber = json['phoneNumber'];
    isDeleted = json['isDeleted'];
    isOnline = json['isOnline'];
    isDeactivated = json['isDeactivated'];
    isNotificationsEnabled = json['isNotificationsEnabled'];
    lastLogin = json['lastLogin'];
    if (json['devices'] != null) {
      devices = <Devices>[];
      json['devices'].forEach((v) {
        devices!.add(Devices.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['otp'] = otp;
    data['otpExpiry'] = otpExpiry;
    data['isEmailVerified'] = isEmailVerified;
    data['password'] = password;
    data['countryCode'] = countryCode;
    data['phoneNumber'] = phoneNumber;
    data['isDeleted'] = isDeleted;
    data['isOnline'] = isOnline;
    data['isDeactivated'] = isDeactivated;
    data['isNotificationsEnabled'] = isNotificationsEnabled;
    data['lastLogin'] = lastLogin;
    if (devices != null) {
      data['devices'] = devices!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Devices {
  String? deviceType;
  String? deviceToken;
  String? deviceId;
  String? loginTimeStamp;
  String? sId;

  Devices(
      {this.deviceType,
        this.deviceToken,
        this.deviceId,
        this.loginTimeStamp,
        this.sId});

  Devices.fromJson(Map<String, dynamic> json) {
    deviceType = json['deviceType'];
    deviceToken = json['deviceToken'];
    deviceId = json['deviceId'];
    loginTimeStamp = json['loginTimeStamp'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['deviceType'] = deviceType;
    data['deviceToken'] = deviceToken;
    data['deviceId'] = deviceId;
    data['loginTimeStamp'] = loginTimeStamp;
    data['_id'] = sId;
    return data;
  }
}
