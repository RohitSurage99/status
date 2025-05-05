import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:status/components/print_value.dart';
import 'package:status/helpers/storage_helper.dart';
import 'package:status/models/error_response_model/api_error_response_model.dart';
import 'package:status/routes/routes_name.dart';
import 'package:status/utils/toast_message.dart';
import 'api_constant.dart';
import 'api_exceptions.dart';

class HttpHelper {
  static final HttpHelper _getInstance = HttpHelper._internal();

  HttpHelper._internal();

  factory HttpHelper() {
    return _getInstance;
  }

  Map<String, String> header (bool isRequireAuthorization) {
    if(isRequireAuthorization){
      return {
        "Content-type": "application/json",
        "Authorization": 'Bearer ${StorageHelper().getUserBearerToken()}',
      };
    }else{
      return {
        "Content-type": "application/json",
      };
    }
  }



  Future<Map<String, dynamic>> get({required String url, bool isRequireAuthorization = false}) async {
    Map<String, dynamic> responseData;

    try {
      final apiResponse = await http.get(Uri.parse(url), headers: header(isRequireAuthorization));

      printValue(url ,tag: "API GET URL: ",);
      printValue(header(isRequireAuthorization) ,tag: "API Header: ",);
      printValue(apiResponse.body ,tag: "API RESPONSE",);

      responseData = _returnResponse(response: apiResponse);
    } on SocketException {
      Map<String, dynamic> responseData = {};
      return responseData;
    }
    return responseData;
  }




  Future<Map<String, dynamic>> post(
      {required String url,
        String body ='',
        bool isRequireAuthorization = false}) async {


    Map<String, dynamic> responseData;

    try {
      final apiResponse = await http.post(Uri.parse(url), body: body, headers: header(isRequireAuthorization));

      printValue(url ,tag: "API POST URL: ",);
      printValue(body ,tag: "API REQ BODY: ",);
      printValue(header(isRequireAuthorization) ,tag: "API Header: ",);
      printValue(apiResponse.body ,tag: "API RESPONSE",);

      responseData = _returnResponse(response: apiResponse);
    } on SocketException {
      Map<String, dynamic> responseData = {};
      return responseData;
    }

    return responseData;
  }


  Future<Map<String, dynamic>> put(
      {required String url,
        String body = '',
        bool isRequireAuthorization = false}) async {

    Map<String, dynamic> responseData;

    try {
      http.Response apiResponse;

      if (body.isEmpty) {
        apiResponse = await http.put(Uri.parse(url), headers: header(isRequireAuthorization));
      } else {
        apiResponse = await http.put(Uri.parse(url), headers: header(isRequireAuthorization), body: body);
      }


      printValue(url ,tag: "API POST URL: ",);
      printValue(body ,tag: "API REQ BODY: ",);
      printValue(header(isRequireAuthorization) ,tag: "API Header: ",);
      printValue(apiResponse.body ,tag: "API RESPONSE",);

      responseData = _returnResponse(response: apiResponse);
    } on SocketException {
      Map<String, dynamic> responseData = {};
      return responseData;
    }
    return responseData;
  }



  Future<Map<String, dynamic>> patch(
      {required String url,
        String body = '',
        bool isRequireAuthorization = false}) async {

    Map<String, dynamic> responseData;

    try {
      http.Response apiResponse;

      if (body.isEmpty) {
        apiResponse = await http.patch(Uri.parse(url), headers: header(isRequireAuthorization));
      } else {
        apiResponse = await http.patch(Uri.parse(url), headers: header(isRequireAuthorization), body: body);
      }


      printValue(url ,tag: "API POST URL: ",);
      printValue(body ,tag: "API REQ BODY: ",);
      printValue(header(isRequireAuthorization) ,tag: "API Header: ",);
      printValue(apiResponse.body ,tag: "API RESPONSE",);

      responseData = _returnResponse(response: apiResponse);
    } on SocketException {
      Map<String, dynamic> responseData = {};
      return responseData;
    }
    return responseData;
  }


