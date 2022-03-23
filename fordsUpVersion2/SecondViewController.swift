//
//  SecondViewController.swift
//  fordsUp
//
//  Created by Brennan Duff on 3/14/22.
//
//test2
import UIKit
import CoreMotion
import Foundation
import AudioToolbox
import SwiftSoup


class SecondViewController: UIViewController
{
            
    var counter = 3
           
    var timeLaunched: Double = 0
    
    var gameTimer = Timer()
    
    var gyroTimer: Timer?
    
    var timerBool = false
        

    @IBOutlet weak var gameLabel: UILabel!
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var playAgain: UIButton!
    
    
    let motion = CMMotionManager()
        
    let h = 0
        var timer: Timer?
        var timer2: Timer?
        var timer3: Timer?
        var correct = 0
        var wrong = 0
        var wrongPoints = 0
        var correctPoints = 0
        var checkDone = false
        var count = 15
        let gameTime = 15
    
    //public schools in haverford township
    var chathamParkTeachers = ["", "", ""]
    var chestnutwoldTeachers = ["", "", ""]
    var coopertownTeachers = ["", "", ""]
    var lynnewoodTeachers = ["", "", ""]
    var manoaTeachers = ["", "", ""]
    var middleSchoolTeachers = ["Collins", "Kim", "Finn"]
    var highSchoolTeachers = ["Smith", "Wells", "Stewart"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
      print(chathum)
        /*
        let frame = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        frame.layer.borderWidth = 3
        frame.layer.borderColor = UIColor.white.cgColor
        frame.layer.cornerRadius = 10
        frame.layer.masksToBounds = true
        view.addSubview(frame) ///////
        
        let frame2 = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        frame2.layer.borderWidth = 2
        frame2.layer.borderColor = UIColor.white.cgColor
        frame2.layer.masksToBounds = true
        view.addSubview(frame2) ///////
        
        let frame3 = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        frame3.layer.borderWidth = 2
        frame3.layer.borderColor = UIColor.white.cgColor
        frame3.layer.masksToBounds = true
        view.addSubview(frame3) ///////
*/
       
        
        
        gameLabel.transform = CGAffineTransform(rotationAngle: (-.pi/2))
        timerLabel.transform = CGAffineTransform(rotationAngle: (-.pi/2))
        playAgain.transform = CGAffineTransform(rotationAngle: (-.pi/2))
       
        playAgain.bringSubviewToFront(self.view)
       
        playAgain.isHidden = true
        print("start")
       
        motion.startDeviceMotionUpdates(using: .xTrueNorthZVertical)
           self.timerLabel?.text = "3"
        
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
        {
            self.timerLabel?.text = "2"
        }
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
        {
            self.timerLabel?.text = "1"
        }
    
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0)
        {
            self.timerLabel?.text = ""
            self.gameLabel?.text = "place phone on your forehead"
            
            self.timer2 = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: (#selector(SecondViewController.check)), userInfo: nil, repeats: true)
         }
    }
    

    @objc func countdown()
    {
        count -= 1
        timerLabel.text! = "\(count)"
        print(count)
        
        
        if count <= 0
        {
            timer?.invalidate()
            count = gameTime //change this to match var count. NOTE: dont add parameters to the function, you cant change them in the countdownTimer
        }
    }
    
    
    func countdownTimer() //this is the function to call to do countdown stuff
    {
        timer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    
    //start at 60, end at 140
    @objc func updateLabel() {
       
        let roll = (((motion.deviceMotion?.attitude.roll)!) * 180 / .pi)

        let r: String = String(format: "%.2f", roll)
        
        
        //tilt up
        if Int(roll) > -46 && Int(roll) < 30
        {
            view.backgroundColor = UIColor.red
            wrong += 1
            if wrong == 1
            {
                wrongPoints += 1
                vibrate()
                self.gameLabel.text = "-1"
                // this makes stuff happen once when phone is tilted up
            }
            
        }
        
        
        //tilt normal, set stuff to default?
        if Int(roll) > 59 && Int(roll) < 98
        {
            view.backgroundColor = UIColor.blue
            correct = 0
            wrong = 0
            self.gameLabel.text = "" //change text to word name
        }
        
        
        //tilt down
        if Int(roll) > 149
        {
            view.backgroundColor = UIColor.green
            correct += 1
            if correct == 1
            {
                vibrate()
                correctPoints += 1
                self.gameLabel.text = "+1"
                // this makes stuff happen once when phone is tilted down
            }
        }
        
    }
    
    func vibrate()
    {
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
    }
    
    func timerFunc() //constant repeat
    {
        self.timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: (#selector(SecondViewController.updateLabel)), userInfo: nil, repeats: true)
    }
    
    @objc func check()
    {
        let roll = (((motion.deviceMotion?.attitude.roll)!) * 180 / .pi)
        
            if roll > 75 && roll < 97
                {
                checkDone = true
                timer2?.invalidate() //stops the check if phone is in correct position
                countdownTimer()
                
                //the method below happens the frame before the game starts
                self.timerLabel.text = "\(count)"
                DispatchQueue.main.asyncAfter(deadline: .now() + 14) // change to how many seconds game will last - 1
                    {
                        //this is what happens when the game ends (after 14 seconds)
                        self.timer?.invalidate()
                        self.timer3?.invalidate() //countdown
                        self.view?.backgroundColor = UIColor.blue
                        self.gameLabel?.text = "correct: \(self.correctPoints)\n wrong: \(self.wrongPoints)"
                        self.timerLabel?.text = ""
                        self.playAgain.isHidden = false
                    }
                
                timerFunc()
                }
    }
    
    
    
    @IBAction func test(_ sender: UIButton)
    {
    print("test")
    }
    
  
    

    

}

/*
 self.navigationController?.popToRootViewController(animated: true)

print("hit")
 */