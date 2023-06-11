import 'dart:convert';
import 'dart:typed_data';

import 'package:ecommrece_app/api_connection/api_connection.dart';
import 'package:ecommrece_app/users/fragments/dashboard_of_fragments.dart';
import 'package:ecommrece_app/users/model/order.dart';
import 'package:ecommrece_app/users/userPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class OrderConfirmationScreen extends StatelessWidget {
  final List<int>? selectedCartIDs;
  final List<Map<String, dynamic>>? selectedCartListItemsInfo;
  final double? totalAmount;
  final String? deliverySystem;
  final String? paymentSystem;
  final String? phoneNumber;
  final String? shipmentAddress;
  final String? note;

  OrderConfirmationScreen({
    this.selectedCartIDs,
    this.selectedCartListItemsInfo,
    this.totalAmount,
    this.deliverySystem,
    this.paymentSystem,
    this.phoneNumber,
    this.shipmentAddress,
    this.note,
  });

  RxList<int> _imageSelectedByte = <int>[].obs;

  Uint8List get imageSelectedByte => Uint8List.fromList(_imageSelectedByte);

  RxString _imageSelectedName = "".obs;

  String get imageSelectedName => _imageSelectedName.value;

  final ImagePicker _picker = ImagePicker();

  CurrentUser currentUser = Get.put(CurrentUser());

  setSelectedImage(Uint8List selectedImage) {
    _imageSelectedByte.value = selectedImage;
  }

  setSelectedImageName(String selectedImageName) {
    _imageSelectedName.value = selectedImageName;
  }

  chooseImageFromGallery() async {
    final pickedImageXFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImageXFile != null) {
      final bytesOfImage = await pickedImageXFile.readAsBytes();

      setSelectedImage(bytesOfImage);
      setSelectedImageName(path.basename(pickedImageXFile.path));
    }
  }

  saveNewOrderInfo() async {
    String selectedItemsString = selectedCartListItemsInfo!
        .map((eachSelectedItem) => jsonEncode(eachSelectedItem))
        .toList()
        .join("||");

    Order order = Order(
      order_id: 1,
      user_id: currentUser.user.user_id,
      selectedItems: selectedItemsString,
      deliverySystem: deliverySystem,
      paymentSystem: paymentSystem,
      note: note,
      totalAmount: totalAmount,
      image: DateTime.now().millisecondsSinceEpoch.toString() +
          "-" +
          imageSelectedName,
      status: "new",
      dateTime: DateTime.now(),
      shipmentAddress: shipmentAddress,
      phoneNumber: phoneNumber,
    );

    try {
      var res = await http.post(
        Uri.parse(API.addOrder),
        body: order.toJson(base64Encode(imageSelectedByte)),
      );

      if (res.statusCode == 200) {
        var responseBodyOfAddNewOrder = jsonDecode(res.body);

        if (responseBodyOfAddNewOrder["success"] == true) {
          //delete selected items from user cart
          selectedCartIDs!.forEach((eachSelectedItemCartID) {
            deleteSelectedItemsFromUserCartList(eachSelectedItemCartID);
          });
        } else {
          Fluttertoast.showToast(
              msg: "Error Msg: \nyour new order do NOT placed.");
        }
      }
    } catch (erroeMsg) {
      Fluttertoast.showToast(msg: "Error Msg: " + erroeMsg.toString());
    }
  }

  deleteSelectedItemsFromUserCartList(int cartID) async {
    try {
      var res = await http
          .post(Uri.parse(API.deleteSelectedItemsFromCartList), body: {
        "cart_id": cartID.toString(),
      });

      if (res.statusCode == 200) {
        var responseBodyFromDeleteCart = jsonDecode(res.body);

        if (responseBodyFromDeleteCart["success"] == true) {
          Fluttertoast.showToast(
              msg: "your new order has been placed Successfully.");

          Get.to(DashboardOfFragments());
        }
      } else {
        Fluttertoast.showToast(msg: "Error, Status Code is not 200");
      }
    } catch (errorMessage) {
      print("Error: " + errorMessage.toString());

      Fluttertoast.showToast(msg: "Error: " + errorMessage.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: SizedBox.fromSize(
                size: Size.fromRadius(150), // Image radius
                child: Image.asset("assets/images/payment_confirmation.jpg",
                    fit: BoxFit.cover),
              ),
            ),
            //image

            const SizedBox(
              height: 4,
            ),

            //title
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Please Attach Transaction \nProof Screenshot / Image",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 30),

            //select image btn
            Material(
              elevation: 8,
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: () {
                  chooseImageFromGallery();
                },
                borderRadius: BorderRadius.circular(30),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  child: Text(
                    "Select Image",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            //display selected image by user
            Obx(() => ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                    maxHeight: MediaQuery.of(context).size.width * 0.6,
                  ),
                  child: imageSelectedByte.length > 0
                      ? Image.memory(
                          imageSelectedByte,
                          fit: BoxFit.contain,
                        )
                      : const Placeholder(
                          color: Colors.white60,
                        ),
                )),

            const SizedBox(height: 16),

            //confirm and proceed
            Obx(() => Material(
                  elevation: 8,
                  color:
                      imageSelectedByte.length > 0 ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      if (imageSelectedByte.length > 0) {
                        //save order info
                        saveNewOrderInfo();
                      } else {
                        Fluttertoast.showToast(
                            msg:
                                "Please attach the transaction proof / screenshot.");
                      }
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 12,
                      ),
                      child: Text(
                        "Confirmed & Proceed",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