  Future<Map<String, dynamic>> delete(
      {required String url, bool isRequireAuthorization = false}) async {

    Map<String, dynamic> responseData;

    try {
      final apiResponse =
      await http.delete(Uri.parse(url), headers: header(isRequireAuthorization));

      printValue(url ,tag: "API DELETE URL: ",);
     // printValue(body ,tag: "API REQ BODY: ",);
      printValue(header(isRequireAuthorization) ,tag: "API Header: ",);
      printValue(apiResponse.body ,tag: "API RESPONSE",);
      responseData = _returnResponse(response: apiResponse);
    } on SocketException {
      Map<String, dynamic> responseData = {};
      return responseData;
    }

    return responseData;
  }



  Future<Map<String, dynamic>> uploadProfileForm({
    File? file,
    String? fileName,
    required String url,
    Map<String, String>? params,
    bool isRequireAuthorization = false,
  }) async {
    var request = http.MultipartRequest('PUT', Uri.parse(url));
    if (file != null) {
      var multipartFile = await http.MultipartFile.fromPath(
        'image',
        file.path,
        filename: fileName ?? 'image',
      );
      request.files.add(multipartFile);
    }


    if (params != null) {
      request.fields.addAll(params.map((key, value) => MapEntry(key, value.toString())));
    }

    if (isRequireAuthorization) {
      request.headers.addAll(header(isRequireAuthorization));
    }

    Map<String, dynamic> responseData;

    final res = await request.send();


    String value = await res.stream.bytesToString();
    responseData = jsonDecode(value);
    printValue(jsonDecode(value));
    return responseData;
  }

//-------------multipart post type data ----------------

  Future<Map<String, dynamic>> createSupportForm({
    File? file,
    String? fileName,
    required String url,
    String imageKeyName = 'attachment',
    Map<String, String>? params,
    bool isRequireAuthorization = false,
  }) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Attach File
      if (file != null) {
        var multipartFile = await http.MultipartFile.fromPath(
          imageKeyName,
          file.path,
          filename: fileName ?? 'image',
        );
        request.files.add(multipartFile);
      }

      // Attach Params
      if (params != null) {
        request.fields.addAll(params); // params already Map<String, String>
      }

      // Attach Headers
      if (isRequireAuthorization) {
        request.headers.addAll(header(isRequireAuthorization));
      }

      // Send Request
      final res = await request.send();
      final responseString = await res.stream.bytesToString();

      // Decode JSON response
      Map<String, dynamic> responseData = jsonDecode(responseString);
      printValue(responseData);

      return responseData;
    } catch (e) {
      return {"error": "Failed to upload support form"};
    }
  }

}

Map<String, dynamic> _returnResponse({required http.Response response}) {
  switch (response.statusCode) {
    case 200:
      var responseJson =
      json.decode(response.body.toString()) as Map<String, dynamic>;
      return responseJson;

    case 201:
      var responseJson =
      json.decode(response.body.toString()) as Map<String, dynamic>;
      return responseJson;

    case 400:
      var decodeError = json.decode(response.body.toString()) as Map<String, dynamic>;
      toastMessage(decodeError['message'].toString());
      throw BadRequestException(response.body.toString());

    case 401:
      StorageHelper().clear(routeName: RouteName.logIn);
      var errorResponse = ApiErrorResponseModel(
          success: false,
          message: "authorized 401",
          );

     throw UnauthorisedException(json.encode(errorResponse));

    case 403:
      throw InvalidInputException(response.body.toString());

    case 404:
      throw BadRequestException(response.body.toString());

    case 500:
      var errorResponse = ApiErrorResponseModel(
          success: false,
          message: "Error occurred while Communication with Server with StatusCode 500",);
      toastMessage(errorResponse.message??'');
      throw FetchDataException(json.encode(errorResponse));

    default:
      var errorResponse = ApiErrorResponseModel(
          success: false,
          message: "Error occurred while Communication with Server with StatusCode ${response.statusCode}",);
      toastMessage(errorResponse.message??'');
      throw FetchDataException(json.encode(errorResponse));
  }
}



Future<List<dynamic>> fetchPosts() async {
  final url = Uri.parse(ApiConstant.getApi);

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error occurred: $e');
  }
}


