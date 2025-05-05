import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:status/helpers/assets_helper.dart';
import 'package:status/helpers/string_helper.dart';
import 'package:status/utils/globle_context.dart';
import '../../components/app_buttons.dart';
import '../../components/text_fiels.dart';
import '../../cubits/user_logIn/user_log_in_cubit.dart';
import '../../helpers/color_helper.dart';
import '../../helpers/dimens_helper.dart';
import '../../helpers/font_helper.dart';
import '../../helpers/storage_helper.dart';
import '../../network_manager/auth_device_data.dart';
import '../../routes/routes_name.dart';
import '../../utils/loading_indicator.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    UserAuthenticationApis().getId();
    super.initState();
  }

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: DimensHelper.dimens_20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.globalSize.height/DimensHelper.dimens_60),
              const Center(child: Text(AppString.appName)),
              SizedBox(height: context.globalSize.height/DimensHelper.dimens_30),

              const Text(AppString.signIn, style: TextStyle(
                  color: ColorHelper.primaryColor,
                  fontSize: FontHelper.size_22,
                  fontWeight: FontHelper.bold),),

              const SizedBox(height: DimensHelper.dimens_20,),

              EmailTextField(controller: emailController,
                currentFocus: emailFocusNode,
                nextFocus: passwordFocusNode,),

              const SizedBox(height: DimensHelper.dimens_20,),

              PasswordTextField(
                controller: passwordController, currentFocus: passwordFocusNode,),

              const SizedBox(height: DimensHelper.dimens_20,),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.scale(
                    scale: 0.6,
                    child: CupertinoSwitch(
                      value: rememberMe,
                      onChanged: (bool value) {
                        setState(() {
                          rememberMe = value;
                        });
                      },
                      activeColor: ColorHelper.primaryColor,
                      trackColor: ColorHelper.greyIcon2Color,
                    ),
                  ),
                  // const SizedBox(width: DimensHelper.dimens_10,),
                  const Text(AppString.rememberMe, style: TextStyle(
                      color: ColorHelper.greyColor,
                      fontWeight: FontHelper.regular,
                      fontSize: FontHelper.size_14)),
                   SizedBox(width: context.globalSize.width/DimensHelper.dimens_8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, RouteName.forgotPassword),
                      child: const Text(AppString.forgotPassword, style: TextStyle(
                          color: ColorHelper.greyColor,
                          fontWeight: FontHelper.regular,
                          fontSize: FontHelper.size_14)
                      ),
                    ),
                  ),
                ],
              ),


              Padding(
                padding:  EdgeInsets.symmetric(
                    horizontal: context.globalSize.width/DimensHelper.dimens_20,
                    vertical: context.globalSize.height/DimensHelper.dimens_40
                ),
                child: Column(
                  children: [


                    logInButton(),

                    SizedBox(height: context.globalSize.height/DimensHelper.dimens_40),

                    Row(
                      children: [
                        Expanded(child: Container(height: 2,
                          color: ColorHelper.grey300,
                          margin: const EdgeInsets.only(
                              right: DimensHelper.dimens_8),)),
                        const Text(AppString.or, style: TextStyle(
                            color: ColorHelper.primaryColor,
                            fontSize: FontHelper.size_14,
                            fontWeight: FontHelper.regular),),
                        Expanded(child: Container(height: 2,
                          color: ColorHelper.grey300,
                          margin: const EdgeInsets.only(left: DimensHelper.dimens_8),)),
                      ],
                    ),


                    SizedBox(height: context.globalSize.height/DimensHelper.dimens_40),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(AppString.doNotHaveAnAccount, style: TextStyle(
                            color: ColorHelper.black,
                            fontWeight: FontHelper.regular,
                            fontSize: FontHelper.size_16)),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RouteName.signUp);
                            },
                            child: const Text(AppString.signUp, style: TextStyle(
                                color: ColorHelper.primaryColor,
                                fontWeight: FontHelper.bold,
                                fontSize: FontHelper.size_16,
                                // decoration: TextDecoration.underline,
                                decorationColor: ColorHelper.primaryColor),)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logInButton() {
    return BlocProvider(
      create: (_) => UserLogInCubit(),
      child: BlocBuilder<UserLogInCubit, UserLogInState>(
          builder: (context, state) {
            return CommonButton(
              onPress: () {
                if (state is UserLogInLoading) {} else {
                  if (_formKey.currentState!.validate()) {
                    context.read<UserLogInCubit>().userLogIn(
                        context, emailController.text.toString(),
                        passwordController.text.toString(),
                        rememberMe
                    );
                  }
                }
              },
              child:
              state is UserLogInLoading ? loadingButton() :
              arrowButtonRow(
                title: AppString.signIn,
                leftIconColor: Colors.transparent,
                rightIconColor: ColorHelper.secondaryColor,
              ),
            );
          }
      ),
    );
  }
}




Widget arrowButtonRow({
  required String title,
  Color leftIconColor = Colors.transparent,
  Color titleColor = Colors.white,
  Color rightIconColor = ColorHelper.primaryColor,
  Color rightArrowIconColor = ColorHelper.primaryColor
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Icon(Icons.arrow_forward, color: leftIconColor ?? ColorHelper.primaryColor),
        ),
      ),
      Text(
        title.toUpperCase(),
        style: TextStyle(
          color: titleColor ?? ColorHelper.whiteColor,
          fontSize: FontHelper.size_18,
          fontWeight: FontHelper.bold,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: rightIconColor,
          child: Icon(Icons.arrow_forward, color: rightArrowIconColor ?? ColorHelper.primaryColor),
        ),
      ),
    ],
  );
}