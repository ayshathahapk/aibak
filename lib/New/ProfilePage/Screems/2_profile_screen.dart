import 'package:aibak/Core/Utils/firebase_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:aibak/Core/Utils/size_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Core/CommenWidgets/custom_image_view.dart';
import '../../../Core/CommenWidgets/space.dart';
import '../../../Core/Theme/new_custom_text_style.dart';
import '../../../Core/Theme/theme_helper.dart';
import '../../../Core/Utils/image_constant.dart';
import '../Controller/profile_controller.dart';

class ProfileScreen2 extends ConsumerStatefulWidget {
  const ProfileScreen2({super.key});

  @override
  ConsumerState createState() => _ProfileScreen2State();
}

class _ProfileScreen2State extends ConsumerState<ProfileScreen2> {
  Widget _buildCard(BuildContext context, IconData icon, String title,
      String subtitle, VoidCallback onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        color: appTheme.gold,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(
                250, 250, 250, 0.2), // Gold background color
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: appTheme.gray800,
                  // color: appTheme.gold, // White background for the icon
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(15),
                child: Icon(
                  icon,
                  size: 30.h,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: CustomPoppinsTextStyles.bodyText1,
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchWhatsApp({required String whNo}) async {
    final Uri url =
        Uri.parse('https://wa.me/+$whNo'); // Replace with your WhatsApp link
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  void _launchMail({required String email}) async {
    final Uri url = Uri.parse('mailto:$email'); // Replace with your mail link
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  void _launchContact({required String phone}) async {
    final Uri url =
        Uri.parse('tel:+$phone'); // Replace with your contact number
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  void _launchMap() async {
    final Uri url =
        Uri.parse(FirebaseConstants.location); // Replace with your map link
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(
          builder: (context, ref1, child) {
            return ref1.watch(profileDetailsProvider).when(
                  data: (data) {
                    if (data != null) {
                      debugPrint("DataUnd");
                      return Container(
                        padding: EdgeInsets.all(10.h),
                        width: SizeUtils.width,
                        height: SizeUtils.height,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ImageConstants.logoBg),
                                fit: BoxFit.cover)),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(FontAwesomeIcons.arrowLeft,
                                      color: appTheme.gold)),
                            ),
                            space(),
                            CustomImageView(
                              imagePath: ImageConstants.logo,
                              width: 150.h,
                            ),
                            Text(
                              'Customer Support',
                              style: CustomPoppinsTextStyles.bodyText3White,
                            ),
                            Text(
                              '24 / 7 Support',
                              style: CustomPoppinsTextStyles.bodyText1White,
                            ),
                            space(h: 10.v),
                            Expanded(
                              flex: 0,
                              child: GridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                children: [
                                  _buildCard(
                                    context,
                                    FontAwesomeIcons.whatsapp,
                                    'WhatsApp',
                                    data.info.whatsapp.toString(),
                                    () {
                                      _launchWhatsApp(
                                          whNo: data.info.whatsapp.toString());
                                    },
                                  ),
                                  _buildCard(
                                    context,
                                    FontAwesomeIcons.envelope,
                                    'Mail',
                                    'Drop us a line',
                                    () {
                                      _launchMail(email: data.info.email);
                                    },
                                  ),
                                  _buildCard(
                                    context,
                                    FontAwesomeIcons.phone,
                                    'Call Us',
                                    data.info.contact.toString(),
                                    () {
                                      _launchContact(
                                          phone: data.info.contact.toString());
                                    },
                                  ),
                                  _buildCard(
                                    context,
                                    FontAwesomeIcons.mapLocationDot,
                                    'Our Adress',
                                    'React us at',
                                    _launchMap,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container(
                        padding: EdgeInsets.all(10.h),
                        width: SizeUtils.width,
                        height: SizeUtils.height,
                        color: const Color(0xFF026C5C),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstants.logo,
                              width: 150.h,
                            ),
                            space(),
                            Text(
                              'Customer Support',
                              style: CustomPoppinsTextStyles.bodyText3White,
                            ),
                            Text(
                              '24 / 7 Support',
                              style: CustomPoppinsTextStyles.bodyText1White,
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              flex: 0,
                              child: GridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                children: [
                                  _buildCard(
                                    context,
                                    FontAwesomeIcons.whatsapp,
                                    'WhatsApp',
                                    FirebaseConstants.whatsapp,
                                    () {
                                      _launchWhatsApp(
                                          whNo: FirebaseConstants.whatsapp);
                                    },
                                  ),
                                  _buildCard(
                                    context,
                                    FontAwesomeIcons.envelope,
                                    'Mail',
                                    'Drop us a line',
                                    () {
                                      _launchMail(
                                          email: FirebaseConstants.mail);
                                    },
                                  ),
                                  _buildCard(
                                    context,
                                    FontAwesomeIcons.phone,
                                    'Call Us',
                                    FirebaseConstants.phone,
                                    () {
                                      _launchContact(
                                          phone: FirebaseConstants.phone);
                                    },
                                  ),
                                  _buildCard(
                                    context,
                                    FontAwesomeIcons.mapLocationDot,
                                    'Our Adress',
                                    'React us at',
                                    _launchMap,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  error: (error, stackTrace) {
                    if (kDebugMode) {
                      print(stackTrace);
                      print(error);
                    }
                    return Container(
                      padding: EdgeInsets.all(10.h),
                      width: SizeUtils.width,
                      height: SizeUtils.height,
                      color: const Color(0xFF026C5C),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstants.logo,
                            width: 150.h,
                          ),
                          space(),
                          Text(
                            'Customer Support',
                            style: CustomPoppinsTextStyles.bodyText3White,
                          ),
                          Text(
                            '24 / 7 Support',
                            style: CustomPoppinsTextStyles.bodyText1White,
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            flex: 0,
                            child: GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              children: [
                                _buildCard(
                                  context,
                                  FontAwesomeIcons.whatsapp,
                                  'WhatsApp',
                                  '+971503961445',
                                  () {
                                    _launchWhatsApp(whNo: "971503961445");
                                  },
                                ),
                                _buildCard(
                                  context,
                                  FontAwesomeIcons.envelope,
                                  'Mail',
                                  'Drop us a line',
                                  () {
                                    _launchMail(
                                        email: "goldking.info@gmail.com");
                                  },
                                ),
                                _buildCard(
                                  context,
                                  FontAwesomeIcons.phone,
                                  'Call Us',
                                  '+971503961445',
                                  () {
                                    _launchContact(phone: "971503961445");
                                  },
                                ),
                                _buildCard(
                                  context,
                                  FontAwesomeIcons.mapLocationDot,
                                  'Our Adress',
                                  'React us at',
                                  _launchMap,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
          },
        ),
      ),
    );
  }
}
