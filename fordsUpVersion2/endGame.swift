//
//  endGame.swift
//  fordsUpVersion2
//
//  Created by david on 5/2/22.
//

import UIKit
import CoreMotion
import Foundation
import AudioToolbox
import SwiftSoup


class endGame: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var redView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 10
        tableView.sectionIndexColor = UIColor.blue
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.isScrollEnabled = true
        tableView.allowsSelection = false
        tableView.isHidden = false
        tableView.bounces = false
        redView.layer.cornerRadius = 10
        tableView.layer.cornerRadius = 10
        
        self.redView?.backgroundColor = UIColor.blue
        self.label?.text = "Correct: \(correctPoints)\n Wrong: \(wrongPoints)"
        
               if guessArr.isEmpty == false
        {
        for j in 0...guessArr.count-1
        {
           
            Decks.append(Deck(name: "\(guessArr[j])"))
            tableView.reloadData()
            
            
        }
        }
        tableView.reloadData()
        
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
    
    
    
    @IBAction func home(_ sender: UIButton)
    {
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
