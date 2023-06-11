import 'package:ecommrece_app/users/controllers/order_now_controller.dart';
import 'package:ecommrece_app/users/order/order_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class OrderNowScreen extends StatelessWidget {
  final List<Map<String, dynamic>>? selectedCartListItemsInfo;
  final double? totalAmount;
  final List<int>? selectedCartIDs;

  OrderNowController orderNowController = Get.put(OrderNowController());
  List<String> deliverySystemNamesList = [
    "FedEx",
    "DHL",
    "United Parcel Service"
  ];
  List<String> paymentSystemNamesList = [
    "Apple Pay",
    "Wire Transfer",
    "Google Pay"
  ];

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController shipmentAddressController = TextEditingController();
  TextEditingController noteToSellerController = TextEditingController();

  OrderNowScreen({
    this.selectedCartListItemsInfo,
    this.totalAmount,
    this.selectedCartIDs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Order Now",
        ),
        titleSpacing: 0,
      ),
      body: ListView(
        children: [
          //display selected items from cart list
          displaySelectedItemsFromUserCart(),

          const SizedBox(height: 30),

          //delivery system
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Delivery System:',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: deliverySystemNamesList.map((deliverySystemName) {
                return Obx(() => RadioListTile<String>(
                      tileColor: Colors.black12,
                      dense: true,
                      activeColor: Colors.deepPurple,
                      title: Text(
                        deliverySystemName,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54),
                      ),
                      value: deliverySystemName,
                      groupValue: orderNowController.deliverySys,
                      onChanged: (newDeliverySystemValue) {
                        orderNowController
                            .setDeliverySystem(newDeliverySystemValue!);
                      },
                    ));
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          //payment system
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Payment System:',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Company Account Number / ID: \nY87Y-HJF9-CVBN-4321',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: paymentSystemNamesList.map((paymentSystemName) {
                return Obx(() => RadioListTile<String>(
                      tileColor: Colors.black12,
                      dense: true,
                      activeColor: Colors.deepPurple,
                      title: Text(
                        paymentSystemName,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54),
                      ),
                      value: paymentSystemName,
                      groupValue: orderNowController.paymentSys,
                      onChanged: (newPaymentSystemValue) {
                        orderNowController
                            .setPaymentSystem(newPaymentSystemValue!);
                      },
                    ));
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          //phone number
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Phone Number:',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              style: const TextStyle(color: Colors.black),
              controller: phoneNumberController,
              decoration: InputDecoration(
                hintText: 'any Contact Number..',
                hintStyle: const TextStyle(
                  color: Colors.black54,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.black54,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          //shipment address
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Shipment Address:',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              style: const TextStyle(color: Colors.black54),
              controller: shipmentAddressController,
              decoration: InputDecoration(
                hintText: 'your Shipment Address..',
                hintStyle: const TextStyle(
                  color: Colors.black54,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.black54,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          //note to seller
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Note to Seller:',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: TextField(
              style: const TextStyle(color: Colors.black),
              controller: noteToSellerController,
              decoration: InputDecoration(
                hintText: 'Any note you want to write to seller..',
                hintStyle: const TextStyle(
                  color: Colors.black54,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Colors.black54,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          //pay amount now btn
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Material(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: () {
                  if (phoneNumberController.text.isNotEmpty &&
                      shipmentAddressController.text.isNotEmpty) {
                    Get.to(OrderConfirmationScreen(
                      selectedCartIDs: selectedCartIDs,
                      selectedCartListItemsInfo: selectedCartListItemsInfo,
                      totalAmount: totalAmount,
                      deliverySystem: orderNowController.deliverySys,
                      paymentSystem: orderNowController.paymentSys,
                      phoneNumber: phoneNumberController.text,
                      shipmentAddress: shipmentAddressController.text,
                      note: noteToSellerController.text,
                    ));
                  } else {
                    Fluttertoast.showToast(msg: "Please complete the form.");
                  }
                },
                borderRadius: BorderRadius.circular(30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "\$" + totalAmount!.toStringAsFixed(2),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      const Text(
                        "Pay Amount Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  displaySelectedItemsFromUserCart() {
    return Column(
      children: List.generate(selectedCartListItemsInfo!.length, (index) {
        Map<String, dynamic> eachSelectedItem =
            selectedCartListItemsInfo![index];

        return Container(
          margin: EdgeInsets.fromLTRB(
            16,
            index == 0 ? 16 : 8,
            16,
            index == selectedCartListItemsInfo!.length - 1 ? 16 : 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white70,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 6,
                color: Colors.black26,
              ),
            ],
          ),
          child: Row(
            children: [
              //image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: FadeInImage(
                  height: 150,
                  width: 130,
                  fit: BoxFit.cover,
                  placeholder:
                      const AssetImage("assets/images/place_holder.png"),
                  image: NetworkImage(
                    eachSelectedItem["image"],
                  ),
                  imageErrorBuilder: (context, error, stackTraceError) {
                    return const Center(
                      child: Icon(
                        Icons.broken_image_outlined,
                      ),
                    );
                  },
                ),
              ),

              //name
              //size
              //price
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //name
                      Text(
                        eachSelectedItem["name"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      //size + color
                      Text(
                        eachSelectedItem["size"]
                                .replaceAll("[", "")
                                .replaceAll("]", "") +
                            "\n" +
                            eachSelectedItem["color"]
                                .replaceAll("[", "")
                                .replaceAll("]", ""),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 16),

                      //price
                      Text(
                        "\$ " + eachSelectedItem["totalAmount"].toString(),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        eachSelectedItem["price"].toString() +
                            " x " +
                            eachSelectedItem["quantity"].toString() +
                            " = " +
                            eachSelectedItem["totalAmount"].toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //quantity
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Q: " + eachSelectedItem["quantity"].toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
