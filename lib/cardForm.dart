import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:leet/env.dart';
import 'package:leet/main.dart';
import 'package:leet/views/CanDownload.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/index.dart';
import 'package:stripe_payment/stripe_payment.dart';

import 'controllers/paymentcontroller.dart';
import 'views/CommentsList.dart';

class CardForm extends StatefulWidget {
  String cty_string;
  int ad_type;
  int amount;
  final String postBody;
  final String postColor;
  final String postFont_type;
  final File postAttached;
  bool is_attached;
  CardForm(
      {@required this.cty_string,
      @required this.ad_type,
      @required this.amount,
      this.postAttached,
      this.is_attached = true,
      this.postBody,
      this.postColor,
      this.postFont_type});
  @override
  State<StatefulWidget> createState() {
    return CardFormState();
  }
}

class CardFormState extends State<CardForm> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isProcessing = false;
  @override
  void initState() {
    StripePayment.setOptions(StripeOptions(publishableKey: stripePK));
    // print('CTRYS:' + widget.cty_string);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('CTRYS:' + widget.cty_string);
    // FocusScope.of(context).unfocus();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Card Details",
          style: TextStyle(color: APP_WHITE),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: APP_WHITE,
          ),
          onTap: () => Navigator.pop(context),
        ),
        centerTitle: true,
        backgroundColor: APP_GREEN,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Theme(
                  data: Theme.of(context).copyWith(accentColor: APP_GREEN),
                  child: CreditCardForm(
                    onCreditCardModelChange: onCreditCardModelChange,
                    themeColor: APP_GREEN,
                    cursorColor: APP_GREEN,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isProcessing = true;
          });
          var list = expiryDate.split('/');

          CreditCard submitCard = CreditCard(
            number: cardNumber,
            expMonth: int.parse(list[0]),
            expYear: int.parse(list[1]),
          );

          StripePayment.createTokenWithCard(
            submitCard,
          ).then((token) async {
            // await createStripePost(
            //     token: token.tokenId,
            //     amount: widget.amount,
            //     user_id: myId,
            //     isAttached: widget.is_attached,
            //     countries: widget.cty_string,
            //     ad_type: widget.ad_type,
            //     body: widget.postBody,
            //     color: widget.postColor,
            //     font_type: widget.postFont_type,
            //     attached: widget.postAttached);

            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => CanDownload(
                      isAd: true,
                      isText: !widget.is_attached,
                      cty_string: widget.cty_string,
                      postBody: widget.postBody,
                      postAttached: widget.postAttached,
                      postColor: widget.postColor,
                      ad_type: widget.ad_type,
                      amount: widget.amount,
                      tokenId: token.tokenId,
                      postFontType: widget.postFont_type,
                    )));

            // showSuccessToast('Payment Success');
            // Navigator.of(context).push(
            //     MaterialPageRoute(builder: (BuildContext context) => Index()));
          });
        },
        backgroundColor: LIGHT_BLUE,
        child: isProcessing
            ? Theme(
                data: Theme.of(context).copyWith(accentColor: APP_WHITE),
                child: new CircularProgressIndicator(),
              )
            : Icon(
                Icons.send,
                color: REAL_WHITE,
              ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
    });
    // print(expiryDate);
  }
}
