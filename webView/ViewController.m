//
//  ViewController.m
//  JavaScriptAndObjectiveC
//
//  Created by huangyibiao on 15/10/13.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    
    // 一个JSContext对象，就类似于Js中的window，只需要创建一次即可。
    self.jsContext = [[JSContext alloc] init];
    
    // jscontext可以直接执行JS代码。
    [self.jsContext evaluateScript:@"var num = 10"];
    [self.jsContext evaluateScript:@"var squareFunc = function(value) { return value * value }"];
    // 计算正方形的面积
    JSValue *square = [self.jsContext evaluateScript:@"squareFunc(num)"];
    
    // 也可以通过下标的方式获取到方法
    JSValue *squareFunc = self.jsContext[@"squareFunc"];
    JSValue *value = [squareFunc callWithArguments:@[@"20"]];
    NSLog(@"直接执行：%@", square.toNumber);
    NSLog(@"获取方法：%@", value.toNumber);
}

//懒加载——也称为延迟加载，即在需要的时候才加载（效率低，占用内存小）。所谓懒加载，写的是其get方法.
- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.scalesPageToFit = YES;
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        _webView.delegate = self;
    }
    
    return _webView;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 通过模型调用方法，这种方式更好些。
    HYBJsObjCModel *model  = [[HYBJsObjCModel alloc] init];
    
    self.jsContext[@"OCModel"] = model;
    model.jsContext = self.jsContext;
    model.webView = self.webView;
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    
    
    _jsContext[@"activityList"] = ^(NSDictionary *param) {
        NSLog(@"111111%@", param);
        
    };
    
}

@end
