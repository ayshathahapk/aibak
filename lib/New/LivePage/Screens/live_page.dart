import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aibak/Core/Utils/size_utils.dart';
import 'package:timezone/timezone.dart' as tz;
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
import '../Controller/live_controller.dart';
import 'dart:math' as Math;

import '../Repository/live_repository.dart';

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
  final bdTimeProvider = StateProvider(
    (ref) => "",
  );
  final uaeTimeProvider = StateProvider(
    (ref) => "",
  );
  final usTimeProvider = StateProvider(
    (ref) => "",
  );
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        spreadData();
      },
    );
    _timer = Timer.periodic(
      const Duration(minutes: 1),
      (timer) {
        _updateTime(timer);
        convertTimes(timer);
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

  void spreadData() {
    ref.watch(liveControllerProvider).getSpread().then(
      (value) {
        ref.read(spreadDataProvider2.notifier).update(
              (state) => value,
            );
      },
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
      case "OZ":
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

  DateTime convertToTimeZone(DateTime dateTime, String timeZone) {
    final location = tz.getLocation(timeZone);
    final tz.TZDateTime tzDateTime = tz.TZDateTime.from(dateTime, location);
    return tzDateTime;
  }

  String ukTimeString = "";
  String bdTimeString = "";
  String inTimeString = "";
  String uaeTimeString = "";
  void convertTimes(Timer timer) {
    // Example timezones
    const String ukTimeZone = 'America/New_York';
    const String bdTimeZone = 'Asia/Dhaka';
    const String currentTimeZone = 'Asia/Kolkata';
    const String uaeTimeZone = 'Asia/Dubai';

    // Current time in your local timezone
    DateTime now = DateTime.now();

    // Convert to UK and Bangladesh time
    DateTime ukTime = convertToTimeZone(now, ukTimeZone);
    DateTime bdTime = convertToTimeZone(now, bdTimeZone);
    DateTime localTime = convertToTimeZone(now, currentTimeZone);
    DateTime uaeTime = convertToTimeZone(now, uaeTimeZone);
    // Format the time as needed
    ukTimeString = DateFormat('h:mm:ss a\nEEEE').format(ukTime);
    bdTimeString = DateFormat('h:mm:ss a\nEEEE').format(bdTime);
    inTimeString = DateFormat('h:mm:ss a\nEEEE').format(localTime);
    uaeTimeString = DateFormat('h:mm:ss a\nEEEE').format(uaeTime);
    ref.read(bdTimeProvider.notifier).update(
          (state) => bdTimeString,
        );
    ref.read(usTimeProvider.notifier).update(
          (state) => ukTimeString,
        );
    ref.read(uaeTimeProvider.notifier).update(
          (state) => uaeTimeString,
        );
  }

  @override
  Widget build(BuildContext context) {
    final liveRateData = ref.watch(liveRateProvider);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  // width: SizeUtils.width / 3,
                  child: Column(
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
                          DateFormat("EEEE").format(DateTime.now()).toUpperCase(),
                          style: CustomPoppinsTextStyles.bodyText)
                    ],
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstants.logo,
                  width: 50.h,
                ),
                SizedBox(
                  // width: SizeUtils.width / 3,
                  child: Column(
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
                  ),
                )
              ],
            ),
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
        
            Consumer(
              builder: (context, ref1, child) {
                final spreadNow = ref1.watch(spreadDataProvider2);
        
                if (liveRateData != null) {
                  print("######## here ########");
                  print(spreadNow?.editedBidSpreadValue);
                  // print(liveRateData.gold.toJson());
                  // print(liveRateData.silver.toJson());
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      ref1.read(rateBidValue.notifier).update(
                        (state) {
                          return liveRateData.gold.bid +
                              (spreadNow?.editedBidSpreadValue ?? 0);
                        },
                      );
                      ref1.read(goldAskPrice.notifier).update(
                        (state) {
                          final res = (liveRateData.gold.bid +
                              (spreadNow?.editedBidSpreadValue ?? 0));
                          return res;
                        },
                      );
                      ref1.read(silverAskPrice.notifier).update(
                        (state) {
                          final res = (liveRateData.gold.bid +
                              (spreadNow?.editedBidSpreadValue ?? 0) +
                              (spreadNow?.editedAskSpreadValue ?? 0) +
                              0.5);
                          return res;
                        },
                      );
                    },
                  );
                  return Column(
                    children: [
                      Card(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: SizeUtils.width,
                          height: SizeUtils.height * 0.1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Gold",
                                    style: CustomPoppinsTextStyles.bodyTextGold),
                                TextSpan(
                                    text: "OZ",
                                    style: GoogleFonts.poppins(
                                        // fontFamily: marine,
                                        color: appTheme.gold,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15.fSize))
                              ])),
                              Column(
                                children: [
                                  ValueDisplayWidget(
                                      value: (liveRateData.gold.bid +
                                          (spreadNow?.editedBidSpreadValue ??
                                              0))),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.arrowtriangle_down_fill,
                                        color: appTheme.red700,
                                      ),
                                      Text(
                                        "${liveRateData.gold.low}",
                                        style: CustomPoppinsTextStyles
                                            .bodyTextSemiBold,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  ValueDisplayWidget2(
                                      value: (liveRateData.gold.bid +
                                          (spreadNow?.editedBidSpreadValue ?? 0) +
                                          (spreadNow?.editedAskSpreadValue ?? 0) +
                                          0.5)),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.arrowtriangle_up_fill,
                                        color: appTheme.mainGreen,
                                      ),
                                      Text(
                                        "${liveRateData.gold.high}",
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
                      ),
                      space(),
                      Card(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: SizeUtils.width,
                          height: SizeUtils.height * 0.1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Silver",
                                    style: CustomPoppinsTextStyles.bodyTextGold),
                                TextSpan(
                                    text: "OZ",
                                    style: GoogleFonts.poppins(
                                        // fontFamily: marine,
                                        color: appTheme.gold,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15.fSize))
                              ])),
                              Column(
                                children: [
                                  ValueDisplayWidgetSilver1(
                                      value: (liveRateData.silver.bid +
                                          (spreadNow
                                                  ?.editedBidSilverSpreadValue ??
                                              0))),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.arrowtriangle_down_fill,
                                        color: appTheme.red700,
                                      ),
                                      Text(
                                        "${liveRateData.silver.low}",
                                        style: CustomPoppinsTextStyles
                                            .bodyTextSemiBold,
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  ValueDisplayWidgetSilver2(
                                      value: (liveRateData.silver.bid +
                                          (spreadNow
                                                  ?.editedBidSilverSpreadValue ??
                                              0) +
                                          (spreadNow
                                                  ?.editedAskSilverSpreadValue ??
                                              0) +
                                          0.05)),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.arrowtriangle_up_fill,
                                        color: appTheme.mainGreen,
                                      ),
                                      Text(
                                        "${liveRateData.silver.high}",
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
                      ),
                      space(),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Card(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: SizeUtils.width,
                          height: SizeUtils.height * 0.1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Gold",
                                    style: CustomPoppinsTextStyles.bodyTextGold),
                                TextSpan(
                                    text: "OZ",
                                    style: GoogleFonts.poppins(
                                        // fontFamily: marine,
                                        color: appTheme.gold,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15.fSize))
                              ])),
                              Column(
                                children: [
                                  ValueDisplayWidget(value: 0.0),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.arrowtriangle_down_fill,
                                        color: appTheme.red700,
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
                                children: [
                                  ValueDisplayWidget2(value: 0.0),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.arrowtriangle_up_fill,
                                        color: appTheme.mainGreen,
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
                      ),
                      space(),
                      Card(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: SizeUtils.width,
                          height: SizeUtils.height * 0.1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Silver",
                                    style: CustomPoppinsTextStyles.bodyTextGold),
                                TextSpan(
                                    text: "OZ",
                                    style: GoogleFonts.poppins(
                                        // fontFamily: marine,
                                        color: appTheme.gold,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15.fSize))
                              ])),
                              Column(
                                children: [
                                  ValueDisplayWidgetSilver1(value: 0.0),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.arrowtriangle_down_fill,
                                        color: appTheme.red700,
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
                                children: [
                                  ValueDisplayWidgetSilver2(value: 0.0),
                                  Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.arrowtriangle_up_fill,
                                        color: appTheme.mainGreen,
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
                      ),
                      space(),
                    ],
                  );
                }
              },
            ),
            Container(
              width: SizeUtils.width,
              // height: SizeUtils.height * 0.05,
              decoration: BoxDecoration(
                // border: Border.all(),
                color: appTheme.gold,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  space(w: SizeUtils.width * 0.01),
                  Text(
                    "COMMODITY",
                    style: CustomPoppinsTextStyles.bodyText1White,
                  ),
                  Spacer(),
                  Text(
                    "UNIT",
                    style: CustomPoppinsTextStyles.bodyText1White,
                  ),
                  Spacer(),
                  // VerticalDivider(
                  //   color: appTheme.gray700,
                  // ),
                  Text(
                    "BUY\n(AED)",
                    textAlign: TextAlign.center,
                    style: CustomPoppinsTextStyles.bodyText1White,
                  ),
                  Spacer(),
                  Text(
                    "SELL\n(AED)",
                    textAlign: TextAlign.center,
                    style: CustomPoppinsTextStyles.bodyText1White,
                  ),
                  Spacer(),
                ],
              ),
            ),
            ref.watch(commoditiesStream).when(
              data: (data) {
                return Consumer(
                  builder: (context, ref2, child) {
                    print("Consumer is rebulding");
        
                    return Expanded(
                        flex: 0,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final commodities = data[index];
                            if (commodities.weight == "GM") {
                              return Padding(
                                padding:
                                    EdgeInsets.only(top: 8.0.v, bottom: 8.0.v),
                                child: Container(
                                  width: SizeUtils.width,
                                  height: SizeUtils.height * 0.05,
                                  decoration: BoxDecoration(
                                    // border: Border.all(),
                                    color: appTheme.whiteA700,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: commodities.metal.toUpperCase(),
                                            style: CustomPoppinsTextStyles
                                                .bodyText1),
                                        TextSpan(
                                            text: commodities.purity,
                                            style: GoogleFonts.poppins(
                                                // fontFamily: marine,
                                                color: appTheme.black900,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.fSize))
                                      ])),
                                      // Text(
                                      //   commodities.metal + commodities.purity,
                                      //   style: CustomPoppinsTextStyles.bodyText1,
                                      // ),
                                      Spacer(),
                                      Text(
                                        commodities.unit + commodities.weight,
                                        style: CustomPoppinsTextStyles.bodyText1,
                                      ),
                                      Spacer(),
                                      // VerticalDivider(
                                      //   color: appTheme.gray700,
                                      // ),
                                      Consumer(
                                        builder: (context, refSell, child) {
                                          final askNow =
                                              (refSell.watch(goldAskPrice) /
                                                      31.103) *
                                                  3.674;
                                          // print(askNow);
                                          // print("unit ${commodities.unit}");
                                          // print(
                                          //     "Multiplier ${getUnitMultiplier(commodities.weight)}");
                                          // print(
                                          //     "Purity${(double.parse(commodities.purity) / Math.pow(10, commodities.purity.length))}");
                                          final rateNow = askNow *
                                              double.parse(commodities.unit) *
                                              getUnitMultiplier(
                                                  commodities.weight) *
                                              (double.parse(commodities.purity) /
                                                  Math.pow(10,
                                                      commodities.purity.length));
                                          return Text(
                                            rateNow.toStringAsFixed(2),
                                            style:
                                                CustomPoppinsTextStyles.bodyText1,
                                          );
                                        },
                                      ),
                                      Spacer(),
                                      Consumer(
                                        builder: (context, refSell, child) {
                                          final askNow =
                                              (refSell.watch(silverAskPrice) /
                                                      31.103) *
                                                  3.674;
                                          // print(askNow);
                                          // print("unit ${commodities.unit}");
                                          // print(
                                          //     "Multiplier ${getUnitMultiplier(commodities.weight)}");
                                          // print(
                                          //     "Purity${(double.parse(commodities.purity) / Math.pow(10, commodities.purity.length))}");
                                          final rateNow = askNow *
                                              double.parse(commodities.unit) *
                                              getUnitMultiplier(
                                                  commodities.weight) *
                                              (double.parse(commodities.purity) /
                                                  Math.pow(10,
                                                      commodities.purity.length));
                                          return Text(
                                            rateNow.toStringAsFixed(2),
                                            style:
                                                CustomPoppinsTextStyles.bodyText1,
                                          );
                                        },
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              );
                            } else if (commodities.weight == "TTB") {
                              return Padding(
                                padding:
                                    EdgeInsets.only(bottom: 8.0.v, top: 8.0.v),
                                child: Container(
                                  width: SizeUtils.width,
                                  height: SizeUtils.height * 0.05,
                                  decoration: BoxDecoration(
                                    // border: Border.all(),
                                    color: appTheme.whiteA700,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "TEN TOLA",
                                            style: CustomPoppinsTextStyles
                                                .bodyText1),
                                        // TextSpan(
                                        //     text: commodities.purity,
                                        //     style: GoogleFonts.poppins(
                                        //       // fontFamily: marine,
                                        //         color: appTheme.black900,
                                        //         fontWeight: FontWeight.w500,
                                        //         fontSize: 10.fSize))
                                      ])),
                                      // Text(
                                      //   commodities.metal + commodities.purity,
                                      //   style: CustomPoppinsTextStyles.bodyText1,
                                      // ),
                                      Spacer(),
                                      Text(
                                        commodities.unit + commodities.weight,
                                        style: CustomPoppinsTextStyles.bodyText1,
                                      ),
                                      Spacer(),
                                      // VerticalDivider(
                                      //   color: appTheme.gray700,
                                      // ),
                                      Consumer(
                                        builder: (context, refSell, child) {
                                          final askNow =
                                              (refSell.watch(goldAskPrice) /
                                                      31.103) *
                                                  3.674;
                                          // print(askNow);
                                          // print("unit ${commodities.unit}");
                                          // print(
                                          //     "Multiplier ${getUnitMultiplier(commodities.weight)}");
                                          // print(
                                          //     "Purity${(double.parse(commodities.purity) / Math.pow(10, commodities.purity.length))}");
                                          final rateNow = askNow *
                                              double.parse(commodities.unit) *
                                              getUnitMultiplier(
                                                  commodities.weight) *
                                              (double.parse(commodities.purity) /
                                                  Math.pow(10,
                                                      commodities.purity.length));
                                          return Text(
                                            rateNow.toStringAsFixed(0),
                                            style:
                                                CustomPoppinsTextStyles.bodyText1,
                                          );
                                        },
                                      ),
                                      Spacer(),
                                      Consumer(
                                        builder: (context, refSell, child) {
                                          final askNow =
                                              (refSell.watch(silverAskPrice) /
                                                      31.103) *
                                                  3.674;
                                          // print(askNow);
                                          // print("unit ${commodities.unit}");
                                          // print(
                                          //     "Multiplier ${getUnitMultiplier(commodities.weight)}");
                                          // print(
                                          //     "Purity${(double.parse(commodities.purity) / Math.pow(10, commodities.purity.length))}");
                                          final rateNow = askNow *
                                              double.parse(commodities.unit) *
                                              getUnitMultiplier(
                                                  commodities.weight) *
                                              (double.parse(commodities.purity) /
                                                  Math.pow(10,
                                                      commodities.purity.length));
                                          return Text(
                                            rateNow.toStringAsFixed(0),
                                            style:
                                                CustomPoppinsTextStyles.bodyText1,
                                          );
                                        },
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Padding(
                                padding:
                                    EdgeInsets.only(bottom: 8.0.v, top: 8.0.v),
                                child: Container(
                                  width: SizeUtils.width,
                                  height: SizeUtils.height * 0.05,
                                  decoration: BoxDecoration(
                                    // border: Border.all(),
                                    color: appTheme.whiteA700,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "GOLD",
                                            style: CustomPoppinsTextStyles
                                                .bodyText1),
                                        TextSpan(
                                            text: commodities.purity,
                                            style: GoogleFonts.poppins(
                                                // fontFamily: marine,
                                                color: appTheme.black900,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15.fSize))
                                      ])),
                                      // Text(
                                      //   commodities.metal + commodities.purity,
                                      //   style: CustomPoppinsTextStyles.bodyText1,
                                      // ),
                                      Spacer(),
                                      Text(
                                        commodities.unit + commodities.weight,
                                        style: CustomPoppinsTextStyles.bodyText1,
                                      ),
                                      Spacer(),
                                      // VerticalDivider(
                                      //   color: appTheme.gray700,
                                      // ),
                                      Consumer(
                                        builder: (context, refSell, child) {
                                          final askNow =
                                              (refSell.watch(goldAskPrice) /
                                                      31.103) *
                                                  3.674;
                                          // print(askNow);
                                          // print("unit ${commodities.unit}");
                                          // print(
                                          //     "Multiplier ${getUnitMultiplier(commodities.weight)}");
                                          // print(
                                          //     "Purity${(double.parse(commodities.purity) / Math.pow(10, commodities.purity.length))}");
                                          final rateNow = askNow *
                                              double.parse(commodities.unit) *
                                              getUnitMultiplier(
                                                  commodities.weight) *
                                              (double.parse(commodities.purity) /
                                                  Math.pow(10,
                                                      commodities.purity.length));
                                          return Text(
                                            rateNow.toStringAsFixed(0),
                                            style:
                                                CustomPoppinsTextStyles.bodyText1,
                                          );
                                        },
                                      ),
                                      Spacer(),
                                      Consumer(
                                        builder: (context, refSell, child) {
                                          final askNow =
                                              (refSell.watch(silverAskPrice) /
                                                      31.103) *
                                                  3.674;
                                          // print(askNow);
                                          // print("unit ${commodities.unit}");
                                          // print(
                                          //     "Multiplier ${getUnitMultiplier(commodities.weight)}");
                                          // print(
                                          //     "Purity${(double.parse(commodities.purity) / Math.pow(10, commodities.purity.length))}");
                                          final rateNow = askNow *
                                              double.parse(commodities.unit) *
                                              getUnitMultiplier(
                                                  commodities.weight) *
                                              (double.parse(commodities.purity) /
                                                  Math.pow(10,
                                                      commodities.purity.length));
                                          return Text(
                                            rateNow.toStringAsFixed(0),
                                            style:
                                                CustomPoppinsTextStyles.bodyText1,
                                          );
                                        },
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              );
                            }
        
                            // return Padding(
                            //   padding: EdgeInsets.only(top: 8.0.v, bottom: 8.0.v),
                            //   child: Container(
                            //     width: SizeUtils.width,
                            //     height: SizeUtils.height * 0.05,
                            //     decoration: BoxDecoration(
                            //       // border: Border.all(),
                            //       color: appTheme.whiteA700,
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //     child: Row(
                            //       children: [
                            //         Spacer(),
                            //         Text(
                            //           "Gold999",
                            //           style: CustomPoppinsTextStyles.commodityText,
                            //         ),
                            //         Spacer(),
                            //         Text(
                            //           "1 GM",
                            //           style: CustomPoppinsTextStyles.commodityText,
                            //         ),
                            //         Spacer(),
                            //         // VerticalDivider(
                            //         //   color: appTheme.gray700,
                            //         // ),
                            //         Text(
                            //           "296.19",
                            //           style: CustomPoppinsTextStyles.commodityText,
                            //         ),
                            //         Spacer(),
                            //         Text(
                            //           "296.19",
                            //           style: CustomPoppinsTextStyles.commodityText,
                            //         ),
                            //         Spacer(),
                            //       ],
                            //     ),
                            //   ),
                            // );
                          },
                        ));
                  },
                );
              },
              error: (error, stackTrace) {
                if (kDebugMode) {
                  print(error.toString());
                  print(stackTrace);
                }
                return const Center(
                  child: Text("Something Went Worng"),
                );
              },
              loading: () {
                return SizedBox();
              },
            ),
        
            ref.watch(newsStream).when(
              data: (data) {
                print("Newwwwssssssssssssssssssssssssssss");
                print(data.newsContent);
                return AutoScrollText(
                  delayBefore: Duration(seconds: 3),
                  data.newsContent + "                             ",
                  style: CustomPoppinsTextStyles.bodyText,
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
            )
        
            // AutoScrollText(
            //   delayBefore: Duration(seconds: 3),
            //   "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
            //   style: CustomPoppinsTextStyles.bodyText,
            // ),
          ],
        ),
      ),
    );
  }
}

