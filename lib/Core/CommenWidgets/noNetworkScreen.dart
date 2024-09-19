import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:aibak/Core/Utils/size_utils.dart';

import '../Theme/new_custom_text_style.dart';
import '../Utils/image_constant.dart';

class NoNetworkScreen extends ConsumerWidget {
  const NoNetworkScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Oops...No NetWork!",
          style: CustomPoppinsTextStyles.bodyText,
        ),
        Center(
          child: Lottie.asset(ImageConstants.noNetwork, height: 200.adaptSize),
        ),
      ],
    );
  }
}
