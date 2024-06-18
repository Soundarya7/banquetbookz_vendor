import 'dart:convert';
import 'dart:io';
import 'package:banquetbookz_vendor/utils/bbapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:banquetbookz_vendor/Models/registrationstatemodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistrationNotifier extends StateNotifier<RegistrationState> {
  
  RegistrationNotifier() : super(RegistrationState());
   void setProfileImage(File image) {
     
    state = state.copyWith(profileImage: image);
    
  }

  void setPropertyImage(File image) {
    state = state.copyWith(propertyImage: image);
  }

  Future<void> register(
      BuildContext context,
      WidgetRef ref,
      String? username,
      String? email,
      String? password,
      String? contactNumber,
      String? address1,
      String? address2,
      String? location,
      String? state,
      String? city,
      String? pincode,
      String? profilepic,
      String? propertypic,) async {
   
      Uri url = Uri.parse(Bbapi.registration);
  
    final request = http.MultipartRequest('POST', url);
// Add the image file to the request
    //if (imageFile != null) {
      //print('Image File: ${request.fields["property_pic"]}');
      request.files.add(await http.MultipartFile.fromPath(
        'property.property_pic',
        propertypic!,
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'profile_pic',
        profilepic!,
      ));
  

    // Add the text fields to the request
    request.fields['username'] = username!;
    request.fields['email'] = email!;
    request.fields['password'] = password!;
    request.fields['mobileno'] = contactNumber!;
    request.fields['property.address_1'] = address1!;
    request.fields['property.address_2'] = address2!;
    request.fields['property.location'] = location!;
    request.fields['property.state'] = state!;
    request.fields['property.city'] = city!;
    request.fields['property.pincode'] = pincode!;
 
    // Send the request
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();
    final responseData = json.decode(responseBody);
    if (response.statusCode == 201) {
      // Handle the response data
      print(responseData);
      showDialog(
          context: context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Success'),
              content: const Text('Registation successful'),
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
        Navigator.of(context).pushNamed('/');  //Goto Login page if Registered succesfully
    } else {
      // Handle the error
      print('Registration failed with status: ${responseBody}');
    }
  }
}

final registrationProvider =
    StateNotifierProvider<RegistrationNotifier, RegistrationState>((ref) {
  return RegistrationNotifier();
});
