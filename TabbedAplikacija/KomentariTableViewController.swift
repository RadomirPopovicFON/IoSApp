//
//  KomentariTableViewController.swift
//  TabbedAplikacija
//
//  Created by Radomir Popovic on 7.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import UIKit

class KomentariTableViewController: UITableViewController,TabelaDelegat {

    var komentari:[Komentar]=[]
    
    
    override func viewDidLoad() {
        SqlKlasa.vratiMojIPAdresu()
        super.viewDidLoad()
        self.navigationController!.navigationBar.topItem!.title = "Vest"
        //self.navigationController!.navigationItem.backBarButtonItem?.title = "Nazad"
        
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

        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return komentari.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("komentar") as! CommentTableViewCell
        cell.delegate=self
        let comment:Komentar = komentari[indexPath.row] as! Komentar
        cell.brLajk.text = String(comment.brojLajkova)
        cell.brDisl.text = String(comment.brojDislajkova)
        
        cell.komentar.layer.cornerRadius = 20
        
        cell.osoba.text = comment.nazivOsobe
        cell.komentar.text = comment.komentar
        
        cell.brLajkSlika.tag = comment.id
        cell.brDislSlika.tag = comment.id
        
        
        return cell
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    func userDaoOcenu(id:Int) -> Bool {
        print("usao")
        if (SqlKlasa.dodajKomentar(id)){
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
                
        })
       
            let Alert = UIAlertController(title: "Info", message: "Uspešno ste dali ocenu na komentar", preferredStyle: .Alert)
            
            let DismissButton = UIAlertAction(title: "Izadji", style: UIAlertActionStyle.Default, handler: {
                
                (alert: UIAlertAction!) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            })
            
            Alert.addAction(DismissButton)
            
            self.presentViewController(Alert, animated: true, completion: nil)
            return true
        }
        else{
        let Alert = UIAlertController(title: "Info", message: "Već ste dali ocenu na komentar", preferredStyle: .Alert)
        
        let DismissButton = UIAlertAction(title: "Izađi", style: UIAlertActionStyle.Default, handler: {
            
            (alert: UIAlertAction!) -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        })
        
        Alert.addAction(DismissButton)
        
        self.presentViewController(Alert, animated: true, completion: nil)
            return false
        }
    }
    

}
