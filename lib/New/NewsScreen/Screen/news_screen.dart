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
import '../Controller/news_controller.dart';

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
                Consumer(
                  builder: (context, ref1, child) {
                    return ref1.watch(newsProvider).when(
                          data: (data) {
                            if (data != null) {
                              print("Data und${data.news.news.length}");
                              if (data.news.news.isNotEmpty) {
                                return SizedBox(
                                  height: SizeUtils.height * 0.575,
                                  child: ListView.builder(
                                    itemCount: data.news.news.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.all(8.0.h),
                                        child: Container(
                                          // height: 50.v,
                                          width: SizeUtils.width * 0.93,
                                          padding: EdgeInsets.all(8.v),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.v),
                                            color: appTheme.gold,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              space(),
                                              Text(
                                                data.news.news[index].title,
                                                style: CustomPoppinsTextStyles
                                                    .bodyText1,
                                              ),
                                              space(),
                                              Text(
                                                data.news.news[index]
                                                    .description,
                                                style: CustomPoppinsTextStyles
                                                    .bodyTextBlack,
                                              ),
                                              space(),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.all(8.0.h),
                                  child: Container(
                                    // height: 50.v,
                                    width: SizeUtils.width * 0.93,
                                    padding: EdgeInsets.all(8.v),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.v),
                                      color: appTheme.gold,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        space(),
                                        Text(
                                          "NO NEWS",
                                          style:
                                              CustomPoppinsTextStyles.bodyText1,
                                        ),
                                        space(),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return Container(
                                width: SizeUtils.width * 0.93,
                                padding: EdgeInsets.all(8.v),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.v),
                                  color: appTheme.gold,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    space(),
                                    Text(
                                      "No News",
                                      style:
                                          CustomPoppinsTextStyles.bodyTextBlack,
                                    ),
                                    space(),
                                  ],
                                ),
                              );
                            }
                          },
                          error: (error, stackTrace) => const Center(
                            child: Text("Something Went Wrong"),
                          ),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
