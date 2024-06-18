import 'dart:ui';

import 'package:banquetbookz_vendor/Colors/coustcolors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

final loadingProvider = StateProvider<bool>((ref) => false);
final loadingProvider2 = StateProvider<bool>((ref) => false);

final buttonTextProvider = StateProvider<String>((ref) => "Next");  // To change Button Name in login Page
final buttonColorprovider = StateProvider<Color>((ref) => CoustColors.colrButton1);
final enablepasswaorProvider = StateProvider<int>((ref) => 0);  // To set visibility of Pwd /Otp field  0= invisbale , 1= otp visble, 2= password visble
final VerifyOtp = StateProvider<bool>((ref) => false);  // After veryfying otp to login into app
final isPasswordSent = StateProvider<bool>((ref) => false);  // After sending password in forgot password
final latlangs = StateProvider<LatLng>((ref) => LatLng(17.3850, 78.4867));  // set cutrren latlang to hyderabad
final refundissued = StateProvider<bool>((ref) => false);  // After click cancle& refund to disply refund details
final canclebuttonprovider = StateProvider<Color>((ref) => CoustColors.colrButton2);