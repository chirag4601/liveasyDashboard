import 'package:flutter/material.dart';
import 'package:liveasy_admin/screens/dashboard.dart';
import 'package:liveasy_admin/screens/shipperDetailsScreen.dart';
import 'package:liveasy_admin/screens/shipperActivities.dart';
import 'package:liveasy_admin/screens/transporterDetailsScreen.dart';
import 'package:liveasy_admin/screens/transporterActivitiesScreen.dart';
import 'package:liveasy_admin/screens/gpsDetailsScreen.dart';
import 'package:liveasy_admin/constants/color.dart';
import 'package:liveasy_admin/constants/fontWeight.dart';
import 'package:liveasy_admin/constants/screenSizeConfig.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  final List<String> userData;
  HomeScreen({required this.userData});
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int active = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 6, initialIndex: 0)
      ..addListener(() {
        setState(() {
          active = tabController.index;
        });
      });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (SizeConfig.mediaQueryData == null) {
      SizeConfig().init(context);
    }
    double safeBlockHorizontal = SizeConfig.safeBlockHorizontal!;
    double safeBlockVertical = SizeConfig.safeBlockVertical!;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: signInColor,
                toolbarHeight: safeBlockVertical * 45,
                leading: Row(children: [
                  SizedBox(width: safeBlockHorizontal * 23),
                  Container(
                      height: safeBlockVertical * 25,
                      width: safeBlockHorizontal * 25,
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset('icons/liveasy_logo_white.png',
                              width: safeBlockHorizontal * 25,
                              height: safeBlockVertical * 24.33)))
                ]),
                titleSpacing: safeBlockHorizontal * 10,
                title: Container(
                    height: safeBlockVertical * 24,
                    width: safeBlockHorizontal * 77,
                    child: FittedBox(
                        fit: BoxFit.cover,
                        child: Text('Liveasy',
                            style: TextStyle(
                                color: white,
                                fontSize: 20,
                                fontWeight: boldWeight)))),
                actions: [
                  IconButton(
                      onPressed: () {}, // Search Logic pending
                      icon: Icon(Icons.search),
                      iconSize: 17),
                  SizedBox(width: safeBlockHorizontal * 19),
                  Center(child: Text("admin")),
                  SizedBox(width: safeBlockHorizontal * 10),
                  Center(
                      child: IconButton(
                          onPressed:
                              () {}, //Admin Account settings like Sign Out Button
                          icon: Icon(Icons.person),
                          iconSize: 25)),
                  SizedBox(width: safeBlockVertical * 45)
                ]),
            body: Row(children: [
              Card(
                  elevation: 1.5,
                  shadowColor: shadow,
                  child: Container(
                    width: safeBlockHorizontal * 238,
                    child: listDrawerItems(false),
                  )),
              tabController.index == 0
                  ? SizedBox(width: safeBlockHorizontal * 31)
                  : SizedBox(width: safeBlockHorizontal * 15),
              Container(
                  width: tabController.index == 0
                      ? safeBlockHorizontal * 1161
                      : safeBlockHorizontal * 1177,
                  height: safeBlockVertical * 979,
                  child: TabBarView(controller: tabController, children: [
                    Dashboard(),
                    ShipperDetailsScreen(),
                    ShipperActivitiesScreen(), //TODO: These Screens are empty
                    TransporterDetailsScreen(),
                    TransporterActivitiesScreen(),
                    GPSDetailsScreen()
                  ]))
            ])));
  }

  Widget listDrawerItems(bool drawerStatus) {
    double safeBlockHorizontal = SizeConfig.safeBlockHorizontal!;
    double safeBlockVertical = SizeConfig.safeBlockVertical!;
    return ListView(children: <Widget>[
      SizedBox(height: safeBlockVertical * 30),
      TextButton(
          style: TextButton.styleFrom(
              fixedSize:
                  Size(safeBlockHorizontal * 238, safeBlockVertical * 35),
              backgroundColor: tabController.index == 0
                  ? tabSelection.withOpacity(0.20)
                  : white),
          onPressed: () {
            tabController.animateTo(0);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Row(children: [
            SizedBox(width: safeBlockHorizontal * 20),
            Container(
                height: safeBlockVertical * 20,
                width: safeBlockHorizontal * 20,
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset('icons/dashboard.png'))),
            SizedBox(width: safeBlockHorizontal * 10),
            Container(
                height: safeBlockVertical * 20,
                width: safeBlockHorizontal * 90,
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text("Dashboard",
                        style: TextStyle(
                            color: greyColor,
                            fontWeight: normalWeight,
                            fontSize: 16))))
          ])),
      SizedBox(height: safeBlockVertical * 3),
      Divider(color: greyColor.withOpacity(0.10)),
      SizedBox(height: safeBlockVertical * 10),
      TextButton(
          style: TextButton.styleFrom(
              fixedSize:
                  Size(safeBlockHorizontal * 238, safeBlockVertical * 35),
              backgroundColor: tabController.index == 1
                  ? tabSelection.withOpacity(0.20)
                  : white),
          onPressed: () {
            tabController.animateTo(1);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Row(children: [
            SizedBox(width: safeBlockHorizontal * 20),
            Container(
                width: safeBlockHorizontal * 20,
                height: safeBlockVertical * 20,
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset('icons/shipper.png'))),
            SizedBox(width: safeBlockVertical * 10),
            Container(
                height: safeBlockVertical * 17,
                width: safeBlockHorizontal * 107,
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text("Shipper details",
                        style: TextStyle(
                            color: greyColor,
                            fontWeight: normalWeight,
                            fontSize: 16))))
          ])),
      SizedBox(height: safeBlockVertical * 10),
      TextButton(
          style: TextButton.styleFrom(
              fixedSize:
                  Size(safeBlockHorizontal * 238, safeBlockVertical * 35),
              backgroundColor: tabController.index == 2
                  ? tabSelection.withOpacity(0.20)
                  : white),
          onPressed: () {
            tabController.animateTo(2);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Row(children: [
            Container(
                width: safeBlockHorizontal * 212,
                child: Row(children: [
                  SizedBox(width: safeBlockHorizontal * 20),
                  Container(
                      height: safeBlockVertical * 20,
                      width: safeBlockHorizontal * 20,
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset('icons/activities.png'))),
                  SizedBox(width: safeBlockVertical * 10),
                  Container(
                      height: safeBlockVertical * 17,
                      width: safeBlockHorizontal * 123,
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text("Shipper activities",
                              style: TextStyle(
                                  color: greyColor,
                                  fontWeight: normalWeight,
                                  fontSize: 16))))
                ])),
            Container(
                height: safeBlockVertical * 12,
                width: safeBlockHorizontal * 12,
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Icon(Icons.chevron_right_outlined)))
          ])),
      SizedBox(height: safeBlockVertical * 10),
      TextButton(
          style: TextButton.styleFrom(
              fixedSize:
                  Size(safeBlockHorizontal * 238, safeBlockVertical * 35),
              backgroundColor: tabController.index == 3
                  ? tabSelection.withOpacity(0.20)
                  : white),
          onPressed: () {
            tabController.animateTo(3);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Row(children: [
            SizedBox(width: safeBlockHorizontal * 20),
            Container(
                height: safeBlockVertical * 20,
                width: safeBlockHorizontal * 20,
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset('icons/transporter.png'))),
            SizedBox(width: safeBlockVertical * 10),
            Container(
                height: safeBlockVertical * 17,
                width: safeBlockHorizontal * 134,
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text("Transporter details",
                        style: TextStyle(
                            color: greyColor,
                            fontWeight: normalWeight,
                            fontSize: 16))))
          ])),
      SizedBox(height: safeBlockVertical * 10),
      TextButton(
          style: TextButton.styleFrom(
              fixedSize:
                  Size(safeBlockHorizontal * 238, safeBlockVertical * 35),
              backgroundColor: tabController.index == 4
                  ? tabSelection.withOpacity(0.20)
                  : white),
          onPressed: () {
            tabController.animateTo(4);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Row(children: [
            Container(
                width: safeBlockHorizontal * 212,
                child: Row(children: [
                  SizedBox(width: safeBlockHorizontal * 20),
                  Container(
                      height: safeBlockHorizontal * 20,
                      width: safeBlockVertical * 20,
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset('icons/activities.png'))),
                  SizedBox(width: safeBlockVertical * 10),
                  Container(
                      height: safeBlockVertical * 17,
                      width: safeBlockHorizontal * 150,
                      child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text("Transporter activities",
                              style: TextStyle(
                                  color: greyColor,
                                  fontWeight: normalWeight,
                                  fontSize: 16))))
                ])),
            Container(
                height: safeBlockVertical * 12,
                width: safeBlockHorizontal * 12,
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Icon(Icons.chevron_right_outlined)))
          ])),
      SizedBox(height: safeBlockVertical * 10),
      TextButton(
          style: TextButton.styleFrom(
              fixedSize:
                  Size(safeBlockHorizontal * 238, safeBlockVertical * 35),
              backgroundColor: tabController.index == 5
                  ? tabSelection.withOpacity(0.20)
                  : white),
          onPressed: () {
            tabController.animateTo(5);
            drawerStatus ? Navigator.pop(context) : print("");
          },
          child: Row(children: [
            SizedBox(width: safeBlockHorizontal * 20),
            Container(
                height: safeBlockVertical * 20,
                width: safeBlockHorizontal * 20,
                child: FittedBox(
                    fit: BoxFit.cover, child: Image.asset('icons/gps.png'))),
            SizedBox(width: safeBlockVertical * 10),
            Container(
                height: safeBlockVertical * 17,
                width: safeBlockHorizontal * 81,
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text("GPS details",
                        style: TextStyle(
                            color: greyColor,
                            fontWeight: normalWeight,
                            fontSize: 16))))
          ]))
    ]);
  }
}