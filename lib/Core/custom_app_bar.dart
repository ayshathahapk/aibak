// custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:aibak/Core/Utils/size_utils.dart';

import 'CommenWidgets/custom_image_view.dart';
import 'Utils/image_constant.dart';
import 'app_export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      // leadingWidth: 100.adaptSize,
      centerTitle: true,
      title: CustomImageView(
        width: 150.adaptSize,
        imagePath: ImageConstants.logo,
      ),
      // title: Text("Home New bookings"),
    );
  }
}
