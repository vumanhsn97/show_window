// Copyright 2018 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "FLEShowWindowPlugin.h"

#import <AppKit/AppKit.h>

// See color_panel.dart for descriptions.
static NSString *const kChannelName = @"inspireui/showwindow";

static NSString *const _kShowWindowMethod = @"Window.Show";
static NSString *const _kPrintLog = @"Window.Log";

@implementation FLEShowWindowPlugin {
  // The channel used to communicate with Flutter.
  FlutterMethodChannel *_channel;
}

+ (void)registerWithRegistrar:(id<FlutterPluginRegistrar>)registrar {
  FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:kChannelName
                                                              binaryMessenger:registrar.messenger];
  FLEShowWindowPlugin *instance = [[FLEShowWindowPlugin alloc] initWithChannel:channel];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)initWithChannel:(FlutterMethodChannel *)channel {
  self = [super init];
  if (self) {
    _channel = channel;
  }
  return self;
}

/**
 * Handles platform messages generated by the Flutter framework on the color
 * panel channel.
 */
- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
  id methodResult = nil;
  if ([call.method isEqualToString:_kShowWindowMethod]) {
   NSString *errorString = [NSString
          stringWithFormat:@"Malformed call for %@. Expected an NSDictionary but got %@",
                           _kShowWindowMethod, NSStringFromClass([call.arguments class])];
  methodResult = [FlutterError errorWithCode:@"Bad arguments" message:errorString details:nil];
  } else if ([call.method isEqualToString:_kPrintLog]) {
    NSString *const helloWorld = @"Wellcome to MacOS Method Channel :)";
    NSRect frame = NSMakeRect(0.8, 0, 200, 200);
    NSWindow* window  = [[NSWindow alloc] initWithContentRect:frame
                    styleMask:NSBorderlessWindowMask
                    backing:NSBackingStoreBuffered
                    defer:true];
    [window setBackgroundColor:[NSColor blueColor]];
    [window makeKeyAndOrderFront:NSApp];
    methodResult = helloWorld;
  } else {
    methodResult = FlutterMethodNotImplemented;
  }
  // If no errors are generated, send an immediate empty success message for handled messages, since
  // the actual color data will be provided in follow-up messages.
  result(methodResult);
}

@end
