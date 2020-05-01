//
//  ViewController.swift
//  Cryptographic_pseudorandom_number_generator
//
//  Created by Doru Mancila on 29/04/2020.
//  Copyright © 2020 Doru Mancila. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var insertSize: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func generateRandomNumbers(_ sender: Any) {
        let letters = NSCharacterSet.letters
        if insertSize.stringValue == "" || insertSize.floatValue <= 0 || insertSize.stringValue.rangeOfCharacter(from: letters) != nil
        {
            Alert.makeAlert(view: view, messageText: "Wrong input", informativeText: "Please insert a grater value than 0! ")
        } else {
            Blum_Micali_Algorithm.generateBits(Int(insertSize.floatValue * 1000000), Int(Date().timeIntervalSinceReferenceDate), Int(insertSize.floatValue * 1000000), view)
        }
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
