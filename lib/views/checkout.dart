import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leet/cardForm.dart';
import 'package:leet/controllers/paymentcontroller.dart';
import 'package:leet/main.dart';
import 'package:leet/paypal/PaypalPayment.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/index.dart';
import 'package:stripe_payment/stripe_payment.dart';

class Checkout extends StatefulWidget {
  List<String> countries;
  int ad_type;
  final String postBody;
  final String postColor;
  final String postFont_type;
  final File postAttached;
  bool is_attached;
  Checkout(
      {@required this.countries,
      @required this.ad_type,
      this.postAttached,
      this.postBody,
      this.is_attached = true,
      this.postColor,
      this.postFont_type});
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  List<String> _results = [];
  int ad_price;
  int total_price;
  String cty_string;
  bool paid = false;
  Token _paymentToken;
  PaymentMethod _paymentMethod;
  CreditCard creditCard;

  @override
  void initState() {
    // _initPaid();
    _results = widget.countries;
    _initAdPrice();
    total_price = ad_price * _results.length;

    super.initState();
  }

  _initCountryString() {
    for (int j = 0; j < _results.length; j++) {
      if (_results[j].isEmpty) {
        continue;
      } else {
        setState(() {
          cty_string = '$cty_string,${_results[j].toUpperCase()}';
        });
      }
    }
  }

  _initAdPrice() {
    if (widget.ad_type == 0) {
      ad_price = 2;
    }

    if (widget.ad_type == 1) {
      ad_price = 5;
    }

    if (widget.ad_type == 2) {
      ad_price = 20;
    }
  }

