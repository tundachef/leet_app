import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leet/main.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/auth/CreateSkip.dart';
import 'package:leet/views/checkout.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/countries.dart';

class LocationSelectCountry extends StatefulWidget {
  @override
  _LocationSelectCountryState createState() => _LocationSelectCountryState();
}

class _LocationSelectCountryState extends State<LocationSelectCountry>
    with AutomaticKeepAliveClientMixin<LocationSelectCountry> {
  List<Country> _notes = [];
  List<Country> _backupnotes = [];

  Country _cty;
  List<String> results = [];

  _initCountry() {
    for (int i = 0; i < COUNTRIES.length; i++) {
      Country itemCountry;
      itemCountry = Country(name: COUNTRIES[i]);
      _notes.add(itemCountry);
    }
    _backupnotes = _notes;
  }

  @override
  bool get wantKeepAlive => true;

  _onChanged(String txt) {
    if (txt.isEmpty) {
      setState(() {
        _notes = _backupnotes;
      });
    } else {
      var text = txt.toLowerCase();
      setState(() {
        _notes = _notes.where((j) {
          var title = j.name.toLowerCase();
          return title.contains(text);
        }).toList();
      });
    }
  }

  @override
  void initState() {
    _initCountry();
    super.initState();
  }

  @override
  void dispose() {
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  onSent() {
    if (_cty == null) {
      showToast('Select a country ', context);
      return;
    }
    setState(() {
      myCountry = _cty.name;
    });
    showSuccessToast(myCountry ?? '', context);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return CreateSkip();
    }));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: APP_WHITE,
      appBar: AppBar(
        backgroundColor: APP_GREEN,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back,
            color: APP_WHITE,
          ),
          onTap: () => Navigator.pop(context),
        ),
        title: Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.symmetric(
            horizontal: 4,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Color(0xffEEEFF3)),
          child: Theme(
            data: Theme.of(context).copyWith(primaryColor: APP_GREEN),
            child: TextField(
              autocorrect: false,
              autofocus: false,
              cursorColor: APP_GREY,
              onChanged: (val) {
                _onChanged(val);
              },
              decoration: InputDecoration(
                focusColor: APP_GREY,
                hintText: 'search country',
                hoverColor: APP_GREY,
                fillColor: APP_GREY,
                prefixIcon: Icon(Icons.search),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: height,
        width: width,
        child: Wrap(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 16, right: 8, bottom: 16, top: 16),
              width: width,
              constraints: BoxConstraints(maxHeight: 72, minHeight: 32),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: APP_GREEN, width: 2, style: BorderStyle.solid)),
              ),
              child: Text(
                _cty == null ? '' : _cty.name,
                maxLines: null,
                style: TextStyle(color: APP_GREEN, fontSize: 20),
              ),
            ),
            Container(
              height: height - 72,
              width: width,
              child: ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    // selected: _notes[index].selected,
                    onTap: () {
                      setState(() {
                        _cty = _notes[index];
                      });
                    },
                    title: Text(_notes[index].name),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onSent,
        child: Icon(
          Icons.send,
          color: APP_WHITE,
        ),
        backgroundColor: LIGHT_BLUE,
      ),
    );
  }
}

class Country {
  final String name;
  bool selected;

  Country({@required this.name, this.selected = false});
}
