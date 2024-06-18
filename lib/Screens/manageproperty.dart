import 'package:banquetbookz_vendor/Colors/coustcolors.dart';
import 'package:banquetbookz_vendor/Models/bookinglistmodel.dart';
import 'package:banquetbookz_vendor/Widgets/elevatedbutton.dart';
import 'package:banquetbookz_vendor/Widgets/tabbar.dart';
import 'package:banquetbookz_vendor/Widgets/text.dart';
import 'package:banquetbookz_vendor/Widgets/textfield.dart';
import 'package:flutter/material.dart';

class ManagePropertyScreen extends StatefulWidget {
  const ManagePropertyScreen({super.key});

  @override
  State<ManagePropertyScreen> createState() => _ManagePropertyScreenState();
}

class _ManagePropertyScreenState extends State<ManagePropertyScreen>
    with SingleTickerProviderStateMixin {
  String searchQuery = '';
  String filter = 'All';
  final List<BookingListModel> bookings = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 12; i++) {
      bookings.add(BookingListModel(
          name: "swagath grand Banquet Hall",
          date: "Registerd on Aug 7,2023",
          address: "Pragathi nagar Hyderabad"));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<BookingListModel> filteredBookings = bookings.where((booking) {
      if (filter != 'All' && booking.status != filter) {
        return false;
      }
      print("print1:" + searchQuery + "/n booking Id ${booking.name}");
      if (searchQuery.isNotEmpty && !booking.name!.contains(searchQuery)) {
        print("print:" + searchQuery);
        return false;
      }
      return true;
    }).toList();
    return Scaffold(
      backgroundColor: CoustColors.colrFill,
      appBar: AppBar(
        backgroundColor: CoustColors.colrFill,
        title: const coustText(
          sName: 'Manage Properties',
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
         actions:  <Widget>[
          IconButton(
            iconSize: 40,
            padding: EdgeInsets.only(right: 25),
            color: CoustColors.colrHighlightedText,
            icon: Icon(Icons.add),
            tooltip: 'Add Property',
            onPressed: () {
              Navigator.of(context).pushNamed('/addproperty');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: CoustTextfield(
              hint: "Search...",
              radius: 30.0,
              width: 10,
              isVisible: false,
              prefixIcon: const Icon(Icons.search),
              fillcolor: CoustColors.colrMainbg,
              filled: true,
              onChanged: (value) {
                setState(() {
                  searchQuery = value!;
                });
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CoustTabbar(
              filter: filter,
              length: 4,
              tab0: "All",
              tab1: "Subscribed",
              tab2: "Deactivated",
              tab3: "UnSubscribed",
              onTap: (selected) {
                setState(() {
                  switch (selected) {
                    case 0:
                      filter = "All";
                      print("Selected${selected}");
                      break;
                    case 1:
                      filter = "Subscribed";
                      print("Selected${selected}");
                      break;
                    case 2:
                      filter = "Deactivated";
                      print("Selected${selected}");
                      break;
                    case 3:
                      filter = "UnSubscribed";
                      print("Selected${selected}");
                      break;
                  }
                });
                return null;
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: CoustColors.colrMainbg,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: filteredBookings.length,
                    itemBuilder: (context, index) {
                      return _buildBookingItem(filteredBookings[index]);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
 
  Widget _buildBookingItem(BookingListModel booking) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 40,
            height: 40,
            color: CoustColors.colrEdtxt4,
          ),
          title: coustText(sName :booking.name!,fontweight: FontWeight.bold,textsize: 18,),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              coustText(sName :booking.address!,textsize: 14,txtcolor: CoustColors.colrEdtxt4,),
              coustText(sName :booking.date!,textsize: 14,txtcolor: CoustColors.colrEdtxt4,),
             CoustElevatedButton(
            buttonName: ('Subscribe pro'),
            width: double.infinity,
            radius: 8,
            FontSize: 20,
            onPressed: () {
              //Navigator.of(context).pushNamed('/venue_details');
            },
          ),
          const SizedBox(
          height: 10,
        ),
        const Divider(
          height: 1,
          thickness: 2,
          color: CoustColors.colrEdtxt4,
        ),
        const SizedBox(
          height: 10,
        )
            ],
          ),
         
          onTap: () {
            // Handle booking item click
            
            print('${booking.name} clicked');
          },
        ),
        const Divider(
          height: 1,
          thickness: 2,
          color: CoustColors.colrEdtxt4,
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
