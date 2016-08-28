//
//  SqlKlasa.swift
//  RadSaBazom
//
//  Created by Radomir Popovic on 3.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import Foundation
import UIKit


extension NSDate
{
    convenience
    init(dateString:String) {
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "dd.MM.yyyy"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        let d = dateStringFormatter.dateFromString(dateString)!
        self.init(timeInterval:0, sinceDate:d)
    }
}


class SqlKlasa {
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let url = DocumentsDirectory.URLByAppendingPathComponent("tabbedAplikacija")
    
    static func stampaj() -> String{
        print("\(DocumentsDirectory)")
        return ("\(DocumentsDirectory)")
    }
//    static func napraviTabelu(){
//        
//        let dbCommandKreiraj : String = "CREATE TABLE Plivaci(ID INT PRIMARY KEY NOT NULL, Ime VARCHAR(50), Zemlja VARCHAR(50));"
//        let dbCommandUpisi : String = "INSERT INTO Plivaci VALUES (1,'Milorad','Srbija')"
//        
//        
//        //izvrsiUpit(dbCommandUpdate)
//    }
    
    static func stampajNiz2d(rows: [[String]])
    {
        for column in rows {
            for row in column {
                print("\(column) | \(row)")
            }
        }
    }
    static func stampajNiz1d(rows: [String])
    {
        for column in rows {
            print("vrednost: \(column)")
            
        }
    }

    
    static func vratiSve(tabela:String, whereUslov:String="") -> [Tabela] {
        var instanceTabele: [Tabela] = []
        
        
        var getStatement: COpaquePointer = nil
        let db: COpaquePointer = SqlKlasa.otvoriBazu()
 
        
        var upit:String = "SELECT * FROM "+tabela
        if whereUslov != "" {upit+=" WHERE "+whereUslov}
        print("Upit je:")
        print(upit)
        print("Tabela je:")
        print(tabela)
        
        if sqlite3_prepare_v2(db, upit, -1, &getStatement, nil) == SQLITE_OK{
            
            if tabela == "Kategorija"{
            while sqlite3_step(getStatement) == SQLITE_ROW{
                
                let idKat = Int(sqlite3_column_int(getStatement, 0))
                let kat = sqlite3_column_text(getStatement, 1)
                let kategorija = String.fromCString(UnsafePointer<CChar>(kat))!
                var podkat = sqlite3_column_text(getStatement, 2)
                let podkategorija = String.fromCString(UnsafePointer<CChar>(podkat))!
                let instanca = Kategorija(id: idKat, nazivKategorije: kategorija, nazivPodKategorije: podkategorija)
                
                instanceTabele.append(instanca)
                
            }
            }
            print("Radi li "+tabela.characters.split(" ").map(String.init)[0])
            
            if tabela == "Komentar INNER JOIN Vest ON Komentar.VestID = Vest.idVest INNER JOIN Kategorija ON Vest.idVest = Kategorija.idKategorija;" || tabela=="Komentar INNER JOIN Vest ON Komentar.VestID = Vest.idVest INNER JOIN Kategorija ON Vest.idVest = Kategorija.idKategorija"{
                while sqlite3_step(getStatement) == SQLITE_ROW{
                    var nizRed: [String] = []
                    
                    let idKom = Int(sqlite3_column_int(getStatement, 0))
                    let nazivOsobe = sqlite3_column_text(getStatement, 1)
                    let n = String.fromCString(UnsafePointer<CChar>(nazivOsobe))!
                    let komentar = sqlite3_column_text(getStatement, 2)
                    let k = String.fromCString(UnsafePointer<CChar>(komentar))!
                    let brojLajkova = Int(sqlite3_column_int(getStatement, 3))
                    let brojDislajkova = Int(sqlite3_column_int(getStatement, 4))
                    let vestId = Int(sqlite3_column_int(getStatement, 5))
                    
                    
                    
                    let idVest = Int(sqlite3_column_int(getStatement, 6))
                    let naslov = sqlite3_column_text(getStatement, 7)
                    let nn = String.fromCString(UnsafePointer<CChar>(naslov))!
                    let text = sqlite3_column_text(getStatement, 8)
                    let t = String.fromCString(UnsafePointer<CChar>(text))!
                    let datumPostavljanja = sqlite3_column_text(getStatement, 9)
                    let d = String.fromCString(UnsafePointer<CChar>(datumPostavljanja))!
                    let slika = sqlite3_column_text(getStatement, 10)
                    let s = String.fromCString(UnsafePointer<CChar>(slika))!
                    
                    
                    let idKat = Int(sqlite3_column_int(getStatement, 11))
                    let kat = sqlite3_column_text(getStatement, 12)
                    let kategorija = String.fromCString(UnsafePointer<CChar>(kat))!
                    var podkat = sqlite3_column_text(getStatement, 13)
                    let podkategorija = String.fromCString(UnsafePointer<CChar>(podkat))!
                    let instancaKategorije = Kategorija(id: idKat, nazivKategorije: kategorija, nazivPodKategorije: podkategorija)
                    
                    let instancaVest = Vest(id: idVest, naslov: nn, text: t, datumPostavljanja: d, kategorija: instancaKategorije,slika: s)
                    
                    
                    
                    
                    let instanca = Komentar(id: idKom, nazivOsobe: n, komentar: k, brojLajkova: brojLajkova, brojDislajkova: brojDislajkova, vest: instancaVest)
                    
                    instanceTabele.append(instanca)
                }
            }
            if tabela == "Vest INNER JOIN Kategorija ON Vest.idVest = Kategorija.idKategorija;" ||
            tabela == "Vest INNER JOIN Kategorija ON Vest.idKategorije = Kategorija.idKategorija" 
            {
                while sqlite3_step(getStatement) == SQLITE_ROW{
                    
                    
                    
                    let nizRed: [String] = []
                    
                    let idVest = Int(sqlite3_column_int(getStatement, 0))
                    let naslov = sqlite3_column_text(getStatement, 1)
                    let n = String.fromCString(UnsafePointer<CChar>(naslov))!
                    let text = sqlite3_column_text(getStatement, 2)
                    let t = String.fromCString(UnsafePointer<CChar>(text))!
                    let datumPostavljanja = sqlite3_column_text(getStatement, 3)
                    let d = String.fromCString(UnsafePointer<CChar>(datumPostavljanja))!
                    let slika = sqlite3_column_text(getStatement, 4)
                    let s = String.fromCString(UnsafePointer<CChar>(slika))!
                    
                    
                    let idKat = Int(sqlite3_column_int(getStatement, 6))
                    
                    let kat = sqlite3_column_text(getStatement, 7)
                    let kategorija = String.fromCString(UnsafePointer<CChar>(kat))!
                    let podkat = sqlite3_column_text(getStatement, 8)
                    let podkategorija = String.fromCString(UnsafePointer<CChar>(podkat))!
                    let instancaKategorije = Kategorija(id: idKat, nazivKategorije: kategorija, nazivPodKategorije: podkategorija)
//                    print("idKat : \(idKat)")
//                    print("kategorija : \(kategorija)")
//                    print("podKat : \(podkategorija)")

                    let instanca = Vest(id: idVest, naslov: n, text: t, datumPostavljanja: d, kategorija: instancaKategorije,slika: s)
                    
                    instanceTabele.append(instanca)
                    
                    
                }
            }
            
            
            
        }
        else { print("bag prepare") }
        sqlite3_finalize(getStatement)
        sqlite3_close(db)
        
        
        return instanceTabele;
        
    }
    
    
    static func otvoriBazu() -> COpaquePointer{
        var db:COpaquePointer = nil
        if sqlite3_open(url.absoluteString,&db) == SQLITE_OK{}
        else { print("Unable to open database" )}
        return db
    }
    static func sacuvajUBazi(vest:Vest){
        

        
        
        
        
        
    }
    static func izvrsiUpit(upit:String){
        var upitStatement: COpaquePointer = nil
        let db: COpaquePointer = SqlKlasa.otvoriBazu()
        
        print("Upit glasi: \(upit)")
        if sqlite3_prepare_v2(db, upit, -1, &upitStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(upitStatement) == SQLITE_DONE{
                
            }
            else {
                print("Nije mogao izvrsiti upit \(upit)), prepare:\(sqlite3_prepare_v2(db, upit, -1, &upitStatement, nil)), step: \(sqlite3_step(upitStatement))")
                
            }
            
        }
        else
        {
            print("Prepare deo propao")
        }
        sqlite3_finalize(upitStatement)
        sqlite3_close(db)
        
    }
    
