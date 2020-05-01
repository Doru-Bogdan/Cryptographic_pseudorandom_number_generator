//
//  Blum-Micali_Algorithm.swift
//  Cryptographic_pseudorandom_number_generator
//
//  Created by Doru Mancila on 30/04/2020.
//  Copyright © 2020 Doru Mancila. All rights reserved.
//

import Cocoa

class Blum_Micali_Algorithm: NSObject {
    static let primeNr = 76543
    static let primitiveRoot = 11
    
    static func exp(_ number: Int, _ power:Int, _ mod: Int) -> Int {
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
        
    class func generateBits(_ numberOfBits: Int, _ seed: Int, _ maxNumberOfBits: Int, _ view: NSView) {
            var seed = seed
            var expo:Int = 0
            let progressBar = ProgressAlert()
            progressBar.maxValue = Double(maxNumberOfBits)
            progressBar.beginSheetModal(for: view.window!)
        
            DispatchQueue.global(qos: .default).async {
                for i in 0..<numberOfBits {
                    expo = exp(primitiveRoot, seed, primeNr)
                    
                    if expo > (primeNr - 1) / 2
                    {
                        if !writeToFile(fileName: "text", writeText: "1") {
                            Alert.makeAlert(view: view, messageText: "Can't write to the desired file", informativeText: "")
                            print("Error: Could not write to file!")
                            return
                        }
                        DispatchQueue.main.async {
                            progressBar.doubleValue = Double(i)
                        }
                        
        //                print("1", separator:" ", terminator:"")
                    } else {
                        if !writeToFile(fileName: "text", writeText: "0") {
                            Alert.makeAlert(view: view, messageText: "Can't write to the desired file", informativeText: "")
                            print("Error: Could not write to file!")
                            return
                        }
                        DispatchQueue.main.async {
                            progressBar.doubleValue = Double(i)
                        }
        //                print("0", separator:" ", terminator: "")
                    }
                    seed = expo
                }
    //            print()
                DispatchQueue.main.async {
                    view.window?.endSheet(progressBar.window)
                }
            }
        }
        
        class func modulo(_ a: Int, _ n: Int) -> Int {
            precondition(n > 0, "modulus must be positive")
            let r = a % n
            return r >= 0 ? r : r + n
        }
        
        class func writeToFile(fileName: String, writeText: String) -> Bool {
            let desktopURL = try! FileManager.default.url(for: .demoApplicationDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = desktopURL.appendingPathComponent(fileName).appendingPathExtension("bin")
          
    //        print("File Path: \(fileURL.path)")
            
            if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
                do {
                    try fileHandle.seekToEnd()
                } catch {
                    print("Error: \(error)")
                    return false
                }
                fileHandle.write(writeText.data(using: String.Encoding.utf8)!)
            }
            
            else {
                do {
                    try writeText.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                } catch let error as NSError {
                    print("Error: fileURL failed to write: \n\(error)" )
                    return false
                }
            }
            return true
        }
}
