//
//  Alert.swift
//  Cryptographic_pseudorandom_number_generator
//
//  Created by Doru Mancila on 01/05/2020.
//  Copyright © 2020 Doru Mancila. All rights reserved.
//

import Cocoa

class Alert: NSObject {
    class func makeAlert(view: NSView, messageText: String, informativeText: String) {
        let alert = NSAlert()
        alert.messageText = messageText
        alert.informativeText = informativeText
        alert.addButton(withTitle: "OK")
        alert.beginSheetModal(for: view.window!)
    }
}

class ProgressAlert: NSAlert {
    public let progressBar = NSProgressIndicator()

    override init() {
        super.init()

        messageText = ""
        informativeText = "Processing..."
        accessoryView = NSView(frame: NSRect(x:0, y:0, width: 290, height: 16))
        accessoryView?.addSubview(progressBar)
        self.layout()
        accessoryView?.setFrameOrigin(NSPoint(x:(self.accessoryView?.frame)!.minX,y:self.window.frame.maxY))
        addButton(withTitle: "")

        progressBar.isIndeterminate = false
        progressBar.style = .bar
        progressBar.sizeToFit()
        progressBar.setFrameSize(NSSize(width:290, height: 16))
        progressBar.usesThreadedAnimation = true
        progressBar.minValue = 0
    }

    /// Increment progress bar in this alert.

    func increment(by value: Double) {
        progressBar.increment(by: value)
    }

    /// Set/get `maxValue` for the progress bar in this alert

    var maxValue: Double {
        get {
            return progressBar.maxValue
        }
        set {
            progressBar.maxValue = newValue
        }
    }
    
    var doubleValue: Double {
        get {
            return progressBar.doubleValue
        }
        set {
            progressBar.doubleValue = newValue
        }
    }
}
