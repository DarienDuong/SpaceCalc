//
//  ViewController.swift
//  calculator
//
//  Created by Darien Duong on 10/23/17.
//  Copyright © 2017 Darien Duong. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType:"wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
        
    }

    @IBAction func numberPressed(sender: UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject){
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject){
        processOperation(operation: .Multiply)
    }

    @IBAction func onSubractPressed(sender: AnyObject){
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject){
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject){
        processOperation(operation: currentOperation)
    }

    func playSound(){
        if btnSound.isPlaying{
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation){
        playSound()
        if currentOperation != Operation.Empty{
    //        if user selects operator and selected another operator without first entering number
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
            
        } else {
//            first time operator is pressed
            if runningNumber == ""{
//                if no number has been entered before the operator was pressed
                leftValStr = "0"
                runningNumber = ""
                currentOperation = operation
            } else {
                leftValStr = runningNumber
                runningNumber = ""
                currentOperation = operation
            }
        }
    }
}

