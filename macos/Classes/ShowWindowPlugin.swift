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

public class ShowWindowPlugin: NSObject, FlutterPlugin {
  let kChannelName = "inspireui/showwindow"
  let _kOpenWindowMethod = "Window.Open"
  let _kCloseWindowMethod = "Window.Close"
  let _kStatusWindowMethod = "Window.Status"
  let _kKeyWindowMethod = "Window.Key"

  public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: kChannelName, binaryMessenger: registrar.messenger)
        let instance = ShowWindowPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case _kOpenWindowMethod:
            let args = call.arguments as? [String: Any]
            let width: Int? = args?["width"] as? Int
            let height: Int? = args?["height"] as? Int
            let x: Double? = args?["x"] as? Double
            let y: Double? = args?["y"] as? Double
            let key: String = args?["key"] as! String
            openNewWindow(
                key: key,
                x: x,
                y: y,
                width: width,
                height: height
            )
            result(true)
            break
        case _kCloseWindowMethod:
            let args = call.arguments as? [String: Any]
            let key: String! = args?["key"] as? String
            result(closeWindow(_key: key))
            break
        case _kStatusWindowMethod:
            let args = call.arguments as? [String: Any]
            let _key: String? = args?["key"] as? String
            let window = NSApp.windows.first(where: { $0.title == _key })
            let screen = window?.frame
            let origin = screen?.origin
            let size = screen?.size
            var _args: [String: Any?] = [:]
            _args["offsetX"] = Double(origin!.x)
            _args["offsetY"] = Double(origin!.y)
            _args["width"] = Double(size!.width)
            _args["height"] = Double(size!.height)
            result(_args)
        case _kKeyWindowMethod:
            let window = NSApp.windows.last
            let _instanceKey = window?.title;
            result(_instanceKey)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    func openNewWindow(key: String, x: Double? = nil, y: Double? = nil, width: Int? = nil, height: Int? = nil) {
        let flutterController = FlutterViewController.init()
        let window = NSWindow()
        window.styleMask = NSWindow.StyleMask(rawValue: 0xf)
        window.backingType = .buffered
        RegisterGeneratedPlugins(registry: flutterController)
        ShowWindowPlugin.register(with: flutterController.registrar(forPlugin: "ShowWindowPlugin"))
        window.contentViewController = flutterController
        if let screen = window.screen {
            let screenRect = screen.visibleFrame
            let newWidth = width ?? Int(screenRect.maxX / 2)
            let newHeight = height ?? Int(screenRect.maxY / 2)
            var newOriginX: CGFloat = (screenRect.maxX / 2) - CGFloat(Double(newWidth) / 2)
            var newOriginY: CGFloat = (screenRect.maxY / 2) - CGFloat(Double(newHeight) / 2)
            if (x != nil) { newOriginX = CGFloat(x!) }
            if (y != nil) { newOriginY = CGFloat(y!) }
            window.setFrameOrigin(NSPoint(x: newOriginX, y: newOriginY))
            window.setContentSize(NSSize(width: newWidth, height: newHeight))
        }
        window.title = key;
        window.titleVisibility = .hidden
        let windowController = NSWindowController()
        windowController.contentViewController = window.contentViewController
        windowController.shouldCascadeWindows = true
        windowController.window = window
        windowController.showWindow(self)
    }


    func closeWindow(_key: String) -> Bool {
        let window = NSApp.windows.first(where: { $0.title == _key })
        window?.close()
        return true
    }
}
