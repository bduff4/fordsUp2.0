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


class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
 let motion = CMMotionManager()
    var counter = 3
    var timeLaunched: Double = 0
    var gameTimer = Timer()
    var gyroTimer: Timer?
    var timerBool = false

    var i = 0
    

    
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var playAgain: UIButton!
        
        let h = 0
        var timer: Timer?
        var timer2: Timer?
        var timer3: Timer?
        var correct = 0
        var wrong = 0
        var normal = 0
        var wrongPoints = 0
        var correctPoints = 0
        var checkDone = false
        var count = 5 // change for time
        let gameTime = 5 // change for time
        let countConstant = 5 //change for time
        var numGuesses = -1
        var wrongArr: [String] = []
        var corrArr: [String] = []
        var guessArr: [String] = []
    
    @IBOutlet weak var redView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    var Decks: [Deck] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionIndexColor = UIColor.blue
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.isScrollEnabled = true
        tableView.allowsSelection = false
      
        
        tableView.isHidden = false

        
        
        tableView.bounces = false
        print("count is \(currentCat.count)")
        
        redView.layer.cornerRadius = 10
        tableView.layer.cornerRadius = 10
        
        gameLabel.transform = CGAffineTransform(rotationAngle: (-.pi/2))
        timerLabel.transform = CGAffineTransform(rotationAngle: (-.pi/2))
        playAgain.transform = CGAffineTransform(rotationAngle: (-.pi/2))
        tableView.transform = CGAffineTransform(rotationAngle: (-.pi/2))
        
        tableView.frame = CGRect(x: (100), y: 100, width: 233, height: 173)
        
        playAgain.bringSubviewToFront(self.view)
       
        playAgain.isHidden = true
        
        print("start")
       
        motion.startDeviceMotionUpdates(using: .xTrueNorthZVertical)
        
        self.timerLabel?.text = "3"
        
        for j in 0..<currentCat.count
        {
            currentCat[j] = currentCat[j].components(separatedBy: " ").last!
            
            if currentCat[j].contains("\'") || currentCat[j].contains("\\'")
            {
          currentCat[j] = currentCat[j].replacingOccurrences(of: "\\'", with: "'", options: .literal, range: nil)
            
           currentCat[j] = currentCat[j].replacingOccurrences(of: "\'", with: "'", options: .literal, range: nil) // just in case
            }
            
            
        }
       currentCat.shuffle()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
        {
            self.timerLabel?.text = "2"
        }
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
        {
            self.timerLabel?.text = "1"
        }
    
       /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0)
        {
            self.timerLabel?.text = ""
            self.gameLabel?.text = "Place your phone on your forehead"
            self.timer2 = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: (#selector(SecondViewController.check)), userInfo: nil, repeats: true)
         }
        */

    }
    
    //////////////////////////////////////////////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return guessArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let currentDeck = Decks[indexPath.row]
        
       
        cell.textLabel?.text = currentDeck.name
        if wrongArr.contains(currentDeck.name)
        {
            cell.backgroundColor = UIColor.red
        }
        
        else
        {
            cell.backgroundColor = UIColor.green
        }
        
        
        return cell
        
    }
    
    
    ///////////////////////////////////////////////////
    
    
    override var prefersStatusBarHidden: Bool
    { return true }



    @objc func countdown()
    {
        count -= 1
        timerLabel.text! = "\(count)"
        print(count)
    
        
        if count <= 0
        {
            timer?.invalidate()
            endStuff()
            count = countConstant //change this to match var count. NOTE: dont add parameters to the function, you cant change them in the countdownTimer
        }
    }
    
    
    func countdownTimer() //this is the function to call to do countdown stuff
    {
        timer3 = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    
    //start at 60, end at 140
    @objc func updateLabel() {
        print(timerLabel.text!)
        if timerLabel.text! == "0"
    {
    print("should end")
            endStuff()
     }
        let roll = (((motion.deviceMotion?.attitude.roll)!) * 180 / .pi)
        //let roll = 25
        
        //let r: String = String(format: "%.2f", roll) //in case of debugging
        
        
        //tilt up
        if Int(roll) > -46 && Int(roll) < 30
        {
            redView.backgroundColor = UIColor.red
            normal = 0
            wrong += 1
            if wrong == 1
            {
                wrongPoints += 1
                vibrate()
                self.gameLabel.text = "-1"
                numGuesses += 1
                wrongArr.append(currentCat[i-1])
                guessArr.append(currentCat[i-1])
                print("num guess \(numGuesses+1)")
                // this makes stuff happen once when phone is tilted up
            }
            
        }
        
        
        //tilt normal, set stuff to default?
        if Int(roll) > 59 && Int(roll) < 98
        {
            redView.backgroundColor = UIColor.blue
            correct = 0
            wrong = 0
            print("correct \(corrArr)")
            print("wrong \(wrongArr)")
            
            if numGuesses == currentCat.count-1
            {
                self.endStuff()
            }
            
            
            else if numGuesses < currentCat.count
            {
           
                normal += 1
                if normal == 1
                {
                    self.gameLabel.text = ("Mr/Ms/Mrs/Dr.\n \(currentCat[i])") //change text to word name
                    i += 1
                }
            }
            
        }
        
        
        //tilt down
        if Int(roll) > 149
        {
            redView.backgroundColor = UIColor.green
           normal = 0
            
            correct += 1
            if correct == 1
            {
                vibrate()
                correctPoints += 1
                self.gameLabel.text = "+1"
                numGuesses += 1
                corrArr.append(currentCat[i-1])
                guessArr.append(currentCat[i-1])
                print("num guess \(numGuesses+1)")
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
       //let roll = 76
        
        
            if roll > 75 && roll < 97
                {
                checkDone = true
                timer2?.invalidate() //stops the check if phone is in correct position
                countdownTimer() //timer
                redView.backgroundColor = UIColor.blue
               self.gameLabel.text = ("Mr/Ms/Mrs/Dr. \n \(currentCat[0])")
               vibrate()
                //the method below happens the frame before the game starts
                self.timerLabel.text = "\(count)"
                timerFunc()
                }
    }
    //present modally
    //fulslcreen
    //same as destination
    
    @IBAction func dismissView(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
  func endStuff()
    {
        self.timer?.invalidate()
        self.timer3?.invalidate() //countdown
        self.redView?.backgroundColor = UIColor.blue
        self.gameLabel?.text = "Correct: \(self.correctPoints)\n Wrong: \(self.wrongPoints)"
        self.timerLabel?.text = ""
        self.playAgain.isHidden = false
        tableView.isHidden = false
        
               if guessArr.isEmpty == false
        {
        for j in 0...guessArr.count-1
        {
           
            Decks.append(Deck(name: "\(guessArr[j])"))
            tableView.reloadData()
            
            
        }
        }
        tableView.reloadData()
        //print("table view cells \(String(describing: tableView.indexPathsForVisibleRows![0]))")

        self.vibrate()
        self.vibrate()
    }
    

    

}

/*
 self.navigationController?.popToRootViewController(animated: true)

print("hit")
 */

