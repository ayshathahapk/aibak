import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as Math;
import '../../../Core/app_export.dart';
import '../Controller/live_controller.dart';

class CommodityList extends ConsumerWidget {
  final double price;
  final double slverPrice;
  const CommodityList({
    super.key,
    required this.price,
    required this.slverPrice,
  });
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
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(spotRateProvider).when(
          data: (data) {
            if (data != null) {
              final commodity = data.info.commodities;
              return Column(
                children: [
                  Container(
                    width: SizeUtils.width,
                    // height: SizeUtils.height * 0.05,
                    decoration: BoxDecoration(
                      // border: Border.all(),
                      color: appTheme.gold,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10.h),
                          topLeft: Radius.circular(10.h)),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: SizeUtils.width / 3.4,
                          child: Center(
                            child: Text(
                              "COMMODITY",
                              style: GoogleFonts.poppins(
                                  // fontFamily: marine,
                                  color: appTheme.whiteA700,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15.fSize),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeUtils.width / 6,
                          child: Center(
                            child: Text(
                              "UNIT",
                              style: GoogleFonts.poppins(
                                  // fontFamily: marine,
                                  color: appTheme.whiteA700,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.fSize),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeUtils.width / 4,
                          child: Center(
                            child: Text(
                              "BUY\n(AED)",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  // fontFamily: marine,
                                  color: appTheme.whiteA700,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.fSize),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeUtils.width / 5,
                          child: Center(
                            child: Text(
                              "SELL\n(AED)",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  // fontFamily: marine,
                                  color: appTheme.whiteA700,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.fSize),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  space(h: 10.v),
                  Consumer(
                    builder: (context, ref2, child) {
                      // print("Consumer is rebulding");

                      return Container(
                          height: SizeUtils.height * 0.27,
                          child: ListView.builder(
                            itemCount: commodity.length,
                            itemBuilder: (context, index) {
                              // print(commodity[index].toMap());
                              final commodities = commodity[index];
                              if (commodities.weight == "GM") {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      top: 8.0.v, bottom: 8.0.v),
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
                                        SizedBox(
                                          width: SizeUtils.width / 4,
                                          child: Center(
                                            child: RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: commodities.metal
                                                      .toUpperCase(),
                                                  style: CustomPoppinsTextStyles
                                                      .bodyText1),
                                              TextSpan(
                                                  text: commodities.purity
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      // fontFamily: marine,
                                                      color: appTheme.black900,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.fSize))
                                            ])),
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeUtils.width / 5,
                                          child: Center(
                                            child: Text(
                                              commodities.unit.toString() +
                                                  commodities.weight,
                                              style: CustomPoppinsTextStyles
                                                  .bodyText1,
                                            ),
                                          ),
                                        ),
                                        Consumer(
                                          builder: (context, refSell, child) {
                                            final cat =
                                                price + commodities.sellPremium;
                                            final askNow =
                                                (cat / 31.103) * 3.674;
                                            final rateNow = askNow *
                                                    (commodities.unit *
                                                        getUnitMultiplier(
                                                            commodities
                                                                .weight)) *
                                                    (commodities.purity /
                                                        Math.pow(
                                                            10,
                                                            (commodities.purity
                                                                    .toString())
                                                                .length)) +
                                                commodities.sellCharge;
                                            return SizedBox(
                                              width: SizeUtils.width / 4,
                                              child: Center(
                                                child: Text(
                                                  rateNow.toStringAsFixed(2),
                                                  style: CustomPoppinsTextStyles
                                                      .bodyText1,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Consumer(
                                          builder: (context, refSell, child) {
                                            final cat = slverPrice +
                                                commodities.sellPremium;
                                            final askNow =
                                                (cat / 31.103) * 3.674;
                                            final rateNow = askNow *
                                                    (commodities.unit *
                                                        getUnitMultiplier(
                                                            commodities
                                                                .weight)) *
                                                    (commodities.purity /
                                                        Math.pow(
                                                            10,
                                                            (commodities.purity
                                                                    .toString())
                                                                .length)) +
                                                commodities.sellCharge;
                                            return SizedBox(
                                              width: SizeUtils.width / 5,
                                              child: Center(
                                                child: Text(
                                                  rateNow.toStringAsFixed(2),
                                                  style: CustomPoppinsTextStyles
                                                      .bodyText1,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else if (commodities.weight == "TTB") {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 8.0.v, top: 8.0.v),
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
                                        SizedBox(
                                          width: SizeUtils.width / 4,
                                          child: Center(
                                            child: RichText(
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
                                          ),
                                        ),
                                        // Text(
                                        //   commodities.metal + commodities.purity,
                                        //   style: CustomPoppinsTextStyles.bodyText1,
                                        // ),

                                        SizedBox(
                                          width: SizeUtils.width / 5,
                                          child: Center(
                                            child: Text(
                                              commodities.unit.toString() +
                                                  commodities.weight,
                                              style: CustomPoppinsTextStyles
                                                  .bodyText1,
                                            ),
                                          ),
                                        ),

                                        // VerticalDivider(
                                        //   color: appTheme.gray700,
                                        // ),
                                        Consumer(
                                          builder: (context, refSell, child) {
                                            final cat =
                                                price + commodities.sellPremium;
                                            final askNow =
                                                (cat / 31.103) * 3.674;
                                            final rateNow = askNow *
                                                    (commodities.unit *
                                                        getUnitMultiplier(
                                                            commodities
                                                                .weight)) *
                                                    (commodities.purity /
                                                        Math.pow(
                                                            10,
                                                            (commodities.purity
                                                                    .toString())
                                                                .length)) +
                                                commodities.sellCharge;
                                            return SizedBox(
                                              width: SizeUtils.width / 4,
                                              child: Center(
                                                child: Text(
                                                  rateNow.toStringAsFixed(0),
                                                  style: CustomPoppinsTextStyles
                                                      .bodyText1,
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        Consumer(
                                          builder: (context, refSell, child) {
                                            // print(askNow);
                                            // print("unit ${commodities.unit}");
                                            // print(
                                            //     "Multiplier ${getUnitMultiplier(commodities.weight)}");
                                            // print(
                                            //     "Purity${(double.parse(commodities.purity) / Math.pow(10, commodities.purity.length))}");
                                            final cat = slverPrice +
                                                commodities.sellPremium;
                                            final askNow =
                                                (cat / 31.103) * 3.674;
                                            final rateNow = askNow *
                                                    (commodities.unit *
                                                        getUnitMultiplier(
                                                            commodities
                                                                .weight)) *
                                                    (commodities.purity /
                                                        Math.pow(
                                                            10,
                                                            (commodities.purity
                                                                    .toString())
                                                                .length)) +
                                                commodities.sellCharge;
                                            return SizedBox(
                                              width: SizeUtils.width / 5,
                                              child: Center(
                                                child: Text(
                                                  rateNow.toStringAsFixed(0),
                                                  style: CustomPoppinsTextStyles
                                                      .bodyText1,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 8.0.v, top: 8.0.v),
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
                                        SizedBox(
                                          width: SizeUtils.width / 4,
                                          child: Center(
                                            child: RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: "GOLD",
                                                  style: CustomPoppinsTextStyles
                                                      .bodyText1),
                                              TextSpan(
                                                  text: commodities.purity
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      // fontFamily: marine,
                                                      color: appTheme.black900,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15.fSize))
                                            ])),
                                          ),
                                        ),
                                        SizedBox(
                                          width: SizeUtils.width / 5,
                                          child: Center(
                                            child: Text(
                                              commodities.unit.toString() +
                                                  commodities.weight,
                                              style: CustomPoppinsTextStyles
                                                  .bodyText1,
                                            ),
                                          ),
                                        ),
                                        Consumer(
                                          builder: (context, refSell, child) {
                                            final cat =
                                                price + commodities.sellPremium;
                                            final askNow =
                                                (cat / 31.103) * 3.674;
                                            final rateNow = askNow *
                                                    (commodities.unit *
                                                        getUnitMultiplier(
                                                            commodities
                                                                .weight)) *
                                                    (commodities.purity /
                                                        Math.pow(
                                                            10,
                                                            (commodities.purity
                                                                    .toString())
                                                                .length)) +
                                                commodities.sellCharge;
                                            return SizedBox(
                                              width: SizeUtils.width / 4,
                                              child: Center(
                                                child: Text(
                                                  rateNow.toStringAsFixed(0),
                                                  style: CustomPoppinsTextStyles
                                                      .bodyText1,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        Consumer(
                                          builder: (context, refSell, child) {
                                            final cat = slverPrice +
                                                commodities.sellPremium;
                                            final askNow =
                                                (cat / 31.103) * 3.674;
                                            final rateNow = askNow *
                                                    (commodities.unit *
                                                        getUnitMultiplier(
                                                            commodities
                                                                .weight)) *
                                                    (commodities.purity /
                                                        Math.pow(
                                                            10,
                                                            (commodities.purity
                                                                    .toString())
                                                                .length)) +
                                                commodities.sellCharge;
                                            return SizedBox(
                                              width: SizeUtils.width / 5,
                                              child: Center(
                                                child: Text(
                                                  rateNow.toStringAsFixed(0),
                                                  style: CustomPoppinsTextStyles
                                                      .bodyText1,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ));
                    },
                  ),
                ],
              );
            } else {
              return Container(
                width: SizeUtils.width,
                // height: SizeUtils.height * 0.05,
                decoration: BoxDecoration(
                  // border: Border.all(),
                  color: appTheme.gold,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.h),
                      topLeft: Radius.circular(10.h)),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: SizeUtils.width / 3.4,
                      child: Center(
                        child: Text(
                          "COMMODITY",
                          style: GoogleFonts.poppins(
                              // fontFamily: marine,
                              color: appTheme.whiteA700,
                              fontWeight: FontWeight.w700,
                              fontSize: 15.fSize),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeUtils.width / 6,
                      child: Center(
                        child: Text(
                          "UNIT",
                          style: GoogleFonts.poppins(
                              // fontFamily: marine,
                              color: appTheme.whiteA700,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.fSize),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeUtils.width / 4,
                      child: Center(
                        child: Text(
                          "BUY\n(AED)",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              // fontFamily: marine,
                              color: appTheme.whiteA700,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.fSize),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SizeUtils.width / 5,
                      child: Center(
                        child: Text(
                          "SELL\n(AED)",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              // fontFamily: marine,
                              color: appTheme.whiteA700,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.fSize),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
          error: (error, stackTrace) {
            return Text("Something Went Wrong");
          },
          loading: () => Center(
            child: CircularProgressIndicator(),
          ),
        );
  }
}
