import 'dart:developer';

import 'package:family_tree_app/keep/localstorage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp/whatsapp.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool fcmInitCheck = true;
  final Uri _url = Uri.parse('https://wa.me/9539871760?text=Hello');
  FirebaseMessaging? messaging;
  String? fcmToken;

  // AndroidNotificationChannel? channel;
  WhatsApp whatsapp = WhatsApp();
  int phoneNumber = 9539871760;

  @override
  void initState() {
    fcmInit();
    // launch("https://wa.me/9539871760?text=Hello");
    // _launchURL();
    super.initState();
  }

  Future<bool> fcmInit() async {
    if (fcmInitCheck) {
      fcmInitCheck = false;
      await Firebase.initializeApp();
      messaging = FirebaseMessaging.instance;

      bool getToken = true;

      if (getToken == false) return true;

      fcmToken = await messaging!.getToken();

      await saveTokenToDatabase(fcmToken);
      log(fcmToken.toString());
      messaging!.onTokenRefresh.listen(saveTokenToDatabase);
    }
    return true;
  }

  Future<void> saveTokenToDatabase(fcmToken) async {
    await LocalStorage.setDeviceToken(fcmToken);
    var btok = await LocalStorage.getDeviceToken();
    _whatsappset();
    // addDevice();
  }

  _whatsappset() async {
    var btok = await LocalStorage.getDeviceToken();
    whatsapp.setup(
      accessToken: btok,
      fromNumberId: 8086991977,
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  // void _launchURL() async => await canLaunchUrl(url)
  //     ? await launchUrl(url)
  //     : throw 'Could not launch https://play.google.com/store/apps/details?id=com.leopard.construction_erp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextButton(
            onPressed: () async {
              _launchUrl();
              // var msg = await whatsapp.short(
              //   to: phoneNumber,
              //   message: "Hello Flutter",
              //   compress: true,
              // );
              // print(await whatsapp.short(
              //   to: phoneNumber,
              //   message: "Hello Flutter",
              //   compress: true,
              // ));

              // launch(msg);
              // url = Uri.parse(msg);

              // _launchURL();
            },
            child: const Text("Generate Short Link"),
          ),
          TextButton(
            onPressed: () async {
              // await whatsapp.messagesText(
              //   to: phoneNumber,
              //   message: "Hello Flutter",
              //   previewUrl: true,
              // );
              print(await whatsapp.messagesText(
                to: phoneNumber,
                message: "Hello Flutter",
                previewUrl: true,
              ));
            },
            child: const Text("Send Message"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesTemplate(
                to: phoneNumber,
                templateName: "hello_world",
              ));
            },
            child: const Text("Send Template"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesMedia(
                to: phoneNumber,
                mediaId: "437536581613407",
                mediaType: "image",
              ));
            },
            child: const Text("Send Media File"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesLocation(
                to: phoneNumber,
                address: "Rajasthan, India",
                longitude: "26.4866491",
                latitude: "74.5288578",
                name: "Pushkar",
              ));
            },
            child: const Text("Send Location"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesMediaByLink(
                  to: phoneNumber,
                  mediaType: "video",
                  mediaLink: "https://example.com/flutter.mp4",
                  caption: "My Flutter Video"));
            },
            child: const Text("Send Media By Link"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesReaction(
                to: phoneNumber,
                messageId: "wamid.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==",
                emoji: "👍",
              ));
            },
            child: const Text("Send Reaction on Message"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesReply(
                to: phoneNumber,
                messageId: "wamid.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==",
                message: "Hey, Flutter!",
                previewUrl: true,
              ));
            },
            child: const Text("Send Reply on Message"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesReplyMedia(
                  to: phoneNumber,
                  messageId: "wamid.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==",
                  mediaType: "image",
                  mediaId: "437536581613407"));
            },
            child: const Text("Send Reply with Media"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesReplyMediaUrl(
                  to: phoneNumber,
                  messageId: "wamid.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX==",
                  mediaType: "video",
                  mediaLink: "http://example.com/video.mp4",
                  caption: "My Flutter Video"));
            },
            child: const Text("Send Reply with Media (Url)"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.registerNumber(pin: "123456"));
            },
            child: const Text("Register a number"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.deregisterNumber(pin: "123456"));
            },
            child: const Text("Deregister a number"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.getWhatsAppBusinessAccounts(
                  inputToken: "EAAGp6a..."));
            },
            child: const Text("Get Shared WhatsApp Business Account Id"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.getWhatsAppBusinessAccountsList(
                  accountId: 111939554870583));
            },
            child: const Text("Get Shared WhatsApp Business Account List"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.messagesButton(
                  to: phoneNumber,
                  bodyText: "Do you love flutter",
                  buttons: [
                    {"id": "yes", "text": "👍 Yes"},
                    {"id": "no", "text": "✋ No"}
                  ]));
            },
            child: const Text("Send Button Options"),
          ),
          // TextButton(
          //   onPressed: () async {
          //     final ImagePicker picker = ImagePicker();
          //     final XFile? image =
          //         await picker.pickImage(source: ImageSource.gallery);
          //     print(await whatsapp.uploadMedia(
          //         mediaFile: image,
          //         mediaType: http_parser.MediaType('image', 'png'),
          //         mediaName: "Flutter Logo"));
          //   },
          //   child: const Text("Upload Image"),
          // ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.deleteMedia(mediaId: "614427183802844"));
            },
            child: const Text("Delete Media"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.getMediaUrl(mediaId: "429565272622604"));
            },
            child: const Text("Retrive Media URL"),
          ),
          TextButton(
            onPressed: () async {
              print(await whatsapp.updateProfile(
                  businessAbout: "A.I.",
                  businessWebsites: ["https://tonystark.com"], //list of website
                  businessAddress: "New York",
                  businessDescription: "You know who i am, the Ironman",
                  businessEmail: "tony@ironman.com",
                  businessIndustry: "A.I",
                  businessProfileId: "10203949568543"));
            },
            child: const Text("Update Profile"),
          ),
          TextButton(
            onPressed: () async {
              print(whatsapp.setTwoStepVerification(pin: "123456"));
            },
            child: const Text("Set Two Step Verification"),
          ),
        ],
      ),
    );
  }
}
