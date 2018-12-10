# sharesdk_example

**原生SDK支持的最低版本:**

- [Android](https://github.com/MobClub/ShareSDK-for-Android) - V3.4.0
- [iOS](https://github.com/MobClub/ShareSDK-for-iOS) - V4.2.1

**文档语言 :** **中文** | **[English](README.md)**

- 导入 library

    ```
    import 'package:sharesdk/sharesdk.dart';
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