  Widget _resultChip({@required String cty_name}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _results.remove(cty_name);
        });
      },
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(color: APP_GREEN, width: 2, style: BorderStyle.solid),
        ),
        child: Row(
          children: <Widget>[
            Text(
              cty_name,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: APP_GREEN,
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _results.remove(cty_name);
                });
              },
              child: CircleAvatar(
                backgroundColor: APP_RED,
                radius: 10,
                child: Icon(
                  Icons.clear,
                  size: 18,
                  color: APP_WHITE,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setError(dynamic error) {
    showErrorToast(error.toString(), context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    total_price = ad_price * _results.length;
    return Scaffold(
      backgroundColor: APP_BLACK,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          paid ? "Payment Completed" : "Checkout",
          style: TextStyle(color: APP_WHITE),
        ),
        leading: paid
            ? Container()
            : GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: APP_WHITE,
                ),
                onTap: () => Navigator.pop(context),
              ),
        centerTitle: true,
        backgroundColor: APP_GREEN,
      ),
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.asset(
                'assets/images/world.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: Container(
                color: REAL_BLACK.withOpacity(0.68),
              ),
            ),
            paid
                ? Positioned.fill(
                    child: Container(
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'PAYMENT ',
                            style: TextStyle(color: LIGHT_BLUE, fontSize: 20),
                          ),
                          Text(
                            'SUCCESS',
                            style: TextStyle(color: APP_GREEN, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ))
                : Positioned.fill(
                    child: Wrap(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          // height: 16,
                          constraints:
                              BoxConstraints(maxHeight: 72, minHeight: 16),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: APP_GREEN,
                                    width: 2,
                                    style: BorderStyle.solid)),
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _results.length,
                            itemBuilder: (context, index) {
                              return _resultChip(cty_name: _results[index]);
                            },
                          ),
                        ),
                        Container(
                          height: height - 72,
                          width: width,
                          margin: EdgeInsets.only(top: 32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        '${_results.length} Countries at ',
                                        style: TextStyle(
                                            color: LIGHT_BLUE, fontSize: 18),
                                      ),
                                      Text(
                                        'USD $ad_price',
                                        style: TextStyle(
                                            color: APP_GREEN, fontSize: 18),
                                      ),
                                      Text(
                                        ' / Country',
                                        style: TextStyle(
                                            color: LIGHT_BLUE, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Total Price: ',
                                        style: TextStyle(
                                            color: LIGHT_BLUE, fontSize: 20),
                                      ),
                                      Text(
                                        'USD $total_price',
                                        style: TextStyle(
                                            color: APP_GREEN, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Column(
                                children: <Widget>[
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     if (_results.length == 0) {
                                  //       showErrorToast(
                                  //           'Please select a country');
                                  //       return;
                                  //     }
                                  //     Navigator.of(context).push(
                                  //       MaterialPageRoute(
                                  //         builder: (BuildContext context) =>
                                  //             PaypalPayment(
                                  //           quantity: _results.length,
                                  //           itemName: 'Leet Post Promotion',
                                  //           itemPrice: ad_price.toString(),
                                  //           totalPrice: total_price.toString(),
                                  //           onFinish: (id) {
                                  //             if (id == null) {
                                  //               showErrorToast(
                                  //                   'Problem executing PayPal payment. Please check your balance');
                                  //               return;
                                  //             }
                                  //             _initCountryString();

                                  //             createPaypalPost(
                                  //                 user_id: myId,
                                  //                 countries: cty_string,
                                  //                 ad_type: widget.ad_type,
                                  //                 body: widget.postBody,
                                  //                 color: widget.postColor,
                                  //                 font_type:
                                  //                     widget.postFont_type,
                                  //                 attached:
                                  //                     widget.postAttached);
                                  //             showSuccessToast(
                                  //                 'Payment Success');
                                  //             setState(() {
                                  //               paid = true;
                                  //             });
                                  //           },
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //         color: LIGHT_BLUE,
                                  //         borderRadius:
                                  //             BorderRadius.circular(16)),
                                  //     padding: EdgeInsets.symmetric(
                                  //         horizontal: 24, vertical: 16),
                                  //     child: Row(
                                  //       mainAxisSize: MainAxisSize.min,
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.center,
                                  //       children: <Widget>[
                                  //         Image.asset(
                                  //           "assets/images/paypal.png",
                                  //           width: 24,
                                  //         ),
                                  //         Text(
                                  //           " PayPal",
                                  //           style: TextStyle(
                                  //               color: APP_WHITE, fontSize: 18),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 24,
                                  // ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_results.length == 0) {
                                        showErrorToast(
                                            'Please select a country', context);
                                        return;
                                      }
                                      _initCountryString();
                                      FocusScope.of(context).unfocus();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  CardForm(
                                                      amount: total_price,
                                                      cty_string: cty_string,
                                                      ad_type: widget.ad_type,
                                                      postBody: widget.postBody,
                                                      is_attached:
                                                          widget.is_attached,
                                                      postColor:
                                                          widget.postColor,
                                                      postFont_type:
                                                          widget.postFont_type,
                                                      postAttached: widget
                                                          .postAttached)));

                                      // showSuccessToast('Payment Success');
                                      // setState(() {
                                      //   paid = true;
                                      // });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: LIGHT_BLUE,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 16),
                                      child: Text(
                                        "Pay with Card",
                                        style: TextStyle(
                                            color: APP_WHITE, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Container(
                                    // margin: EdgeInsets.symmetric(vertical: 16),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 16),
                                    decoration: BoxDecoration(
                                        color: APP_BLACK.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(2)),
                                    child: Text(
                                      'If Card is declined Post will not be sent',
                                      maxLines: null,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: LIGHT_BLUE,
                                          fontSize: 17,
                                          height: 1.2),
                                    ),
                                  ),
                                  // GestureDetector(
                                  //   onTap: () {

                                  //     if (_results.length == 0) {
                                  //       showErrorToast(
                                  //           'Please select a country');
                                  //       return;
                                  //     }
                                  //     StripePayment.paymentRequestWithNativePay(
                                  //       androidPayOptions:
                                  //           AndroidPayPaymentRequest(
                                  //         totalPrice: total_price.toString(),
                                  //         currencyCode: "USD",
                                  //       ),
                                  //       applePayOptions: ApplePayPaymentOptions(
                                  //         countryCode: 'DE',
                                  //         currencyCode: 'USD',
                                  //         items: [
                                  //           ApplePayItem(
                                  //             label: 'Leet Post Promotion',
                                  //             amount: total_price.toString(),
                                  //           )
                                  //         ],
                                  //       ),
                                  //     ).then((token) {
                                  //       setState(() {
                                  //         _paymentToken = token;
                                  //       });

                                  //       _initCountryString();
                                  //       print(token.tokenId);

                                  //       createStripePost(
                                  //           token: token.toString(),
                                  //           amount: total_price,
                                  //           user_id: myId,
                                  //           countries: cty_string,
                                  //           ad_type: widget.ad_type,
                                  //           body: widget.postBody,
                                  //           color: widget.postColor,
                                  //           font_type: widget.postFont_type,
                                  //           attached: widget.postAttached);

                                  //       showSuccessToast('Payment Success');
                                  //       setState(() {
                                  //         paid = true;
                                  //       });
                                  //     }).catchError(setError);
                                  //   },
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //         color: LIGHT_BLUE,
                                  //         borderRadius:
                                  //             BorderRadius.circular(16)),
                                  //     padding: EdgeInsets.symmetric(
                                  //         horizontal: 24, vertical: 16),
                                  //     child: Row(
                                  //       mainAxisSize: MainAxisSize.min,
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.center,
                                  //       children: <Widget>[
                                  //         Image.asset(
                                  //           "assets/images/google.png",
                                  //           width: 24,
                                  //         ),
                                  //         SizedBox(
                                  //           width: 16,
                                  //         ),
                                  //         Image.asset(
                                  //           "assets/images/apple.png",
                                  //           width: 24,
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: paid ? APP_GREEN : APP_RED,
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => Index()));
        },
        icon: paid
            ? Icon(
                Icons.home,
                color: APP_WHITE,
              )
            : Icon(
                Icons.clear,
                color: APP_WHITE,
              ),
        label: paid
            ? Text(
                "Home",
                style: TextStyle(color: APP_WHITE),
              )
            : Text(
                "Cancel",
                style: TextStyle(color: APP_WHITE),
              ),
      ),
    );
  }
}
