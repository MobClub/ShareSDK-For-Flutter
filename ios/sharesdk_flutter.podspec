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

