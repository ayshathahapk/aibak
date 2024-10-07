import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../Core/CommenWidgets/CustomElevatedButton/custom_elevated_button.dart';
import '../../Core/CommenWidgets/custom_text_field.dart';
import '../../Core/CommenWidgets/space.dart';
import '../../Core/Theme/new_custom_text_style.dart';
import '../../Core/Theme/theme_helper.dart';
import '../../Core/Utils/firebase_constants.dart';
import '../../Core/Utils/image_constant.dart';
import '../../Core/Utils/size_utils.dart';
import '../../Core/Utils/snackbar_dialogs.dart';
import 'bank_controller.dart';

class Details extends ConsumerStatefulWidget {
  const Details({super.key});

  @override
  ConsumerState<Details> createState() => _DetailsState();
}

class _DetailsState extends ConsumerState<Details> {
  Future reqbank() async {
    var headers = {
      'X-Secret-Key': 'IfiuH/ko+rh/gekRvY4Va0s+aGYuGJEAOkbJbChhcqo=',
      'Content-Type': 'application/json'
    };
    var data = json.encode({"request": "Request for bankDetails"});
    var dio = Dio();
    var response = await dio.request(
      '${FirebaseConstants.baseUrl}request-admin/${FirebaseConstants.adminId}',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  final TextEditingController _acName = TextEditingController();
  final TextEditingController _iban = TextEditingController();
  final TextEditingController _ifsc = TextEditingController();
  final TextEditingController _swift = TextEditingController();
  final TextEditingController _bankName = TextEditingController();
  final TextEditingController _branch = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _holderName = TextEditingController();
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _acName.dispose();
    _iban.dispose();
    _ifsc.dispose();
    _swift.dispose();
    _bankName.dispose();
    _branch.dispose();
    _city.dispose();
    _country.dispose();
    _holderName.dispose();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(8.v),
          height: SizeUtils.height,
          width: SizeUtils.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImageConstants.logoBg),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                Image.asset(
                  ImageConstants.logo,
                  width: SizeUtils.width * 0.30,
                ),
                Text(
                  DateFormat('MMM/dd/yyyy-h:mm:ss a').format(DateTime.now()),
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
                      "Bank Details",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
                space(h: 30.v),
                Consumer(
                  builder: (context, refBank, child) {
                    return refBank.watch(bankDetailsProvider).when(
                          data: (data) {
                            if (data != null) {
                              print("data Null alla");
                              print(data.bankInfo.bankDetails);
                              if (data.bankInfo.bankDetails.isNotEmpty) {
                                return Expanded(
                                  flex: 0,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: data.bankInfo.bankDetails.length,
                                    itemBuilder: (context, index) {
                                      final bank =
                                          data.bankInfo.bankDetails[index];
                                      _acName.text = bank.accountNumber;
                                      _holderName.text = bank.holderName ?? "";
                                      _iban.text = bank.iban ?? "";
                                      _ifsc.text = bank.ifsc ?? "";
                                      _swift.text = bank.swift ?? "";
                                      _bankName.text = bank.bankName ?? "";
                                      _branch.text = bank.branch ?? "";
                                      _city.text = bank.city ?? "";
                                      _country.text = bank.country ?? "";

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        child: Container(
                                          padding: EdgeInsets.all(12.h),
                                          height: SizeUtils.height * 0.8,
                                          width: SizeUtils.width * 0.93,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.v),
                                            color: Colors.black54,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomTextField(
                                                  readOnly: true,
                                                  controller: _acName,
                                                  label: "Account Number"),
                                              CustomTextField(
                                                  readOnly: true,
                                                  controller: _iban,
                                                  label: "IBAN"),
                                              CustomTextField(
                                                  readOnly: true,
                                                  controller: _ifsc,
                                                  label: "IFSC"),
                                              CustomTextField(
                                                  readOnly: true,
                                                  controller: _swift,
                                                  label: "Swift"),
                                              CustomTextField(
                                                  readOnly: true,
                                                  controller: _bankName,
                                                  label: "Bank Name"),
                                              CustomTextField(
                                                  readOnly: true,
                                                  controller: _branch,
                                                  label: "Branch Name"),
                                              CustomTextField(
                                                  readOnly: true,
                                                  controller: _city,
                                                  label: "City"),
                                              CustomTextField(
                                                  readOnly: true,
                                                  controller: _country,
                                                  label: "Country"),
                                              CustomTextField(
                                                  readOnly: true,
                                                  controller: _holderName,
                                                  label: "Holder Name"),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              } else {
                                return Container(
                                  // height: 50.v,
                                  width: SizeUtils.width * 0.93,
                                  padding: EdgeInsets.all(8.v),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.v),
                                    // color: appTheme.gold,
                                  ),
                                  child: CustomElevatedButton(
                                      onPressed: () {
                                        reqbank()
                                            .then(
                                          (value) => showSnackBarDialogue(
                                              context: context,
                                              message:
                                                  "Requested For BankDetails"),
                                        )
                                            .catchError((onError) {
                                          showSnackBarDialogue(
                                              context: context,
                                              message:
                                                  "Please Try After Sometime");
                                        });
                                        // refBank
                                        //     .read(bankControllerProvider)
                                        //     .requestBank()
                                        //     .onError(
                                        //   (error, stackTrace) {
                                        //     print(
                                        //         "#########Error Requesting BankDetails###########");
                                        //     print(error.toString());
                                        //   },
                                        // );
                                      },
                                      buttonTextStyle:
                                          CustomPoppinsTextStyles.buttonText,
                                      text: "Request Bank Details",
                                      height: 50.v,
                                      width: 30.h,
                                      // text: "Register",
                                      buttonStyle: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.all<Color>(
                                          appTheme.mainGreen,
                                        ),
                                        // Set background color to red
                                        shape: WidgetStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10), // Set border radius to 24
                                          ),
                                        ),
                                        // You can add more styling properties here, such as padding, elevation, etc.
                                      )),
                                );
                              }
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
                                        "Something Went Wrong",
                                        style: CustomPoppinsTextStyles
                                            .bodyText1White,
                                      ),
                                      space(),
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                          error: (error, stackTrace) {
                            print("###__#####");
                            if (kDebugMode) {
                              print("888***888");
                              print(error);
                              print(stackTrace);
                            }
                            return const Center(
                              child: Text("Something Went Wrong"),
                            );
                          },
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
