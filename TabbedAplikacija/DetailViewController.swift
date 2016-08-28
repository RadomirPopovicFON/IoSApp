//
//  DetailViewController.swift
//  TabbedAplikacija
//
//  Created by Radomir Popovic on 3.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var skroler: UIScrollView!
    @IBOutlet weak var slika: UIImageView!
    @IBOutlet weak var kategorizacija: UILabel!
    @IBOutlet weak var naslov: UILabel!
    @IBOutlet weak var text: UITextView!
    
    var vest:Vest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Prima : \(vest.slika)")
        
        slika.contentMode = .ScaleAspectFit
        
        
        slika.image = UIImage(named: vest.slika)
        
        
        if let urlPR = NSURL(string: "http://multiplaskleroza.org.rs/slikeMobRac/\(vest.slika)") {
            if let data = NSData(contentsOfURL: urlPR) {
                slika.image = UIImage(data: data)
            }
        }
        
        
        slika.layer.cornerRadius = 20
        skroler.contentInset = UIEdgeInsetsMake(0, 0, 200, 0)
        print("\(vest.kategorija.nazivKategorije),\(vest.kategorija.id),\(vest.kategorija.nazivPodKategorije)")
        self.kategorizacija.text = vest.kategorija.nazivKategorije+">"+vest.kategorija.nazivPodKategorije
        self.naslov.text = vest.naslov
        self.text.text = vest.text
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "prikaziKomentar" {
            
            let kvc = segue.destinationViewController as! KomentariTableViewController
            
            
           // var listaKomentara: [Tabela] = SqlKlasa.vratiSve("Komentar INNER JOIN Vest ON Komentar.VestID = Vest.idVest INNER JOIN Kategorija ON Vest.idVest = Kategorija.idKategorija",whereUslov: "Vest.idVest="+String(vest.id)+";")
            
            var listaKomentara: [Tabela] = MySqlKlasa.get("Komentar",whereUslov: "idVest="+String(vest.id))
            

            
            var listaKonvertovana: [Komentar] = []
            var tekls : String = ""
            for column in listaKomentara {
                let k:Komentar = column as! Komentar
                listaKonvertovana.append(k)
                tekls+=k.komentar
            }
            
            kvc.komentari = listaKonvertovana
                
                
        }
        if segue.identifier == "ostaviKomentar" {
            
            let ovc = segue.destinationViewController as! OstaviKomentarViewController
            ovc.vest = vest
        }
        
    }
    


}
