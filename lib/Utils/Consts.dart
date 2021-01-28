import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'AboutUsPage.dart';
import 'PrivacyPolicy.dart';
import 'Terms_and_Conditions.dart';

String u_id;
String testImageUrl = "https://www.gstatic.com/webp/gallery/3.webp";

bool isLogIn() {
  if (u_id == null)
    return false;
  else
    return true;
}

class MyColors {
  static final Color PrimaryColor = Color(0xff2f89fc);
  static final Color SecColor = Colors.blue[50];

  static final Color listh1Font = Colors.white;
  static final Color listp1Font = Colors.white.withOpacity(0.6);

  static final Color h1FontBlack = Colors.black;
  static final Color p1FontBalck = Colors.black.withOpacity(0.6);
  static final LinearGradient backGroundGradient = LinearGradient(colors: [
    Colors.white,
    Colors.white,
  ]);
}

class MyButtons {
  static Widget footer(BuildContext context) {
    return BottomAppBar(
      color: MyColors.SecColor,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrivacyPolicyPage()));
              },
              child: Text(
                "Privacy Policy",
                style: TextStyle(fontSize: 12),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsandConditionPage()));
              },
              child: Text(
                "Terms & Conditions",
                style: TextStyle(fontSize: 12),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUsPage()));
              },
              child: Text(
                "About Us",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget myButton(String txt, BuildContext context, Widget a) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => a));
      },
      padding: EdgeInsets.all(12),
      color: Colors.lightBlueAccent,
      child: Container(
          width: 300,
          child:
              Center(child: Text(txt, style: TextStyle(color: Colors.white)))),
    );
  }
}

Future<void> showMyDialog(
    BuildContext context, String title, String detail) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(detail),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

String initPageRout;
String autoSign() {
  // FirebaseAuth auth = FirebaseAuth.instance;
  // u_id = auth.currentUser.uid;
  if (u_id != "") {
    initPageRout = '/listPage';
    print("Ok hai sb");
  } else {
    initPageRout = '/loginpage';
  }
  return initPageRout;
}

const spinkit = SpinKitRotatingCircle(
  color: Colors.white,
  size: 50.0,
);
String PrivacyPolicy =
    "Minority app was built as a free app. This service is provided at no cost and is intended for use as is. This page is used to inform visitors regarding policies with the collection, use, and disclosure of personal information if anyone decided to use this service.\n"
    "This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.\n"
    "If you choose to use the Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that is collected is used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy.\n"
    "The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible at Minority Report unless otherwise defined in this Privacy Policy.\n"
    "Information Collection and Use\n"
    "For a better experience, while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to Minority Report. The information that We request will be retained on your device and is not collected by us in any way.\n"
    "The app does use third party services that may collect information used to identify you.\n"
    "Link to privacy policy of third-party service providers used by the app\n"
    "Google Play Services\n"
    "Google Analytics for Firebase\n"
    "Log Data\n"
    "We want to inform you that whenever you use our Service, in a case of an error in the app We collect data and information (through third party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing my Service, the time and date of your use of the Service, and other statistics.\n"
    "Cookies\n"
    "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.\n"
    "This Service does not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.\n"
    "Service Providers"
    "We may employ third-party companies and individuals due to the following reasons:\n"
    "To facilitate our Service;\n"
    "To provide the Service on our behalf;\n"
    "To perform Service-related services; or\n"
    "To assist us in analyzing how our Service is used.\n"
    "We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.\n"
    "Security\n"
    "We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and We cannot guarantee its absolute security.\n"
    "Links to Other Sites\n"
    "This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, we strongly advise you to review the Privacy Policy of these websites. We have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.\n"
    "Children’s Privacy\n"
    "These Services do not address anyone under the age of 13. We do not knowingly collect personally identifiable information from children under 13. In the case We discover that a child under 13 has provided us with personal information, We immediately delete this from our servers. If you are a parent or guardian and you are aware that your child has provided us with personal information, please contact us so that We will be able to do necessary actions.\n"
    "Changes to This Privacy Policy\n"
    "We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page.\n"
    "This policy is effective as of 2020-10-14\n"
    "Contact Us\n"
    "If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at minorityreports2020@gmail.com.\n"
    "This privacy policy page was created at privacypolicytemplate.net and modified/generated by App Privacy Policy Generator";

String termConditionTitle = "Terms & Conditions\n ";
String termConditionTxt =
    "By downloading or using the app, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the app. you’re not allowed to copy, or modify the app, any part of the app, or our trademarks in any way. You’re not allowed to attempt to extract the source code of the app, and you also shouldn’t try to translate the app into other languages, or make derivative versions. \n"
    "The app itself, and all the trade marks, copyright, database rights and other intellectual property rights related to it, still belong to Minority Report.\n "
    "Minority Report is committed to ensuring that the app is as useful and efficient as possible. For that reason, we reserve the right to make changes to the app or to charge for its services, at any time and for any reason. We will never charge you for the app or its services without making it very clear to you exactly what you’re paying for.\n"
    "The Minority Report app stores and processes personal data that you have provided to us, in order to provide our Service. It’s your responsibility to keep your phone and access to the app secure. We therefore recommend that you do not jailbreak or root your phone, which is the process of removing software restrictions and limitations imposed by the official operating system of your device. It could make your phone vulnerable to malware/viruses/malicious programs, compromise your phone’s security features and it could mean that the Minority Report app won’t work properly or at all.\n The app does use third party services that declare their own Terms and Conditions.\n"
    "Link to Terms and Conditions of third-party service providers used by the app Google Play Services Google Analytics for Firebase You should be aware that there are certain things that Minority Report will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi, or provided by your mobile network provider, but Minority Report cannot take responsibility for the app not working at full functionality if you don’t have access to Wi-Fi, and you don’t have any of your data allowance left. If you’re using the app outside of an area with Wi-Fi, you should remember that your terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.\n"
    "Along the same lines, Minority Report cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Minority Report cannot accept responsibility. With respect to Minority Report’s responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you. Minority Report accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app. At some point, we may wish to update the app. The app is currently available on Android – the requirements for system(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app. Minority Report does not promise that it will always update the app so that it is relevant to you and/or works with the Android version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, we may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end;\n"
    " (b) you must stop using the app, and (if needed) delete it from your device. Changes to This Terms and Conditions We may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Terms and Conditions on this page. These terms and conditions are effective as of 2020-10-14.\n"
    "   Contact Us\n"
    "    If you have any questions or suggestions about my Terms and Conditions, do not hesitate to contact us at minorityreports2020@gmail.com. \n"
    "This Terms and Conditions page was generated by App Privacy Policy Generator";
String privacyPlcy = '{"Privacy policy": ""}';
Future<String> _loadFromAsset() async {
  return await rootBundle.loadString("assets/privacypolicy.json");
}

Future parseJson() async {
  String jsonString = await _loadFromAsset();
  final jsonResponse = jsonDecode(jsonString);
}
