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
    
    func disableScreenSleep(reason: String = "Unknown reason") -> Bool? {
        guard success != nil else { return nil }
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
            print("Enable Screen-Keep-On")
            disableScreenSleep(reason: "Disabled by KeyLock")
        case .off:
            print("Disable Screen-Keep On")
            enableScrenSleep()
        default:
            print("Unknow state")
        }
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
