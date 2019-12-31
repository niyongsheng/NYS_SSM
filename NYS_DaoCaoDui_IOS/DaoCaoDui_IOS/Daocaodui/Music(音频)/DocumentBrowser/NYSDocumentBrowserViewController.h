//
//  NYSDocumentBrowserViewController.h
//  DaoCaoDui_IOS
//
//  Created by 倪永胜 on 2019/12/30.
//  Copyright © 2019 NiYongsheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYSFileType.h"

typedef void(^CallBack)(NSData *contentsData, NSArray *fileType, NSString *fileName, NSURL *fileURL);

@interface NYSDocumentBrowserViewController : UIDocumentBrowserViewController

@property (nonatomic,copy)CallBack callBack;

@end
