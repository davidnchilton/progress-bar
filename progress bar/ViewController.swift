// created on a shift with nothing to do, so I used the time so I could watch the progress... 
//
//  ViewController.swift
//  progress bar
//
//  Created by David Chilton on 10/04/2022.
//

import UIKit

class ViewController: UIViewController {
    
    //data storage
    let defaults = UserDefaults.standard
    var savedShiftStart = ""
    var savedShiftLength = ""
    var dataStored = 0

    
    @IBAction func reset(_ sender: UIButton) {
        button.isHidden = false
        stepper.isHidden = false
        stepperLength.isHidden = false
        shiftStartLabel.isHidden = false
        shiftLengthLabel.isHidden = false
    }
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var helpLabel1: UILabel!
    @IBOutlet weak var helpLabel2: UILabel!
    @IBOutlet weak var shiftStartLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBAction func shiftStartStepper(_ sender: UIStepper) {
        
        shiftStartLabel.text = Int(sender.value).description
        
    }
    
    @IBOutlet weak var shiftLengthLabel: UILabel!
    
    
    @IBOutlet weak var stepperLength: UIStepper!
    @IBAction func shiftLengthStepper(_ sender: UIStepper) {
        shiftLengthLabel.text = Int(sender.value).description
    }
    
    
    
    @IBOutlet weak var button: UIButton!
    @IBAction func buttonMain(_ sender: UIButton) {
        shiftStart = shiftStartLabel.text
        shiftLength = shiftLengthLabel.text
        shiftProgress()
        
        
        //saving shift time
        defaults.set(shiftStart, forKey: "shiftStart")
        defaults.set(shiftLength, forKey: "shiftLength")
        
        button.isHidden = true
        stepper.isHidden = true
        stepperLength.isHidden = true
        shiftStartLabel.isHidden = true
        shiftLengthLabel.isHidden = true
        helpLabel1.isHidden = true
        helpLabel2.isHidden = true
        
    }
    
    var shiftStart: String? = "16"
    var shiftLength: String? = "2"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        stepper.maximumValue = 24
        stepper.wraps = true
        
        stepperLength.maximumValue = 24
        stepperLength.wraps = true
        
        
        //loading shift data
        
        savedShiftStart = defaults.string(forKey: "shiftStart") ?? "1"
        shiftStart = savedShiftStart
        savedShiftLength = defaults.string(forKey: "shiftLength") ?? "25"
        shiftLength = savedShiftLength
        
        if savedShiftLength == "25" {
            button.isHidden = false
            stepper.isHidden = false
            stepperLength.isHidden = false
            shiftStartLabel.isHidden = false
            shiftLengthLabel.isHidden = false
            helpLabel1.isHidden = false
            helpLabel2.isHidden = false
        }
        else {
        button.isHidden = true
        stepper.isHidden = true
        stepperLength.isHidden = true
        shiftStartLabel.isHidden = true
        shiftLengthLabel.isHidden = true
            helpLabel1.isHidden = true
            helpLabel2.isHidden = true
        }
        
         //print("saved shift length:  \(savedShiftLength)") //test saved ok
        //while true {
        shiftProgress()
        
        
        }
    
    
    
    
    
    
    func shiftProgress() {
        //------- current time ----------
        // 2 vars: hour, min
        let date = Date()
        let calendar = Calendar.current
        let hour = Int(calendar.component(.hour, from: date))
        let minutes = Int(calendar.component(.minute, from: date))
        //-------------------------------
        

        
        let shiftStartInt: Int!
       
         
        //string to int conversion, using new vars postfix Int
        if let shiftStart = shiftStart {
          shiftStartInt = Int(shiftStart)
          //print(shiftStartInt ?? 0) ?? provides default in case nil
         
          let timePassed = hour - shiftStartInt //Edit for correct time if virtual comp/offline
         
          
         
          let timeElapsed = timePassed*60 + minutes
           //total time from 00:00 in minutes
         
         
            let shiftLengthInt: Int! = Int(shiftLength!)
          let shiftLengthMinutes = shiftLengthInt*60 //240
         
          
          let ma1 = Float(timeElapsed) / Float(shiftLengthMinutes)
         
          let ma2 = (ma1*100)
         
         
          //visual progress bar
          let progress = (Float(ma2)/100) //percent to x/100
            //print(progress) //should print decimal
            progressBar.progress = progress
    }
    }
    


}

