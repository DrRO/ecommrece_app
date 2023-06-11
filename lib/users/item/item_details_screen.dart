import 'dart:convert';

import 'package:ecommrece_app/users/cart/cart_list_screen.dart';
import 'package:ecommrece_app/users/controllers/item_details_controller.dart';
import 'package:ecommrece_app/users/model/products.dart';
import 'package:ecommrece_app/users/userPreferences/current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../api_connection/api_connection.dart';

class ItemDetailsScreen extends StatefulWidget {
  final Products? itemInfo;

  ItemDetailsScreen({
    this.itemInfo,
  });

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  final itemDetailsController = Get.put(ItemDetailsController());
  final currentOnlineUser = Get.put(CurrentUser());

  addItemToCart() async {
    try {
      var res = await http.post(
        Uri.parse(API.addToCart),
        body: {
          "user_id": currentOnlineUser.user.user_id.toString(),
          "item_id": widget.itemInfo!.item_id.toString(),
          "quantity": itemDetailsController.quantity.toString(),
          "color": widget.itemInfo!.colors![itemDetailsController.color],
          "size": widget.itemInfo!.sizes![itemDetailsController.size],
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfAddCart = jsonDecode(res.body);
        if (resBodyOfAddCart['success'] == true) {
          Fluttertoast.showToast(msg: "item saved to Cart Successfully.");
        } else {
          Fluttertoast.showToast(
              msg: "Error Occur. Item not saved to Cart and Try Again.");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error Msg: " + errorMsg.toString());
    }
  }

  validateFavoriteList() async {
    try {
      var res = await http.post(
        Uri.parse(API.validateFavorite),
        body: {
          "user_id": currentOnlineUser.user.user_id.toString(),
          "item_id": widget.itemInfo!.item_id.toString(),
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfValidateFavorite = jsonDecode(res.body);
        if (resBodyOfValidateFavorite['favoriteFound'] == true) {
          itemDetailsController.setIsFavorite(true);
        } else {
          itemDetailsController.setIsFavorite(false);
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error Msg: " + errorMsg.toString());
    }
  }

  addItemToFavoriteList() async {
    try {
      var res = await http.post(
        Uri.parse(API.addFavorite),
        body: {
          "user_id": currentOnlineUser.user.user_id.toString(),
          "item_id": widget.itemInfo!.item_id.toString(),
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfAddFavorite = jsonDecode(res.body);
        if (resBodyOfAddFavorite['success'] == true) {
          Fluttertoast.showToast(
              msg: "item saved to your Favorite List Successfully.");

          validateFavoriteList();
        } else {
          Fluttertoast.showToast(msg: "Item not saved to your Favorite List.");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error Msg: " + errorMsg.toString());
    }
  }

  deleteItemFromFavoriteList() async {
    try {
      var res = await http.post(
        Uri.parse(API.deleteFavorite),
        body: {
          "user_id": currentOnlineUser.user.user_id.toString(),
          "item_id": widget.itemInfo!.item_id.toString(),
        },
      );

      if (res.statusCode ==
          200) //from flutter app the connection with api to server - success
      {
        var resBodyOfDeleteFavorite = jsonDecode(res.body);
        if (resBodyOfDeleteFavorite['success'] == true) {
          Fluttertoast.showToast(msg: "item Deleted from your Favorite List.");

          validateFavoriteList();
        } else {
          Fluttertoast.showToast(
              msg: "item NOT Deleted from your Favorite List.");
        }
      } else {
        Fluttertoast.showToast(msg: "Status is not 200");
      }
    } catch (errorMsg) {
      print("Error Msg: " + errorMsg.toString());
    }
  }

  @override
  void initState() {
    super.initState();

    validateFavoriteList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //item image
          FadeInImage(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            placeholder: const AssetImage("assets/images/place_holder.png"),
            image: NetworkImage(
              widget.itemInfo!.image!,
            ),
            imageErrorBuilder: (context, error, stackTraceError) {
              return const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                ),
              );
            },
          ),

          //item information
          Align(
            alignment: Alignment.bottomCenter,
            child: itemInfoWidget(),
          ),

          //3 buttons || back - favorite - shopping cart
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  //back
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.deepPurple,
                    ),
                  ),

                  const Spacer(),

                  //favorite
                  Obx(() => IconButton(
                        onPressed: () {
                          if (itemDetailsController.isFavorite == true) {
                            //delete item from favorites
                            deleteItemFromFavoriteList();
                          } else {
                            //save item to user favorites
                            addItemToFavoriteList();
                          }
                        },
                        icon: Icon(
                          itemDetailsController.isFavorite
                              ? Icons.bookmark
                              : Icons.bookmark_border_outlined,
                          color: Colors.deepPurple,
                        ),
                      )),

                  //shopping cart icon
                  IconButton(
                    onPressed: () {
                      Get.to(CartListScreen());
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  itemInfoWidget() {
    return Container(
      height: MediaQuery.of(Get.context!).size.height * 0.6,
      width: MediaQuery.of(Get.context!).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -3),
            blurRadius: 6,
            color: Colors.deepPurple,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 18,
            ),

            Center(
              child: Container(
                height: 8,
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            //name
            Text(
              widget.itemInfo!.name!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            //rating + rating num
            //tags
            //price
            //quantity item counter
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //rating + rating num
                //tags
                //price
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //rating + rating num
                      Row(
                        children: [
                          //rating bar
                          RatingBar.builder(
                            initialRating: widget.itemInfo!.rating!,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, c) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (updateRating) {},
                            ignoreGestures: true,
                            unratedColor: Colors.grey,
                            itemSize: 20,
                          ),

                          const SizedBox(
                            width: 8,
                          ),

                          //rating num
                          Text(
                            "(" + widget.itemInfo!.rating.toString() + ")",
                            style: const TextStyle(
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      //tags
                      Text(
                        widget.itemInfo!.tags!
                            .toString()
                            .replaceAll("[", "")
                            .replaceAll("]", ""),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 16),

                      //price
                      Text(
                        "\$" + widget.itemInfo!.price.toString(),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                //quantity item counter
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //+
                      IconButton(
                        onPressed: () {
                          itemDetailsController.setQuantityItem(
                              itemDetailsController.quantity + 1);
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        itemDetailsController.quantity.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //-
                      IconButton(
                        onPressed: () {
                          if (itemDetailsController.quantity - 1 >= 1) {
                            itemDetailsController.setQuantityItem(
                                itemDetailsController.quantity - 1);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Quantity must be 1 or greater than 1");
                          }
                        },
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //sizes
            const Text(
              "Size:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              runSpacing: 8,
              spacing: 8,
              children: List.generate(widget.itemInfo!.sizes!.length, (index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      itemDetailsController.setSizeItem(index);
                    },
                    child: Container(
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: itemDetailsController.size == index
                              ? Colors.transparent
                              : Colors.grey,
                        ),
                        color: itemDetailsController.size == index
                            ? Colors.purpleAccent.withOpacity(0.4)
                            : Colors.black,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.itemInfo!.sizes![index]
                            .replaceAll("[", "")
                            .replaceAll("]", ""),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            //colors
            const Text(
              "Color:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              runSpacing: 8,
              spacing: 8,
              children: List.generate(widget.itemInfo!.colors!.length, (index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      itemDetailsController.setColorItem(index);
                    },
                    child: Container(
                      height: 35,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: itemDetailsController.color == index
                              ? Colors.transparent
                              : Colors.grey,
                        ),
                        color: itemDetailsController.color == index
                            ? Colors.purpleAccent.withOpacity(0.4)
                            : Colors.black,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.itemInfo!.colors![index]
                            .replaceAll("[", "")
                            .replaceAll("]", ""),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),

            //description
            const Text(
              "Description:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.itemInfo!.description!,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            //add to cart button
            Material(
              elevation: 4,
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  addItemToCart();
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
