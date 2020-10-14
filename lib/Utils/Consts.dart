
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  static final Color PrimaryColor = Colors.blue;
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

String privacytxt="Minority Report's privacy policy is based on the guidelines and the terms used by the regulator in approving the Basic Data Protection Regulations. We take the protection of your data very seriously, keep your personal information confidential and in accordance with the law.\n . Description \n Our data protection declaration should be easy to read and understand not only for the public but also for customers and service providers. To confirm this, I would like to explain in advance the terms used. In this data protection application, we use the following terms, along with other terms.\n a) Personal Information \n Personal data is all information related to a known or identifiable individual (hereinafter referred to as the 'subject of information'). Identifiers can be identified directly or indirectly, especially by name, identification number, location information, and online contact information. \n (b) information subject \n An information subject is any known, identifiable individual who is processed by a personal data controller.\n (c) processing \n
Processing is any process or series of operations performed by automated procedures, such as the collection, collection, organization, classification, storage, adaptation, modification, reading, acquisition, use, or transmission of personal data. , distribute or otherwise provide, compare, link, restrict, delete, delete.
d) Processing restrictions
Restriction of processing is the recording of stored personal data in order to limit their further processing.
(e) profile
A profile is any form of automated processing of personal information that involves the use of that personal information to assess and predict certain aspects of a person's identity, such as job performance, economic status, health, and personal preferences. , the person's interests, credibility, behavior, location or relocation.
(f) a controller or supervisor
An information controller or controller is an individual, legal entity, government agency, organization, or other organization that solves the purpose and means of processing personal information, alone or in association with others. Where the purpose and means of such processing are established by federal law or by the law of the Member States, certain criteria for the appointment of a supervisor may be established by federal law or by the law of the Member States.
g) Service provider or owner
A service provider is an individual, legal entity, business entity, or other organization that provides a service.
h) The client
A client is an individual, legal entity, organization, or other organization that hires service providers.
( j) a third party
A third party is an individual, legal entity, authority, organization, or other organization other than a data subject, data processor, data processor, data processor, or other person authorized to process personal information under the direct responsibility of the data processor. .
k) Permission
Consent is the voluntary expression of will in the form of a statement of the data subject or, in certain cases, other clearly approved acts expressing consent to the processing of personal data relating to him or her. him.
1.2 Automatic storage of information
Today, when you visit websites, some information is automatically generated and stored, including this website.
If you visit our website as you are currently visiting, our web server (the computer where this website is stored) will automatically call it a & # 8221; server log file & # 8221; stores as. The following data is recorded as follows:
The IP address of your device, the address of the subpage you visited, the details of the browser (for example, Chrome, Firefox, Edge,…) and the date and time. We do not use or pass on this data, but we do not rule out the possibility of viewing this data in the event of an illegal act.
1.3 Retention of Personal Information
We will only use personal information transmitted to us electronically from this website, such as your name, email address, address or other personal information related to the submission of forms or comments, only with time and date. In each case, the IP address will be securely stored for the purposes stated and will not be passed on to third parties.
We will not transfer your personal information without your consent, but we do not rule out the possibility of viewing this data in the event of an illegal act.
We record customer activity as part of our operations. We will collect the following data
these logs:
User ID
Activity time stamp
Type of action
Specific actions
We store the following personal information:
Surname Name Name of the
organization Data in
your profile: photo
Address
Phone number
Email address
All social addresses

