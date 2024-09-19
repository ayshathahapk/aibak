import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:quickalert/models/quickalert_type.dart';
// import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:aibak/Core/app_export.dart';

void showSnackBarDialogue({
  bool showLoading = false,
  bool isError = false,
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: isError ? appTheme.red700 : appTheme.mainBlue,
        duration: showLoading
            ? const Duration(seconds: 5)
            : const Duration(seconds: 4),
        content: Row(
          children: [
            if (showLoading)
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: CircularProgressIndicator(),
              ),
            Expanded(
              flex: 3,
              child: Text(
                overflow: TextOverflow.visible,
                message,
                style: GoogleFonts.poppins(
                    // fontFamily: marine,
                    color: appTheme.whiteA700,
                    fontWeight: FontWeight.w500,
                    fontSize: 20.fSize),
              ),
            ),
          ],
        ),
      ),
    );
}

// Future<bool> alert(
//   BuildContext context,
//   String message,
// ) async {
//   bool result = await QuickAlert.show(
//     barrierDismissible: false,
//     context: context,
//     disableBackBtn: false,
//     type: QuickAlertType.warning,
//     showConfirmBtn: true,
//     title: 'Are you sure ?',
//     text: message,
//     confirmBtnText: "Yes",
//     cancelBtnText: "No",
//     cancelBtnTextStyle: CustomPoppinsTextStyles.titleSmallRed700SemiBold_1,
//     confirmBtnTextStyle: CustomPoppinsTextStyles.titleSmallWhiteA700SemiBold_1,
//     confirmBtnColor: appTheme.mainGreen,
//     showCancelBtn: true,
//     onCancelBtnTap: () {
//       Navigator.of(context, rootNavigator: true).pop(false);
//     },
//     onConfirmBtnTap: () {
//       Navigator.of(context, rootNavigator: true).pop(true);
//     },
//   );
//
//   ///
//   // showDialog(
//   //     context: context,
//   //     builder: (context) => AlertDialog(
//   //           shape: RoundedRectangleBorder(
//   //               borderRadius: BorderRadius.circular(24.0)),
//   //           title: const Text('Are you sure ?'),
//   //           content: Text(message),
//   //           actions: <Widget>[
//   //             CustomElevatedButton(
//   //                 onPressed: () {
//   //                   Navigator.of(context, rootNavigator: true).pop(true);
//   //                 },
//   //                 buttonStyle: ButtonStyle(
//   //                   backgroundColor: MaterialStateProperty.all<Color>(
//   //                       appTheme.mainGreen), // Set background color to red
//   //                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//   //                     RoundedRectangleBorder(
//   //                       borderRadius: BorderRadius.circular(
//   //                           10.0.h), // Set border radius to 24
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 buttonTextStyle: CustomTextStyles.titleSmallWhiteA700SemiBold,
//   //                 width: SizeUtils.width * 0.15,
//   //                 height: SizeUtils.height * 0.035,
//   //                 text: "Yes"),
//   //             // SizedBox(
//   //             //   width: 10.h,
//   //             // ),
//   //             CustomElevatedButton(
//   //                 onPressed: () {
//   //                   Navigator.of(context, rootNavigator: true).pop(false);
//   //                 },
//   //                 buttonStyle: ButtonStyle(
//   //                   backgroundColor: MaterialStateProperty.all<Color>(
//   //                       appTheme.red700), // Set background color to red
//   //                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//   //                     RoundedRectangleBorder(
//   //                       borderRadius: BorderRadius.circular(
//   //                           10.0.h), // Set border radius to 24
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 buttonTextStyle: CustomTextStyles.titleSmallWhiteA700SemiBold,
//   //                 width: SizeUtils.width * 0.15,
//   //                 height: SizeUtils.height * 0.035,
//   //                 text: "No"),
//   //           ],
//   //         ));
//
//   return result;
// }
//
// void showToast(BuildContext context, String message) {
//   Fluttertoast.showToast(
//     msg: message,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     backgroundColor: appTheme.mainBlue,
//     textColor: appTheme.mainWhite,
//   );
// }
//
// Future<bool> showExitConfirmationDialog(BuildContext context) async {
//   return (await QuickAlert.show(
//         barrierDismissible: false,
//         context: context,
//         disableBackBtn: false,
//         type: QuickAlertType.error,
//         showConfirmBtn: true,
//         title: 'Are you sure ?',
//         text: "Your Progress will Lost",
//         confirmBtnText: "Yes",
//         cancelBtnText: "No",
//         cancelBtnTextStyle: CustomPoppinsTextStyles.titleSmallRed700SemiBold_1,
//         confirmBtnTextStyle:
//             CustomPoppinsTextStyles.titleSmallWhiteA700SemiBold_1,
//         confirmBtnColor: appTheme.mainGreen,
//         showCancelBtn: true,
//         onCancelBtnTap: () {
//           Navigator.of(context, rootNavigator: true).pop(false);
//         },
//         onConfirmBtnTap: () {
//           Navigator.of(context, rootNavigator: true).pop(true);
//         },
//       )) ??
//       false;
// }
