import 'dart:io';

import 'package:ann_shop_flutter/theme/app_styles.dart';
import 'package:ann_shop_flutter/ui/favorite/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    bool isLogin = false;
    return Scaffold(
      backgroundColor: AppStyles.dividerColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cá nhân'),
        actions: <Widget>[
          FavoriteButton(color: Colors.white),
        ],
      ),
      body: Container(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: _buildAccount(),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 12),
                _buildItemCommon(
                  'Quản lý đơn hàng',
                  icon: Icon(Icons.description),
                ),
                _buildItemCommon('Sản phẩm đã xem',
                    icon: Icon(Icons.remove_red_eye), onTap: () {
                  Navigator.pushNamed(context, '/seen');
                }),
                _buildItemCommon('Sản phẩm yêu thích',
                    icon: Icon(Icons.favorite), onTap: () {
                  Navigator.pushNamed(context, '/favorite');
                }),
                _buildItemCommon(
                  'Thông báo',
                  icon: Icon(Icons.notifications),
                ),
                _buildItemCommon('Liên hệ', icon: Icon(Icons.headset_mic)),
                _buildItemCommon('Cài đặt', icon: Icon(Icons.settings),
                    onTap: () {
                  Navigator.pushNamed(context, '/setting');
                }),
              ]),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 12),
                _buildItemCommon('Giới thiệu'),
                _buildItemCommon('Hướng dẫn mua sỉ'),
                _buildItemCommon('Chính sách vận chuyển'),
                _buildItemCommon('Chính sách thanh toán'),
                _buildItemCommon('Chính sách đổi trả'),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCommon(String title, {Icon icon, GestureTapCallback onTap}) {
    return Container(
      margin: EdgeInsets.only(bottom: 1),
      color: Colors.white,
      child: ListTile(
        onTap: onTap,
        leading: icon,
        title: Text(title),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: AppStyles.dividerColor),
      ),
    );
  }

  Widget _buildAccount() {
    return Container(
      height: 80,
      color: Colors.white,
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.account_circle,
            size: 50,
            color: Theme.of(context).primaryColor,
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Chào mừng bạn đến với Xưỡng ANN',
                    style: Theme.of(context).textTheme.caption,
                    maxLines: 1,
                  ),
                  Text(
                    'Đăng nhập/Đăng ký',
                    style: Theme.of(context).textTheme.body2.merge(
                        TextStyle(color: Theme.of(context).primaryColor)),
                  )
                ],
              ),
            ),
          ),
          Icon(
            Icons.navigate_next,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  _onLogIn() {}

  _onLogOut() {}

  _onLaunchURL() {
    if (Platform.isIOS) {
      launch("tel:/1800555555");
    } else {
      launch("tel:1800555555");
    }
  }
}