///

class ValueDisplayWidgetSilver1 extends StatefulWidget {
  final double value;

  const ValueDisplayWidgetSilver1({super.key, required this.value});

  @override
  _ValueDisplayWidgetSilver1State createState() =>
      _ValueDisplayWidgetSilver1State();
}

class _ValueDisplayWidgetSilver1State extends State<ValueDisplayWidgetSilver1> {
  Color _containerColor = Colors.white;
  Timer? _debounceTimer;
  double _lastValue = 0;

  @override
  void initState() {
    super.initState();
    _lastValue = widget.value;
  }

  @override
  void didUpdateWidget(ValueDisplayWidgetSilver1 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _updateColor();
    }
  }

  void _updateColor() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 100), () {
      setState(() {
        if (widget.value > _lastValue) {
          _containerColor = appTheme.mainGreen;
        } else if (widget.value < _lastValue) {
          _containerColor = appTheme.red700;
        } else {
          _containerColor = appTheme.mainWhite;
        }
        _lastValue = widget.value;
      });
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // color: _containerColor,
      height: 50.v,
      width: 120.v,
      decoration: BoxDecoration(
          color: _containerColor,
          // color: godLow == godBid
          //     ? appTheme.mainWhite
          //     : godLow < godBid
          //         ? appTheme.red700
          //         : appTheme.mainGreen,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: appTheme.gray500)),
      child: Center(
        child: Text(
          widget.value.toStringAsFixed(4),
          style: CustomPoppinsTextStyles.bodyText2,
        ),
      ),
    );
  }
}

