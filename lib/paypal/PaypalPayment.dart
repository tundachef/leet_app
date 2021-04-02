import 'dart:core';
import 'package:flutter/material.dart';
import 'package:leet/controllers/paymentcontroller.dart';
import 'package:leet/env.dart';
import 'package:leet/main.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'PaypalServices.dart';

class PaypalPayment extends StatefulWidget {
  final Function onFinish;
  final String itemName;
  final String itemPrice;
  final int quantity;
  final String totalPrice;

  PaypalPayment(
      {@required this.onFinish,
      @required this.itemName,
      @required this.itemPrice,
      @required this.quantity,
      @required this.totalPrice});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String checkoutUrl;
  String executeUrl;
  String accessToken;
  PaypalServices services = PaypalServices();

  // item name, price and quantity
  String itemName;
  String itemPrice;
  int quantity;
  String totalAmount;

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity;
    itemPrice = widget.itemPrice;
    itemName = widget.itemName;
    totalAmount = widget.totalPrice;

    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams();
        final res =
            await services.createPaypalPayment(transactions, accessToken);
        if (res != null) {
          setState(() {
            checkoutUrl = res["approvalUrl"];
            executeUrl = res["executeUrl"];
          });
        }
      } catch (e) {
        // print('exception: ' + e.toString());
        final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  Map<String, dynamic> getOrderParams() {
    List items = [
      {
        "name": itemName,
        "quantity": quantity,
        "price": itemPrice,
        "currency": defaultCurrency["currency"]
      }
    ];

    // checkout invoice details

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
          },
          "description": "Leet Post Promotion",
          "payment_options": {
            "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
          },
          "item_list": {
            "items": items,
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_WHITE,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: APP_WHITE,
          ),
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          "PayPal Checkout",
          style: TextStyle(color: APP_WHITE),
        ),
        centerTitle: true,
        backgroundColor: APP_GREEN,
      ),
      body: checkoutUrl != null
          ? WebView(
              initialUrl: checkoutUrl,
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request) {
                if (request.url.contains(returnURL)) {
                  final uri = Uri.parse(request.url);
                  final payerID = uri.queryParameters['PayerID'];
                  if (payerID != null) {
                    services
                        .executePayment(executeUrl, payerID, accessToken)
                        .then((id) {
                      widget.onFinish(id);
                    });
                  } else {
                    // widget.onFinish(null);
                    Navigator.of(context).pop();
                  }
                  // widget.onFinish(null);
                  Navigator.of(context).pop();
                }
                if (request.url.contains(cancelURL)) {
                  // widget.onFinish(null);
                  // Navigator.of(context).pop();
                }
                return NavigationDecision.navigate;
              },
            )
          : Center(child: Container(child: CircularProgressIndicator())),
    );
  }
}
