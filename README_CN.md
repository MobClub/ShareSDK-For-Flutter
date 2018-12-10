**文档语言 :** **中文** | **[English](README.md)**

# ShareSDK For Flutter
### 这是一个基于ShareSDK功能的扩展的Flutter插件。使用此插件能够帮助您在使用Flutter开发应用时,快速地实现社会化功能,例如第三方授权登录,获取用户信息以及社交平台的分享等功能。

**原生SDK支持的最低版本:**

- [Android](https://github.com/MobClub/ShareSDK-for-Android) - V3.4.0
- [iOS](https://github.com/MobClub/ShareSDK-for-iOS) - V4.2.1

**简介：** http://www.mob.com/product/sharesdk
**插件主页：**https://pub.dartlang.org/packages/sharesdk

## 开始集成

参考[官方插件集成文档](https://pub.dartlang.org/packages/sharesdk#-installing-tab-)

自定义需要导入的分享平台:
- iOS : 你需要重新编辑 *sharesdk.podspec* 文件设置 dependency，具体支持的平台可以参阅 pod search mob_sharesdk 或者参考[官网文档](http://wiki.mob.com/cocoapods%E9%9B%86%E6%88%90/)

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

- Android :
  