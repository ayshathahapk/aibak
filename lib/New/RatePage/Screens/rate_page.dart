import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Core/CommenWidgets/CustomElevatedButton/custom_elevated_button.dart';
import '../../../Core/CommenWidgets/space.dart';
import '../../../Core/Theme/new_custom_text_style.dart';
import '../../../Core/Theme/theme_helper.dart';
import '../../../Core/Utils/size_utils.dart';
import '../../../Models/alertValue_model.dart';
import '../../LivePage/Repository/live_repository.dart';
import '../../LivePage/Screens/live_page.dart';
import '../Controller/rate_controller.dart';

final diviceID = StateProvider(
  (ref) => "",
);

class RatePage extends ConsumerStatefulWidget {
  const RatePage({super.key});

  @override
  ConsumerState createState() => _RatePageState();
}

class _RatePageState extends ConsumerState<RatePage> {
  int _counter = 0;
  int count = 0;
  final countProvider = StateProvider<double>(
    (ref) => 500,
  );
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  final incrementCount = StateProvider<double>(
    (ref) {
      return 0;
    },
  );

  final decrementCount = StateProvider<double>(
    (ref) {
      return 0;
    },
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(countProvider.notifier).update(
              (state) => ref.watch(rateBidValue),
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: SizeUtils.height * 0.15,
          width: SizeUtils.height * 0.15,
          child: Center(
            child: CircleAvatar(
              radius: SizeUtils.height * 0.065,
              backgroundColor: CupertinoColors.systemYellow,
              child: CircleAvatar(
                backgroundColor: appTheme.mainBlack,
                radius: SizeUtils.height * 0.06,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer(
                      builder: (context, ref1, child) {
                        final spreadNow = ref1.watch(spreadDataProvider2);
                        final liveRateData = ref1.watch(liveRateProvider);
                        ref1.watch(rateBidValue);
                        final res = ref1.watch(rateBidValue);
                        return Text(
                          "\$${(liveRateData?.gold.bid ?? 0 + (spreadNow?.editedBidSpreadValue ?? 0)).toStringAsFixed(2)}",
                          style: CustomPoppinsTextStyles.bodyText1White,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        space(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              onPressed: () {
                ref.read(countProvider.notifier).update(
                  (state) {
                    double res = state - 1;
                    return res;
                  },
                );
              },
              // onPressed: () async {
              //   BookingModel res = widget.bookingModel;
              //   if (widget.bookingModel.driver ==
              //       "Dummy Driver") {
              //     res = res.copyWith(
              //         status: "Order Received",
              //         selectedDriver: ref.watch(dId),
              //         driver: ref
              //             .watch(userDataProvider)
              //             ?.driverName ??
              //             "");
              //   } else {
              //     res = res.copyWith(status: "Order Received");
              //   }
              //   ref
              //       .read(homeContProvider)
              //       .statusUpdate(model: res, context: context);
              //   // Navigator.push(
              //   //     context,
              //   //     MaterialPageRoute(
              //   //       builder: (context) => PickupDetails(
              //   //         bookingModel: res,
              //   //       ),
              //   //     ));
              // },
              height: 40.v,
              width: 90.h,
              text: "-50",
              buttonStyle: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    Colors.transparent), // Set background color to red
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.h,
                    ),
                    side: BorderSide(
                        color: CupertinoColors.systemYellow, width: 2),
                  ),
                ),
              ),
              buttonTextStyle: theme.textTheme.titleMedium!,
            ),
            space(w: 55.h),
            Consumer(
              builder: (context, ref1, child) {
                return Text(
                  ref1.watch(countProvider).toStringAsFixed(0),
                  style: CustomPoppinsTextStyles.bodyText1White,
                );
              },
            ),
            space(w: 55.h),
            CustomElevatedButton(
              onPressed: () {
                // NotificationService.showInstantNotification(
                //     "Alert", "2562", "high_importance_channel");
                if (ref.watch(incrementCount) < 50) {
                  ref.read(incrementCount.notifier).update(
                        (state) => state++,
                      );
                  ref.read(countProvider.notifier).update(
                    (state) {
                      double res = state + 1;
                      return res;
                    },
                  );
                }
              },
              // onPressed: () async {
              //   final res = widget.bookingModel
              //       .copyWith(status: "Rejected");
              //   final out = await alert(
              //       context, "Do you want to Reject?");
              //   if (out == true) {
              //     ref.read(homeContProvider).statusUpdate(
              //         model: res, context: context);
              //   }
              // },
              height: 40.v,
              width: 90.h,
              text: "+50",
              buttonStyle: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                    Colors.transparent), // Set background color to red
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.h,
                    ),
                    side: BorderSide(
                        color: CupertinoColors.systemYellow, width: 2),
                  ),
                ),
              ),
              buttonTextStyle: theme.textTheme.titleMedium!,
            ),
          ],
        ),
        space(h: 30.v),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 8,
          ),
          child: SwipeButton(
            inactiveTrackColor: appTheme.gray800,
            activeTrackColor: appTheme.gold,
            thumbPadding: const EdgeInsets.all(3),
            thumb: const Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
            elevationThumb: 2,
            elevationTrack: 2,
            child: Text(
              "Set Alert".toUpperCase(),
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18.fSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            onSwipe: () {
              AlertValueModel model = AlertValueModel(
                  alertValue: ref.watch(countProvider).roundToDouble(),
                  fcm: "",
                  uniqueId: ref.watch(diviceID),
                  docId: '');
              ref.read(rateController).setAlert(model: model, context: context);
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text("Swipped"),
              //     backgroundColor: Colors.green,
              //   ),
              // );
            },
          ),
        ),
        Consumer(
          builder: (context, ref2, child) {
            return ref2.watch(allAlertStream(ref2.watch(diviceID))).when(
              data: (data) {
                return Expanded(
                    flex: 0,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                            endActionPane: ActionPane(
                                motion: const StretchMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) async {
                                      ref2.read(rateController).deleteAlert(
                                          model: data[index], context: context);
                                      // final okk = await alert(
                                      //     context, "Are You Sure?");
                                      // if (okk == true) {
                                      //   ref.read(rateController).deleteAlert(
                                      //       model: data[index],
                                      //       context: context);
                                      // }
                                    },
                                    backgroundColor: appTheme.red700,
                                    icon: CupertinoIcons.delete_simple,
                                  )
                                ]),
                            child: Card(
                              elevation: 0,
                              color: appTheme.gold,
                              child: ListTile(
                                trailing: Icon(CupertinoIcons.alarm),
                                leading: Text((index + 1).toString()),
                                title: Text(
                                  "${data[index].alertValue}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 18.fSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ));
                      },
                    ));
              },
              error: (error, stackTrace) {
                print(error.toString());
                print(stackTrace);
                return SizedBox();
              },
              loading: () {
                return SizedBox();
              },
            );
          },
        )
      ],
    );
  }
}
