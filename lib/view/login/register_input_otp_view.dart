import 'package:ann_shop_flutter/core/core.dart';
import 'package:ann_shop_flutter/model/account/account_register_state.dart';
import 'package:ann_shop_flutter/repository/account_repository.dart';
import 'package:ann_shop_flutter/repository/app_response.dart';
import 'package:ann_shop_flutter/ui/button/primary_button.dart';
import 'package:ann_shop_flutter/ui/button/text_button.dart';
import 'package:ann_shop_flutter/ui/utility/app_snackbar.dart';
import 'package:ann_shop_flutter/ui/utility/progress_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class RegisterInputOtpView extends StatefulWidget {
  @override
  _RegisterInputOtpViewState createState() => _RegisterInputOtpViewState();
}

class _RegisterInputOtpViewState extends State<RegisterInputOtpView> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset < -50) {
        if (MediaQuery.of(context).viewInsets.bottom > 100 || true) {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      }
    });
    registerStream();
  }

  Stream<int> stream;
  int countDown;

  registerStream() {
    countDown = 60 - AccountRegisterState.instance.getDifferenceOTP();
    stream = Stream<int>.periodic(Duration(seconds: 1), transform);
    stream = stream.takeWhile((value) {
      return countDown > 0;
    });
    listenStream();
  }

  listenStream() async {
    await for (int i in stream) {
      setState(() {
        countDown = i;
      });
    }
  }

  int transform(int value) {
    int second = AccountRegisterState.instance.getDifferenceOTP();
    return 60 - second;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    print(AccountRegisterState.instance.otp);
    return Scaffold(
      appBar: AppBar(
        title: Text('Nhập OTP'),
      ),
      body: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: countDown <= 0
                    ? TextButton(
                        'Gửi lại OTP',
                        onPressed: () {
                          onResentOTP();
                        },
                      )
                    : Text(
                        'OTP (00:$countDown)',
                        style: Theme.of(context).textTheme.body2,
                      ),
              ),
              TextFormField(
                maxLength: 6,
                decoration: InputDecoration(
                  hintText: 'Nhập OTP',
                  contentPadding: EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: Colors.red, width: 1, style: BorderStyle.solid),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != AccountRegisterState.instance.otp) {
                    return 'OTP không trùng khớp';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(height: 30),
              PrimaryButton(
                'Gửi OTP',
                onPressed: _validateInput,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextButton(String text, {GestureTapCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            decoration: TextDecoration.underline),
      ),
    );
  }

  void _validateInput() {
    final form = _formKey.currentState;
    if (form.validate()) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/register_input_password', ModalRoute.withName('/login'));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Future onResentOTP() async {
    bool _checkInternet = await checkInternet();
    if (_checkInternet == false) {
      AppSnackBar.showFlushbar(context, 'Kiểm tra kết nối mạng và thử lại.');
    } else {
      try {
        showLoading();
        AppResponse response = await AccountRepository.instance.requestOTP(
            AccountRegisterState.instance.phone,
            AccountRegisterState.instance.otp);
        hideLoading();
        if (response.status) {
          AccountRegisterState.instance.timeOTP = DateTime.now();
          registerStream();
        } else {
          AppSnackBar.showFlushbar(context,
              response.message ?? 'Có lỗi xãi ra, vui lòng thử lại sau.');
        }
      } catch (e) {
        print(e);
        AppSnackBar.showFlushbar(
            context, 'Có lỗi xãi ra, vui lòng thử lại sau.');
      }
    }
  }

  checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return (connectivityResult != ConnectivityResult.none);
  }

  ProgressDialog _progressDialog;

  showLoading() {
    if (_progressDialog == null) {
      _progressDialog = ProgressDialog(context, message: 'Gửi OTP...')..show();
    }
  }

  hideLoading() {
    if (_progressDialog != null) {
      _progressDialog.hide(contextHide: context);
      _progressDialog = null;
    }
  }
}