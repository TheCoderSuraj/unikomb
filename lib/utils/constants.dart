import "package:flutter/material.dart";
// import 'package:google_fonts/google_fonts.dart';

const kAppName = "UniKomb";
const kPagePadding = EdgeInsets.all(12);
const kAuthPagePadding = EdgeInsets.all(24);
const double kAuthPagesTopPadding = 80.0;
const double kMaxScreenWidthLimit = 600;
const kMinAppUpgraderVersion = "1.2.0";

const kMinJoinYear = 1950;

const kTestImgUrl = "https://picsum.photos/200";

// database

//shared pref ids
const kFirstTimeUserPrefBoolId = "First Time User prefBool id";
const kLoginEmailPrefStringId = "Login Email Pref String Id";
const kLoginPasswordPrefStringId = "Login Password Pref String Id";

// colors
// const kYellowColor = Color(0xffffb642);
// const kYellowColor1 = Color(0xffffa91c);
// const kBlueColor = Color(0xff23a9b2);
// const kBlueColor1 = Color(0xff18bdaf);

const kHighLightColor = Color(0x5042C2FF);
const kBackGroundColor = Color(0x50FEF5AC);

const kLightBlueColor = Color(0xff469FD1);
const kBlueColor = Color(0xff0386D0);

// text styles

// const kTitleTextStyle = GoogleFonts.roboto();
const kDefaultTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
  color: Color(0xC8000000),
);
const kSmallTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.normal,
  color: Color(0xC8000000),
);

const kBoldTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const kSemiBoldTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

const kTitleTextStyle = TextStyle(
  fontSize: 35,
  fontWeight: FontWeight.bold,
);

const kSubtitleTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