1.4 User account
To place an order using this offer, each customer must open a password-protected user account. This includes an order review and an active ordering process. If you leave your website as a subscriber, it will appear automatically.
1.5 Ordering process
All customer input data is stored as part of the order processing. These include:
Full name
City and country
email address
Payment data required for order processing is passed on to third-party service providers such as Paypal.
Your data will be deleted as soon as it is no longer required or required by law.
1 .6. Dealing with comments, evaluations, and notes
If you leave a rating or comment on this website, your IP address will be saved. This applies to the security of the website operator: If your text violates the law, he wants to know who you are.
1.7 . For customers
Make sure you visit Miniihot.com. Follow the link “Miniihot.com Beware of too cheap offers. If the price seems too low, listen to your intuition, as counterfeit coal may be a poor quality product.
Are you choosing goods not far from home? If the customer you are selling requires an advance on the fact that the goods are in another city or another country, it is better to choose a customer who is ready to meet you.
Do not share personal information, such as your passport number or bank card. If they are trying to persuade you, it is the first sign of dealing with an unfair customer.
Warning:
Miniihot.com will never ask you for a reply message. If, after posting an ad, you can click & # 8221; OK to activate your ad & # 8221; etc. If you receive a text message or a message that something has won, it is a scam.
Never share links from Miniihot.com to anyone. Even the staff at Miniihot.com shouldn't ask you. If you ask, it means you are a fraud.
If the price is too low or too high, you are likely to be an unscrupulous seller.
If you are asked to pay for transportation or insurance because the goods are in another city or country, you may be deceived.
The Miniihot.com team cares about your safety and offers the following tips:
If you receive a text message from a special number asking for a reply to your number, such as "Your account has been closed" or "Please reply because the ad has been canceled", be careful not to reply.
Be careful not to make purchases using remittances. It will be difficult to get your money back from the transfer due to any fraud.
If you are suspicious of any ad or ad on Miniihot.com, feel free to let us know. This can be done by clicking the "Complaint" button below the ad owner's name on the ad page or contacting us.

1.7.1. Require advance payment
When a seller refuses to meet in person and requires a full or partial down payment, it is recommended that you look for a similar product in your area or use the services of a certified seller or store. This also includes real estate ads.

1.7.2. Reply to message
Messages requesting a response on behalf of Miniihot.com should not come from a special number. It is recommended that you do not reply as your unit will drop when you reply to such a number. Tell your phone operator about a similar message.
1.7.3. Transfer of personal information
Be careful if for some reason the seller (or buyer) wants to get your personal information (bank card number, account number, etc.). We recommend that you do not act in a way that you do not understand, as such information is directly related to your financial and personal security.

1.8. Ways to contact sellers and buyers
You can contact the ad owner by phone or chat. To avoid misunderstandings on the part of the site, it is recommended to share the details of the purchase via chat. These include:
a certain amount of payment (price of goods and delivery price, if necessary);
The meeting place is the address to send the goods after the coalition receives payment.
The buyer is always concerned about what happened to the goods he bought. If, in accordance with the terms of the transaction, you receive payment in a transaction and the goods are delivered by parcel, please provide the following information:
• whether the transferred money is in your account;
• whether the goods have been shipped (parcel number, if available).

1.9. Your rights
In principle, you have the right to receive, correct, delete, restrict, transmit, cancel or refuse information. If you believe that the processing of your data violates the data protection law or in any way violates your data protection claim, you can file a complaint with your state regulatory authority.
After receiving the payment, you will be able to access the membership section where you can view the training materials. These include video tutorials, live tutorials, quizzes, assessments, new words, phrases, and pdf documents 24/7.

1.10. TLS encryption with https
We will use https to securely transfer data over the Internet. By using the TLS (Transport Layer Security), an encryption protocol for secure data transmission over the Internet, we can ensure the protection of confidential information. You can accept the use of this data transfer security as a small lock icon in the upper left corner of the browser and the use of the https scheme as part of our web address.
1.11. Use and Disclosure of Personal Information
By providing the personal data of the users of our website, we use them only to answer questions asked by the website users and / or customers, to fill in and use them with the website users and / or closed contract users. for technical administration. We will not disclose personal information to third parties or use it in any other way unless it is necessary to use it for contract processing or payment purposes, or with the prior consent of the website user and / or client. The User and / or the Client of the Website reserves the right to revoke such permission when it becomes effective in the future.
If the Website User and / or Client revokes the storage permit, the stored personal information will be deleted as knowledge of this information is no longer required for storage purposes or cannot be stored for other legal reasons.
";