//
//  NYSFileType.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/30.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    //---------------------------图片类型-----------------------
    ENUM_Image = 1000,//图片
    //---------------------------音频类型-----------------------
    ENUM_Audio,//音频
    //---------------------------视频类型-----------------------
    ENUM_Video,//视频
    //---------------------------文档类型-----------------------
    ENUM_Txt,//文本
    ENUM_Ppt,//PPT
    ENUM_Word,//Word
    ENUM_Excel,//Excel
    
    ENUM_Rtf,//Rtf
    ENUM_Numbers,//Numbers
    ENUM_Pages,//Pages
    ENUM_KeyNote,//KeyNote
    
    ENUM_Wps,//WPS
    
    ENUM_Html,//Html
    ENUM_MarkDown,//MarkDown
    ENUM_PDF,//PDF
    //---------------------------压缩类型-----------------------
    ENUM_Zip,//Zip
    ENUM_Rar,//Rar
    ENUM_Iso,//Iso
    ENUM_Exe,//Exe
    ENUM_Dmg,//Dmg
    ENUM_Ipa,//Ipa
    ENUM_Apk,//Apk
    //---------------------------其他类型-----------------------
    ENUM_UnKnow,//其他
} FileTypes;

@interface NYSFileType : NSObject

/// 判断文件格式
+ (NSArray *)fieldType:(NSURL *)fieldType;

@end
