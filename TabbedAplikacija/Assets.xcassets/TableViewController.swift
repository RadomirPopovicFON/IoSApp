//
//  TableViewController.swift
//  TabbedAplikacija
//
//  Created by Radomir Popovic on 3.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import UIKit


class TableViewController: UITableViewController {

    
    @IBOutlet weak var ucitajSl5: UIButton!
    
    var limitPar = 3;
    
    @IBAction func ucitajSl5(sender: AnyObject) {
        
        
        str = self.restorationIdentifier!
        
        if(str=="sport"){
            // print("velicina je: \(SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idVest = Kategorija.idKategorija",whereUslov: " Vest.idKategorije<5;").count)")
            
            if(limitPar==MySqlKlasa.get("Vest",whereUslov:"sport").count){
                return;
            }
            limitPar+=1;
            
            lista=MySqlKlasa.get("Vest",whereUslov:"sport",limit: String(limitPar))
            if(lista.count==0){
                lista = SqlKlasa.vratiSve("Vest", whereUslov: "sport")
            }
            lista = SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idKategorije = Kategorija.idKategorija",whereUslov: "Kategorija.idKategorija>4")
            
            
            
            
            //print("sport")
        }
        if(str=="vesti"){
            //print("velicina je: \(SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idVest = Kategorija.idKategorija",whereUslov: " Vest.idKategorije<5;").count)")
            
            if(limitPar==MySqlKlasa.get("Vest",whereUslov:"glavna").count){
                return;
            }
            limitPar+=1;
            
            lista=MySqlKlasa.get("Vest",whereUslov:"glavna",limit: String(limitPar))
            
//            
//            lista=SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idKategorije = Kategorija.idKategorija",whereUslov: "Kategorija.idKategorija<5")
            
            print("vesti")
        }
        self.tableView.reloadData()
        
    }
    var str: String! = ""
    
    
    var lista:[Tabela] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        str = self.restorationIdentifier!
        
        if(str=="sport"){
           // print("velicina je: \(SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idVest = Kategorija.idKategorija",whereUslov: " Vest.idKategorije<5;").count)")

            lista=MySqlKlasa.get("Vest",whereUslov:"sport",limit: String(limitPar))
            

            //print("sport")
        }
        if(str=="vesti"){
            //print("velicina je: \(SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idVest = Kategorija.idKategorija",whereUslov: " Vest.idKategorije<5;").count)")
            
            lista=MySqlKlasa.get("Vest",whereUslov:"glavna")
            
            
            print("vesti")
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return limitPar
    }

 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("vest") as! TableViewCell
        
        
        
        let vest:Vest = lista[indexPath.row] as! Vest
        
        
        cell.naslov.text = vest.naslov
        
        
        
        cell.slika.image = UIImage(named: vest.slika)
        
        
        
        //
        if let urlPR = NSURL(string: "http://multiplaskleroza.org.rs/slikeMobRac/\(vest.slika)") {
            if let data = NSData(contentsOfURL: urlPR) {
                cell.slika.image = UIImage(data: data)
            }        
        }
        
        cell.slika.layer.cornerRadius = 20
        cell.slika.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.whiteColor().CGColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = CGSizeZero
        cell.layer.shadowRadius = 10
        
        
        let imageView = UIImageView(frame: CGRectMake(0, 0, cell.frame.width, cell.frame.height))
        let image1 = UIImage(named: "newsBack.jpg")
        let image2 = UIImage(named: "tennis.jpg")
        if(vest.kategorija.id<5){
        imageView.image = image1
        }
        else{imageView.image = image2}
        //cell.backgroundView = UIView()
        //cell.backgroundView!.addSubview(imageView)
        
        
        
        
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var identifikator: String = segue.identifier!
        
        
    
        if identifikator == "prikaziVest" {
            print("prikazi vest")
            
            let dc = segue.destinationViewController as! DetailViewController
            
            
            if let indexpath = self.tableView.indexPathForSelectedRow {
                
                //dc.delegate = self
                
                let vesttt:Vest = lista[indexpath.row] as! Vest
                dc.vest = vesttt
                
                
            }
        }
            if identifikator == "prikaziSport"{
            
                let dc = segue.destinationViewController as! DetailViewController
            
                if let indexpath = self.tableView.indexPathForSelectedRow {
                    
                    //dc.delegate = self
                    
                    let vesttt:Vest = lista[indexpath.row] as! Vest
                    dc.vest = vesttt
                    
            }
            }
        
        }


}
