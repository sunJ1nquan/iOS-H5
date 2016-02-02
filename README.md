#概述
--------
这个项目讲述了IOS与H5的交互过程。

#H5调用OC
--------
1. 函数传递
2. 模型调用
3. 事件传递

```
#import <JavaScriptCore/JavaScriptCore.h>
```

##2模型调用

h5
```
// h5
<input type="button" value="Call ObjC system camera" onclick="OCModel.callSystemCamera()">
```

点击H5,获取OC模型

```
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;


self.jsContext[@"OCModel"] = model;
model.jsContext = self.jsContext;
model.webView = self.webView;

```

OC Model

```
// 此模型用于注入JS的模型，这样就可以通过模型来调用方法。
@interface HYBJsObjCModel : NSObject <JavaScriptObjectiveCDelegate>

@property (nonatomic, weak) JSContext *jsContext;
@property (nonatomic, weak) UIWebView *webView;

@end

// Js调用了callSystemCamera
- (void)callSystemCamera {
NSLog(@"JS调用了OC的方法，调起系统相册");

// JS调用后OC后，又通过OC调用JS，但是这个是没有传参数的
JSValue *jsFunc = self.jsContext[@"jsFunc"];
[jsFunc callWithArguments:nil];
}

```


2. 通过OC对象调用：
    1. 函数
    2. 传值


#OC 调用
-----------
1. 获取
2. 直接调用
3. 模型调用

#OC模型（被调用） 调用JS
-----------
1. 被H5调用
2. 实现调用协议
1. 实现调用方法
