# sharesdk_flutter

ShareSDK is a social sharing component that provides social functions for apps, like authorization and share, shortens the development time of developers, and has social statistical analysis management background.

Introduce: http://www.mob.com/product/sharesdk

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

For help on editing plugin code, view the [documentation](https://flutter.io/developing-packages/#edit-plugin-package).

If you need to customize the platform:
- iOS : you need to editor *sharesdk_flutter.podspec*

```
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'sharesdk_flutter'
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


