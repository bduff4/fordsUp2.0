//
//  ViewController.swift
//  fordsUp
//
//  Created by Brennan Duff on 3/14/22.
//
//test2
import UIKit
import SwiftSoup


class ViewController: UIViewController
{
    var chathum: [String] = []
    var chestnutwald: [String] = []
    var coopertown: [String] = []
    var lynnewood: [String] = []
    var manoa: [String] = []
    var ms: [String] = []
    var hs: [String] = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool)
    {
        parse(urlString: "https://www.haverford.k12.pa.us/home-chatham-park/directory", toArray: "chathum")
        
        parse(urlString: "https://www.haverford.k12.pa.us/home-chestnutwold/directory", toArray: "chestnutwold"); print("chestnutwold words are \(chestnutwald)")
      
        parse(urlString: "https://www.haverford.k12.pa.us/home-coopertown/directory",  toArray: "coopertown"); print("coopertown words are \(coopertown)")
     
        parse(urlString: "https://www.haverford.k12.pa.us/home-lynnewood/directory",  toArray: "lynnewood"); print("lynnewood words are \(lynnewood)")
     
        parse(urlString: "https://www.haverford.k12.pa.us/home-manoa/directory", toArray: "manoa"); print("manoa words are \(manoa)")
        
        parse(urlString: "https://www.haverford.k12.pa.us/home-middle-school/directory",  toArray: "ms"); print("ms words are \(ms)")
        
        parse(urlString: "https://www.haverford.k12.pa.us/home-high-school/directory",  toArray: "hs"); print("hs words are \(hs)")
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
    

