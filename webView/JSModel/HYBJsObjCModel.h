//
//  HYBJsObjCModel.h
//  webView
//
//  Created by tengfei li on 2/2/16.
//  Copyright © 2016年 SJQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JavaScriptObjectiveCDelegate.h"

// 此模型用于注入JS的模型，这样就可以通过模型来调用方法。
@interface HYBJsObjCModel : NSObject <JavaScriptObjectiveCDelegate>

@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;


@end
