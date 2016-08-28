//
//  Tabela.swift
//  TabbedAplikacija
//
//  Created by Radomir Popovic on 3.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import UIKit

class Tabela {
    
    static func stampajNiz(niz:[Tabela]){
        
        for column in niz {
            
            let tip: String = String(column.dynamicType)
            let tipKategorija: String = "Kategorija"
            let tipVest: String = "Vest"
            let tipKomentar: String = "Komentar"
            
            if tip == tipKategorija {
                //print("vrednost: \(column)")
                
                let k: Kategorija = column as! Kategorija
                k.description()
            }
            
            if tip == tipVest {
                //print("vrednost: \(column)")
                var v: Vest = column as! Vest
                v.description()
            }
            if tip == tipKomentar {
                //print("vrednost: \(column)")
                var kom: Komentar = column as! Komentar
                kom.description()
            }
        }
    }
    func description() -> String {
        return "Tabela"
    }
    
    
}

class Vest:Tabela {
    
    var id:Int = 0
    var naslov:String = ""
    var text:String=""
    var datumPostavljanja:String = ""
    var kategorija:Kategorija
    var slika:String = ""
    
    init(id:Int, naslov:String, text:String, datumPostavljanja: String,kategorija:Kategorija,slika:String){
        self.id = id
        self.naslov = naslov
        self.text = text
        self.datumPostavljanja=datumPostavljanja
        self.kategorija=kategorija
        self.slika = slika
    }
    
    override func description() -> String {
        print("Id: \(id), naslov: \(naslov), text: \(text), datum: \(datumPostavljanja), kategorija: \(kategorija.id),slika: \(slika)")
        return "Id: \(id), naslov: \(naslov), text: \(text), datum: \(datumPostavljanja), kategorija: \(kategorija),slika: \(slika)"
        
    }
    
}

class Komentar:Tabela {
    
    var id:Int = 0
    var nazivOsobe:String = ""
    var komentar:String=""
    var brojLajkova:Int = 0
    var brojDislajkova:Int = 0
    var vest:Vest
    
    init(id:Int, nazivOsobe:String, komentar:String, brojLajkova: Int, brojDislajkova:Int, vest:Vest){
        self.id = id
        self.nazivOsobe = nazivOsobe
        self.komentar = komentar
        self.brojLajkova=brojLajkova
        self.brojDislajkova=brojDislajkova
        self.vest=vest
    }
    
    init(nazivOsobe:String, komentar:String, vest:Vest){
        self.nazivOsobe = nazivOsobe
        self.komentar = komentar
        self.vest=vest
    }
    
    override func description() -> String {
        print("id: \(id), osoba: \(nazivOsobe), komentar: \(komentar), lajkovi: \(brojLajkova), dislajkovi: \(brojDislajkova), vestId: \(vest.id)")
        return "id: \(id), osoba: \(nazivOsobe), komentar: \(komentar), lajkovi: \(brojLajkova), dislajkovi: \(brojDislajkova), vestId: \(vest.id)"
    }
}

class Kategorija:Tabela {
    
    var id:Int = 0
    var nazivKategorije:String = ""
    var nazivPodKategorije:String=""
    
    init(id:Int, nazivKategorije:String, nazivPodKategorije: String){
        self.id = id
        self.nazivKategorije = nazivKategorije
        self.nazivPodKategorije = nazivPodKategorije
    }
    override func description() -> String {
        print("Id: \(id), kategorija: \(nazivKategorije), podKategorija:\(nazivPodKategorije)")
        return "Id: \(id), kategorija: \(nazivKategorije), podKategorija:\(nazivPodKategorije)"
    }
    
}