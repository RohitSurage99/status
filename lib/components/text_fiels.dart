import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:status/helpers/assets_helper.dart';
import 'package:status/helpers/string_helper.dart';
import '../helpers/color_helper.dart';
import '../helpers/dimens_helper.dart';
import '../helpers/font_helper.dart';


class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? currentFocus, nextFocus;
  final String? hintText, errorMessage;
  final int? maxLine, maxLength;
  final dynamic? icon;
  final TextInputType? textInputType;
  final commanStyle;
  final List<TextInputFormatter>? textInputFormatter;
  const CommonTextField({super.key, required this.controller, this.currentFocus, this.nextFocus,required this.hintText, this.maxLine, this.icon, this.errorMessage, this.textInputType, this.maxLength, this.textInputFormatter, this.commanStyle});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: currentFocus,
      maxLines: maxLine??1,
      maxLength: maxLength,
      textCapitalization: TextCapitalization.words,
      cursorColor: ColorHelper.primaryColor,
      keyboardType: textInputType??TextInputType.text,
      inputFormatters: textInputFormatter??[],
      style: commanStyle ??  const TextStyle(color: ColorHelper.primaryColor,
          fontWeight: FontHelper.medium, fontSize: FontHelper.size_18),
      decoration: InputDecoration(
        hintText: hintText,
        counter: const Offstage(),
        hintStyle: commanStyle ?? const TextStyle(color: ColorHelper.greyColor,
            fontWeight: FontHelper.medium, fontSize: FontHelper.size_18),
        prefixIcon: icon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide: const BorderSide(color: ColorHelper.grey300),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide: const BorderSide(color: ColorHelper.grey300),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide: const BorderSide(color: ColorHelper.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide: const BorderSide(color: ColorHelper.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide: const BorderSide(color: ColorHelper.redColor),
        ),
      ),
      onFieldSubmitted: (String v){
        FocusScope.of(context).requestFocus(nextFocus);
      },
      validator: (val) {
        if(errorMessage?.isNotEmpty??false){
          if(maxLength == null){
            if (val!.isEmpty) {
              return errorMessage;
            }else{
              return null;
            }
          }else{
            if(maxLength != controller.text.length){
              return errorMessage;
            }
          }

        }
        return null;
      },
    );
  }
}

class EmailTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? currentFocus, nextFocus;
  final bool? readOnly;
  const EmailTextField({super.key, required this.controller, this.currentFocus, this.nextFocus, this.readOnly});

  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {

  @override
  void initState() {
    widget.currentFocus?.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    widget.currentFocus?.removeListener;
    widget.currentFocus?.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.currentFocus,
      readOnly: widget.readOnly??false,
      cursorColor: ColorHelper.primaryColor,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: ColorHelper.primaryColor,
          fontWeight: FontHelper.medium,
          fontSize: FontHelper.size_18),
      decoration: InputDecoration(
        fillColor: widget.readOnly==true ? ColorHelper.grey200 : Colors.transparent,
        filled: true,
        hintText: AppString.enterEmailAddress,
        hintStyle: const TextStyle(color: ColorHelper.greyColor,
            fontWeight: FontHelper.medium, fontSize: FontHelper.size_18),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(DimensHelper.dimens_10),
          child: Icon(Icons.email_outlined,
            color: widget.currentFocus!.hasFocus
                ? ColorHelper.primaryColor
                : ColorHelper.greyColor)
        ),
        // const Icon(Icons.email_outlined),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide: const BorderSide(color: ColorHelper.grey300),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide: const BorderSide(color: ColorHelper.grey300),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide: const BorderSide(color: ColorHelper.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide: const BorderSide(color: ColorHelper.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide: const BorderSide(color: ColorHelper.redColor),
        ),
      ),
      onFieldSubmitted: (String v){
        FocusScope.of(context).requestFocus(widget.nextFocus);
      },
      validator: (val) {
        if (val!.isEmpty) {
          return AppString.pleaseEnterEmail;
        } else if (!val.contains('@') && !val.contains('.com')){
          return AppString.enterValidEmail;
        }else{
          return null;
        }
      },
    );
  }
}


