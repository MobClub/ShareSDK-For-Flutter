**Document Language:** **English** | **[中文](README_CN.md)**

# ShareSDK For Flutter
### ShareSDK is a social sharing component that provides social functions for apps, like authorization and share, and has social statistical analysis management background.

**supported original ShareSDK minimum version:**

- [Android](https://github.com/MobClub/ShareSDK-for-Android) - V3.4.0
- [iOS](https://github.com/MobClub/ShareSDK-for-iOS) - V4.2.1

**introduce:** http://www.mob.com/product/sharesdk
**plugin homepage：**https://pub.dartlang.org/packages/sharesdk

## Getting Started

Refer to [the official document](https://pub.dartlang.org/packages/sharesdk#-installing-tab-)

If you need to customize the platforms:
- iOS : You need to editor *sharesdk.podspec* , please refer to [official website document](http://wiki.mob.com/cocoapods%E9%9B%86%E6%88%90/) for supported platforms.

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
