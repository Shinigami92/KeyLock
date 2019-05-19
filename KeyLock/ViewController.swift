//
//  ViewController.swift
//  KeyLock
//
//  Created by Christopher Quadflieg on 19.05.19.
//  Copyright © 2019 Shinigami. All rights reserved.
//

import Cocoa
import IOKit
import IOKit.pwr_mgt

class ViewController: NSViewController {
    
    var assertionID: IOPMAssertionID = 0
    var success: IOReturn?
    
    func disableScreenSleep(reason: String = "Unknown reason") -> Bool {
        success = IOPMAssertionCreateWithName(kIOPMAssertionTypeNoDisplaySleep as CFString,
                                              IOPMAssertionLevel(kIOPMAssertionLevelOn),
                                              reason as CFString,
                                              &assertionID)
        
        return success == kIOReturnSuccess
    }
    
    func enableScrenSleep() -> Bool {
        if success != nil {
            success = IOPMAssertionRelease(assertionID)
            success = nil
            return true
        }
        return false
    }
    
    @IBAction func keepScreen(_ sender: NSButtonCell) {
        switch sender.state {
        case .on:
            if disableScreenSleep(reason: "Disabled by KeyLock") {
                print("Enable Screen-Keep-On")
            }
        case .off:
            if enableScrenSleep() {
                print("Disable Screen-Keep On")
            }
        default:
            print("Unknow state")
        }
    }
    
    @IBAction func ok(_ sender: NSButton) {
        AppDelegate.closeWindow(nil)
    }
    
    static func freshController() -> ViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier("ViewController")
        guard let viewController = storyboard.instantiateController(withIdentifier: identifier) as? ViewController else {
            fatalError("Why cant i find ViewController? - Check Main.storyboard")
        }
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
}
