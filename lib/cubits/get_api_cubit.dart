
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status/components/print_value.dart';
import 'package:status/helpers/string_helper.dart';
import 'package:status/network_manager/http_helper.dart';
import 'package:status/utils/connectivity.dart';
import 'package:status/utils/toast_message.dart';

part 'get_api_state.dart';

class GetApiCubit extends Cubit<GetApiState> {
  GetApiCubit() : super(GetApiInitial());
  List dataList  = [];
  getApiFun() async {
    if (!await isNetworkAvailable()) {
      toastMessage(AppString.connectYourInternet);
    } else {
      emit(GetApiLoading());
      try {
        final data = await fetchPosts();
        dataList = data;
        emit(GetApiLoaded(data));
      } catch (error) {
        toastMessage(AppString.somethingWentWrong);
        emit(GetApiError());
        printValue(error.toString(), tag: "FetchPosts Error");
      }
    }
  }


}
