//  ViewController.swift
//  Circulous
//
//  Created by Conner Vieira on 4/6/20.
//  Copyright © 2020 V0LT.
import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var Radius: NSTextField!
    @IBOutlet weak var Area: NSTextField!
    @IBOutlet weak var Circumference: NSTextField!
    
    var ClipboardContentsToSave = ""
    
    func DisplayDialog(question: String, text: String) -> Bool { // Define function to display alert dialog
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    @IBAction func Submit(_ sender: Any) { // Function to run when the Submit button is pushed
        var RadiusFilled = false
        var AreaFilled = false
        var CircumferenceFilled = false
        
        var ClearedToRun = true // Assume that the program is cleared to run calculations by default
        
        // Determine which fields are filled
        if (Radius.stringValue == "") { // Check if Radius field is filled
            RadiusFilled = false
        } else {
            RadiusFilled = true
        }
        if (Area.stringValue == "") { // Check if Area field is filled
            AreaFilled = false
        } else {
            AreaFilled = true
        }
        if (Circumference.stringValue == "") { // Check if Circumference field is filled
            CircumferenceFilled = false
        } else {
            CircumferenceFilled = true
        }
        
        if (RadiusFilled == true && AreaFilled == true && CircumferenceFilled == true) { // Determine if all fields are already filled in
            ClearedToRun = false // Mark calculations as not cleared to run
            DisplayDialog(question: "Error", text: "All of the values are already filled. There isn't anything to calculate.") // Display alert dialog with error
        }
        
        if (RadiusFilled == false && AreaFilled == false && CircumferenceFilled == false) { // Determine if all fields are empty
            ClearedToRun = false // Mark calculations as not cleared to run
            DisplayDialog(question: "Error", text: "Not enough information was provided to make any calculations. At least one metric needs to be entered.") // Display alert dialog with error
        }
        
        if (ClearedToRun == true) {
            if (RadiusFilled == true) { // Calculations to run given the radius of a circle
                Area.doubleValue = Double.pi * (Radius.doubleValue * Radius.doubleValue) // a = pi * r^2
                Circumference.doubleValue = (2 * Double.pi) * Radius.doubleValue // c = 2pi * r
            }
            if (AreaFilled == true) { // Calculations to run given the area of a circle
                Circumference.doubleValue = 2 * (Double.pi * Area.doubleValue).squareRoot() // c = 2 * sqrt(pi * a)
                Radius.doubleValue = 2 * ((Double.pi * Area.doubleValue).squareRoot()) / (2 * Double.pi) // r = (2 * sqrt(pi * a)) / (2 * pi)
            }
            if (CircumferenceFilled == true) { // Calculations to run given the circumference of a circle
                Area.doubleValue = (Circumference.doubleValue * Circumference.doubleValue) / (4 * Double.pi) // a = c^2
                Radius.doubleValue = Circumference.doubleValue / (2 * Double.pi) // r = c / 2 * pi
            }
        }
    }
    
    @IBAction func ClearFields(_ sender: Any) { // Function to run when the "Clear" button is pushed
        Circumference.stringValue = "" // Clear Circumference field
        Radius.stringValue = "" // Clear Radius field
        Area.stringValue = "" // Clear Area field
    }
    
    @IBAction func CopyAll(_ sender: Any) { // Function to run when the "Copy All" buttion is pushed
        ClipboardContentsToSave = "Circumference = " + Circumference.stringValue + "\nRadius = " + Radius.stringValue + "\nArea = " + Area.stringValue
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.writeObjects([self.ClipboardContentsToSave as NSString])
    }
}

