import 'dart:developer';
import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:leet/cardForm.dart';
import 'package:leet/models/post.dart';
import 'package:leet/views/CanDownload.dart';
import 'package:leet/views/CommentsList.dart';
import 'package:leet/views/PostShimmer.dart';
import 'package:leet/views/ProfileShimmer.dart';
import 'package:leet/views/TrendingShimmer.dart';
import 'package:leet/views/auth/CreateAccount.dart';
import 'package:leet/views/auth/CreateSkip.dart';
import 'package:leet/views/discover/Discover.dart';
import 'package:leet/views/auth/agreement.dart';
import 'package:leet/views/auth/location.dart';
import 'package:leet/views/auth/signin.dart';
import 'package:leet/views/auth/world.dart';
import 'package:leet/views/checkout.dart';
import 'package:leet/views/colors.dart';
import 'package:leet/views/landing.dart';
import 'package:leet/views/profile.dart';
import 'package:leet/views/promotionspage.dart';
import 'package:leet/views/selectCountry.dart';
import 'package:leet/views/settings.dart';
import 'package:leet/views/texteditor.dart';
import 'package:leet/views/trending_cover.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/user.dart';
import 'views/discover/LocationSelectCountry.dart';
import 'views/imageeditor.dart';
import 'views/index.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   initFirebase();
//   _loadId();
//   runApp(MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initFirebase();

  // initCountry();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;
  // print(status);
  runApp(MyApp(status));
}

initFirebase() async {
  await Firebase.initializeApp();
  // print('firebase done');
}

String myCountry;
String backUpCountry;
String myId;
String myContacts;
String myProfilePic;
// bool loggedIn = false;
// Future<Database> database = initDB();
const String onlyId = '00';

_loadId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var cow = (prefs.getString('myId') ?? '');
  var cat = (prefs.getString('myProfilePic') ?? '');
  var prr = (prefs.getString('myCountry') ?? myCountry);
  if (cow.isEmpty) {
    // loggedIn = false;
    myId = '';
    myProfilePic = '';
    backUpCountry = myCountry;
  } else {
    // loggedIn = true;
    myId = cow;
    myProfilePic = cat;
    backUpCountry = prr;
  }
}

Future<void> logoutUser(context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs?.clear();
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (BuildContext context) => Landing()));
}

setUser(User user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString('myId', user.id);
  prefs.setString('myProfilePic', user.profile_pic);
  prefs.setString('myCountry', myCountry);
  prefs.setBool('isLoggedIn', true);
  _loadId();
}

// initCountry() async {
//   myCountry = await _getCountryName() ?? backUpCountry;
//   // print("myCty:" + myCountry);
// }

_initZContacts() async {
  myContacts = await initContacts();
}

initContacts() async {
  var status = await Permission.contacts.status;
  PermissionStatus stt;
  if (!status.isGranted) {
    stt = await Permission.contacts.request();
    if (stt == PermissionStatus.denied) {
      return '00';
    }
  }
  String numbers = '0';
  var contactsl = await ContactsService.getContacts(withThumbnails: false);
  var contacts = contactsl.map((e) => e.phones.toList()).toList();
  for (int i = 0; i < contacts.length; i++) {
    List<Item> phones = contacts[i];
    for (var item in phones) {
      numbers = numbers + ",${item.value}";
    }
  }

  return numbers;
}

// Future<String> _getCountryName() async {
//   var status = await Permission.location.status;
//   PermissionStatus stt;
//   if (!status.isGranted) {
//     stt = await Permission.location.request();
//     if (stt == PermissionStatus.denied) {
//       return 'United States';
//     }
//   }
//   Position position =
//       await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   // debugPrint('location: ${position.latitude}');
//   final coordinates = new Coordinates(position.latitude, position.longitude);
//   var addresses =
//       await Geocoder.local.findAddressesFromCoordinates(coordinates);
//   var first = addresses.first;
//   return first.countryName; // this will return country name
// }

class MyApp extends StatefulWidget {
  bool status;
  MyApp(@required this.status);
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    _initZContacts();

    _loadId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: APP_BLACK, // bottom buttons
      statusBarColor: Colors.transparent, // top date bar
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // initCountry();

    _createFolder("Leet Culture");
    return MaterialApp(
      title: 'Leet Culture',
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      theme: ThemeData(
          fontFamily: 'ProximaNova',
          primaryColor: LIGHT_BLUE,
          accentColor: APP_GREEN),
      // home: widget.status ? Index() : Landing(),
      home: Index(),
      debugShowCheckedModeBanner: false,

      // home: CardForm(amount: 20, cty_string: 'Uganda', ad_type: 2),
    );
  }
}

// VIP CLASS DON'T TAMPER!!!!!
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

Future<void> downloadFile({@required String url, @required String name}) async {
  Dio dio = Dio();

  final String prepFolder = await _createFolder("Leet Culture");
  showToast("Downloading", context);

  await dio.download(url, '$prepFolder/$name',
      onReceiveProgress: (recv, total) {
    if (recv == total) {
      showSuccessToast('Download Complete', context);
    }
    // if (recv == total*0.1) {

    // }
  }, deleteOnError: true);
}

Future<String> _createFolder(String cow) async {
  final folderName = cow;
  final path = Directory("storage/emulated/0/$folderName");
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
  if ((await path.exists())) {
    // print(path.path);
    return path.path;
  } else {
    path.create(recursive: true);
    // print(path.path);
    return path.path;
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