class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? currentFocus, nextFocus;
  final String? hintText;

  const PasswordTextField({
    super.key,
    required this.controller,
    this.currentFocus,
    this.nextFocus,
    this.hintText,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  ValueNotifier<bool> obSecurePassword = ValueNotifier(true);
  // FocusNode? currentFocus;



  @override
  void initState() {
    widget.currentFocus?.addListener(() => setState(() {}));
    // widget.currentFocus = widget.currentFocus;
    super.initState();
  }

  @override
  void dispose() {
    widget.currentFocus?.removeListener;
    widget.currentFocus?.dispose();
    obSecurePassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obSecurePassword,
      builder: (context, value, child) {
        return TextFormField(
          controller: widget.controller,
          focusNode: widget.currentFocus,
          obscureText: obSecurePassword.value,
          cursorColor: ColorHelper.primaryColor,
          keyboardType: TextInputType.text,
          obscuringCharacter: "*",
          style: const TextStyle(
            color: ColorHelper.primaryColor,
            fontWeight: FontHelper.medium,
            fontSize: FontHelper.size_18,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText ?? AppString.enterPassword,
            hintStyle: const TextStyle(
              color: ColorHelper.greyColor,
              fontWeight: FontHelper.medium,
              fontSize: FontHelper.size_18,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(DimensHelper.dimens_10),
              child:Icon(Icons.lock_open,
                color: widget.currentFocus!.hasFocus
                ? ColorHelper.primaryColor
                : ColorHelper.greyColor,)
            ),
            suffixIcon: IconButton(
              onPressed: () {
                obSecurePassword.value = !obSecurePassword.value;
              },
              icon: Icon(
                obSecurePassword.value ? Icons.visibility_off : Icons.visibility,
                color: ColorHelper.greyIcon2Color,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
              borderSide: const BorderSide(color: ColorHelper.grey300),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
              borderSide: const BorderSide(color: ColorHelper.grey300),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
              borderSide: const BorderSide(color: ColorHelper.grey300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
              borderSide: const BorderSide(color: ColorHelper.primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
              borderSide: const BorderSide(color: ColorHelper.redColor),
            ),
          ),
          onFieldSubmitted: (String v) {
            FocusScope.of(context).requestFocus(widget.nextFocus);
          },
          validator: (val) {
            if (val!.isEmpty) {
              return AppString.pleaseEnterPassword;
            } else {
              return null;
            }
          },
        );
      },
    );
  }
}


class PhoneNumberTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool? readOnly;
  const PhoneNumberTextField({super.key, required this.controller, this.focusNode, this.readOnly});

  @override
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {


  @override
  void initState() {
    widget.focusNode?.addListener(() => setState(() {}));
    super.initState();
  }


  @override
  void dispose() {
    widget.focusNode?.removeListener;
    widget.focusNode?.dispose();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      cursorColor: ColorHelper.primaryColor,
      readOnly: widget.readOnly ?? false,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        LengthLimitingTextInputFormatter(12),
        FilteringTextInputFormatter.digitsOnly
      ],
      style: const TextStyle(color: ColorHelper.primaryColor,
          fontWeight: FontHelper.medium, fontSize: FontHelper.size_18),
      decoration: InputDecoration(
        fillColor: widget.readOnly==true ? ColorHelper.grey200 : Colors.transparent,
        filled: true,
        hintText: AppString.enterPhoneNumber,
        hintStyle: const TextStyle(color: ColorHelper.greyColor,
            fontWeight: FontHelper.medium, fontSize: FontHelper.size_18),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(DimensHelper.dimens_10),
          child: Icon(Icons.phone_outlined,
              color: widget.focusNode!.hasFocus
                  ? ColorHelper.primaryColor
                  : ColorHelper.greyColor
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide: const BorderSide(color: ColorHelper.grey300),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide: const BorderSide(color: ColorHelper.grey300),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide: const BorderSide(color: ColorHelper.grey300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide:  BorderSide(color:  widget.readOnly==true ? ColorHelper.grey200 :ColorHelper.primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(DimensHelper.dimens_12),
          borderSide: const BorderSide(color: ColorHelper.redColor),
        ),
      ),
      validator: (val) {
        if (val!.isEmpty) {
          return AppString.pleaseEnterPhoneNumber;
        }
          // else if (val.length != 12){
        //   return AppString.enterValidPhoneNumber;
        // }
        else{
          return null;
        }
      },
    );
  }
}
