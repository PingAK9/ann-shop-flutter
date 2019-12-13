import 'package:ann_shop_flutter/provider/utility/config_provider.dart';
import 'package:ann_shop_flutter/core/core.dart';
import 'package:ann_shop_flutter/ui/utility/app_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class HomeBanner extends StatelessWidget {
  final height = 120.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: height / 2),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: AppImage(
                'https://khohangsiann.com/wp-content/uploads/si-bao-li-xi-2020.png',
                fit: BoxFit.cover,
                showLoading: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
