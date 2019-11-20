#import "FlutterBuglyPlugin.h"
#import <flutter_bugly_plugin/flutter_bugly_plugin-Swift.h>

@implementation FlutterBuglyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterBuglyPlugin registerWithRegistrar:registrar];
}
@end
