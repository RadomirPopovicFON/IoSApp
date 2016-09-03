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
    
    var limitPar = 7;
    var neUcitavaj : Bool = false
    
    @IBAction func ucitajSl5(sender: AnyObject) {
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
        
        str = self.restorationIdentifier!
        
        if(str=="sport"){
            // print("velicina je: \(SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idVest = Kategorija.idKategorija",whereUslov: " Vest.idKategorije<5;").count)")
            
            if(limitPar>=MySqlKlasa.get("Vest",whereUslov:"sport").count){
                
                let Alert = UIAlertController(title: "Info", message: "Sve ste ucitali", preferredStyle: .Alert)
                
                let DismissButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                    
                    (alert: UIAlertAction!) -> Void in
                    self.navigationController?.popViewControllerAnimated(true)
                })
                
                Alert.addAction(DismissButton)
                
                self.presentViewController(Alert, animated: true, completion: nil)
                return

                
            }
            limitPar+=3;
            
            lista=MySqlKlasa.get("Vest",whereUslov:"sport",limit: String(limitPar))
            
            
            if(lista.count==0){
                lista = SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idKategorije = Kategorija.idKategorija",whereUslov: "Kategorija.idKategorija>4")
            }
            
            
            //print("sport")
        }
        if(str=="vesti"){
            //print("velicina je: \(SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idVest = Kategorija.idKategorija",whereUslov: " Vest.idKategorije<5;").count)")
            
            if(limitPar>=MySqlKlasa.get("Vest",whereUslov:"glavna").count){
                
                let Alert = UIAlertController(title: "Info", message: "Sve ste ucitali", preferredStyle: .Alert)
                
                let DismissButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                    
                    (alert: UIAlertAction!) -> Void in
                    self.navigationController?.popViewControllerAnimated(true)
                })
                
                Alert.addAction(DismissButton)
                
                self.presentViewController(Alert, animated: true, completion: nil)
                return

                
                return;
            }
            limitPar+=3;
            
            lista=MySqlKlasa.get("Vest",whereUslov:"glavna",limit: String(limitPar))
            
            if(lista.count==0){
                lista = SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idKategorije = Kategorija.idKategorija",whereUslov: "Kategorija.idKategorija<5")
            }
            
//            
//            lista=SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idKategorije = Kategorija.idKategorija",whereUslov: "Kategorija.idKategorija<5")
            
            print("vesti")
        }
        self.tableView.reloadData()
        
    }
    var str: String! = ""
    
    
    var lista:[Tabela] = []
    
    override func viewDidLoad() {
        
        
        if let key = NSUserDefaults.standardUserDefaults().objectForKey("Baza"){
            if key as! String == "OK" {
                print("Baza vec postoji")            }
        }else {SqlKlasa.napraviTabelu(); print("Baza prvi put napravljena!");print("Debug3");}
        
        //SqlKlasa.napraviTabelu();
        
        
        SqlKlasa.stampaj()
        
        str = self.restorationIdentifier!
        
        if(str=="sport"){
           // print("velicina je: \(SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idVest = Kategorija.idKategorija",whereUslov: " Vest.idKategorije<5;").count)")

        lista=MySqlKlasa.get("Vest",whereUslov:"sport",limit: String(limitPar))
            
            
            if lista.count != 0 {
                
                var novaLista: [Tabela] = []
                for index in 0...limitPar-1 {
                    novaLista.append(lista[index])
                }
                
            SqlKlasa.ubaciVesti(novaLista)
            }
            
            if lista.count == 0 {
                neUcitavaj = true
                lista = SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idKategorije = Kategorija.idKategorija",whereUslov: "Kategorija.idKategorija>4")
                self.limitPar == lista.count-1
            }
           
        }
        if(str=="vesti"){
            
            //print("velicina je: \(SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idVest = Kategorija.idKategorija",whereUslov: " Vest.idKategorije<5;").count)")
            
            lista=MySqlKlasa.get("Vest",whereUslov:"glavna",limit: String(limitPar))
            
            
            print("Velicina je: \(lista.count)")
            
            if lista.count != 0 {
                
                var novaLista: [Tabela] = []
                for index in 0...limitPar-1 {
                    novaLista.append(lista[index])
                }
                SqlKlasa.ubaciVesti(novaLista)
            }
            
            if lista.count == 0 {
                neUcitavaj = true
                
                lista = SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idKategorije = Kategorija.idKategorija",whereUslov: "Kategorija.idKategorija<5")
//                print("Broj: \(lista.count)")
//                self.limitPar = lista.count-1
//                print("Pre \(limitPar)")
            }
            
        }
        
        
        super.viewDidLoad()
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
        
    
        
        if SqlKlasa.daLiImaKonekcije() == false {return lista.count}
        
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
