part of 'resend_otp_cubit.dart';

@immutable
sealed class ResendOtpState {}

final class ResendOtpInitial extends ResendOtpState {}

final class ResendOtpLoading extends ResendOtpState {}

final class ResendOtpLoaded extends ResendOtpState {}

final class ResendOtpError extends ResendOtpState {}
