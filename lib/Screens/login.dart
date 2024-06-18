import 'package:banquetbookz_vendor/Colors/coustcolors.dart';
import 'package:banquetbookz_vendor/Providers/auth.dart';
import 'package:banquetbookz_vendor/Providers/phoneauthnotifier.dart';
import 'package:banquetbookz_vendor/Providers/stateproviders.dart';
import 'package:banquetbookz_vendor/Widgets/elevatedbutton.dart';
import 'package:banquetbookz_vendor/Widgets/heading.dart';
import 'package:banquetbookz_vendor/Widgets/text.dart';
import 'package:banquetbookz_vendor/Widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _validationkey = GlobalKey<FormState>();

  final TextEditingController _edtxtNum = TextEditingController();
  final TextEditingController _edtxtpwd = TextEditingController();
 // String sBtnName = "Next"; //Button Name
  bool bOtp = false; // check for valid mobile num
  late String sOtp;
  Color btnColor = CoustColors.colrButton1;
  bool _isButtonDisabled = true;

// Function to check if a string is a valid email
  bool isValidEmail(String value) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(value);
  }

  // Function to check if a string is a valid number
  bool isValidNumber(String value) {
    final numberRegex = RegExp(r'^\d+$');
    return numberRegex.hasMatch(value);
  }

  void resendOTP() {
    // Add your OTP resend logic here
    print("OTP Resent");
  }

  void forgotpwd(BuildContext context, WidgetRef ref) {
    ref.read(enablepasswaorProvider.notifier).state = 0;
    ref.read(buttonColorprovider.notifier).state = CoustColors.colrButton1;
    Navigator.of(context).pushNamed('/forgotpwd');
  }

  void onrgistration(BuildContext context) {
    Navigator.of(context).pushNamed('/registration');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: <Widget>[
        Expanded(
          child: Container(
            child: Heading(
              sText1: "Welcome to BanquetBookz",
              sText2:
                  "Enter your Email/Mobile Number to Sign-in to your account",
              //bVisibil: true,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                  color: CoustColors.colrFill,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Form(
                        key: _validationkey,
                        child: Consumer(
                          builder: (BuildContext context, WidgetRef ref,
                              Widget? child) {
                           var sBtnName = ref.watch(buttonTextProvider);
                            btnColor = ref.watch(
                                buttonColorprovider); // get button name from provider
                            bOtp = ref.watch(VerifyOtp ); // enablepasswaorProvider from provider

                            var isPwdVisible = ref
                                .watch(enablepasswaorProvider); // Get provider

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CoustTextfield(
                                  radius: 8.0,
                                  width: 10,
                                  isVisible: false,
                                  hint: "Email/mobileNumber",
                                  iconwidget: iconwidget(Icons.person,(ref.watch(
                                                          buttonColorprovider)),),
                                  controller: _edtxtNum,
                                  inputtype: TextInputType.emailAddress,
                                  onChanged: (_edtxtNum) {
                                    if (_edtxtNum == null ||
                                        _edtxtNum.isEmpty) {
                                      ref
                                              .read(enablepasswaorProvider.notifier)
                                              .state =
                                          0; // If num textfield is null invisble pwd field
                                    } else {
                                      if (isValidNumber(_edtxtNum)) {
                                        // ref
                                        //     .read(
                                        //         enablepasswaorProvider.notifier)
                                        //     .state = 1;
                                        ref
                                            .read(buttonColorprovider.notifier)
                                            .state = CoustColors.colrButton3;
                                        ref
                                                .read(buttonTextProvider.notifier)
                                                .state =
                                            "Next";
                                       } // Set Name for button based on textfield content
                                      // } else if (isValidEmail(_edtxtNum)) {
                                      //   ref
                                      //       .read(
                                      //           enablepasswaorProvider.notifier)
                                      //       .state = 2;
                                      //   ref
                                      //       .read(buttonTextProvider.notifier)
                                      //       .state = "Login";
                                      //   ref
                                      //       .read(buttonColorprovider.notifier)
                                      //       .state = CoustColors.colrButton3;
                                      // } else {
                                      //   ref
                                      //       .read(buttonColorprovider.notifier)
                                      //       .state = CoustColors.colrButton1;
                                      //   ref
                                      //       .read(buttonTextProvider.notifier)
                                      //       .state = "Next";
                                      // }
                                      else{
                                         ref
                                            .read(
                                                enablepasswaorProvider.notifier)
                                            .state = 2;
                                        ref
                                            .read(buttonTextProvider.notifier)
                                            .state = "Login";
                                        ref
                                            .read(buttonColorprovider.notifier)
                                            .state = CoustColors.colrButton3;
                                      }
                                    }

                                    return null;
                                  },
                                  validator: (_edtxtNum) {
                                    if (_edtxtNum == null ||
                                        _edtxtNum.isEmpty) {
                                      return 'Please enter a valid email address or number';
                                    }
                                    if (isValidNumber(_edtxtNum)) {
                                      print("num:" +
                                          "${isValidNumber(_edtxtNum)}");
                                      if (_edtxtNum.length < 10) {
                                        return 'Enter valid Mobile Number';
                                      } else {
                                        print("elsel:${_edtxtNum.length}");
                                        return null;
                                      }
                                    }
                                    // } else if (!isValidEmail(_edtxtNum)) {
                                    //   print("mail:" +
                                    //       "${isValidEmail(_edtxtNum)}");
                                    //   return "Pleasee enter valid emial Id";
                                    // }
                                     else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    isPwdVisible != 0 // if it is 1(otp enable)
                                        ? ((isPwdVisible ==
                                                    2) && //if it is 2 (pwd enable)
                                                (isPwdVisible != 0))
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    child: CoustTextfield(
                                                      controller: _edtxtpwd,
                                                      isVisible: false,
                                                      hint: "Password",
                                                      iconwidget: iconwidget(Icons.password,(ref.watch(
                                                          buttonColorprovider)),),
                                                      radius: 8.0,
                                                      width: 10,
                                                      validator: (_edtxtpwd) {
                                                        if (_edtxtpwd == null ||
                                                            _edtxtpwd.isEmpty) {
                                                          return 'Please enter password';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      forgotpwd(context, ref);
                                                    },
                                                    child: const coustText(
                                                      sName: "Forgot Password",
                                                      decoration: TextDecoration
                                                          .underline,
                                                      txtcolor: CoustColors
                                                          .colrEdtxt2,
                                                      textsize: 15,
                                                      decorationcolor:
                                                          CoustColors
                                                              .colrEdtxt2,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: OTPTextField(
                                                      otpFieldStyle: OtpFieldStyle(
                                                          borderColor:
                                                              CoustColors
                                                                  .colrEdtxt2,
                                                          focusBorderColor:
                                                              CoustColors
                                                                  .colrEdtxt2),
                                                      onChanged: (value) {
                                                        //check_mobile_exists (Using post ) 200
                                                        print(
                                                            "Otp Value ${value}");
                                                        sOtp = value;
                                                      },
                                                      length: 6,
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: _isButtonDisabled
                                                        ? null
                                                        : resendOTP,
                                                    child: const coustText(
                                                        sName: 'Resend OTP'),
                                                  ),
                                                ],
                                              )
                                        : Container(),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: CoustElevatedButton(
                                    buttonName: (ref.watch(buttonTextProvider)),
                                    width: double.infinity,
                                    bgColor: (ref.watch(buttonColorprovider)),
                                    radius: 8,
                                    FontSize: 20,
                                    onPressed: () {
                                      if (_validationkey.currentState!.validate()) {
                                           if((isPwdVisible == 0)&&(sBtnName == "Next")){      // Phone Number entered
                                                  // Send Sms and set button text to login also strt timer
                                                   ref
                                                .read(authprovider.notifier)
                                                .numCheck(context,
                                                    _edtxtNum.text.trim(), ref);
                                           } else if((isPwdVisible == 1)&&(sBtnName =="Login")){   // Receiver password and verify it
                                             print('Login : signInWithPhoneNumber');
                                             ref
                                                .read(
                                                    phoneAuthProvider.notifier)
                                                .signInWithPhoneNumber(
                                                    sOtp,
                                                    context,
                                                    ref,
                                                    _edtxtNum.text.trim(),
                                                    true,email:_edtxtNum.text.trim(),password:_edtxtpwd.text.trim(), );
                                           } else if(isPwdVisible == 2){   // Email entered
                                                  //Connet to server
                                                ref .read(authprovider.notifier).loginwithpassword(context, _edtxtNum.text.trim(), _edtxtpwd.text.trim(), ref);
                                           } else{
                                             print('Login : No Con Stisfied ${isPwdVisible} && ${sBtnName}');
                                           }
 



                                          }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                const coustText(
                                  sName: "Don't have an account?",
                                  textsize: 15,
                                ),
                                TextButton(
                                  onPressed: () {
                                    onrgistration(context);
                                  },
                                  child: const coustText(
                                    sName: "Get Started",
                                    decoration: TextDecoration.underline,
                                    txtcolor: CoustColors.colrEdtxt2,
                                    textsize: 15,
                                    decorationcolor: CoustColors.colrEdtxt2,
                                  ),
                                ),
                              ],
                            );
                          },
                        )),
                  ))),
        )
      ]),
    ));
  }

  Widget iconwidget(IconData icon,Color suficonColor) {
    return Container(
      padding: EdgeInsets.all(10), // Padding for the circular effect
      child: CircleAvatar(
        radius: 15,
        backgroundColor: suficonColor,
        child: Icon(
          icon,
          color: CoustColors.colrFill,
          size: 20,
        ),
      ),
    );
  }
}
