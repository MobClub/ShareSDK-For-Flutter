
# ShareSDK For Flutter
### 这是一个基于ShareSDK功能的扩展的Flutter插件。使用此插件能够帮助您在使用Flutter开发应用时,快速地实现社会化功能,例如第三方授权登录,获取用户信息以及社交平台的分享等功能。

**原生SDK支持的最低版本:**

- [Android](https://github.com/MobClub/ShareSDK-for-Android) - V3.4.0
- [iOS](https://github.com/MobClub/ShareSDK-for-iOS) - V4.3.2

**简介：** http://www.mob.com/product/sharesdk

**插件主页：** https://pub.dartlang.org/packages/sharesdk_plugin

**官网文档：** http://wiki.mob.com/快速集成/

**Demo例子：** https://github.com/MobClub/ShareSDK-For-Flutter/sharesdk_plugin

## 开始集成

参考[官方插件集成文档](https://pub.dartlang.org/packages/sharesdk#-installing-tab-)

自定义需要导入的分享平台:
### iOS 
 你需要重新编辑 *sharesdk.podspec* 文件设置 dependency，具体支持的平台可以参阅`pod search mob_sharesdk` 或者参考[官网文档](https://www.mob.com/wiki/detailed?wiki=4&id=14)

```
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
s.name             = 'sharesdk'
s.version          = '0.0.1'
s.summary          = 'flutter plugin for sharesdk.'
s.description      = 'ShareSDK is the most comprehensive Social SDK in the world,which share easily with 40+ platforms.'
s.homepage         = 'http://www.mob.com'
s.license          = { :file => '../LICENSE' }
s.author           = { 'Mob' => 'mobproducts@163.com' }
s.source           = { :path => '.' }
s.source_files = 'Classes/**/*'
s.public_header_files = 'Classes/**/*.h'
s.dependency 'Flutter'
s.dependency 'mob_sharesdk'
#  s.dependency 'mob_sharesdk/ShareSDKUI'
#  s.dependency 'mob_sharesdk/ShareSDKPlatforms/QQ'
#  s.dependency 'mob_sharesdk/ShareSDKPlatforms/SinaWeibo'
#  s.dependency 'mob_sharesdk/ShareSDKPlatforms/WeChat'
#  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Facebook'
#  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Twitter'

s.ios.deployment_target = '8.0'
end
```

然后你需要根据[官方文档](https://www.mob.com/wiki/detailed?wiki=484&id=14)在Xcode工程的info.plist里面配置Appkey 和 AppSecret, 以及各平台的白名单和urlScheme。

### Android
你需要重新编辑build.gradle, mobsdk.gradle文件来选择你需要使用的平台，具体支持的平台可以参阅[官网技术文档](https://www.mob.com/wiki/detailed?wiki=485&id=14)

#### build.gradle

```
buildscript {
    repositories {
                    google()
                    jcenter()
                    maven {
                    url "http://mvn.mob.com/android"
                    }
                 }

    dependencies {
                    classpath 'com.android.tools.build:gradle:3.1.2'
                    classpath 'com.mob.sdk:MobSDK:+'
                 }
}
```

#### mobsdk.gradle

```
MobSDK {
    appKey "moba6b6c6d6"
    appSecret "b89d2427a3bc7ad1aea1e1e8c1d36bf3"

        ShareSDK {

            // platform configuration information
            devInfo {
                        QQ {
                        id 7
                        sortId 7
                        appId "100371282"
                        appKey "aed9b0303e3ed1e27bae87c33761161d"
                        shareByAppClient true
                        bypassApproval false
                        enable true
                        }

                        SinaWeibo {
                        id 1
                        sortId 1
                        appKey "568898243"
                        appSecret "38a4f8204cc784f81f9f0daaf31e02e3"
                        callbackUri "http://www.sharesdk.cn"
                        shareByAppClient true
                        enable true
                        }

                        Wechat {
                        id 4
                        sortId 4
                        appId "wx4868b35061f87885"
                        appSecret "64020361b8ec4c99936c0e3999a9f249"
                        userName "gh_afb25ac019c9"
                        path "pages/index/index.html?id=1"
                        withShareTicket true
                        miniprogramType 0
                        bypassApproval false
                        enable true
                        }

                        Facebook {
                        id 8
                        sortId 8
                        appKey "1412473428822331"
                        appSecret "a42f4f3f867dc947b9ed6020c2e93558"
                        callbackUri "https://mob.com"
                        shareByAppClient true
                        enable true
                        }

                        Twitter {
                        id 9
                        sortId 9
                        appKey "viOnkeLpHBKs6KXV7MPpeGyzE"
                        appSecret "NJEglQUy2rqZ9Io9FcAU9p17omFqbORknUpRrCDOK46aAbIiey"
                        callbackUri "http://mob.com"
                        shareByAppClient true
                        enable true
                        }
                    }
                }
}
```

## 接口方法说明
接口详情：[API接口调用](https://www.mob.com/wiki/detailed?wiki=31&id=14)

## 技术支持
如有问题请联系技术支持:

```
服务电话:   400-685-2216
QQ:        4006852216
节假日值班电话:
    iOS：185-1664-1951
Android: 185-1664-1950
电子邮箱:   support@mob.com
市场合作:   021-54623100
```