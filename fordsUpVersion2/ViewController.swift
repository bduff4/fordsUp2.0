//
//  ViewController.swift
//  fordsUp
//
//  Created by Brennan Duff on 3/14/22.
//
//test2
import UIKit
import SwiftSoup
//commit
// 

// needs to be outside class
var chatham: [String] = ["Ellen Cohan", "Catherine Mallam", "Josephine Schoppet", "Jabari Whitehead"]
var chestnutwold: [String] = ["Jaclyn McAnany", "Kristie Pennoni"]
var coopertown: [String] = ["Carole Loro", "Elizabeth Mastrocola"]
var lynnewood: [String] = ["Sue Fairman", "Jillian Mcgilvery"]
var manoa: [String] = ["Regan Bushey", "Ryan Davidson", "Maria Hernandez", "Quinton Herriot", "Carolynne Kilcullen", "George Ramoundos"]
var ms: [String] = ["Mr. Horan", "Ms. Kim", "Ms. Wingood", ]
var hs: [String] = ["Mr. Marron", "Mr. Walter", "Mrs. Grady", "Mr. Fidler", "Mr. Grabias", "Mr. Corsi", "Mr. Berardoni"]
//var ms: [String] = ["name Horan", "name Kim", "name Wingood", "name Brocklesby", "name Crater", "name Finnegan", "name Naylor", "name Wagner", "name Cararelli", "name Langley", "name Ramos", "name Viola", "name Stump", "name Barber", "name DiMattia", "name Henrey", "name Hay", "name Meier", "name Finn", "name Tallon", "name Whitney"]
//var hs: [String] = ["name Marren", "name Walter", "name Grady", "name Fidler", "name Grabias", "name Corsi", "name Berardoni", "name Althouse", "name Brennan", "name Hart", "name Cunicelli", "name Latrano", "name Donaghy", "name Fein", "name Malligan", "name Smith", "name Withers"]
var currentCat: [String] = []
var internetCheck: Timer = Timer()
var connected = false
var conCount = 0
var conCount2 = 0



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
  
    
  
  
    var myDecks: [Deck] = []
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    let alert = UIAlertController(title: "Waiting to connect", message: "This won't take long \n(Note: For the best experience, please use an internet connection)", preferredStyle: .alert)
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        myTableView.delegate = self
        myTableView.dataSource = self
        
        present(alert, animated: true, completion: nil)
        
        let lynnewoodDeck = Deck(name: "Lynnewood", description: "teachers", imageName: "lynnewood")
        myDecks.append(lynnewoodDeck)
        
        let  chathamDeck = Deck(name: "Chatham", description: "teachers", imageName: "chatham")
        myDecks.append(chathamDeck)
        
        let chestnutwoldDeck = Deck(name: "Chestnutwold", description: "teachers", imageName: "chestnutwold")
        myDecks.append(chestnutwoldDeck)
        
        let  coopertownDeck = Deck(name: "Coopertown", description: "teachers", imageName: "coopertown")
        myDecks.append(coopertownDeck)
        
        let  manoaDeck = Deck(name: "Manoa", description: "teachers", imageName: "manoa")
        myDecks.append(manoaDeck)
        
        let  msDeck = Deck(name: "Haverford Middle School", description: "teachers", imageName: "ms")
        myDecks.append(msDeck)
        
        let  hsDeck = Deck(name: "Haverford High School", description: "teachers", imageName: "hs")
        myDecks.append(hsDeck)
        
    }

    override func viewDidAppear(_ animated: Bool)
    {
       
    
    
        
        parse(urlString: "https://www.haverford.k12.pa.us/home-chatham-park/directory", toArray: "chatham")
        
        parse(urlString: "https://www.haverford.k12.pa.us/home-chestnutwold/directory", toArray: "chestnutwold")
        parse(urlString: "https://www.haverford.k12.pa.us/home-coopertown/directory",  toArray: "coopertown")
     
        parse(urlString: "https://www.haverford.k12.pa.us/home-lynnewood/directory",  toArray: "lynnewood")
        parse(urlString: "https://www.haverford.k12.pa.us/home-manoa/directory", toArray: "manoa")
        
        parse(urlString: "https://www.haverford.k12.pa.us/home-middle-school/directory",  toArray: "ms")
        
        parse(urlString: "https://www.haverford.k12.pa.us/home-high-school/directory",  toArray: "hs")
        
        internetCheck = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: (#selector(ViewController.waitForInternet)), userInfo: nil, repeats: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDecks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
       
        let currentDeck = myDecks[indexPath.row]
        
        cell.textLabel?.text = currentDeck.name
        cell.detailTextLabel?.text = currentDeck.description
        cell.imageView?.image = UIImage(named: currentDeck.imageName)
        
        
        return cell
        
    }
    
    
    @objc func waitForInternet()
    {
       
      
        if chatham.count > 5 && chestnutwold.count > 5 && coopertown.count > 5 && lynnewood.count > 5 && manoa.count > 5 && ms.count > 5 && hs.count > 5
        {
            connected = true
           
            
            alert.dismiss(animated: true, completion: nil)
           internetCheck.invalidate()
          
            /*
            print(coopertown)
            coopertown.append(contentsOf: coopertownD)
            
            
            print(chathum)
            
            print(chestnutwald)
            print(lynnewood)
            print(manoa)
            print(ms)
            print(hs)
            */
            
            
            
        }
    
        else
        {
            connected = false
           conCount += 1
            if conCount == 1
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 20.0)
                {
                    self.alert.dismiss(animated: true, completion: nil)
                  
                    let alert = UIAlertController(title: "Error getting teacher data", message: "Using default data", preferredStyle: .alert)
                    
                    
                    let ok = UIAlertAction(title: "ok" , style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                    
                    //add arrays
                   
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    internetCheck.invalidate()
                }
            }
        }
    
    }
    
    func parse(urlString: String, toArray: String)
    {
        
        if let url = URL(string: urlString)
        {
            let task = URLSession.shared.dataTask(with: url)
            { [self] (data, response, error) in
                        //what
                 guard let data = data else { return }
                 let result = String(data: data, encoding: .utf8)!
                
                do {
                    let doc = try SwiftSoup.parse(result)
                    let names = try doc.select("a.fsConstituentProfileLink").map {
                        try $0.text()
                    }
                    
//                    DispatchQueue.main.async {
//                         // do stuff to the ui like update a label etc.  All that must be done on the main thread.
//                    }
                    
                    if toArray == "chatham"
                    {chatham.append(contentsOf: names)}
                    
                    else if toArray == "chestnutwold"
                    {chestnutwold.append(contentsOf: names)}
                    
                   else if toArray == "coopertown"
                    {coopertown.append(contentsOf: names)}
                    
                    else if toArray == "lynnewood"
                    {lynnewood.append(contentsOf: names)}
                    
                    else if toArray == "manoa"
                    {manoa.append(contentsOf: names)}
                    
                    else if toArray == "ms"
                    {ms.append(contentsOf: names)}
                    
                   else if toArray == "hs"
                    {hs.append(contentsOf: names)}
                    
                    //print("\(toArray)")
                     
                   //print("names are \(names)")
                    
                     
                } catch {
                    print("error getting teacher names")
                }
                
                // this is the String of the data.
                // print(String(data: data, encoding: .utf8)!)
                   // print(result)
                 // do stuff with the data
                 
             }
            
            task.resume()
         }
        
    }
    

    
    
    
    
}
    /*
     for i in 0...lynnewood.count-1
     {
 lynnewood[i] = lynnewood[i].replacingOccurrences(of: "\\", with: "")
 lynnewood[i] = lynnewood[i].replacingOccurrences(of: "D\'", with: "D'")
//chathum[i] = chathum[i].replacingOccurrences(of: "M", with: "D'")
        
     }
     print("lynnewood words are \(lynnewood)")
 }
     */
    