///

class ValueDisplayWidgetSilver2 extends StatefulWidget {
  final double value;

  const ValueDisplayWidgetSilver2({super.key, required this.value});

  @override
  _ValueDisplayWidgetSilver2State createState() =>
      _ValueDisplayWidgetSilver2State();
}

class _ValueDisplayWidgetSilver2State extends State<ValueDisplayWidgetSilver2> {
  Color _containerColor = Colors.white;
  Timer? _debounceTimer;
  double _lastValue = 0;

  @override
  void initState() {
    super.initState();
    _lastValue = widget.value;
  }

  @override
  void didUpdateWidget(ValueDisplayWidgetSilver2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _updateColor();
    }
  }

  void _updateColor() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 100), () {
      setState(() {
        if (widget.value > _lastValue) {
          _containerColor = appTheme.mainGreen;
        } else if (widget.value < _lastValue) {
          _containerColor = appTheme.red700;
        } else {
          _containerColor = appTheme.mainWhite;
        }
        _lastValue = widget.value;
      });
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // color: _containerColor,
      height: 50.v,
      width: 120.v,
      decoration: BoxDecoration(
          color: _containerColor,
          // color: godLow == godBid
          //     ? appTheme.mainWhite
          //     : godLow < godBid
          //         ? appTheme.red700
          //         : appTheme.mainGreen,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: appTheme.gray500)),
      child: Center(
        child: Text(
          widget.value.toStringAsFixed(4),
          style: CustomPoppinsTextStyles.bodyText2,
        ),
      ),
    );
  }
}

