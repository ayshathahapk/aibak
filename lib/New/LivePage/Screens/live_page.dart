import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aibak/Core/Utils/size_utils.dart';
import 'package:auto_scroll_text/auto_scroll_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../Core/CommenWidgets/custom_image_view.dart';
import '../../../Core/CommenWidgets/space.dart';
import '../../../Core/Theme/new_custom_text_style.dart';
import '../../../Core/Theme/theme_helper.dart';
import '../../../Core/Utils/image_constant.dart';
import '../../../Models/spread_document_model.dart';
import '../../NewsScreen/Controller/news_controller.dart';
import '../Controller/live_controller.dart';
import 'dart:math' as Math;

import '../Repository/live_repository.dart';
import 'commodity_list.dart';
import 'live_rate_widget.dart';

final rateBidValue = StateProvider(
  (ref) {
    return 0.0;
  },
);

class LivePage extends ConsumerStatefulWidget {
  const LivePage({super.key});

  @override
  ConsumerState createState() => _LivePageState();
}

final spreadDataProvider2 = StateProvider<SpreadDocumentModel?>(
  (ref) {
    return null;
  },
);

class _LivePageState extends ConsumerState<LivePage> {
  late Timer _timer;
  String formattedTime = DateFormat('h:mm:ss a').format(DateTime.now());
  final formattedTimeProvider = StateProvider(
    (ref) => DateFormat('h:mm a').format(DateTime.now()),
  );

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) {
        _updateTime(timer);
      },
    );
  }

  final goldAskPrice = StateProvider.autoDispose<double>(
    (ref) => 0,
  );
  final silverAskPrice = StateProvider.autoDispose<double>(
    (ref) => 0,
  );
  void _updateTime(Timer timer) {
    ref.read(formattedTimeProvider.notifier).update(
          (state) => DateFormat('h:mm a').format(DateTime.now()),
        );
  }

  double getUnitMultiplier(String weight) {
    switch (weight) {
      case "GM":
        return 1;
      case "KG":
        return 1000;
      case "TTB":
        return 116.6400;
      case "TOLA":
        return 11.664;
      case " OZ":
        return 31.1034768;
      default:
        return 1;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final bannerBool = StateProvider.autoDispose(
    (ref) => false,
  );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 18.0.h, right: 18.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.calendar,
                            color: appTheme.whiteA700,
                          ),
                          Text(
                            DateFormat("MMM dd yyyy").format(DateTime.now()),
                            style: CustomPoppinsTextStyles.bodyText,
                          ),
                          Text(
                              DateFormat("EEEE")
                                  .format(DateTime.now())
                                  .toUpperCase(),
                              style: CustomPoppinsTextStyles.bodyText)
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            CupertinoIcons.time,
                            color: appTheme.whiteA700,
                          ),
                          Consumer(
                            builder: (context, ref, child) => Text(
                              ref.watch(formattedTimeProvider),
                              style: CustomPoppinsTextStyles.bodyText,
                            ),
                          ),
                          space()
                        ],
                      )
                    ],
                  ),
                ),
                space(),
                space(),
                Container(
                  height: 55.h,
                  decoration: BoxDecoration(
                    color: appTheme.gold,
                    borderRadius: BorderRadius.circular(15.v),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      space(w: 50.h),
                      Spacer(),
                      Text(
                        "BUY\$",
                        style: CustomPoppinsTextStyles.bodyText1White,
                      ),
                      Spacer(),
                      Text(
                        "SELL\$",
                        style: CustomPoppinsTextStyles.bodyText1White,
                      ),
                      space(w: 50.h)
                    ],
                  ),
                ),
                space(),

                ///First Table Live Rate of GOLD and SILVER.
                Consumer(
                  builder: (context, ref1, child) {
                    final liveRateData = ref1.watch(liveRateProvider);
                    return ref1.watch(spotRateProvider).when(
                      data: (spotRate) {
                        if (spotRate != null &&
                            liveRateData != null &&
                            liveRateData.gold != null &&
                            liveRateData.silver != null) {
                          final spreadNow = spotRate.info;
                          WidgetsBinding.instance.addPostFrameCallback(
                            (timeStamp) {
                              ref1.read(bannerBool.notifier).update(
                                (state) {
                                  return liveRateData.gold!.marketStatus !=
                                          "TRADEABLE"
                                      ? true
                                      : false;
                                },
                              );
                              ref1.read(rateBidValue.notifier).update(
                                (state) {
                                  return liveRateData.gold!.bid +
                                      (spreadNow.goldBidSpread);
                                },
                              );
                              ref1.read(goldAskPrice.notifier).update(
                                (state) {
                                  final res = (liveRateData.gold!.bid +
                                      (spreadNow.goldBidSpread));
                                  return res;
                                },
                              );
                              ref1.read(silverAskPrice.notifier).update(
                                (state) {
                                  final res = (((liveRateData.gold!.bid +
                                              spreadNow.goldBidSpread) +
                                          spreadNow.goldAskSpread) +
                                      0.5);
                                  return res;
                                },
                              );
                            },
                          );
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(10.v)),
                                width: SizeUtils.width,
                                height: SizeUtils.height * 0.1,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "Gold",
                                          style: CustomPoppinsTextStyles
                                              .bodyTextGold),
                                      TextSpan(
                                          text: " OZ",
                                          style: GoogleFonts.poppins(
                                              // fontFamily: marine,
                                              color: appTheme.gold,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.fSize))
                                    ])),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ValueDisplayWidget(
                                          value: (liveRateData.gold!.bid +
                                              (spreadNow.goldBidSpread)),
                                          // value: ref1.watch(goldAskPrice),
                                          // value: (liveRateData.gold.bid +
                                          //     (spreadNow?.editedBidSpreadValue ??
                                          //         0))
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons
                                                  .arrowtriangle_down_fill,
                                              color: appTheme.red700,
                                              size: 20.v,
                                            ),
                                            Text(
                                              "${liveRateData.gold!.low + (spreadNow.goldLowMargin)}",
                                              style: CustomPoppinsTextStyles
                                                  .bodyTextSemiBold,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ValueDisplayWidget2(
                                            value: (((liveRateData.gold!.bid +
                                                        spreadNow
                                                            .goldBidSpread) +
                                                    spreadNow.goldAskSpread) +
                                                0.5)),
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons
                                                  .arrowtriangle_up_fill,
                                              color: appTheme.mainGreen,
                                              size: 20.v,
                                            ),
                                            Text(
                                              "${liveRateData.gold?.high ?? 0 + (spreadNow.goldHighMargin)}",
                                              style: CustomPoppinsTextStyles
                                                  .bodyTextSemiBold,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              space(),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(10.v)),
                                width: SizeUtils.width,
                                height: SizeUtils.height * 0.1,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "Silver",
                                          style: CustomPoppinsTextStyles
                                              .bodyTextGold),
                                      TextSpan(
                                          text: " OZ",
                                          style: GoogleFonts.poppins(
                                              // fontFamily: marine,
                                              color: appTheme.gold,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.fSize))
                                    ])),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ValueDisplayWidgetSilver1(
                                            // value: 0,
                                            value: (liveRateData.silver?.bid ??
                                                0 +
                                                    (spreadNow
                                                            .silverBidSpread ??
                                                        0))),
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons
                                                  .arrowtriangle_down_fill,
                                              color: appTheme.red700,
                                              size: 20.v,
                                            ),
                                            Text(
                                              (liveRateData.silver?.low ??
                                                      0 +
                                                          (spreadNow
                                                              .silverLowMargin))
                                                  .toStringAsFixed(2),
                                              style: CustomPoppinsTextStyles
                                                  .bodyTextSemiBold,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ValueDisplayWidgetSilver2(
                                            // value: 0,
                                            value: (((liveRateData.silver!.bid +
                                                        spreadNow
                                                            .silverBidSpread) +
                                                    spreadNow.silverAskSpread) +
                                                0.05)),
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons
                                                  .arrowtriangle_up_fill,
                                              color: appTheme.mainGreen,
                                              size: 20.v,
                                            ),
                                            Text(
                                              (liveRateData.silver?.high ??
                                                      0 +
                                                          (spreadNow
                                                              .silverHighMargin))
                                                  .toStringAsFixed(2),
                                              style: CustomPoppinsTextStyles
                                                  .bodyTextSemiBold,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              space(),
                            ],
                          );
                        } else {
                          print("Spot rate is Null");
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(10.v)),
                                width: SizeUtils.width,
                                height: SizeUtils.height * 0.1,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "Gold",
                                          style: CustomPoppinsTextStyles
                                              .bodyTextGold),
                                      TextSpan(
                                          text: " OZ",
                                          style: GoogleFonts.poppins(
                                              // fontFamily: marine,
                                              color: appTheme.gold,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.fSize))
                                    ])),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const ValueDisplayWidget(
                                          value: 0.0,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons
                                                  .arrowtriangle_down_fill,
                                              color: appTheme.red700,
                                              size: 20.v,
                                            ),
                                            Text(
                                              "0.0",
                                              style: CustomPoppinsTextStyles
                                                  .bodyTextSemiBold,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const ValueDisplayWidget2(
                                          value: 0.0,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons
                                                  .arrowtriangle_up_fill,
                                              color: appTheme.mainGreen,
                                              size: 20.v,
                                            ),
                                            Text(
                                              "0.0",
                                              style: CustomPoppinsTextStyles
                                                  .bodyTextSemiBold,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              space(),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.black38,
                                    borderRadius: BorderRadius.circular(10.v)),
                                width: SizeUtils.width,
                                height: SizeUtils.height * 0.1,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: "Silver",
                                          style: CustomPoppinsTextStyles
                                              .bodyTextGold),
                                      TextSpan(
                                          text: " OZ",
                                          style: GoogleFonts.poppins(
                                              // fontFamily: marine,
                                              color: appTheme.gold,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15.fSize))
                                    ])),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const ValueDisplayWidgetSilver1(
                                            // value: 0,
                                            value: 0.0),
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons
                                                  .arrowtriangle_down_fill,
                                              color: appTheme.red700,
                                              size: 20.v,
                                            ),
                                            Text(
                                              "0.0",
                                              style: CustomPoppinsTextStyles
                                                  .bodyTextSemiBold,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const ValueDisplayWidgetSilver2(
                                            // value: 0,
                                            value: 0.0),
                                        Row(
                                          children: [
                                            Icon(
                                              CupertinoIcons
                                                  .arrowtriangle_up_fill,
                                              color: appTheme.mainGreen,
                                              size: 20.v,
                                            ),
                                            Text(
                                              "0.0",
                                              style: CustomPoppinsTextStyles
                                                  .bodyTextSemiBold,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              space(),
                            ],
                          );
                        }
                      },
                      error: (error, stackTrace) {
                        print("###ERROR###");
                        print(error.toString());
                        print(stackTrace);
                        return const Center(
                          child: Text("Something Went Wrong"),
                        );
                      },
                      loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  },
                ),
                Consumer(
                  builder: (context, ref2, child) => CommodityList(
                    price: ref2.watch(goldAskPrice),
                    slverPrice: ref2.watch(silverAskPrice),
                  ),
                ),

                space(),
                Consumer(
                  builder: (context, ref1, child) {
                    return ref1.watch(newsProvider).when(
                          data: (data123) {
                            if (data123 != null &&
                                data123.news.news.isNotEmpty) {
                              return AutoScrollText(
                                delayBefore: const Duration(seconds: 1),
                                "${data123.news.news[0].title}   ${data123.news.news[0].title}   ",
                                style: CustomPoppinsTextStyles.bodyText,
                              );
                            } else {
                              return AutoScrollText(
                                delayBefore: const Duration(seconds: 1),
                                "Aibak Gold & Diamonds Aibak Gold & Diamonds Aibak Gold & Diamonds Aibak Gold & Diamonds",
                                style: CustomPoppinsTextStyles.bodyText,
                              );
                            }
                          },
                          error: (error, stackTrace) {
                            print(stackTrace);
                            print(error.toString());
                            return SizedBox();
                          },
                          loading: () => SizedBox(),
                        );
                  },
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              space(w: 40),
              CustomImageView(
                imagePath: ImageConstants.logo,
                width: 85.h,
              ),
              Text(
                "AIBAK GOLD",
                style: CustomPoppinsTextStyles.name,
              )
            ],
          ),
        ),
        if (ref.watch(bannerBool))
          Positioned(
            top: 15.v,
            right: 90.h,
            child: Transform.rotate(
              angle: -Math.pi / 4,
              child: Consumer(
                builder: (context, refBanner, child) {
                  return Container(
                    width: SizeUtils.width,
                    height: 30.h,
                    color: Colors.red,
                    child: Center(
                      child: AutoScrollText(
                        delayBefore: const Duration(seconds: 1),
                        "Market is closed. It will open soon!  Market is closed. It will open soon! ",
                        style: CustomPoppinsTextStyles.buttonText,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
