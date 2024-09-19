import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../Core/CommenWidgets/space.dart';
import '../../../Core/Theme/new_custom_text_style.dart';
import '../../../Core/Theme/theme_helper.dart';
import '../../../Core/Utils/image_constant.dart';
import '../../../Core/Utils/size_utils.dart';
import '../../LivePage/Controller/live_controller.dart';

class NewsScreen extends ConsumerStatefulWidget {
  const NewsScreen({super.key});

  @override
  ConsumerState createState() => _NewsScreenState();
}

class _NewsScreenState extends ConsumerState<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: SizeUtils.height,
          width: SizeUtils.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.logoBg),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Image.asset(
                  ImageConstants.logo,
                  width: SizeUtils.width * 0.30,
                ),
                Text(
                  DateFormat('MMM/dd/yyyy-h:mm a').format(DateTime.now()),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: SizeUtils.height * 0.02,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Latest News",
                      style: CustomPoppinsTextStyles.bodyText2White,
                    )),
                space(h: 10.h),
                Container(
                  // color: const Color(0xFFBFA13A),
                  width: SizeUtils.width * 0.93,
                  padding: EdgeInsets.all(8.v),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.v),
                    color: appTheme.gold,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 2),
                    child: Consumer(
                      builder: (context, ref, child) {
                        return ref.watch(newsStream).when(
                          data: (data) {
                            print("Newwwwssssssssssssssssssssssssssss");
                            print(data.newsContent);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                space(),
                                Text(
                                  data.newsTitle,
                                  style: CustomPoppinsTextStyles.bodyText1,
                                ),
                                space(),
                                Text(
                                  data.newsContent,
                                  style: CustomPoppinsTextStyles.bodyTextBlack,
                                ),
                                space(),
                              ],
                            );
                          },
                          error: (error, stackTrace) {
                            print(error);
                            print(stackTrace);
                            return SizedBox();
                          },
                          loading: () {
                            return SizedBox();
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
