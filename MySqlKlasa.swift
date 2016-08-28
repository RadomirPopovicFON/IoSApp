//
//  SqlKlasa.swift
//  RadSaBazom
//
//  Created by Radomir Popovic on 3.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import UIKit

class MySqlKlasa {
    
    static func insert(comment:Komentar){
        
//        $nazivOsobe = $_POST['nazivOsobe'];
//        $komentar = $_POST['komentar'];
//        $brojLajkova = $_POST['brojLajkova'];
//        $brojDislajkova = $_POST['brojDislajkova'];
//        $VestID = $_POST['VestID'];
//        
        //let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost:8888/swift/post.php")!)//localhost
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://multiplaskleroza.org.rs/postMobRacunarstvo.php")!)
        request.HTTPMethod = "POST"
        var postString = "nazivOsobe="+comment.nazivOsobe+"&komentar="+comment.komentar
        postString+="&brojLajkova="+String(comment.brojLajkova)
        postString+="&brojDislajkova="+String(comment.brojDislajkova)+"&VestID="+String(comment.vest.id)
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    
    static func get(tabela:String,whereUslov:String="",limit:String="") -> [Tabela]{
        
        var instance:[Tabela]=[]
        print("where uslov: \(whereUslov)")
        var upit:String = "http://multiplaskleroza.org.rs/selectMobRacunarstvo.php?tabela="+tabela
        
        if whereUslov != ""{
            if whereUslov.containsString("idVest") {
                upit+="&"+whereUslov
            }
            else{
            upit+="&id="+whereUslov;
            }
            
        }
        if limit != ""{
            upit+="&limit=\(limit)"
        }
        
        print("Upit glasi: "+upit)
        print("________")
        let url = NSURL(string: upit)
        let data = NSData(contentsOfURL: url!)
        
        
        //AKO NEMA INTERNETA
        if data==nil {return [];}
        
        
        //AKO JE PRAZNO
        
        
        
        
        var values = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
        
        
        if values.count==0 {return [];}
        
        
        if tabela == "Kategorija" {
            
            for index in 0...values.count-1 {
                
            
                    let idKat = Int(values[index]["idKategorija"]!!.intValue)
                    let kategorija = String(values[index]["nazivKategorije"]!!)
                    let podkategorija = String(values[index]["nazivPodkategorije"]!!)
                    let instanca = Kategorija(id: idKat, nazivKategorije: kategorija, nazivPodKategorije: podkategorija)
                
                    instanca.description()
                
                    instance.append(instanca)
            }
        }
        if tabela == "Komentar" {
            
                   for index in 0...values.count-1 {
                    
                    let idKom = Int(values[index]["idKomentar"]!!.intValue)
                    let nazivOsobe = String(values[index]["nazivOsobe"]!!)
                    let k = String(values[index]["komentar"]!!)
                    let brojLajkova = Int(values[index]["brojLajkova"]!!.intValue)
                    let brojDislajkova = Int(values[index]["brojDislajkova"]!!.intValue)
                    let vestId = Int(values[index]["VestID"]!!.intValue)
                    
                    
                    
                    let idVest = Int(values[index]["idKomentar"]!!.intValue)
                    let nn = String(values[index]["naslov"]!!)
                    let t = String(values[index]["text"]!!)
                    let d = String(values[index]["datumPostavljanja"]!!)
                    let s = String(values[index]["slikaNaServeru"]!!)
                    
                    
                    let idKat = Int(values[index]["idKategorija"]!!.intValue)
                    let kategorija = String(values[index]["nazivKategorije"]!!)
                    let podkategorija = String(values[index]["nazivPodkategorije"]!!)
                    
                    let instancaKategorije = Kategorija(id: idKat, nazivKategorije: kategorija, nazivPodKategorije: podkategorija)
                    let instancaVest = Vest(id: idVest, naslov: nn, text: t, datumPostavljanja: d, kategorija: instancaKategorije,slika: s)

                  
                    
                    
                    let instanca = Komentar(id: idKom, nazivOsobe: nazivOsobe, komentar: k, brojLajkova: brojLajkova, brojDislajkova: brojDislajkova, vest: instancaVest)
                    
                    instance.append(instanca)
                }
            
            }
            if tabela == "Vest"
            {
                for index in 0...values.count-1 {
                
                    let idVest = Int(values[index]["idVest"]!!.intValue)
                    let n = String(values[index]["naslov"]!!)
                    let t = String(values[index]["text"]!!)
                    let d = String(values[index]["datumPostavljanja"]!!)
                    let s = String(values[index]["slikaNaServeru"]!!)
                    let idKat = Int(values[index]["idKategorija"]!!.intValue)
                    let kategorija = String(values[index]["nazivKategorije"]!!)
                    let podkategorija = String(values[index]["nazivPodkategorije"]!!)
                    let instancaKategorije = Kategorija(id: idKat, nazivKategorije: kategorija, nazivPodKategorije: podkategorija)
                    
                    let instanca = Vest(id: idVest, naslov: n, text: t, datumPostavljanja: d, kategorija: instancaKategorije,slika: s)
                    
                    instance.append(instanca)
                    
                    
                }
            }
        
        
        return instance
    }
    
    
    static func delete(){
        let request = NSMutableURLRequest(URL: NSURL(string: "http://multiplaskleroza.org.rs/deleteMobRacunarstvo")!)
        request.HTTPMethod = "POST"
        let postString = "id=13&kat=kategorija1&podkat=podkategorija1"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    
    static func update(lajkuje:Bool,id:Int){
        let request = NSMutableURLRequest(URL: NSURL(string: "http://multiplaskleroza.org.rs/updateMobRacunarstvo.php")!)
        request.HTTPMethod = "POST"
        
        
        var postString = "idKomentar="+String(id)
        if lajkuje {postString+="&lajkuje="+"DA"}
        else {postString+="&lajkuje="+"NE"}
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            print("Upit glasi: \(responseString)")
        }
        task.resume()
    }
//
//    static func get(tabela:String,whereUslov:String="") -> [Tabela]{
//        
//        var instance:[Tabela]=[]
//        print("where uslov: \(whereUslov)")
//        var upit:String = "https://swift-baza-radomirpopovic.c9users.io/select.php?tabela="+tabela
//        
//        if whereUslov != ""{
//            if whereUslov.containsString("idVest") {
//                upit+="&"+whereUslov
//            }
//            else{
//                upit+="&id="+whereUslov;
//            }
//            
//        }
//        
//        let request = NSMutableURLRequest(URL: NSURL(string: upit)!)
//        request.HTTPMethod = "GET"
//        
//        
//        
//        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
//            guard error == nil && data != nil else {                                                          // check for fundamental networking error
//                print("error=\(error)")
//                return
//            }
//            
//            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
//                print("statusCode should be 200, but is \(httpStatus.statusCode)")
//                print("response = \(response)")
//            }
//            
//            let httpResponse = response as! NSHTTPURLResponse!
//            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            var data: NSData = responseString!.dataUsingEncoding(NSUTF8StringEncoding)!
//            var values = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSArray
//            if(values.count==0){
//                return 
//            }
//            if tabela == "Kategorija" {
//                
//                for index in 0...values.count-1 {
//                    
//                    
//                    let idKat = Int(values[index]["idKategorija"]!!.intValue)
//                    let kategorija = String(values[index]["nazivKategorije"]!!)
//                    let podkategorija = String(values[index]["nazivPodkategorije"]!!)
//                    let instanca = Kategorija(id: idKat, nazivKategorije: kategorija, nazivPodKategorije: podkategorija)
//                    
//                    instanca.description()
//                    
//                    instance.append(instanca)
//                }
//            }
//            if tabela == "Komentar" {
//                
//                for index in 0...values.count-1 {
//                    
//                    let idKom = Int(values[index]["idKomentar"]!!.intValue)
//                    let nazivOsobe = String(values[index]["nazivOsobe"]!!)
//                    let k = String(values[index]["komentar"]!!)
//                    let brojLajkova = Int(values[index]["brojLajkova"]!!.intValue)
//                    let brojDislajkova = Int(values[index]["brojDislajkova"]!!.intValue)
//                    let vestId = Int(values[index]["VestID"]!!.intValue)
//                    
//                    
//                    
//                    let idVest = Int(values[index]["idKomentar"]!!.intValue)
//                    let nn = String(values[index]["naslov"]!!)
//                    let t = String(values[index]["text"]!!)
//                    let d = String(values[index]["datumPostavljanja"]!!)
//                    let s = String(values[index]["slikaNaServeru"]!!)
//                    
//                    
//                    let idKat = Int(values[index]["idKategorija"]!!.intValue)
//                    let kategorija = String(values[index]["nazivKategorije"]!!)
//                    let podkategorija = String(values[index]["nazivPodkategorije"]!!)
//                    
//                    let instancaKategorije = Kategorija(id: idKat, nazivKategorije: kategorija, nazivPodKategorije: podkategorija)
//                    let instancaVest = Vest(id: idVest, naslov: nn, text: t, datumPostavljanja: d, kategorija: instancaKategorije,slika: s)
//                    
//                    
//                    
//                    
//                    let instanca = Komentar(id: idKom, nazivOsobe: nazivOsobe, komentar: k, brojLajkova: brojLajkova, brojDislajkova: brojDislajkova, vest: instancaVest)
//                    
//                    instance.append(instanca)
//                }
//                
//            }
//            if tabela == "Vest"
//            {
//                for index in 0...values.count-1 {
//                    
//                    let idVest = Int(values[index]["idVest"]!!.intValue)
//                    let n = String(values[index]["naslov"]!!)
//                    let t = String(values[index]["text"]!!)
//                    let d = String(values[index]["datumPostavljanja"]!!)
//                    let s = String(values[index]["slikaNaServeru"]!!)
//                    let idKat = Int(values[index]["idKategorija"]!!.intValue)
//                    let kategorija = String(values[index]["nazivKategorije"]!!)
//                    let podkategorija = String(values[index]["nazivPodkategorije"]!!)
//                    let instancaKategorije = Kategorija(id: idKat, nazivKategorije: kategorija, nazivPodKategorije: podkategorija)
//                    
//                    let instanca = Vest(id: idVest, naslov: n, text: t, datumPostavljanja: d, kategorija: instancaKategorije,slika: s)
//                    
//                    instanca.description()
//                    
//                    instance.append(instanca)
//                    
//                    
//                }
//            }
//            
//            
//        }
//        task.resume()
//        
//        sleep(3)
//        
//        //print(instance.count)
//        return instance
//        
//        
//    
//
//    }

    
}