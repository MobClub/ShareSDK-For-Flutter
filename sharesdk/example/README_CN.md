# sharesdk_example

**原生SDK支持的最低版本:**

- [Android](https://github.com/MobClub/ShareSDK-for-Android) - V3.4.0
- [iOS](https://github.com/MobClub/ShareSDK-for-iOS) - V4.2.1

**文档语言 :** **中文** | **[English](README.md)**

- 导入 library

    ```
    import 'package:sharesdk/sharesdk.dart';
    ```
    
- 注册平台（iOS）
    
    ```java
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
            
        //注册
        ShareSDK.regist(register);
        
        super.initState();
      }
    
    ```


- 分享接口示例

    ```java
    SSDKMap params = SSDKMap()..setGeneral("text", 
    ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541565611543&di=4615c8072e155090a2b833059f19ed5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F06%2F20150106003502_Ajcte.jpeg"], 
    null, "title", SSDKContentTypes.auto);

    ShareSDK.share(ShareSDKPlatforms.facebook, params, (SSDKResponseState state, Map userdata, Map contentEntity, SSDKError error){
      showAlert(state, error.rawData, context);
    });
    ```
- 授权接口示例
    
    ```java
    ShareSDK.auth(ShareSDKPlatforms.facebook, null, (SSDKResponseState state, Map user, SSDKError error){
      showAlert(state, user != null ? user:error.rawData, context);
    });
    ```
- 显示分享菜单

    ```java
    SSDKMap params = SSDKMap()..setGeneral("text", 
    ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541565611543&di=4615c8072e155090a2b833059f19ed5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F06%2F20150106003502_Ajcte.jpeg"], 
    null, "title", SSDKContentTypes.auto);
    ShareSDK.showMenu(null, params, (SSDKResponseState state, ShareSDKPlatform platform, Map userData, Map contentEntity, SSDKError error){

      showAlert(state, error.rawData, context);
    });   
    ```

- 其他接口请参考：**sharesdk_interface.dart**
