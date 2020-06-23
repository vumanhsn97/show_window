// Copyright 2019 Google LLC
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

import FlutterMacOS
import Foundation

let kChannelName = "inspireui/showwindow"
let _kOpenWindowMethod = "Window.Open"
let _kCloseWindowMethod = "Window.Close"
let _kStatusWindowMethod = "Window.Status"
let _kKeyWindowMethod = "Window.Key"

class ShowWindowPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
      let channel = FlutterMethodChannel(name: kChannelName, binaryMessenger: registrar.messenger)
      let instance = ShowWindowPlugin()
      registrar.addMethodCallDelegate(instance, channel: channel)
  }
    
  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch call.method {
        default:
            result(FlutterMethodNotImplemented)
      }
  }
}
