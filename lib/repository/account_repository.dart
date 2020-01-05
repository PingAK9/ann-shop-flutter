import 'dart:convert';
import 'dart:io';

import 'package:ann_shop_flutter/model/account/account.dart';
import 'package:ann_shop_flutter/model/account/account_controller.dart';
import 'package:ann_shop_flutter/repository/app_response.dart';
import 'package:http/http.dart' as http;

class AccountRepository {
  static final AccountRepository instance = AccountRepository._internal();

  factory AccountRepository() => instance;

  AccountRepository._internal() {
    // todo
  }

  Future<AppResponse> requestOTP(String phone, String otp) async {
    try {
      Map data = {"phone": phone, "otp": otp};
      final url = 'http://xuongann.com/api/sms/otp';
      final response = await http.post(url, body: data);
      log(url);
      log(data);
      log(response.statusCode);
      log(response.body);
      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.noContent) {
        return AppResponse(true);
      } else {
        return AppResponse(false, message: getMessage(response.body));
      }
    } catch (e) {
      print('Server Exception!!!' + e);
    }
    return AppResponse(false);
  }

  Future<AppResponse> register(String phone, String password) async {
    try {
      Map data = {"phone": phone, "password": password};
      String url = 'http://xuongann.com/api/flutter/user/register';
      final response = await http
          .post(
            url,
            body: data,
          )
          .timeout(Duration(seconds: 10));

      log(url);
      log(data);
      log(response.statusCode);
      log(response.body);
      if (response.statusCode == HttpStatus.ok) {
        var parsed = jsonDecode(response.body);
        return AppResponse(true, data: parsed);
      } else {
        return AppResponse(false, message: getMessage(response.body));
      }
    } catch (e) {}
    return AppResponse(false);
  }

  Future<AppResponse> login(String phone, String password) async {
    try {
      Map data = {"phone": phone, "password": password};
      String url = 'http://xuongann.com/api/flutter/user/login';
      final response = await http
          .post(
            url,
            body: data,
          )
          .timeout(Duration(seconds: 10));
      log(url);
      log(data.toString());
      log(response.body);
      if (response.statusCode == HttpStatus.ok) {
        var parsed = jsonDecode(response.body);
        return AppResponse(true, data: parsed);
      } else {
        return AppResponse(false, message: getMessage(response.body));
      }
    } catch (e) {}
    return AppResponse(false);
  }

  Future<AppResponse> updateInformation(Account account) async {
    try {
      final url = 'http://xuongann.com/api/flutter/user/update-info';
      final response = await http.patch(
        url,
        body: jsonEncode(account.toJson()),
        headers: AccountController.instance.header,
      );
      log(url);
      log(account.toJson());
      log(response.statusCode);
      log(response.body);
      if (response.statusCode == HttpStatus.ok) {
        var parsed = jsonDecode(response.body);
        return AppResponse(true, data: parsed);
      } else {
        return AppResponse(false, message: getMessage(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
    return AppResponse(false);
  }

  Future<AppResponse> forgotPassword(String phone) async {
    try {
      Map data = {
        "phone": phone,
      };
      String url = 'http://xuongann.com/api/flutter/user/password-new';
      final response =
          await http.patch(url, body: data).timeout(Duration(seconds: 10));

      log(url);
      log(data);
      log(response.statusCode);
      log(response.body);
      if (response.statusCode == HttpStatus.ok) {
        var parsed = jsonDecode(response.body);
        return AppResponse(true, data: parsed['password']);
      } else {
        return AppResponse(false, message: getMessage(response.body));
      }
    } catch (e) {}
    return AppResponse(false);
  }

  Future<AppResponse> changePassword(String newPassword) async {
    try {
      Map data = {
        "phone": AccountController.instance.account.phone,
        "password": newPassword
      };
      String url = 'http://xuongann.com/api/flutter/user/change-password';
      final response = await http
          .patch(
            url,
            body: data,
            headers: AccountController.instance.header,
          )
          .timeout(Duration(seconds: 10));

      log(url);
      log(data);
      log(response.statusCode);
      log(response.body);
      if (response.statusCode == HttpStatus.ok) {
        return AppResponse(true);
      } else {
        return AppResponse(false, message: getMessage(response.body));
      }
    } catch (e) {}
    return AppResponse(false);
  }

  String getMessage(body) {
    try {
      Map parsed = jsonDecode(body);
      if (parsed.containsKey('Message')) {
        return parsed['Message'];
      }
      if (parsed.containsKey('ModelState')) {}
    } catch (e) {
      log(e);
    }
    return null;
  }

  log(object) {
    print('account_repository: ' + object.toString());
  }

  final cityOfVietnam = [
    "An Giang",
    "Bà Rịa – Vũng Tàu",
    "Bắc Giang",
    "Bắc Kạn,",
    "Bạc Liêu",
    "Bắc Ninh",
    "Bến Tre",
    "Bình Định",
    "Bình Dương",
    "Bình Phước",
    "Bình Thuận",
    "Cà Mau",
    "Cần Thơ",
    "Cao Bằng",
    "Đà Nẵng",
    "Đắk Lắk",
    "Đắk Nông",
    "Điện Biên",
    "Đồng Nai",
    "Đồng Tháp",
    "Gia Lai",
    "Hà Giang",
    "Hà Nam",
    "Hà Nội",
    "Hà Tĩnh",
    "Hải Dương",
    "Hải Phòng",
    "Hậu Giang",
    "Hòa Bình",
    "Hưng Yên",
    "Khánh Hòa",
    "Kiên Giang",
    "Kon Tum",
    "Lai Châu",
    "Lâm Đồng",
    "Lạng Sơn",
    "Lào Cai",
    "Long An",
    "Nam Định",
    "Nghệ An",
    "Ninh Bình",
    "Ninh Thuận",
    "Phú Thọ",
    "Phú Yên",
    "Quảng Bình",
    "Quảng Nam",
    "Quảng Ngãi",
    "Quảng Ninh",
    "Quảng Trị",
    "Sóc Trăng",
    "Sơn La",
    "Tây Ninh",
    "Thái Bình",
    "Thái Nguyên",
    "Thanh Hóa",
    "Thừa Thiên Huế",
    "Tiền Giang",
    "TP Hồ Chí Minh",
    "Trà Vinh",
    "Tuyên Quang",
    "Vĩnh Long",
    "Vĩnh Phúc",
    "Yên Bái",
  ];
}
