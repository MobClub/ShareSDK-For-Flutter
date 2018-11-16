# sharesdk_example

- import library

    ```
    import 'package:sharesdk/sharesdk.dart';
    ```

- share to facebook

    ```java
    SSDKMap params = SSDKMap()..setGeneral("text", 
    ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541565611543&di=4615c8072e155090a2b833059f19ed5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F06%2F20150106003502_Ajcte.jpeg"], 
    null, "title", SSDKContentTypes.auto);

    ShareSDK.share(ShareSDKPlatforms.facebook, params, (SSDKResponseState state, Map userdata, Map contentEntity, SSDKError error){
      showAlert(state, error.rawData, context);
    });
    ```
- auth
    
    ```java
    ShareSDK.auth(ShareSDKPlatforms.facebook, null, (SSDKResponseState state, Map user, SSDKError error){
      showAlert(state, user != null ? user:error.rawData, context);
    });
    ```
- show platforms menu

    ```java
    SSDKMap params = SSDKMap()..setGeneral("text", 
    ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1541565611543&di=4615c8072e155090a2b833059f19ed5b&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F06%2F20150106003502_Ajcte.jpeg"], 
    null, "title", SSDKContentTypes.auto);
    ShareSDK.showMenu(null, params, (SSDKResponseState state, ShareSDKPlatform platform, Map userData, Map contentEntity, SSDKError error){

      showAlert(state, error.rawData, context);
    });   
    ```

Please refer to **sharesdk_interface.dart** for other interfaces


## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).