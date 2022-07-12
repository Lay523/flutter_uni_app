#import "FlutterUniAppPlugin.h"
#if __has_include(<flutter_uni_app/flutter_uni_app-Swift.h>)
#import <flutter_uni_app/flutter_uni_app-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_uni_app-Swift.h"
#endif

#import "DCUniMP.h"

@implementation FlutterUniAppPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterUniAppPlugin registerWithRegistrar:registrar];
}
@end
