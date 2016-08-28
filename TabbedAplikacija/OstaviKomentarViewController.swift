//
//  OstaviKomentarViewController.swift
//  TabbedAplikacija
//
//  Created by Radomir Popovic on 7.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import UIKit

class OstaviKomentarViewController: UIViewController {
    
    var vest:Vest!
    
    @IBAction func ostaviKomentar(sender: AnyObject) {
        var komentarNovi:Komentar = Komentar(nazivOsobe: ime.text!, komentar: komentar.text, vest: vest!)
        
        var upit:String = "INSERT INTO Komentar('nazivOsobe','komentar',brojLajkova,brojDislajkova,VestID) VALUES('\(komentarNovi.nazivOsobe)','\(komentarNovi.komentar)',0,0,\(komentarNovi.vest.id));"
        print(upit)
        komentar.layer.cornerRadius = 20
        MySqlKlasa.insert(komentarNovi)
        //SqlKlasa.izvrsiUpit(upit)
    }

    @IBOutlet weak var ime: UITextField!
    @IBOutlet weak var komentar: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
