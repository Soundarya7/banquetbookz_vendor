import 'package:banquetbookz_vendor/Colors/coustcolors.dart';
import 'package:banquetbookz_vendor/Widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CoustColors.colrFill,
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 90,
                  // ignore: unnecessary_const
                  decoration: const BoxDecoration(
                      color: CoustColors.colrHighlightedText,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadiusDirectional.only(
                          bottomEnd: Radius.circular(25),
                          bottomStart: Radius.circular(25))),
                  child: const Padding(
                      padding: EdgeInsets.only(top: 25.0, left: 15),
                      child: coustText(
                        sName: "Settings",
                        txtcolor: CoustColors.colrEdtxt4,
                        textsize: 20,
                      )),
                ),
                Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: CoustColors.colrMainbg,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.person,
                                  size: 40, color: CoustColors.colrHighlightedText),
                              SizedBox(width: 16.0),
                              coustText(sName:'Suresh Ramesh',textsize: 18,txtcolor: CoustColors.colrEdtxt2,)
                            
                            ],
                          ),
                        ),
                        const SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: const coustText(sName: 'Edit Profile'),
                  onTap: () {Navigator.of(context).pushNamed('/editprofile');
                    // Handle edit profile action
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                  title: const coustText(sName: 'Logout'),
                  onTap: () {
                    // Handle edit profile action
                  },
                ),
                      ],
                    )),
                
              ],
            ),
          );
        },
      ),
    );
  }
}
