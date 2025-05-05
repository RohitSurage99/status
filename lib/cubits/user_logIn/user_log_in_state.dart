part of 'user_log_in_cubit.dart';

@immutable
sealed class UserLogInState {}

final class UserLogInInitial extends UserLogInState {}

final class UserLogInLoading extends UserLogInState {}

final class UserLogInLoaded extends UserLogInState {}

final class UserLogInError extends UserLogInState {}
