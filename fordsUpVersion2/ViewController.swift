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


var chathum: [String] = []
let chathumD = []
var chestnutwald: [String] = []

var coopertown: [String] = []
let coopertownD = ["Sharon Auerbach", "Allison Bahleda", "Kristen Bilotta", "Kimberly Bohrer", "Beth Brawley", "Melissa Caiazzo", "Alejandro Camacho", "Jane Castner", "April Chester", "Jennifer Corcoran", "Susan Coyne", "Dominique DiPietro", "Nicole Dolski", "Janet Fastuca", "Megan Fore", "Lauren Gallagher", "Shelleyann Greenberg", "Rachel Gutman", "Kristine Heery", "Sharon Jackson", "Kimberly Kennedy", "Suzanne Kintzley", "Lauren Lacourte", "Francesca Livi", "Carole Loro", "Heather Markland", "Elizabeth Mastrocola", "Caitlin McCabe", "Jessica Mendez", "Jennifer Morris", "Deirdre Mulhern", "Stacey O\'Brien", "Emily O\'Neill", "Elizabeth Quinn", "Stephanie Reilly", "Jennifer Reimer", "Tonya Rodenbach", "Carolyn Russo", "Rebecca Schillinger", "Heather Schwerdtfeger", "Andrew Shanefield", "Jennifer Sheridan", "Luke Sullivan", "Amy Todd", "Sacoya Wesley", "Marisa Woodworth"]
var lynnewood: [String] = []

var manoa: [String] = []
var ms: [String] = ["Mr. Horan", "Ms. Kim", "Ms. Wingood", ]
var hs: [String] = ["Mr. Marron", "Mr. Walter", "Mrs. Grady", "Mr. Fidler", "Mr. Grabias", "Mr. Corsi", "Mr. Berardoni"]
var currentCat: [String] = []
var internetCheck: Timer = Timer()
var connected = false
var conCount = 0
var conCount2 = 0



class ViewController: UIViewController
{
  
   
    let alert = UIAlertController(title: "Waiting to connect", message: "This won't take long \n(note: this app requires an internet connection)", preferredStyle: .alert)
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
        
        present(alert, animated: true, completion: nil)
        
        
    }

    override func viewDidAppear(_ animated: Bool)
    {
       
    
    
        
        parse(urlString: "https://www.haverford.k12.pa.us/home-chatham-park/directory", toArray: "chathum")
        
        parse(urlString: "https://www.haverford.k12.pa.us/home-chestnutwold/directory", toArray: "chestnutwold")
        parse(urlString: "https://www.haverford.k12.pa.us/home-coopertown/directory",  toArray: "coopertown")
     
        parse(urlString: "https://www.haverford.k12.pa.us/home-lynnewood/directory",  toArray: "lynnewood")
        parse(urlString: "https://www.haverford.k12.pa.us/home-manoa/directory", toArray: "manoa")
        
        parse(urlString: "https://www.haverford.k12.pa.us/home-middle-school/directory",  toArray: "ms")
        
        parse(urlString: "https://www.haverford.k12.pa.us/home-high-school/directory",  toArray: "hs")
        
        internetCheck = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: (#selector(ViewController.waitForInternet)), userInfo: nil, repeats: true)
        
    }
    
    @objc func waitForInternet()
    {
       
      
        if chathum.count > 5 && chestnutwald.count > 5 && coopertown.count > 5 && lynnewood.count > 5 && manoa.count > 5 && ms.count > 5 && hs.count > 5
        {
            connected = true
           
            
            alert.dismiss(animated: true, completion: nil)
           internetCheck.invalidate()
           print(coopertown)
            coopertown.append(contentsOf: coopertownD)
            
            
            print(chathum)
            
            print(chestnutwald)
            print(lynnewood)
            print(manoa)
            print(ms)
            print(hs)
            
            
            
            
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
                    
                    if toArray == "chathum"
                    {chathum.append(contentsOf: names)}
                    
                    else if toArray == "chestnutwold"
                    {chestnutwald.append(contentsOf: names)}
                    
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
    


