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
var lynnewood: [String] = ["name Fairman", "name Mcgilvery", "name Ardoline", "name Bond-Farrel", "name Bush", "name Doyle", "name Elko", "name Ferraro", "name Grahm-Popiel", "name Greenberg", "name Isen", "name Kelly", "name Kofsky", "name McAndrews", "name Pennoni", "name Shanefield", "name Sherbinko"]
//16
var chatham: [String] = ["name Cohan", "name Mallam", "name Schoppet", "name Whitehead", "name Cooke", "name Genstein", "name Greenberg", "name Hickey", "name Guardiola", "name Krauter", "name MacCrory", "name Moore", "name Miroumand", "name O'Brien", "name Schaefer", "name Shanefield"]
//15
var chestnutwold: [String] = ["name McAnany", "name Pennoni", "name Corr", "name Greenberg", "name Kerrins", "name Reynolds", "name Recknagel", "name Shanefield", "name Sminkey"]
//8
var coopertown: [String] = ["name Loro", "name Mastrocola", "name Caiazzo", "name Coyne", "name Greenberg", "name Shanefield"]
//5
var manoa: [String] = ["name Bushey", "name Davidson", "name Hernandez", "name Herriot", "name Kilcullen", "name Ramoundos", "name Chase", "name Greenberg", "name Klock", "name Kulsik", "name Levin", "name Miller", "name Reynolds", "name Shanefield", "name Sterba", "name Sullivan", "name Turek", "name Welsh", "name Wishart"]
//18
var ms: [String] = ["name Horan", "name Kim", "name Wingood", "name Brocklesby", "name Crater", "name Finnegan", "name Naylor", "name Wagner", "name Cararelli", "name Langley", "name Ramos", "name Viola", "name Stump", "name Barber", "name DiMattia", "name Henrey", "name Hay", "name Meier", "name Finn", "name Tallon", "name Whitney"]
//20
var hs: [String] = ["name Marren", "name Walter", "name Grady", "name Fidler", "name Grabias", "name Corsi", "name Berardoni", "name Althouse", "name Brennan", "name Hart", "name Cunicelli", "name Latrano", "name Donaghy", "name Fein", "name Malligan", "name Smith", "name Withers", "name Donaghy"]
//16
var currentCat: [String] = []
var internetCheck: Timer = Timer()
var connected = false
var conCount = 0
var conCount2 = 0
var sel = -1
var test = 0

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var myDecks: [Deck] = []
    @IBOutlet weak var startButton: UIButton!
    var removeCount = 0
    @IBOutlet weak var myTableView: UITableView!

    let alert = UIAlertController(title: "Waiting to connect", message: "Restart app if this takes longer than 10 seconds \n(Note: For the best experience, please use an internet connection)", preferredStyle: .alert)
    
    var vcAppeared = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.myTableView.contentInset = UIEdgeInsets(top: -36, left: 0, bottom: 0, right: 0);

        myTableView.delegate = self
        myTableView.dataSource = self
        startButton.isEnabled = false
        startButton.tintColor = UIColor.systemBlue
        myTableView.sectionIndexColor = UIColor.blue
        myTableView.contentInsetAdjustmentBehavior = .never
        myTableView.isScrollEnabled = false
        
        
        present(alert, animated: true, completion: nil)
        
        
        vcAppeared += 1
        if vcAppeared == 1 //first time vc appears
        {
        
            let lynnewoodDeck = Deck(name: "Lynnewood", description: "", imageName: "lynnewood")
            myDecks.append(lynnewoodDeck)
        
        let  chathamDeck = Deck(name: "Chatham", description: "", imageName: "chatham")
        myDecks.append(chathamDeck)
        
        let chestnutwoldDeck = Deck(name: "Chestnutwold", description: "", imageName: "chestnutwold")
        myDecks.append(chestnutwoldDeck)
        
        let  coopertownDeck = Deck(name: "Coopertown", description: "", imageName: "coopertown")
        myDecks.append(coopertownDeck)
        
        let  manoaDeck = Deck(name: "Manoa", description: "", imageName: "manoa")
        myDecks.append(manoaDeck)
        
        let  msDeck = Deck(name: "Haverford Middle School", description: "", imageName: "ms")
        myDecks.append(msDeck)
        
        let  hsDeck = Deck(name: "Haverford High School", description: "", imageName: "hs")
        myDecks.append(hsDeck)
        
            internetCheck = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: (#selector(ViewController.waitForInternet)), userInfo: nil, repeats: true)
        }
        
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
        
        
        }
    }
    
    ////////////////////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDecks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
       
        let currentDeck = myDecks[indexPath.row]
        
        cell.textLabel?.text = currentDeck.name
        cell.detailTextLabel?.text = currentDeck.description
        cell.imageView?.image = UIImage(named: currentDeck.imageName)
        cell.imageView?.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        
        
        if cell.isSelected
        {
            cell.backgroundColor = UIColor.blue
        }
        
        return cell
        
    }
    
    let minRowHeight: CGFloat = 55.0

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tHeight = (myTableView.frame.height) - 35
            let temp = tHeight / CGFloat(myDecks.count)
            return temp > minRowHeight ? temp : minRowHeight
    }
    
    
    func addingToSelected(array: inout [String])
    {
        currentCat.removeAll()
        currentCat.append(contentsOf: array)
        print(array.first!)
        
        //print(array)
    }
    
    func removeAfterConnected(array: inout [String], remove: Int)
    {

            array.removeSubrange(0...remove)
        print(array.first!)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
        sel = indexPath.row
        print("selected row is \(indexPath.row)")
        startButton.isEnabled = true
        startButton.tintColor = UIColor.systemBlue
        if sel == 0
        {
            addingToSelected(array: &lynnewood)
        }

        else if sel == 1
        {
            addingToSelected(array: &chatham)
        }
        
        else if sel == 2
        {
            addingToSelected(array: &chestnutwold)
        }
        
        else if sel == 3
        {
            addingToSelected(array: &coopertown)
        }
        
        else if sel == 4
        {
            addingToSelected(array: &manoa)
        }
        
        else if sel == 5
        {
            addingToSelected(array: &ms)
        }
        
        else if sel == 6
        {
            addingToSelected(array: &hs)
        }
        
        
    }
    ///////////////////////////////////////////
    
    @objc func waitForInternet()
    {
        
        if chatham.count > 25 && chestnutwold.count > 25 && coopertown.count > 25 && lynnewood.count > 25 && manoa.count > 25 && ms.count > 25 && hs.count > 25
        {
            connected = true
           
            
            alert.dismiss(animated: true, completion: nil)
           
            
            removeAfterConnected(array: &lynnewood, remove: 16)
                       
            removeAfterConnected(array: &chatham, remove: 15)
                    
            removeAfterConnected(array: &chestnutwold, remove: 8)
                    
            removeAfterConnected(array: &coopertown, remove: 5)

            removeAfterConnected(array: &manoa, remove: 18)
                                    
            removeAfterConnected(array: &ms, remove: 20)

            removeAfterConnected(array: &hs, remove: 17)
            
            
            internetCheck.invalidate()
            
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
                    
                
                    
                     
                } catch {
                    print("error getting teacher names")
                }
                
                
                 
             }
            
            task.resume()
         }
        
    }
    


}
