#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'sharesdk_plugin'
  s.version          = '1.1.3'
  s.summary          = 'Flutter plugin for ShareSDK.'
  s.description      = <<-DESC
  ShareSDK is the most comprehensive Social SDK in the world,which share easily with 40+ platforms.
                       DESC
  s.homepage         = 'http://www.mob.com/mobService/sharesdk'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Mob' => 'mobproduct@mob.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'mob_sharesdk'
  s.dependency 'mob_sharesdk/ShareSDKExtension'
  s.dependency 'mob_sharesdk/ShareSDKUI'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/QQ'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/SinaWeibo'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/WeChat'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Facebook'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Twitter'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Oasis'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Line'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/SnapChat'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/WatermelonVideo'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/KuaiShou'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Douyin'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/TikTok'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Kakao'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Line'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Instagram'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Messenger'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/WhatsApp'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/GooglePlus'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/LinkedIn'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/VKontakte'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Telegram'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Reddit'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Pocket'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Flickr'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Dropbox'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Pinterest'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Reddit'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Instapaper'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/DingTalk'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/YouDaoNote'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/MingDao'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Evernote'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/Yixin'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/SMS'
  s.dependency 'mob_sharesdk/ShareSDKPlatforms/WeWork'

  #分享闭环
  s.dependency 'mob_sharesdk/ShareSDKRestoreScene'
  s.static_framework = true

  s.ios.deployment_target = '8.0'
end