///

class ValueDisplayWidget extends StatefulWidget {
  final double value;

  const ValueDisplayWidget({Key? key, required this.value}) : super(key: key);

  @override
  _ValueDisplayWidgetState createState() => _ValueDisplayWidgetState();
}

class _ValueDisplayWidgetState extends State<ValueDisplayWidget> {
  Color _containerColor = Colors.white;
  Timer? _debounceTimer;
  double _lastValue = 0;

  @override
  void initState() {
    super.initState();
    _lastValue = widget.value;
  }

  @override
  void didUpdateWidget(ValueDisplayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _updateColor();
    }
  }

  void _updateColor() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 100), () {
      setState(() {
        if (widget.value > _lastValue) {
          _containerColor = appTheme.mainGreen;
        } else if (widget.value < _lastValue) {
          _containerColor = appTheme.red700;
        } else {
          _containerColor = appTheme.mainWhite;
        }
        _lastValue = widget.value;
      });
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // color: _containerColor,
      height: 50.v,
      width: 120.v,
      decoration: BoxDecoration(
          color: _containerColor,
          // color: godLow == godBid
          //     ? appTheme.mainWhite
          //     : godLow < godBid
          //         ? appTheme.red700
          //         : appTheme.mainGreen,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: appTheme.gray500)),
      child: Center(
        child: Text(
          widget.value.toStringAsFixed(2),
          style: CustomPoppinsTextStyles.bodyText2,
        ),
      ),
    );
  }
}

