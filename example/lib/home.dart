import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharesdk/sharesdk.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

 void shareSdkVersion(BuildContext context)
  {
    ShareSDK.sdkVersion
        .then((dynamic version) {
      if (version.length > 0) {
        if (Platform.isIOS) {
          showAlertText("ShareSDK iOS 版本", version.toString(), context);
        }
        else if (Platform.isAndroid) {
          showAlertText("ShareSDK Android 版本", version.toString(), context);
        }
        
      }
      else {
        showAlertText("ShareSDK版本", "获取失败", context);
      }
    });
  }

  void shareToWechat(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541565611543&di=4615c8072e155090a2b833059f19ed5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F06%2F20150106003502_Ajcte.jpeg"
          ],
          "http://pic28.photophoto.cn/20130818/0020033143720852_b.jpg",
          null,
          "http://pic28.photophoto.cn/20130818/0020033143720852_b.jpg",
          "http://pic28.photophoto.cn/20130818/0020033143720852_b.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          SSDKContentTypes.image);

    ShareSDK.share(
        ShareSDKPlatforms.wechatSession, params, (SSDKResponseState state,
        Map userdata, Map contentEntity, SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void authToWechat(BuildContext context) {
    ShareSDK.auth(
        ShareSDKPlatforms.wechatSession, null, (SSDKResponseState state,
        Map user, SSDKError error) {
      showAlert(state, user != null ? user : error.rawData, context);
    });
  }

  void getUserInfoToWechat(BuildContext context) {
    ShareSDK.getUserInfo(
        ShareSDKPlatforms.wechatSession, (SSDKResponseState state,
        Map user, SSDKError error) {
      showAlert(state, user != null ? user : error.rawData, context);
    });
  }

  void cancelAuth(BuildContext context) {
   ShareSDK.cancelAuth(ShareSDKPlatforms.wechatSession,
      (SSDKResponseState state, Map user, SSDKError error) {
        showAlert(state, error.rawData, context);
      });
  }

  void hasAuthed(BuildContext context) {
    ShareSDK.hasAuthed(ShareSDKPlatforms.wechatSession,
    (SSDKResponseState state, Map user, SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void shareToSina(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541565611543&di=4615c8072e155090a2b833059f19ed5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F06%2F20150106003502_Ajcte.jpeg"
          ],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          null,
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          SSDKContentTypes.auto);

    ShareSDK.share(
        ShareSDKPlatforms.sina, params, (SSDKResponseState state, Map userdata,
        Map contentEntity, SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void authToSina(BuildContext context) {
    ShareSDK.getUserInfo(ShareSDKPlatforms.qq, (SSDKResponseState state, Map userdata, SSDKError error) {
      print("--------------------------> authToSina:");
      showAlert(state, userdata, context);
    });
  }

  void showShareMenu(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541565611543&di=4615c8072e155090a2b833059f19ed5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F06%2F20150106003502_Ajcte.jpeg"
          ],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          null,
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          SSDKContentTypes.webpage);
    ShareSDK.showMenu(
        null, params, (SSDKResponseState state, ShareSDKPlatform platform,
        Map userData, Map contentEntity, SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void showEditor(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setGeneral(
          "title",
          "text",
          [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541565611543&di=4615c8072e155090a2b833059f19ed5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F06%2F20150106003502_Ajcte.jpeg"
          ],
          "http://wx3.sinaimg.cn/large/006nLajtly1fpi9ikmj1kj30dw0dwwfq.jpg",
          null,
          "http://www.mob.com/",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fw9612f17sj30dw0dwgnd.jpg",
          "http://i.y.qq.com/v8/playsong.html?hostuin=0&songid=&songmid=002x5Jje3eUkXT&_wv=1&source=qq&appshare=iphone&media_mid=002x5Jje3eUkXT",
          "http://f1.webshare.mob.com/dvideo/demovideos.mp4",
          SSDKContentTypes.auto);

    ShareSDK.showEditor(
        ShareSDKPlatforms.sina, params, (SSDKResponseState state,
        ShareSDKPlatform platform, Map userData, Map contentEntity,
        SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void openMiniProgram(BuildContext context) {
    ShareSDK.openWeChatMiniProgram("gh_52568203455c", "pages/index/index", 0)
        .then((dynamic open) {
      if (open) {
        showAlert(SSDKResponseState.Success, null, context);
      }
      else {
        showAlert(SSDKResponseState.Fail, null, context);
      }
    });
  }

  void shareMiniProgram(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setWeChatMiniProgram(
          "MiniProgram",
          "test MiniProgram",
          "http://www.mob.com",
          "pages/index/index",
          null,
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522154322305&di=7f4bf3d0803fe8c2c66c140f0a6ea0b4&imgtype=0&src=http%3A%2F%2Fa4.topitme.com%2Fo%2F201007%2F29%2F12803876734174.jpg",
          "http://pic28.photophoto.cn/20130818/0020033143720852_b.jpg",
          "gh_afb25ac019c9",
          true,
          0,
          ShareSDKPlatforms.wechatSession);
    ShareSDK.share(ShareSDKPlatforms.wechatSession, params,
            (SSDKResponseState state, Map userdata, Map contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareSinaCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setSina(
          "text",
          "title",
          [
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541659481198&di=80760a9d745a78dab3ed3d5577286682&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fbaike%2Fpic%2Fitem%2Fd1a20cf431adcbef011db9bba6af2edda3cc9f66.jpg",
            "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541659494384&di=ad32f8ac8c75f51612a90d6b7c1d8db8&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201609%2F14%2F20160914232743_hwnCt.thumb.700_0.jpeg"
          ],
          null,
          "http://www.mob.com/",
          0.0,
          0.0,
          null,
          false,
          "http://wx4.sinaimg.cn/large/006WfoFPly1fq0jo9svnaj30dw0dwdhv.jpg",
          null,
          SSDKContentTypes.auto);
    ShareSDK.share(ShareSDKPlatforms.sina, params,
            (SSDKResponseState state, Map userdata, Map contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareSinaLinkCard(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setSinaLinkCard(
          "linkcard_text",
          "linkcard_title",
          "http://www.mob.com/",
          "全新品牌，优质服务",
          "http://wx4.sinaimg.cn/large/006WfoFPly1fq0jo9svnaj30dw0dwdhv.jpg",
          "120",
          "120");
    ShareSDK.share(ShareSDKPlatforms.sina, params,
            (SSDKResponseState state, Map userdata, Map contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareTwitterCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setTwitter("text",
          "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541659481198&di=80760a9d745a78dab3ed3d5577286682&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fbaike%2Fpic%2Fitem%2Fd1a20cf431adcbef011db9bba6af2edda3cc9f66.jpg",
          null, 0.0, 0.0, SSDKContentTypes.auto);
    ShareSDK.share(ShareSDKPlatforms.twitter,
        params, (SSDKResponseState state, Map userdata, Map contentEntity,
            SSDKError error) {
          showAlert(state, error.rawData, context);
        });
  }

  void shareFacebookCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setFacebook(
          "Share SDK Link Desc",
          "http://ww4.sinaimg.cn/bmiddle/005Q8xv4gw1evlkov50xuj30go0a6mz3.jpg",
          "http://www.mob.com",
          "Share SDK",
          null,
          null,
          "#MobData",
          "Mob官网 - 全球领先的移动开发者服务平台",
          SSDKContentTypes.webpage);
    ShareSDK.share(ShareSDKPlatforms.facebook, params, (SSDKResponseState state,
        Map userdata, Map contentEntity, SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void shareQQCustom(BuildContext context) {
    SSDKMap params = SSDKMap()
      ..setQQ(
          "text",
          "title",
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          "http://wx4.sinaimg.cn/large/006tkBCzly1fy8hfqdoy6j30dw0dw759.jpg",
          null,
          "http://www.mob.com/api/documentList",
          null,
          null,
          SSDKContentTypes.webpage,
          ShareSDKPlatforms.qq);
    ShareSDK.share(
        ShareSDKPlatforms.qq, params, (SSDKResponseState state, Map userdata,
        Map contentEntity, SSDKError error) {
      showAlert(state, error.rawData, context);
    });
  }

  void isClientInstalledQQ(BuildContext context) {
    ShareSDK.isClientInstalled(ShareSDKPlatforms.qq).then((dynamic hasClient) {
      showAlertText("是否安装了QQ客户端", hasClient.toString(), context);
    });
  }

  void showAlert(SSDKResponseState state, Map content, BuildContext context) {
    print("--------------------------> state:" + state.toString());
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
        builder: (BuildContext context) =>
            CupertinoAlertDialog(
                title: new Text(title),
                content: new Text(content != null ? content.toString() : ""),
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

void showAlertText(String title, String content, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            CupertinoAlertDialog(
                title: new Text(title),
                content: new Text(content != null ? content : ""),
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

  Widget _creatRow(String methodName, String methodDes, Function method,
      BuildContext context) {
    return new GestureDetector(
      onTap: () {
        method(context);
      },
      child: new Container(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        width: MediaQuery
            .of(context)
            .size
            .width,
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

    register.setupWechat(
        "wx617c77c82218ea2c", "c7253e5289986cf4c4c74d1ccc185fb1");
    register.setupSinaWeibo("568898243", "38a4f8204cc784f81f9f0daaf31e02e3",
        "http://www.sharesdk.cn");
    register.setupQQ("100371282", "aed9b0303e3ed1e27bae87c33761161d");
    register.setupFacebook(
        "1412473428822331", "a42f4f3f867dc947b9ed6020c2e93558", "shareSDK");
    register.setupTwitter("viOnkeLpHBKs6KXV7MPpeGyzE",
        "NJEglQUy2rqZ9Io9FcAU9p17omFqbORknUpRrCDOK46aAbIiey", "http://mob.com");
    ShareSDK.regist(register);

    ShareSDK.listenNativeEvent();

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
          _creatRow("ShareSDK版本号", "ShareSDK版本号", shareSdkVersion, context),
          _creatRow("分享到微信", "分享图片到微信", shareToWechat, context),
          _creatRow("微信授权", "微信授权(不返回用户数据)", authToWechat, context),
          _creatRow("取消微信授权", "取消微信平台的授权", cancelAuth, context),
          _creatRow("判断微信是否授权", "判断微信平台是否授权", hasAuthed, context),
          _creatRow("微信用户信息", "获取微信用户信息", getUserInfoToWechat, context),
          _creatRow("新浪分享", "分享多图到新浪微博", shareToSina, context),
          _creatRow("新浪/QQ授权", "新浪/QQ授权(返回用户数据)", authToSina, context),
          _creatRow("弹出分享菜单", "弹出分享菜单", showShareMenu, context),
          _creatRow("弹出编辑界面", "分享直接进行内容编辑(IOS)", showEditor, context),
          _creatRow("打开微信小程序", "需要导入WechatConnector", openMiniProgram, context),

          _creatRow("分享小程序到微信", "测试自定义参数", shareMiniProgram, context),
          _creatRow("分享到新浪微博", "测试自定义参数", shareSinaCustom, context),
          _creatRow("分享到新浪微博LinkCard", "分享到LinkCard", shareSinaLinkCard, context),
          _creatRow("分享到QQ", "测试自定义参数", shareQQCustom, context),
          _creatRow("分享到Twitter", "测试自定义参数", shareTwitterCustom, context),
          _creatRow("分享到Facebook", "测试自定义参数", shareFacebookCustom, context),
          _creatRow("判断客户端安装", "是否安装了QQ客户端", isClientInstalledQQ, context)
        ],
      ),
    );
  }
}