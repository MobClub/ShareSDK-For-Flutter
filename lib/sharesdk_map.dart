import 'package:flutter/foundation.dart';
import './sharesdk_defines.dart';

 class SSDKMap
 {
   final Map map = {};

   void setGeneral(String text, dynamic images, String url, String title, int contentType)
   {
     map["type"] = contentType;
     map["text"] = text;
     map["title"] = title;
     map["images"] = images;
     map["url"] = url;
   }

   void setWechat(String text, String title, String url, String thumbImage, dynamic images, String musicFileURL, String extInfo, String fileData, String emoticonData, String fileExtension, String sourceFileData, int contentType, ShareSDKPlatform subPlatform)
   {
     
   }
  
}

