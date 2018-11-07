import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:sharesdk_flutter/sharesdk.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {


  void shareToWechat(BuildContext context) {

    SSDKMap params = SSDKMap()..setGeneral("text", 
    ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541565611543&di=4615c8072e155090a2b833059f19ed5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F06%2F20150106003502_Ajcte.jpeg"], 
    null, "title", SSDKContentTypes.auto);

    ShareSDK.share(ShareSDKPlatforms.wechatSession, params, (SSDKResponseState state, Map userdata, Map contentEntity, SSDKError error){
      showAlert(state, error.rawData, context);
    });
  }

  void authToWechat(BuildContext context) {
    ShareSDK.auth(ShareSDKPlatforms.wechatSession, null, (SSDKResponseState state, Map user, SSDKError error){
      showAlert(state, user != null ? user:error.rawData, context);
    });
  }

  void shareToSina(BuildContext context) {
    SSDKMap params = SSDKMap()..setGeneral("text", 
    ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541565611543&di=4615c8072e155090a2b833059f19ed5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F06%2F20150106003502_Ajcte.jpeg"], 
    null, "title", SSDKContentTypes.auto);

    ShareSDK.share(ShareSDKPlatforms.sina, params, (SSDKResponseState state, Map userdata, Map contentEntity, SSDKError error){

      showAlert(state, error.rawData, context);
    });
  }

  void authToSina(BuildContext context) {
    ShareSDK.auth(ShareSDKPlatforms.sina, null, (SSDKResponseState state, Map user, SSDKError error){
      showAlert(state, user != null ? user:error.rawData, context);
    });
  }

  void showShareMenu(BuildContext context) {
    SSDKMap params = SSDKMap()..setGeneral("text", 
    ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541565611543&di=4615c8072e155090a2b833059f19ed5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F06%2F20150106003502_Ajcte.jpeg"], 
    null, "title", SSDKContentTypes.auto);
    ShareSDK.showMenu(null, params, (SSDKResponseState state, ShareSDKPlatform platform, Map userData, Map contentEntity, SSDKError error){

      showAlert(state, error.rawData, context);
    });
  }

  void showEditor(BuildContext context) {
    SSDKMap params = SSDKMap()..setGeneral("text", 
    ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541565611543&di=4615c8072e155090a2b833059f19ed5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F06%2F20150106003502_Ajcte.jpeg"], 
    null, "title", SSDKContentTypes.auto);

    ShareSDK.showEditor(ShareSDKPlatforms.sina, params, (SSDKResponseState state, ShareSDKPlatform platform, Map userData, Map contentEntity, SSDKError error){

      showAlert(state, error.rawData, context);
    });
  }

  void openMiniProgram(BuildContext context){
    ShareSDK.openWeChatMiniProgram("gh_afb25ac019c9", "pages/index/index", 0).then((dynamic open){

      if (open)
      {
        showAlert(SSDKResponseState.Success, null, context);
      }
      else
      {
        showAlert(SSDKResponseState.Fail, null, context);
      }
    });
  }

  void showAlert(SSDKResponseState state, Map content, BuildContext context) {
    print("--------------------------> state:"+state.toString());
    String title = "失败";
    switch (state) {
      case SSDKResponseState.Success:
        title = "成功";
      break;
      case SSDKResponseState.Fail:
       title = "失败";
      break;
      case SSDKResponseState.Cancel:
        title = "取消";
      break;
      default:
        title = state.toString();
      break;
    }

      showDialog(
              context: context,
              builder: (BuildContext context) => CupertinoAlertDialog (
                      title: new Text(title),
                      content: new Text(content !=null?content.toString():""),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("OK"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ]
                    ));
  }

  Widget _creatRow(String methodName, String methodDes, Function method, BuildContext context) {
    return new GestureDetector(
      onTap: (){
        method(context);
      },
      child: new Container(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.withAlpha(10),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // padding: const EdgeInsets.only(bottom: 2.0),
          children: [
            new Container(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: new Text(
                methodName,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            new Text(
              methodDes,
              style: new TextStyle(
                color: Colors.grey[500],
              ),
            ),
            new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Container(
                padding: const EdgeInsets.only(top: 0.33),
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
    void initState() {
      // TODO: implement initState
      ShareSDKRegister register = ShareSDKRegister();
      register.setupSinaWeibo("568898243", "38a4f8204cc784f81f9f0daaf31e02e3", "http://www.sharesdk.cn");
      register.setupWechat("wx617c77c82218ea2c", "c7253e5289986cf4c4c74d1ccc185fb1");
      register.setupQQ("100371282", "aed9b0303e3ed1e27bae87c33761161d");
      register.setupFacebook("1412473428822331", "a42f4f3f867dc947b9ed6020c2e93558", "shareSDK");
      register.setupTwitter("viOnkeLpHBKs6KXV7MPpeGyzE", "NJEglQUy2rqZ9Io9FcAU9p17omFqbORknUpRrCDOK46aAbIiey", "http://mob.com");
      ShareSDK.regist(register);
      super.initState();
    }

@override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new ListView(
        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        children: <Widget>[
          _creatRow("分享到微信", "分享图片到微信", shareToWechat,context),
          _creatRow("微信授权", "微信授权", authToWechat,context),
          _creatRow("新浪分享", "分享多图到新浪微博", shareToSina,context),
          _creatRow("新浪授权", "新浪授权", authToSina,context),
          _creatRow("弹出分享菜单", "弹出分享菜单", showShareMenu,context),
          _creatRow("弹出编辑界面", "分享直接进行内容编辑", showEditor,context),
          _creatRow("打开微信小程序", "需要导入WechatConnector", openMiniProgram,context),
        ],
      ),
      );
  }
}