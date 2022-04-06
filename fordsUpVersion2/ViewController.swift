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
var lynnewood: [String] = []
//16
var chatham: [String] = []
//15
var chestnutwold: [String] = []
//8
var coopertown: [String] = []
//5
var manoa: [String] = []
//18
var ms: [String] = []
//20
var hs: [String] = []
//16
var currentCat: [String] = []
var internetCheck: Timer = Timer()
var connected = false
var conCount = 0
var conCount2 = 0
var sel = -1


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var myDecks: [Deck] = []
    @IBOutlet weak var startButton: UIButton!
    var removeCount = 0
    
    
    @IBOutlet weak var myTableView: UITableView!

    let alert = UIAlertController(title: "Waiting to connect", message: "This won't take long \n(Note: For the best experience, please use an internet connection)", preferredStyle: .alert)
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myTableView.delegate = self
        myTableView.dataSource = self
    
        
        startButton.isEnabled = false
        startButton.tintColor = UIColor.systemBlue
        
        
        myTableView.sectionIndexColor = UIColor.blue
       
        lynnewood.append(contentsOf: ["name Fairman", "name Mcgilvery", "name Ardoline", "name Bond-Farrel", "name Bush", "name Doyle", "name Elko", "name Ferraro", "name Grahm-Popiel", "name Greenberg", "name Isen", "name Kelly", "name Kofsky", "name McAndrews", "name Pennoni", "name Shanefield", "name Sherbinko"])
        
        chatham.append(contentsOf: ["name Cohan", "name Mallam", "name Schoppet", "name Whitehead", "name Cooke", "name Genstein", "name Greenberg", "name Hickey", "name Guardiola", "name Krauter", "name MacCrory", "name Moore", "name Miroumand", "name O'Brien", "name Schaefer", "name Shanefield"])
        
        chestnutwold.append(contentsOf: ["name McAnany", "name Pennoni", "name Corr", "name Greenberg", "name Kerrins", "name Reynolds", "name Recknagel", "name Shanefield", "name Sminkey"])
        
        coopertown.append(contentsOf: ["name Loro", "name Mastrocola", "name Caiazzo", "name Coyne", "name Greenberg", "name Shanefield"])
        
        manoa.append(contentsOf: ["name Bushey", "name Davidson", "name Hernandez", "name Herriot", "name Kilcullen", "name Ramoundos", "name Chase", "name Greenberg", "name Klock", "name Kulsik", "name Levin", "name Miller", "name Reynolds", "name Shanefield", "name Sterba", "name Sullivan", "name Turek", "name Welsh", "name Wishart"])
        
        ms.append(contentsOf: ["name Horan", "name Kim", "name Wingood", "name Brocklesby", "name Crater", "name Finnegan", "name Naylor", "name Wagner", "name Cararelli", "name Langley", "name Ramos", "name Viola", "name Stump", "name Barber", "name DiMattia", "name Henrey", "name Hay", "name Meier", "name Finn", "name Tallon", "name Whitney"])
        
        hs.append(contentsOf: ["name Marren", "name Walter", "name Grady", "name Fidler", "name Grabias", "name Corsi", "name Berardoni", "name Althouse", "name Brennan", "name Hart", "name Cunicelli", "name Latrano", "name Donaghy", "name Fein", "name Malligan", "name Smith", "name Withers"])
        
        
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
        
        myTableView.isScrollEnabled = false
        
    }

    override func viewDidAppear(_ animated: Bool)
    {
        if connected == false
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
        
        
        
        if cell.isSelected
        {
            cell.backgroundColor = UIColor.blue
        }
        
        return cell
        
    }
    
    func addingToSelected(array: inout [String], remove: Int)
    {
        removeCount = 0
        print("array is \(array)")
        currentCat.removeAll()
        if connected == true && removeCount == 0
        {
            array.removeSubrange(0...remove)
            removeCount += 1
            print("new array is \(array)")
        }
        currentCat.append(contentsOf: array)
    print("current category list \(currentCat)")
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
        sel = indexPath.row
        print(indexPath.row)
        startButton.isEnabled = true
        startButton.tintColor = UIColor.systemBlue
        if sel == 0
        {
            addingToSelected(array: &lynnewood, remove: 16)
        }

        else if sel == 1
        {
            addingToSelected(array: &chatham, remove: 15)
        }
        
        else if sel == 2
        {
            addingToSelected(array: &chestnutwold, remove: 8)
        }
        
        else if sel == 3
        {
            addingToSelected(array: &coopertown, remove: 5)
        }
        
        else if sel == 4
        {
            addingToSelected(array: &manoa, remove: 18)
        }
        
        else if sel == 5
        {
            addingToSelected(array: &ms, remove: 20)
        }
        
        else if sel == 6
        {
            addingToSelected(array: &hs, remove: 16)
        }
        
        
    }
    
    
    @objc func waitForInternet()
    {
        
        if chatham.count > 25 && chestnutwold.count > 25 && coopertown.count > 25 && lynnewood.count > 25 && manoa.count > 25 && ms.count > 25 && hs.count > 25
        {
            connected = true
           
            
            alert.dismiss(animated: true, completion: nil)
           internetCheck.invalidate()
            print(chatham.count)
        }
        //
           conCount += 1
            if conCount == 1
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0)
                {
                    
                    if chatham.count < 25
                    {
                    self.alert.dismiss(animated: true, completion: nil)
                  
                    let alert = UIAlertController(title: "Error getting teacher data", message: "Using default data", preferredStyle: .alert)
                    
                    
                    let ok = UIAlertAction(title: "ok" , style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                    connected = false
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
    


