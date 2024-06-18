import 'package:banquetbookz_vendor/Colors/coustcolors.dart';
import 'package:banquetbookz_vendor/Providers/auth.dart';
import 'package:banquetbookz_vendor/Screens/addproperty.dart';
import 'package:banquetbookz_vendor/Screens/alltransactions.dart';
import 'package:banquetbookz_vendor/Screens/bookingdetails.dart';
import 'package:banquetbookz_vendor/Screens/dashboard.dart';
import 'package:banquetbookz_vendor/Screens/editprofile.dart';
import 'package:banquetbookz_vendor/Screens/forgotpassword.dart';
import 'package:banquetbookz_vendor/Screens/login.dart';
import 'package:banquetbookz_vendor/Screens/manage.dart';
import 'package:banquetbookz_vendor/Screens/managebookinng.dart';
import 'package:banquetbookz_vendor/Screens/manageproperty.dart';
import 'package:banquetbookz_vendor/Screens/registration.dart';
import 'package:banquetbookz_vendor/Screens/sales.dart';
import 'package:banquetbookz_vendor/Screens/settings.dart';
import 'package:banquetbookz_vendor/Widgets/bottomnavigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banquetbookz Vendor',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto', // Set the default font family
        scaffoldBackgroundColor: CoustColors.colrScaffoldbg,
         elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              maximumSize: Size.fromWidth(double.infinity),
              disabledForegroundColor: CoustColors.colrEdtxt4,
              disabledBackgroundColor: CoustColors.colrButton1,
              foregroundColor: CoustColors.colrEdtxt4,
              backgroundColor: CoustColors.colrButton1,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: CoustColors.colrButton3,
            unselectedItemColor: CoustColors.colrSubText,
          )
      ),
        routes: {
        '/': (context) { return Consumer(
            builder: (context, ref, child) {
              final authState = ref.watch(authprovider);
              // Check if the user is authenticated and profile is complete

              // If the user is not authenticated, attempt auto-login
              return FutureBuilder(
                future: ref.watch(authprovider.notifier).tryAutoLogin(),
                builder: (context, snapshot) {
                  print("print circular");
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Show SplashScreen while waiting
                  } else {
                    // Based on auto-login result, navigate to appropriate screen
                    return snapshot.data == true
                        ? CoustNavigation() //Welcome page
                        : LoginScreen(); //Login page
                  }
                },
              );
            },
          );
        },
        '/forgotpwd': (BuildContext context) {
          return const ForgotpasswordScreen();
        },
        '/registration': (BuildContext context) {
          return const RegistrationScreen();
        },
        '/welcome': (BuildContext context) {//welcome page
          return  const CoustNavigation();
        },
        '/home': (BuildContext context) {//welcome page
          return  const DashboardScreen();
        },
        '/manage': (BuildContext context) {//welcome page
          return  const ManageScreen();
        },
        '/sales': (BuildContext context) {//welcome page
          return  const SalesScreen();
        },
        '/settings': (BuildContext context) {//welcome page
          return  const SettingsScreen();
        },
         '/managebooking': (BuildContext context) {//welcome page
          return  const ManageBookingScreen(); 
         },
         '/bookingdetails': (BuildContext context) {//welcome page
          return  const BookingDetailsScreen(); 
         },
         '/manageproperty': (BuildContext context) {//welcome page
          return  const ManagePropertyScreen(); 
         },
          '/addproperty': (BuildContext context) {//welcome page
          return  const AddPropertyScreen(); 
         },
          '/alltransactions': (BuildContext context) {//welcome page
          return  const TransactionsScreen(); 
         },
         '/editprofile': (BuildContext context) {//welcome page
          return  const EditprofileSceren();
         }
      },
    );
  }
}
