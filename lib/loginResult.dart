import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import kakao sdk
import 'package:kakao_flutter_sdk/user.dart';

class LoginResult extends StatefulWidget {
  @override
  _LoginResultState createState() => _LoginResultState();
}

class _LoginResultState extends State<LoginResult> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initTexts();
  }

  _initTexts() async {
    final User user = await UserApi.instance.me();

    print(
        "=========================[kakao account]=================================");
    print(user.kakaoAccount.toString());
    print(
        "=========================[kakao account]=================================");

    setState(() {
      _accountEmail = user.kakaoAccount.email;
      _nickName = user.kakaoAccount.profile.nickname;
    });
  }

  String _accountEmail = 'None';
  String _nickName = 'None';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Result"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(_accountEmail),
              Text(_nickName),
            ],
          ),
        ),
      ),
    );
  }
}
