#import "DtAnimateKitPlugin.h"
#if __has_include(<dt_animate_kit/dt_animate_kit-Swift.h>)
#import <dt_animate_kit/dt_animate_kit-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "dt_animate_kit-Swift.h"
#endif

@implementation DtAnimateKitPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDtAnimateKitPlugin registerWithRegistrar:registrar];
}
@end
