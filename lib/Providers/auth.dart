import 'dart:convert';
import 'package:banquetbookz_vendor/Models/authstate.dart';
import 'package:banquetbookz_vendor/Providers/phoneauthnotifier.dart';
import 'package:banquetbookz_vendor/Providers/stateproviders.dart';
import 'package:banquetbookz_vendor/utils/bbapi.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState());
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      print('trylogin is false');
      return false;
    }

    final extractData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    if (state.token == null) {
      state = state.copyWith(
        username: extractData['username'],
        mobileno: extractData['mobileno'],
        email: extractData['email'],
        usertype: extractData['usertype'],
        token: extractData['token'],
      );
    }

    print('access token:${state.token}');
    return true;
  }


  Future<void> numCheck(
      BuildContext context, String? phonenum, WidgetRef ref) async {
    const url = Bbapi.mobilecheck;
    print("NumCheck${phonenum}");
    final prefs = await SharedPreferences.getInstance();
    final loadingState = ref.read(loadingProvider2.notifier);
    loadingState.state = true;
    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type':
              'application/json', // Set the content type to application/json
        },
        body: json.encode({"mobileno": phonenum}));
    print("username: $phonenum");
    var userDetails = json.decode(response.body);
    print('booking response:$userDetails');
    switch (response.statusCode) {
      case 200:
        loadingState.state = false;
        print('success');
        ref.read(enablepasswaorProvider.notifier).state = 1;
        ref.read(buttonTextProvider.notifier).state = "Login";
        ref.read(phoneAuthProvider.notifier).phoneAuth(context, "$phonenum", ref);

        break;
      case 400:
        loadingState.state = false;
        print('success');
        showDialog(
          context: context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(cleanErrorMessage(userDetails)),
              actions: [
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );

        break;
      
      case 500:
        loadingState.state = false;
        break;
    }
    // Handle other status codes as needed
  }

  Future<void>  loginOtp(
      BuildContext context, String? token, WidgetRef ref) async {
    const url = Bbapi.login_otp;
    //print("Otp check${otp}");
    final prefs = await SharedPreferences.getInstance();
    String? verificationId = prefs.getString('verificationid');
    final loadingState = ref.read(loadingProvider2.notifier);
    loadingState.state = true;

    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type':
              'application/json', // Set the content type to application/json
        },
        body: json.encode({"token": token}));
    print("verificationId: $verificationId");
    var userDetails = json.decode(response.body);
    print('booking response:$userDetails');
    switch (response.statusCode) {
      case 200:
        loadingState.state = false;
        print('success');
        state = state.copyWith(
            token: userDetails["token"],
            username: userDetails["username"],
            email: userDetails["email"],
            mobileno: userDetails["mobileno"],
            usertype: userDetails["usertype"]);
        final userData = json.encode({
          'token': state.token,
          'username': state.username,
          'email': state.email,
          'mobileno': state.mobileno,
          'usertype': state.usertype,
        });
        await prefs.setString('userData', userData);
        print('pushNamed //');
        //Navigator.of(context).pushNamed('/');
        break;
      case 400:
        loadingState.state = false;
        print('success');
        showDialog(
          context: context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(cleanErrorMessage(userDetails)),
              //content: Text("$userDetails"),
              actions: [
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );

        break;
      case 500:
        loadingState.state = false;
        showDialog(
          context: context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(cleanErrorMessage(userDetails)),
              //content: Text("$userDetails"),
              actions: [
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        break;
    }
    // Handle other status codes as needed
  }

  Future<void> loginwithpassword(
      BuildContext context, String? username, String? password,WidgetRef ref) async {
    const url = Bbapi.login_pwd;
    //print("Otp check${otp}");
    final prefs = await SharedPreferences.getInstance();
    String? verificationId = prefs.getString('verificationid');
    final loadingState = ref.read(loadingProvider2.notifier);
    loadingState.state = true;

    var response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type':
              'application/json', // Set the content type to application/json
        },
        body: json.encode({
          "username": username!,
          "password": password!,
        }));
    print("verificationId: $verificationId");
    var userDetails = json.decode(response.body);
    print('booking response:$userDetails');
    switch (response.statusCode) {
      case 200:
        loadingState.state = false;
        print('success');
        state = state.copyWith(
            token: userDetails["token"],
            username: userDetails["username"],
            email: userDetails["email"],
            mobileno: userDetails["mobileno"],
            usertype: userDetails["usertype"]);
        final userData = json.encode({
          'token': state.token,
          'username': state.username,
          'email': state.email,
          'mobileno': state.mobileno,
          'usertype': state.usertype,
        });
        await prefs.setString('userData', userData);
        print('pushNamed //');
        //Navigator.of(context).pushNamed('/');
        break;
      case 400:
        loadingState.state = false;
        print('success');
        showDialog(
          context: context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(cleanErrorMessage(userDetails)),
              //content: Text("$userDetails"),
              actions: [
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );

        break;
      case 500:
        loadingState.state = false;
        showDialog(
          context: context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(cleanErrorMessage(userDetails)),
              //content: Text("$userDetails"),
              actions: [
                ElevatedButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        break;
    }
    // Handle other status codes as needed
  }


void clear() {
    state = state.clear(); // Reset to initial state
    state = state.copyWith();
  }

}
 String cleanErrorMessage(String errorMessage) {
    // Remove the "ERROR:" prefix
    String cleanedMessage = errorMessage.replaceFirst('ERROR:', '');

    // Remove the curly brackets
    cleanedMessage = cleanedMessage.replaceAll(RegExp(r'[{}]'), '');

    // Trim any extra whitespace
    cleanedMessage = cleanedMessage.trim();

    return cleanedMessage;
  }

final authprovider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
