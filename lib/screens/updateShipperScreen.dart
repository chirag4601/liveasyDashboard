import 'package:flutter/material.dart';
import 'package:liveasy_admin/functions/updateUserApi.dart';
import 'package:liveasy_admin/models/shipperApiModel.dart';
import 'package:get/get.dart';
import 'package:liveasy_admin/controller/ShipperController.dart';
import 'package:liveasy_admin/services/getUserDocuments.dart';
import 'package:liveasy_admin/widgets/appBar.dart';
import 'package:liveasy_admin/widgets/cancelButtonWidget.dart';
import 'package:liveasy_admin/widgets/showDialog.dart';
import 'package:liveasy_admin/widgets/radioButtonWidget.dart';
import 'package:liveasy_admin/widgets/saveButtonWidget.dart';
import 'package:liveasy_admin/widgets/updateScreenCardLayout.dart';
import 'package:liveasy_admin/widgets/updateScreenTextField.dart';
import 'package:liveasy_admin/constants/color.dart';
import 'package:liveasy_admin/constants/fontWeight.dart';
import 'package:liveasy_admin/constants/screenSizeConfig.dart';
import 'package:liveasy_admin/constants/space.dart';

class UpdateShipperScreen extends StatefulWidget {
  final ShipperDetailsModel shipperDetails;
  UpdateShipperScreen({required this.shipperDetails});

  @override
  _UpdateShipperScreenState createState() => _UpdateShipperScreenState();
}

class _UpdateShipperScreenState extends State<UpdateShipperScreen> {
  double height = SizeConfig.safeBlockVertical!;
  double width = SizeConfig.safeBlockHorizontal!;
  TextEditingController? name;
  TextEditingController? contact;
  TextEditingController? location;
  TextEditingController? companyName;
  FocusNode nameFocusNode = FocusNode();
  FocusNode locationFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode companyFocusNode = FocusNode();
  bool isNameEditable = false;
  bool isLocationEditable = false;
  bool isCompanyNameEditable = false;
  Map<String, dynamic> dataToUpdate = {};
  ShipperController shipperController = Get.find<ShipperController>();

