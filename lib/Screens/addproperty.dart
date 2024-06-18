import 'dart:convert';

import 'package:banquetbookz_vendor/Colors/coustcolors.dart';
import 'package:banquetbookz_vendor/Providers/stateproviders.dart';
import 'package:banquetbookz_vendor/Widgets/elevatedbutton.dart';
import 'package:banquetbookz_vendor/Widgets/text.dart';
import 'package:banquetbookz_vendor/Widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class AddPropertyScreen extends StatefulWidget{
  const AddPropertyScreen({super.key});

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  bool txtboxclr = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController emailid = TextEditingController();
  final TextEditingController pwd = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  final TextEditingController add1 = TextEditingController();
  final TextEditingController add2 = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController pin = TextEditingController();
  final TextEditingController Contact = TextEditingController();
  final _validationkey = GlobalKey<FormState>();

  MapController _mapController = MapController();
  


//  void _searchLocation(WidgetRef ref) async {
//     final response = await http.get(Uri.parse(
//         'https://nominatim.openstreetmap.org/search?q=${location.text}&format=json&addressdetails=1&limit=1'));
//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);
//       if (data.isNotEmpty) {
//         double lat = double.parse(data[0]['lat']);
//         double lon = double.parse(data[0]['lon']);
//         ref.read(latlangs.notifier).state = LatLng(lat, lon);
        
//         _mapController.move((ref.watch(latlangs)), 15.0);
//       }
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoustColors.colrFill,
      appBar: AppBar(
        backgroundColor: CoustColors.colrFill,
        title: const coustText(
          sName: 'Add Properties',
          txtcolor: CoustColors.colrEdtxt2,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: CoustColors.colrHighlightedText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: CoustColors.colrMainbg,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    const coustText(
                      sName: "Vender Coverpage",
                      textsize: 24,
                      fontweight: FontWeight.bold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        color: CoustColors.colrButton1,
                        child: const Center(
                            child: coustText(
                          sName: "Upload photo",
                          align: TextAlign.center,
                        )),
                      ), //set Upload file
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  
                  return Form(
                    key: _validationkey,
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: CoustColors.colrMainbg,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: coustText(
                                    sName: "Vender Details",
                                    textsize: 24,
                                    fontweight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                regform(
                                    "Vendor name",
                                    name,
                                    "Please Enter Vendor Name"),
                                const SizedBox(
                                  height: 10,
                                ),
                                regform(
                                    "Email Id",
                                    emailid,
                                    "Please Enter Email id"),
                                const SizedBox(
                                  height: 10,
                                ),
                                regform(
                                    "Contact Number",
                                    mobile,
                                    "Please Enter Contact Number"),
                                const SizedBox(
                                  height: 10,
                                ),
                                regform(
                                    "Veneder Address line 1",
                                    add1,
                                    "Please Enter Address 1"),
                                const SizedBox(
                                  height: 10,
                                ),
                                regform(
                                    "Veneder Address line 2",
                                    add2,
                                    "Please Enter Address 2"),
                                const SizedBox(
                                  height: 10,
                                ),
                                regform("State", state, "Please Enter State"),
                                const SizedBox(
                                  height: 10,
                                ),
                                regform("City", city, "Please Enter City"),
                                const SizedBox(
                                  height: 10,
                                ),
                                regform(
                                    "Pincode",
                                    pin,
                                    "Please Enter Pin Number"),
                                const SizedBox(
                                  height: 10,
                                ),
                                 regform(
                                    "Contact Number",
                                    Contact,
                                    "Please Enter Contact Number"),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: const coustText(sName: "Location",),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: SizedBox(
                                    height: 150,
                                    width: double.infinity,
                                    child: FlutterMap(
                                      mapController: _mapController,
                                      options: MapOptions(
                                        initialCenter: (ref.watch(latlangs)),
                                        initialZoom: 15,
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                          subdomains: ['a', 'b', 'c'],
                                        ),
                                        MarkerLayer(
                                          markers: [
                                            Marker(
                                              width: 80.0,
                                              height: 80.0,
                                              point: (ref.watch(latlangs)),
                                              child: Container(
                                                child: const Icon(
                                                  Icons.location_on,
                                                  color: Colors.red,
                                                  size: 40,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                regform(
                                    "Vendor Categories",
                                    Contact,
                                    "Please Enter Categories"),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Wrap(
                                                                  spacing: 8.0,
                                                                  children: [
                                                                    Chip(
                                    label: Text('Value for Money'),
                                    backgroundColor: Colors.purple[100],
                                                                    ),
                                                                    Chip(
                                    label: Text('Best Seller'),
                                    backgroundColor: Colors.purple[100],
                                                                    ),
                                                                    Chip(
                                    label: Text('Limited time offer'),
                                    backgroundColor: Colors.purple[100],
                                                                    ),
                                                                  ],
                                                                ),
                                  ),
                                 const SizedBox(height: 20,) ,
                              const Padding(
                               padding: EdgeInsets.only(left: 8.0),
                                child: coustText(
                                      sName: "Pricing Details",
                                      textsize: 24,
                                      fontweight: FontWeight.bold,
                                    ),
                              ),
                                 regform(
                                    "Weekday pricing",
                                    Contact,
                                    "Please Enter Price"),
                                    regform(
                                    "Weekend Pricing",
                                    Contact,
                                    "Please Enter price"),

                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: CoustElevatedButton(
                            buttonName: "Draft",
                            width: double.infinity,
                            bgColor: CoustColors.colrButton3,
                            radius: 8,
                            FontSize: 20,
                            onPressed: () {
                              if (_validationkey.currentState!.validate()) {}
                            },
                          ),
                        ),
                         //SizedBox(height: 20,),
                        //  SizedBox(
                        //   width: double.infinity,
                        //   child: CoustElevatedButton(
                        //     buttonName: "Discard",
                        //     width: double.infinity,
                        //     bgColor: CoustColors.colrButton2,
                        //     radius: 8,
                        //     FontSize: 20,
                        //     onPressed: () {
                        //       if (_validationkey.currentState!.validate()) {}
                        //     },
                        //   ),
                        // ),
                        SizedBox(height: 20,),
                         SizedBox(
                          width: double.infinity,
                          child: CoustElevatedButton(
                            buttonName: "Add Vendor",
                            width: double.infinity,
                            bgColor: CoustColors.colrButton3,
                            radius: 8,
                            FontSize: 20,
                            onPressed: () {
                              if (_validationkey.currentState!.validate()) {}
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget regform(String name, TextEditingController txtController,
      String erromsg, ) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: CoustTextfield(
        
        radius: 8.0,
        width: 10,
        isVisible: true,
        hint: name,
        title: name,
        controller: txtController,
        onChanged: (txtController) {
          
          return null;
        },
        validator: (txtController) {
          if (txtController == null || txtController.isEmpty) {
            return erromsg;
          }
          return null;
        },
      ),
    );
  }
}
