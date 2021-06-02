import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';

import 'loginResult.dart';

void main() {
  //앱키
  KakaoContext.clientId = '382c7a5d0fb2bf4a7ba53352fe15a602';
  KakaoContext.javascriptClientId = 'c01f9afe25a46d2003c10524aa0be7d5';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isKakaoTalkInstalled = false;
  void initState() {
    _initKakaoTalkInstalled();
    super.initState();
  }

  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    print('kakao install : ' + installed.toString());

    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  _loginWithKakao() async {
    try {
      print('loginWithKakao');
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  _loginWithTalk() async {
    try {
      print('loginWithTalk');
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
    } catch (e) {
      print(e);
    }
  }

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      print("token : " + token.toString());
      AccessTokenStore.instance.toStore(token);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginResult()),
      );
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: InkWell(
        onTap: () =>
            _isKakaoTalkInstalled ? _loginWithTalk() : _loginWithKakao(),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.yellow,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.chat_bubble,
                color: Colors.black54,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                '카카오계정 로그인',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
