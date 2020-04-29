//
//  ViewController.swift
//  Cryptographic_pseudorandom_number_generator
//
//  Created by Doru Mancila on 29/04/2020.
//  Copyright © 2020 Doru Mancila. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let primeNr = 5351
    let primitiveRoot = 13
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateBits(10, Int(Date().timeIntervalSinceReferenceDate))
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func exp(_ number: Int, _ power:Int, _ mod: Int) -> Int {
        var rez: Int = 1
        var number = number
        var power = power
        while power != 0 {
            if (power & 1) != 0 {
                rez = modulo((rez * number),mod)
            }
            number = modulo(number * number, mod)
            power >>= 1
        }
        return rez
    }
    
    func generateBits(_ numberOfBits: Int, _ seed: Int) {
        var seed = seed
        var expo:Int
        for _ in 0..<numberOfBits {
            expo = exp(primitiveRoot, seed, primeNr)
            
            if expo > (primeNr - 1) / 2
            {
                print("1", separator:" ", terminator:"")
            } else {
                print("0", separator:" ", terminator: "")
            }
            seed = expo
        }
        print()
    }
    
    func modulo(_ a: Int, _ n: Int) -> Int {
        precondition(n > 0, "modulus must be positive")
        let r = a % n
        return r >= 0 ? r : r + n
    }

}

