#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'sharesdk_plugin'
  s.version          = '1.1.4'
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
  s.dependency 'mob_sharesdk_spec2'
  s.dependency 'mob_sharesdk_spec2/ShareSDKExtension'
  s.dependency 'mob_sharesdk_spec2/ShareSDKUI'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/QQ'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/SinaWeibo'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/WeChat'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Facebook'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Twitter'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Oasis'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Line'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/SnapChat'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/WatermelonVideo'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/KuaiShou'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Douyin'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/TikTok'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Kakao'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Line'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Instagram'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Messenger'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/WhatsApp'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/GooglePlus'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/LinkedIn'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/VKontakte'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Telegram'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Reddit'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Pocket'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Flickr'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Dropbox'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Pinterest'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Reddit'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Instapaper'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/DingTalk'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/YouDaoNote'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/MingDao'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Evernote'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/Yixin'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/SMS'
  s.dependency 'mob_sharesdk_spec2/ShareSDKPlatforms/WeWork'

  #分享闭环
  s.dependency 'mob_sharesdk_spec2/ShareSDKRestoreScene'
  s.static_framework = true

  s.ios.deployment_target = '8.0'
end

