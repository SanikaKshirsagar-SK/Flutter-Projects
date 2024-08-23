import "dart:developer";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:get/get.dart";
import "package:upi_india/upi_india.dart";
import "../Controllers/cart_controller.dart";
import "../Controllers/payment_controller.dart";
import "../widgets.dart";

class PaymentOptionsView extends StatefulWidget {
  const PaymentOptionsView({super.key});

  @override
  PaymentOptionsViewState createState() => PaymentOptionsViewState();
}

class PaymentOptionsViewState extends State<PaymentOptionsView> {
  final CartController _cartController = Get.find();
  final PaymentController _paymentController = Get.find();
  List<UpiApp>? apps;
  final Map<String, String> logoUrls = {
    "GPay":
        "https://cdn1.iconfinder.com/data/icons/logos-brands-in-colors/436/Google_Pay_GPay_Logo-512.png",
    "Paytm":
        "https://cdn2.iconfinder.com/data/icons/social-icons-color/512/paytm-256.png",
    "PhonePe":
        "https://cdn2.iconfinder.com/data/icons/essentials-bigdark/100/Artboard_158-256.png",
    "Amazon":
        "https://cdn2.iconfinder.com/data/icons/social-icons-33/128/Amazon-512.png",
    "BHIM":
        "https://cdn3.iconfinder.com/data/icons/miscellaneous-529-color-shadow/128/transactions_proceedings_deal_barcode_scaning_qrcode_phone_wireless_upi_user-256.png",
  };

  @override
  void initState() {
    super.initState();
    _paymentController.initUpiApps();
    if (_paymentController.upiApps != null) {
      for (var app in _paymentController.upiApps!) {
        log(app.name);
      }
    } else {
      log("No UPI apps available");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        title: Text("Payment Options", style: textStylAppBarData()),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset("assets/back.svg", width: 30, height: 30),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Select Payment Method",
              style: textStyleData(25, 600, 25, [13, 13, 13, 1]),
            ),
            sizedBox20(),
            sizedBox10(),
            Expanded(
              child: Obx(
                () => _paymentController.upiApps != null
                    ? ListView.builder(
                        itemCount: _paymentController.upiApps!.length,
                        itemBuilder: (context, index) {
                          String logoUrl = logoUrls[
                                  _paymentController.upiApps![index].name] ??
                              "";
                          return Card(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            elevation: 5,
                            margin: const EdgeInsets.all(20),
                            child: ListTile(
                                leading: logoUrl.isNotEmpty
                                    ? Image.network(logoUrl,
                                        width: 30, height: 30)
                                    : const SizedBox(width: 30, height: 30),
                                title: Text(
                                  _paymentController.upiApps![index].name,
                                  style: textStyleData16(),
                                ),
                                trailing: Obx(
                                  () => Transform.scale(
                                    scale: 1.3,
                                    child: Radio(
                                      value: index,
                                      groupValue:
                                          _paymentController.selectedIndex,
                                      onChanged: (value) {
                                        _paymentController
                                            .selectIndex(value as int);
                                      },
                                      activeColor: _paymentController
                                                  .selectedIndex ==
                                              index
                                          ? const Color.fromRGBO(76, 61, 59, 1)
                                          : Colors.grey,
                                    ),
                                  ),
                                )),
                          );
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
            const Spacer(),
            customButtonRounded(
                onPressed: () async {
                  log(
                    "Cart Controller Cart Total: ${_cartController.cartTotal.value.toString()}",
                  );

                  await showPaymentSuccessBottomSheet(Get.context!,
                      totalAmount: _cartController.total,
                      totalQuantity: _cartController.totalQuantity);
                },
                buttonText: "Proceed to Pay"),
          ],
        ),
      ),
    );
  }

  Future<void> showPaymentSuccessBottomSheet(
    BuildContext context, {
    required double totalAmount,
    required int totalQuantity,
  }) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 350,
          child: Column(
            children: [
              sizedBox20(),
              sizedBox10(),
              Text(
                "Payment Summary",
                style: textStyleData(25, 600, 25, [13, 13, 13, 1]),
              ),
              sizedBox20(),
              sizedBox20(),
              buildCartSummary(totalAmount, totalQuantity),
              customButton(
                onPressed: () {
                  if (_paymentController.selectedIndex != -1) {
                    _paymentController
                        .initiateTransaction(
                      _paymentController
                          .upiApps![_paymentController.selectedIndex],
                    )
                        .then((response) {
                      if (response.status == UpiPaymentStatus.SUCCESS) {
                        Get.snackbar("Payment Successful",
                            "Thank you for your payment!");
                      } else {
                        Get.snackbar(
                            "Payment Failed", "Please try again later.");
                      }
                    });
                  } else {
                    Get.snackbar("Error", "Please try again later.");
                  }
                },
                buttonText: "Confirm Payment",
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildCartSummary(double totalAmount, int quantity) {
    return Column(
      children: [
        const Divider(
          thickness: 2,
        ),
        sizedBox20(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Items",
              style: textStyleData(20, 400, 18, [121, 119, 128, 1]),
            ),
            Text(
              "$quantity",
              style: textStyleData(24, 600, 18, [13, 13, 14, 1]),
            ),
          ],
        ),
        sizedBox20(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Standard Delivery ",
              style: textStyleData(20, 400, 18, [121, 119, 128, 1]),
            ),
            Text(
              "\$${_cartController.deliveryCharge.value.toStringAsFixed(2)}",
              style: textStyleData(24, 600, 18, [13, 13, 14, 1]),
            ),
          ],
        ),
        sizedBox20(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Payment ",
              style: textStyleData(20, 400, 18, [121, 119, 128, 1]),
            ),
            Text(
              "\$${(totalAmount.toStringAsFixed(2))}",
              style: textStyleData(24, 600, 18, [13, 13, 14, 1]),
            ),
          ],
        ),
        sizedBox20(),
      ],
    );
  }
}
