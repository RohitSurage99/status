part of 'get_api_cubit.dart';

sealed class GetApiState {}

final class GetApiInitial extends GetApiState {}
final class GetApiLoading extends GetApiState {}
final class GetApiLoaded extends GetApiState {
  final List<dynamic> dataList;
  GetApiLoaded(this.dataList);
}

final class GetApiError extends GetApiState {}
