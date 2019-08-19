**Document Language:** **English** | **[中文](https://github.com/MobClub/ShareSDK-For-Flutter/blob/master/README_CN.md)**

# ShareSDK For Flutter
### ShareSDK is a social sharing component that provides social functions for apps, like authorization and share, and has social statistical analysis management background.

**supported original ShareSDK minimum version:**

- [Android](https://github.com/MobClub/ShareSDK-for-Android) - V3.4.0
- [iOS](https://github.com/MobClub/ShareSDK-for-iOS) - V4.2.1

**introduce:** http://www.mob.com/product/sharesdk

**plugin homepage:** https://pub.dartlang.org/packages/sharesdk

**official document:** http://wiki.mob.com/快速集成/

## Getting Started

Refer to [the official document](https://pub.dartlang.org/packages/sharesdk#-installing-tab-)

If you need to customize the platforms:

### iOS
You need to editor *sharesdk.podspec* , please refer to [official website document](http://wiki.mob.com/cocoapods%E9%9B%86%E6%88%90/) for supported platforms.

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

Then you need to configure Appkey and AppSecret in info.plist according to [the official document](http://wiki.mob.com/快速集成/), as well as the whitelist and urlScheme of each platform.

### Android
You need to edit build.gradle, mobsdk.gradle file again to select the platform you need to use,
For specific supported platforms, please refer to [official website technical documentation](http://wiki.mob.com/%E5%AE%8C%E6%95%B4%E9%9B%86%E6%88%90%E6%96%87%E6%A1%A3%EF%BC%88gradle%EF%BC%89/)
To meet the requirements of the example project, you need to configure at least the following platforms:

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