    static func ubaciVesti(vesti:[Tabela]){
        
        var vest:Vest
        
        for index in 0...vesti.count-1 {
            //                        print("\(index).clan niza je \(niz[index])")
        vest = vesti[index] as! Vest
        
            
        let upit:String="INSERT INTO `Vest`(`idVest`, `naslov`, `text`, `datumPostavljanja`, `slikaNaServeru`, `idKategorije`) VALUES (\(vest.id),'\(vest.naslov)','\(vest.text)','\(vest.datumPostavljanja)','\(vest.slika)',\(vest.kategorija.id))"
        izvrsiUpit(upit)
        }
        
    }
    
    static func vratiMojIPAdresu(){
        
        var ipAdresa:String = ""
        
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let postEndpoint: String = "https://httpbin.org/ip"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: postEndpoint)!
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            // Read the JSON
            do {
                if let ipString = NSString(data:data!, encoding: NSUTF8StringEncoding) {
                    let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
                    let origin = jsonDictionary["origin"] as! String
                    ipAdresa = String(origin)
                    
                    print("Vasa adresa je :\(ipAdresa)")
                    
                   //inicijalizujNSUSERDEF(ipAdresa)
                    
                    inicijalizujNSUSERDEF(ipAdresa)
                    
                    
                    
                    
                    //NSUSER PREGLED
                    
//                    var info: NSUserDefaults = NSUserDefaults.standardUserDefaults()
//                    //info.arrayForKey(<#T##defaultName: String##String#>)
//                    
//                    let adresa:String = String(info.objectForKey("ip")!)
//                    print("adresa: \(adresa)")
//                    let niz:[Int] = info.arrayForKey(adresa) as! [Int]
//                    print(niz.count)
//                    print("niz: \(niz[niz.count-1])")
//                    
//                    for index in 0...niz.count-1 {
//                        print("\(index).clan niza je \(niz[index])")
//                    }
//
                    
                    
                    
                    
                }
                
            } catch {
                print("bad things happened")
            }
        }).resume()
        
    }
    static func inicijalizujNSUSERDEF(ipAdresa:String){
        
        var info: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let adresa:String? = String(info.objectForKey("ip")!)
        
        
        if !(adresa!.isEmpty){
            return;
        }
        
        
        
        
        var prazanNiz:[Int]=[]
        
        info.setObject(ipAdresa, forKey: "ip")
        info.setValue(prazanNiz, forKey: ipAdresa)
        print("Rezultat je: \(String(info.objectForKey("ip")!))")
        info.synchronize()
    }
    static func dodajKomentar(ip:Int) -> Bool{
        var info: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        let adresa:String = String(info.objectForKey("ip")!)
       
        var niz:[Int] = info.arrayForKey(adresa) as! [Int]
        print("niz")
        print(niz.count)
        if( niz.count != 0 ){
        for index in 0...niz.count-1 {
            
            print("index: \(index)")
            print("broj: \(niz[index])")
            
            if(niz[index]==ip){
                return false
            }
        }
        }
        
        niz.append(ip)
        info.setObject(niz, forKey: adresa)
        info.synchronize()
        return true
    }
    
    
}