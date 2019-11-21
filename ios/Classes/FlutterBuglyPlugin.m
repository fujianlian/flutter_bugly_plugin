#import "FlutterBuglyPlugin.h"
#import <Bugly/Bugly.h>

@implementation FlutterBuglyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_bugly_plugin"
            binaryMessenger:[registrar messenger]];
  FlutterBuglyPlugin* instance = [[FlutterBuglyPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if([@"setUp" isEqualToString:call.method]) {
        //Bugly SDK初始化方法
        NSString *appID = call.arguments[@"app_id"];
        [Bugly startWithAppId:appID];
    } else if ([@"postException" isEqualToString:call.method]) {
      //获取Bugly数据上报所需要的各个参数信息
      NSString *message = call.arguments[@"crash_message"];
      NSString *detail = call.arguments[@"crash_detail"];

      NSArray *stack = [detail componentsSeparatedByString:@"\n"];
      //调用Bugly数据上报接口
      [Bugly reportExceptionWithCategory:4 name:message reason:stack[0] callStack:stack extraInfo:@{} terminateApp:NO];
      result(@0);
  } else {
    //方法未实现
    result(FlutterMethodNotImplemented);
  }
}

@end