  Future<void> onPressed() async {
    ShipperController shipperController = Get.find<ShipperController>();
    if (isNameEditable && name!.text != "") {
      dataToUpdate.addAll({'shipperName': name!.text});
    } else if (isNameEditable &&
        shipperController.onShipperApprove.value == 1) {
      dialogBox(context, 'Alert', 'Shipper Name is not entered', null, null);
    }
    if (isLocationEditable && location!.text != "") {
      dataToUpdate['shipperLocation'] = location!.text;
    } else if (isLocationEditable &&
        shipperController.onShipperApprove.value == 1) {
      dialogBox(
          context, 'Alert', 'Shipper Location is not entered', null, null);
    }
    if (isCompanyNameEditable && companyName!.text != "") {
      dataToUpdate['companyName'] = companyName!.text;
    } else if (isCompanyNameEditable &&
        shipperController.onShipperApprove.value == 1) {
      dialogBox(context, 'Alert', 'Company is not entered', null, null);
    }
    if (shipperController.onShipperApprove.value != 0) {
      dataToUpdate['companyApproved'] =
          shipperController.onShipperApprove.value == 1 ? true : false;
    } else {
      dialogBox(
          context, 'Alert', 'Shipper Approval is not choosen', null, null);
    }
    if (shipperController.onShipperApprove.value == 1) {
      dataToUpdate['accountVerificationInProgress'] = false;
    }
    await runPutUserApi(
        type: "Shipper",
        toBeUpdated: dataToUpdate,
        userId: widget.shipperDetails.shipperId!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    name = TextEditingController(text: widget.shipperDetails.shipperName);
    contact =
        TextEditingController(text: widget.shipperDetails.phoneNo.toString());
    location =
        TextEditingController(text: widget.shipperDetails.shipperLocation);
    companyName =
        TextEditingController(text: widget.shipperDetails.companyName);
    return Scaffold(
        appBar: appBar(),
        body: SingleChildScrollView(child: Center(child: Obx(() {
          shipperController.onShipperDocumentfails.value;
          return FutureBuilder(
              future: getUserDocumentURL(widget.shipperDetails.shipperId!),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (!snapshot.hasData) {
                    Future(() {
                      dialogBox(
                          context,
                          'Error Loading Documents',
                          'Unable to Fetch the User Documents\nPlease try again later',
                          null,
                          "ShipperDocuments");
                    });
                    return Container();
                  } else {
                    String? profile = snapshot.data[0];
                    String? aadhar1 = snapshot.data[1];
                    String? aadhar2 = snapshot.data[2];
                    String? pan = snapshot.data[3];
                    String? gst = snapshot.data[4];
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height * 37),
                          Container(
                              height: height * 40,
                              width: width * 240,
                              child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Text('Shipper details',
                                      style: TextStyle(
                                          fontSize: 32,
                                          color: greyColor,
                                          fontWeight: regularWeight)))),
                          SizedBox(height: height * 30),
                          Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(radius_30)),
                              shadowColor: black,
                              elevation: 2.0,
                              child: Container(
                                  width: width * 1137,
                                  padding: EdgeInsets.only(
                                      top: height * 46, left: width * 64),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            height: height * 34,
                                            width: width * 230,
                                            child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Text('Edit information',
                                                    style: TextStyle(
                                                        fontSize: 28,
                                                        color: greyColor,
                                                        fontWeight:
                                                            regularWeight)))),
                                        SizedBox(height: height * 35),
                                        if (profile == null)
                                          Center(
                                              child: Container(
                                                  height: height * 63,
                                                  width: width * 63,
                                                  child: FittedBox(
                                                      fit: BoxFit.cover,
                                                      child: Image.asset(
                                                          "icons/profile.png"))))
                                        else
                                          Center(
                                              child: Container(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  height: height * 63,
                                                  width: width * 63,
                                                  child: FittedBox(
                                                      fit: BoxFit.cover,
                                                      child: CircleAvatar(
                                                          child: Image.network(
                                                              profile))))),
                                        SizedBox(height: height * 45),
                                        Row(children: [
                                          Container(
                                              height: height * 18,
                                              width: width * 48,
                                              child: FittedBox(
                                                  fit: BoxFit.cover,
                                                  child: Text('Name',
                                                      style: TextStyle(
                                                          color: greyColor,
                                                          fontWeight:
                                                              boldWeight,
                                                          fontSize: 14)))),
                                          SizedBox(width: width * 212),
                                          Container(
                                              height: height * 18,
                                              width: width * 55.2,
                                              child: FittedBox(
                                                  fit: BoxFit.cover,
                                                  child: Text('Contact',
                                                      style: TextStyle(
                                                          color: greyColor,
                                                          fontWeight:
                                                              boldWeight,
                                                          fontSize: 14)))),
                                          SizedBox(width: width * 212),
                                          Container(
                                              height: height * 18,
                                              width: width * 60,
                                              child: FittedBox(
                                                  fit: BoxFit.cover,
                                                  child: Text('Address',
                                                      style: TextStyle(
                                                          color: greyColor,
                                                          fontWeight:
                                                              boldWeight,
                                                          fontSize: 14)))),
                                          SizedBox(width: width * 212),
                                          Container(
                                              height: height * 18,
                                              width: width * 150,
                                              child: FittedBox(
                                                  fit: BoxFit.fitHeight,
                                                  child: Text(
                                                      'Approve this Shipper ?',
                                                      style: TextStyle(
                                                          color: greyColor,
                                                          fontWeight:
                                                              boldWeight,
                                                          fontSize: 14))))
                                        ]),
                                        SizedBox(height: height * 10),
                                        Row(children: [
                                          UpdateScreenTextField(
                                              labelText: "Name",
                                              controller: name!,
                                              editable: isNameEditable,
                                              focusNode: nameFocusNode),
                                          SizedBox(width: width * 53),
                                          UpdateScreenTextField(
                                              labelText: "Contact",
                                              controller: contact!,
                                              editable: false),
                                          SizedBox(width: width * 53),
                                          UpdateScreenTextField(
                                              labelText: "Location",
                                              controller: location!,
                                              editable: isLocationEditable,
                                              focusNode: locationFocusNode),
                                          SizedBox(width: width * 53),
                                          RadioButtonWidget(type: "Shipper")
                                        ]),
                                        SizedBox(height: height * 30),
                                        Container(
                                            height: height * 18,
                                            width: width * 121,
                                            child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Text('Company Name',
                                                    style: TextStyle(
                                                        color: greyColor,
                                                        fontWeight: boldWeight,
                                                        fontSize: 14)))),
                                        SizedBox(height: height * 15),
                                        Row(children: [
                                          IDProofLayout(pan: pan),
                                          SizedBox(width: width * 65),
                                          AddressProofLayout(
                                              aadhar1: aadhar1,
                                              aadhar2: aadhar2)
                                        ]),
                                        SizedBox(height: height * 30),
                                        Text('Company Name',
                                            style: TextStyle(
                                                color: greyColor,
                                                fontWeight: boldWeight,
                                                fontSize: 10)),
                                        SizedBox(height: height * 15),
                                        UpdateScreenTextField(
                                            labelText: "Company Name",
                                            controller: companyName!,
                                            editable: isCompanyNameEditable,
                                            focusNode: companyFocusNode),
                                        SizedBox(height: height * 30),
                                        Text('Company Details',
                                            style: TextStyle(
                                                color: greyColor,
                                                fontWeight: boldWeight,
                                                fontSize: 10)),
                                        SizedBox(height: height * 15),
                                        CompanyProofLayout(gst: gst),
                                        SizedBox(height: height * 35),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SaveButtonWidget(
                                                  onPressed: onPressed),
                                              SizedBox(width: width * 50),
                                              CancelButtonWidget()
                                            ]),
                                        SizedBox(height: height * 30)
                                      ])))
                        ]);
                  }
                }
              });
        }))));
  }
}
