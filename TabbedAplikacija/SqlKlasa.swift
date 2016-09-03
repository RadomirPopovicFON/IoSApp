//
//  SqlKlasa.swift
//  RadSaBazom
//
//  Created by Radomir Popovic on 3.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration


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
    static func napraviTabelu(){
        


         let dbCommandKreiraj1 : String = "CREATE TABLE `Kategorija` (`idKategorija` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,`nazivKategorije` varchar(50) NOT NULL,`nazivPodkategorije` varchar(50) NOT NULL);"
        let dbCommandKreiraj2 : String = "CREATE TABLE `Vest` (`idVest` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,`naslov` varchar(100) NOT NULL,`text` varchar(1200) NOT NULL,`datumPostavljanja` date NOT NULL,`slikaNaServeru` varchar(100) NOT NULL,`idKategorije` int(50) NOT NULL,FOREIGN KEY (`idKategorije`) REFERENCES `Kategorija` (`idKategorija`))";
        let dbCommandKreiraj3 : String = "CREATE TABLE `Komentar` (`idKomentar` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,`nazivOsobe` varchar(50) NOT NULL,`komentar` varchar(200) NOT NULL,`brojLajkova` int(50) NOT NULL,`brojDislajkova` int(50) NOT NULL,`VestID` int(50) NOT NULL,FOREIGN KEY (`VestID`) REFERENCES `Vest` (`idVest`))";
        
        izvrsiUpit(dbCommandKreiraj1)
        izvrsiUpit(dbCommandKreiraj2)
        izvrsiUpit(dbCommandKreiraj3)

        
        
        let dbCommandInsertKategorija1 : String = "INSERT INTO Kategorija('idKategorija','nazivKategorije','nazivPodkategorije') VALUES (1,'Glavna','Svet');";
        let dbCommandInsertKategorija2 : String = "INSERT INTO Kategorija('idKategorija','nazivKategorije','nazivPodkategorije') VALUES (2,'Glavna','Politika');";
        let dbCommandInsertKategorija3 : String = "INSERT INTO Kategorija('idKategorija','nazivKategorije','nazivPodkategorije') VALUES (3,'Glavna','Kultura');"
        let dbCommandInsertKategorija4 : String = "INSERT INTO Kategorija('idKategorija','nazivKategorije','nazivPodkategorije') VALUES (4,'Glavna','IT');";
        let dbCommandInsertKategorija5 : String = "INSERT INTO Kategorija('idKategorija','nazivKategorije','nazivPodkategorije') VALUES (5,'Sport','Kosarka');";
        let dbCommandInsertKategorija6 : String = "INSERT INTO Kategorija('idKategorija','nazivKategorije','nazivPodkategorije') VALUES (6,'Sport','Fudbal');"
        let dbCommandInsertKategorija7 : String = "INSERT INTO Kategorija('idKategorija','nazivKategorije','nazivPodkategorije') VALUES (7,'Sport','Odbojka');"
        let dbCommandInsertKategorija8 : String = "INSERT INTO Kategorija('idKategorija','nazivKategorije','nazivPodkategorije') VALUES (8,'Sport','Rukomet');"
        let dbCommandInsertKategorija9 : String = "INSERT INTO Kategorija('idKategorija','nazivKategorije','nazivPodkategorije') VALUES (9,'Sport','Vaterpolo');"
        let dbCommandInsertKategorija10 : String = "INSERT INTO Kategorija('idKategorija','nazivKategorije','nazivPodkategorije') VALUES (10,'Sport','Tenis');"
        let dbCommandInsertKategorija11 : String = "INSERT INTO Kategorija('idKategorija','nazivKategorije','nazivPodkategorije') VALUES (11,'Sport','Ostalo');"
        
         izvrsiUpit(dbCommandInsertKategorija1);
         izvrsiUpit(dbCommandInsertKategorija2);
         izvrsiUpit(dbCommandInsertKategorija3);
         izvrsiUpit(dbCommandInsertKategorija4);
         izvrsiUpit(dbCommandInsertKategorija5);
         izvrsiUpit(dbCommandInsertKategorija6);
         izvrsiUpit(dbCommandInsertKategorija7);
         izvrsiUpit(dbCommandInsertKategorija8);
         izvrsiUpit(dbCommandInsertKategorija9);
         izvrsiUpit(dbCommandInsertKategorija10);
         izvrsiUpit(dbCommandInsertKategorija11);
        
         var info: NSUserDefaults = NSUserDefaults.standardUserDefaults()
         info.setObject("OK", forKey: "Baza")
         info.synchronize()
        
//        izvrsiUpit(dbCommandInsertKategorija2);izvrsiUpit(dbCommandInsertKategorija3);izvrsiUpit(dbCommandInsertKategorija4);izvrsiUpit(dbCommandInsertKategorija5);izvrsiUpit(dbCommandInsertKategorija6);izvrsiUpit(dbCommandInsertKategorija7);izvrsiUpit(dbCommandInsertKategorija8);izvrsiUpit(dbCommandInsertKategorija9);izvrsiUpit(dbCommandInsertKategorija10);
        
        
    
    }
    
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
//        print("Upit je:")
//        print(upit)
//        print("Tabela je:")
//        print(tabela)
        
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
            //print("Radi li "+tabela.characters.split(" ").map(String.init)[0])
            
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
        else { print("bag prepare"); print("Upit: \(upit)") }
        sqlite3_finalize(getStatement)
        sqlite3_close(db)
        
        
        return instanceTabele;
        
    }
    
    
    static func otvoriBazu() -> COpaquePointer{
        var db:COpaquePointer = nil
        if sqlite3_open(url.absoluteString,&db) == SQLITE_OK{
            
            //print("Uspesno otvorio bazu: \(url.absoluteString)")
            
        }
        else { print("Unable to open database" )}
        return db
    }
    
    static func daLiPostojiBaza() -> Bool {
        var db:COpaquePointer = nil
        if sqlite3_open(url.absoluteString,&db) == SQLITE_OK{
            
            return true
        }
        return false
    }
    static func izvrsiUpit(upit:String){
        var upitStatement: COpaquePointer = nil
        let db: COpaquePointer = SqlKlasa.otvoriBazu()
        
        //print("Upit glasi: \(upit)")
        if sqlite3_prepare_v2(db, upit, -1, &upitStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(upitStatement) == SQLITE_DONE{
                print("Upit izvrsen: \(upit)")
            }
            else {
                //print("Nije mogao izvrsiti upit \(upit)), prepare:\(sqlite3_prepare_v2(db, upit, -1, &upitStatement, nil)), step: \(sqlite3_step(upitStatement))")
                //print("Vest postoji vec u bazi telefona :)")
                print("Upit nije izvrsen - verovatno se ubacuje vest koja vec postoji")
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
    
    static func daLiImaKonekcije() -> Bool {
        
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
                SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
            }
            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
                return false
            }
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            return (isReachable && !needsConnection)
        
        
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
                print("ipak ne")
            }
        }).resume()
        
    }
    static func inicijalizujNSUSERDEF(ipAdresa:String){
        
        var info: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        
        if let key = NSUserDefaults.standardUserDefaults().objectForKey("ip"){
            print("Nije nul1")
            return;
        }
        
        
        print("Null je ")
        print("breakpoint2");
        
        
        //let adresa:String? = String(info.objectForKey("ip")!)
        
        
        
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