///

class ValueDisplayWidget2 extends StatefulWidget {
  final double value;

  const ValueDisplayWidget2({Key? key, required this.value}) : super(key: key);

  @override
  _ValueDisplayWidget2State createState() => _ValueDisplayWidget2State();
}

class _ValueDisplayWidget2State extends State<ValueDisplayWidget2> {
  Color _containerColor = Colors.white;
  Timer? _debounceTimer;
  double _lastValue = 0;

  @override
  void initState() {
    super.initState();
    _lastValue = widget.value;
  }

  @override
  void didUpdateWidget(ValueDisplayWidget2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _updateColor();
    }
  }

  void _updateColor() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    _debounceTimer = Timer(const Duration(milliseconds: 100), () {
      setState(() {
        if (widget.value > _lastValue) {
          _containerColor = appTheme.mainGreen;
        } else if (widget.value < _lastValue) {
          _containerColor = appTheme.red700;
        } else {
          _containerColor = appTheme.mainWhite;
        }
        _lastValue = widget.value;
      });
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // color: _containerColor,
      height: 50.v,
      width: 120.v,
      decoration: BoxDecoration(
          color: _containerColor,
          // color: godLow == godBid
          //     ? appTheme.mainWhite
          //     : godLow < godBid
          //         ? appTheme.red700
          //         : appTheme.mainGreen,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: appTheme.gray500)),
      child: Center(
        child: Text(
          widget.value.toStringAsFixed(2),
          style: CustomPoppinsTextStyles.bodyText2,
        ),
      ),
    );
  }
}
