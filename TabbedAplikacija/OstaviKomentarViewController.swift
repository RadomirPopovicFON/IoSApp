//
//  OstaviKomentarViewController.swift
//  TabbedAplikacija
//
//  Created by Radomir Popovic on 7.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import UIKit

class OstaviKomentarViewController: UIViewController,UITextViewDelegate {
    
    var vest:Vest!
    
    @IBOutlet weak var textFieldDel: UITextView!
    @IBAction func Dismiss1(sender: AnyObject) {
        self.resignFirstResponder()
    }
    @IBAction func ostaviKomentar(sender: AnyObject) {
        if SqlKlasa.daLiImaKonekcije() == false {
            let Alert = UIAlertController(title: "Info", message: "Molimo konektujte se na internet", preferredStyle: .Alert)
            
            let DismissButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                
                (alert: UIAlertAction!) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            })
            
            Alert.addAction(DismissButton)
            
            self.presentViewController(Alert, animated: true, completion: nil)
            return
            
        }
        var komentarNovi:Komentar = Komentar(nazivOsobe: ime.text!, komentar: komentar.text, vest: vest!)
        
        var upit:String = "INSERT INTO Komentar('nazivOsobe','komentar',brojLajkova,brojDislajkova,VestID) VALUES('\(komentarNovi.nazivOsobe)','\(komentarNovi.komentar)',0,0,\(komentarNovi.vest.id));"
        //print(upit)
        
        
        if ime.text=="" || komentar.text=="" {
            let Alert = UIAlertController(title: "Info", message: "Ne možete ubaciti prazan komentar/bez imena", preferredStyle: .Alert)
            
            let DismissButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                
                (alert: UIAlertAction!) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            })
            
            Alert.addAction(DismissButton)
            
            self.presentViewController(Alert, animated: true, completion: nil)
            return
            
        }
        
        
        MySqlKlasa.insert(komentarNovi)
        
        let Alert = UIAlertController(title: "Info", message: "Uspešno ste komentarisali vest!", preferredStyle: .Alert)
        
        let DismissButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
            
            (alert: UIAlertAction!) -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        })
        
        Alert.addAction(DismissButton)
        
        self.presentViewController(Alert, animated: true, completion: nil)
        
        //SqlKlasa.izvrsiUpit(upit)
    }

    @IBOutlet weak var ime: UITextField!
    @IBOutlet weak var komentar: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        komentar.returnKeyType = UIReturnKeyType.Done
        ime.returnKeyType = UIReturnKeyType.Done
        textFieldDel.delegate = self
        komentar.layer.cornerRadius = 20
        

        self.navigationController!.navigationBar.topItem!.title = "Vest"
        //self.navigationController!.navigationItem.backBarButtonItem?.title = "Vest"
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
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }

}
