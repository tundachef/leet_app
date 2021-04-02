import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/checkout.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/countries.dart';

class SelectCountry extends StatefulWidget {
  final int ad_type;
  String user_id;
  String body;
  String color;
  String font_type;
  File attached;
  bool is_attached;
  SelectCountry(
      {@required this.ad_type,
      @required this.user_id,
      this.body,
      this.color,
      this.is_attached = true,
      this.font_type,
      this.attached});
  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry>
    with AutomaticKeepAliveClientMixin {
  List<Country> _notes = [];
  List<Country> _backupnotes = [];
  List<Country> _selectedCountries = [];
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
    if (_selectedCountries.isEmpty) {
      showToast('Select atleast one country', context);
      return;
    }
    for (int k = 0; k < _selectedCountries.length; k++) {
      results.add(_selectedCountries[k].name);
    }
    FocusScope.of(context).unfocus();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      // return Pay(countries: results);
      return Checkout(
        countries: results,
        ad_type: widget.ad_type,
        postAttached: widget.attached,
        is_attached: widget.is_attached,
        postBody: widget.body,
        postColor: widget.color,
        postFont_type: widget.font_type,
      );
    }));
  }

  Widget _selectedChip(Country cty) {
    return GestureDetector(
      onTap: () {
        setState(() {
          cty.selected = false;
          _selectedCountries.remove(cty);
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
              cty.name,
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
                  cty.selected = false;
                  _selectedCountries.remove(cty);
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: APP_WHITE,
      appBar: AppBar(
        backgroundColor: REAL_BLACK,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
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
              padding: EdgeInsets.symmetric(vertical: 16),
              // height: 16,
              constraints: BoxConstraints(maxHeight: 72, minHeight: 16),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: APP_BLACK, width: 2, style: BorderStyle.solid)),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedCountries.length,
                itemBuilder: (context, index) {
                  return _selectedChip(_selectedCountries[index]);
                },
              ),
            ),
            Container(
              height: height - 72,
              width: width,
              child: ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    value: _notes[index].selected,
                    onChanged: (val) {
                      setState(() {
                        _notes[index].selected = val;
                        if (val == true) {
                          _selectedCountries.add(_notes[index]);
                        } else {
                          _selectedCountries.remove(_notes[index]);
                        }
                      });
                    },
                    title: Text(_notes[index].name),
                    activeColor: APP_BLACK,
                    checkColor: APP_WHITE,
                    controlAffinity: ListTileControlAffinity.platform,
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
