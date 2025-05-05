import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:status/helpers/string_helper.dart';
import 'package:status/utils/globle_context.dart';
import '../../components/app_buttons.dart';
import '../../components/back_button.dart';
import '../../components/print_value.dart';
import '../../cubits/resend_otp/resend_otp_cubit.dart';
import '../../cubits/verify_otp/verify_otp_cubit.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../utils/loading_indicator.dart';
import '../../utils/toast_message.dart';
import 'login_screen.dart';

class VerificationCode extends StatefulWidget {
  final Map args;
  const VerificationCode({super.key, required this.args});

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {

  final TextEditingController verificationCodeController = TextEditingController();

  final StreamController<int> _controller = StreamController<int>.broadcast();
  Timer? _timer;
  int _secondsLeft = 60;

  Map userSignupData = {};

  @override
  void initState() {
    printValue(widget.args);
    if(widget.args.containsKey('userSignupData')){
      userSignupData = widget.args['userSignupData'];
    }
    startTimer ();
    super.initState();
  }


  @override
  void dispose() {
    _timer?.cancel();
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const BackButtonWidget()
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppString.verificationCode, style: TextStyle(color: ColorHelper.primaryColor, fontSize: FontHelper.size_22, fontWeight: FontHelper
                .bold),),

            const SizedBox(height: DimensHelper.dimens_10,),
            Text("${AppString.verificationCodeDes}\ncode on " + userSignupData['email'], style: const TextStyle(color: ColorHelper.greyColor, fontSize:
            FontHelper
                .size_16, fontWeight:
            FontHelper.regular),),

            const SizedBox(height: DimensHelper.dimens_30),

            // Text(userSignupData['email']??"", style: const TextStyle(color: ColorHelper.black, fontSize: FontHelper.size_14, fontWeight: FontHelper
            //     .extraBold),),
            //
            // const SizedBox(height: DimensHelper.dimens_20,),

            PinCodeTextField(
              appContext: context,
              length: 4,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              separatorBuilder: (context, i)=> SizedBox(width: 4.w,),
              hintCharacter: '-',
              // obscureText: false,
              // obscuringCharacter: '*',
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: DimensHelper.dimens_60,
                fieldWidth: DimensHelper.dimens_60,
                inactiveFillColor: ColorHelper.whiteColor,
                inactiveColor: ColorHelper.grey300,
                selectedColor: ColorHelper.primaryColor,
                activeFillColor: ColorHelper.whiteColor,
                activeColor: ColorHelper.grey300,
                selectedFillColor: ColorHelper.whiteColor,
              ),
              animationType: AnimationType.fade,
              cursorColor: ColorHelper.primaryColor,
              textStyle: const TextStyle(fontSize: FontHelper.size_22,
                  color: ColorHelper.primaryColor,
                  fontWeight: FontHelper.medium),
              enableActiveFill: true,
              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              onCompleted: (String v){
                // context.read<VerifyOtpCubit>().otpVarification(routeName,mobileNumber, v, deviceToken);
              },
              onChanged: (value) {
                if(value.length == 4){
                //  context.read<VerifyOtpCubit>().otpVarification(routeName,mobileNumber, value, deviceToken);
                }
              },
            ),

             SizedBox(height: context.globalSize.height/2.5),

            Padding(
              padding:  EdgeInsets.symmetric(
                  horizontal: context.globalSize.width/DimensHelper.dimens_20),
              child: Column(
                children: [

                  BlocProvider(
                    create: (_) => ResendOtpCubit(),
                    child: BlocBuilder<ResendOtpCubit, ResendOtpState>(
                        builder: (context, state) {
                         return Align(
                      alignment: Alignment.center,
                      child: StreamBuilder<int>(
                          stream: _controller.stream,
                          builder: (context, snapshot) {
                            if(_secondsLeft != 0){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(AppString.resendCode,
                                    style: TextStyle(color: ColorHelper.black,
                                        fontWeight: FontHelper.medium, fontSize:
                                        FontHelper.size_16),),
                                  Text(' 0:$_secondsLeft',
                                    style: const TextStyle(color: ColorHelper.primaryColor,
                                        fontSize: FontHelper.size_16,
                                        fontWeight: FontHelper.regular),),
                                ],
                              );
                            }else{
                              return GestureDetector(
                                onTap: (){
                                  _secondsLeft = 60; startTimer();
                                  if(state is ResendOtpLoading){

                                  }else{
                                    context.read<ResendOtpCubit>().resendOtp(userSignupData['email']??"", context);
                                  }
                                },
                                child: const Text(AppString.resendCode,
                                    style: TextStyle(color: ColorHelper.black,
                                        fontWeight: FontHelper.medium, fontSize:
                                        FontHelper.size_16)),
                              );
                            }

                          }
                      ));
                      }
                    ),
                  ),

                  const SizedBox(height: DimensHelper.dimens_30,),


                  verifyButton(),

                ],
              ),
            ),



            //
            // Row(
            //   children: [
            //     const Text(StringHelper.didNotReceiveOTP, style: TextStyle(color: ColorHelper.black, fontWeight: FontHelper.medium, fontSize: FontHelper.size_16),),
            //     GestureDetector(
            //         onTap: (){},
            //         child: const Text(StringHelper.resendCode, style: TextStyle(color: ColorHelper.primaryColor, fontWeight: FontHelper.bold, fontSize: FontHelper.size_16,decoration: TextDecoration.underline,decorationColor: ColorHelper.primaryColor),)),
            //   ],
            // ),
          ],
        ),
      ),

    );
  }


  Widget verifyButton () {
    // final stringHelper = StringHelper.of(context)!;
    return BlocProvider(
      create: (_) => VerifyOtpCubit(),
      child: BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
          builder: (context, state) {
          return CommonButton(
            onPress: (){
              if(verificationCodeController.text.length != 4){
                toastMessage(AppString.enter4DigitOtp);
              }else {
                if(state is VerifyOtpLoading){

                }else{
                  context.read<VerifyOtpCubit>().verifyOtp(
                      context,userSignupData,
                      int.parse(verificationCodeController.text.toString()),
                    false
                  );
                }
              }
              },
            child: state is VerifyOtpLoading? loadingButton():
            arrowButtonRow(
              title: AppString.continues,
              leftIconColor: Colors.transparent,
              rightIconColor: ColorHelper.secondaryColor
          ));
        }
      ),
    );
  }

  startTimer () {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer){
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
        });
        _controller.add(_secondsLeft);
      } else {
        _timer?.cancel();
      }
    });
  }
}
