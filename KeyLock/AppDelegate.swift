//
//  AppDelegate.swift
//  KeyLock
//
//  Created by Christopher Quadflieg on 19.05.19.
//  Copyright © 2019 Shinigami. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    static let window = NSWindow(contentRect: NSMakeRect(0, 0, NSScreen.main!.frame.midX, NSScreen.main!.frame.midY), styleMask: [.closable], backing: .buffered, defer: false)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("StatusBarButtonImage"))
        }
        
        AppDelegate.window.title = "KeyLock"
        AppDelegate.window.isOpaque = false
        AppDelegate.window.center()
        AppDelegate.window.isMovableByWindowBackground = true
        //        AppDelegate.window.backgroundColor = NSColor(calibratedHue: 0, saturation: 1.0, brightness: 0, alpha: 0.7)
        AppDelegate.window.contentViewController = ViewController.freshController()
        
        constructMenu()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Preferences...", action: #selector(AppDelegate.openWindow(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit KeyLock", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    @objc func openWindow(_ sender: Any?) {
        print("Show window")
        AppDelegate.window.makeKeyAndOrderFront(self)
    }
    
    @objc static func closeWindow(_ sender: Any?) {
        print("Hide window")
        window.orderOut(self)
    }
    
}
