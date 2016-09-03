//
//  VremeViewController.swift
//  TabbedAplikacija
//
//  Created by Radomir Popovic on 6.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import UIKit
import SwiftyJSON

class Grad{

    var minimalna:Int = 0
    var maksimalna:Int = 0
    var trenutna:Int = 0
    var vlaznost:String = ""
    var vetar:String = ""
    var pritisak: String = ""
    var naziv:String = ""
    var opis:String=""
    
    init(minimalna:Int, maksimalna:Int, trenutna:Int,vlaznost:String,vetar:String,naziv:String
         ,pritisak:String,opis:String){
        self.minimalna=minimalna
        self.maksimalna=maksimalna
        self.trenutna=trenutna
        self.vlaznost=vlaznost
        self.vetar=vetar
        self.pritisak=pritisak
        self.naziv=naziv
        self.opis=opis
    }

}

class VremeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nazivGrada: UILabel!
    @IBOutlet weak var opis: UILabel!
    @IBOutlet weak var trenutnaTemp: UILabel!
    @IBOutlet weak var slika: UIImageView!
    @IBOutlet weak var minim: UILabel!
    @IBOutlet weak var maxim: UILabel!
    @IBOutlet weak var vlazn: UILabel!
    @IBOutlet weak var pritisk: UILabel!
    @IBOutlet weak var brzinaVetr: UILabel!
    
    var gradovi:[Grad] = []
    var pickerData:[String] = []
    
    func farenhajtToCelz(far:Double) -> Double{
        return (5/9) * (far-32)
    }
    func kelvinToCelz(far:Double) -> Int{
        return Int(far-273.15)
    }
    
    //ecd8b8c709df38bbbb0666ed79a9aa2f
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "ikonice/horoskopBack.jpg")!)
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        gradovi = nadjiVreme()
        
        if gradovi.count == 0 {
            let Alert = UIAlertController(title: "Info", message: "Molimo konektujte se na internet", preferredStyle: .Alert)
            
            let DismissButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                
                (alert: UIAlertAction!) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            })
            
            Alert.addAction(DismissButton)
            
            self.presentViewController(Alert, animated: true, completion: nil)
            return
        }
        
        stilizuj()
        
        // pickerData = [[NSArray alloc] initWithObjects:@"Row 1",@"Row 2",@"Row 3",@"Row 4", nil];
        pickerData = ["Beograd, Novi Sad, Nis"]
        
        prikaziZaGrad(0)
        
        
        
        // Do any additional setup after loading the view.
    }
    func stilizuj(){
        slika.layer.cornerRadius = 20
        slika.clipsToBounds = true
        slika.layer.borderWidth = 3.5
        
        slika.layer.shadowColor = UIColor.grayColor().CGColor
        slika.layer.shadowRadius = 5
        slika.layer.shadowOpacity = 0.5
    }
    func prikaziZaGrad(broj:Int){
        
        if(gradovi.count==0) {return}
        
        nazivGrada.text = gradovi[broj].naziv
        if nazivGrada.text == "Belgrade" {nazivGrada.text = "Beograd"}
        opis.text = gradovi[broj].opis
        trenutnaTemp.text = "Temperatura: "+String(gradovi[broj].trenutna)+" C"
        maxim.text = "Maksimalna dnevna temp: "+String(gradovi[broj].maksimalna)+" C"
        minim.text = "Minimalna dnevna temp: "+String(gradovi[broj].minimalna)+" C"
        vlazn.text="Vlaznost vazduha: "+gradovi[broj].vlaznost
        pritisk.text="Pritisak: "+gradovi[broj].pritisak
        brzinaVetr.text="Brzina vetra: "+gradovi[broj].vetar
        
        
        if(gradovi[broj].opis.containsString("Kiša")){
            slika.image = UIImage(named: "ikonice/rain.png")
        }
        if(gradovi[broj].opis==("Vedro")){
            slika.image = UIImage(named: "ikonice/sunny.jpg")
        }
        if(gradovi[broj].opis==("Oblačno")){
            slika.image = UIImage(named: "ikonice/cloudy.ico")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradovi.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        prikaziZaGrad(row)
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return gradovi[row].naziv
    }
    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: gradovi[row].naziv, attributes: [NSForegroundColorAttributeName : UIColor.whiteColor()])
        return attributedString
    }
    func nadjiVreme() -> [Grad]{
        
        //bg, subotica, ns, nis, kragujevac,pancevo, zrenjanin,cacak, kraljevo, novi pazar,smederevo,vranje,uzice,valjevo,krusevac,sabac,pozarevac,sombor,pirot,zajecar,kikinda,sremmitr,jagodina,loznica,zlatibor,kopaonik
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/group?id=792680,3194360,3189595,787657,789128,787237,783814,792078,789107,787595,788709,785756,784227,3188434,3188402,788975,3191376,786827,3190342,787050,784024,789518,3190103,789923,784136,729530,3302765&units=metric&appid=ecd8b8c709df38bbbb0666ed79a9aa2f")
        let jsonData = NSData(contentsOfURL: url!)
        
        
        if(jsonData==nil){return [];}
        
        
        let readable = JSON(data: jsonData!)
        
        
        //var name = readable["People","Person1","Name"] // var name = readable["People"]["Person1"]["Name"]
        
        let brojUListi:Int = readable["cnt"].intValue
        print("Broj u listi: \(brojUListi)")
        
        var gradovi:[Grad]=[]
        
        for index in 0...brojUListi-1{
            var deskripcija = procistiDeskripciju(String(readable["list"][index]["weather"][0]["description"]))
            var temperatura = readable["list"][index]["main"]["temp"].intValue
            var minimalna = readable["list"][index]["main"]["temp_min"].intValue-2
            var maksimalna = readable["list"][index]["main"]["temp_max"].intValue+3
            var vlazn = String(readable["list"][index]["main"]["humidity"]) + " %"
            var vetr = String(readable["list"][index]["wind"]["speed"]) + " m/s"
            var pritsk = String(Double(round(100*readable["list"][index]["main"]["pressure"].doubleValue)/100)) + " Pa"
            var naziv = String(readable["list"][index]["name"])

            if naziv=="Belgrade" {naziv = "Beograd"}
            
            var grad = Grad(minimalna: minimalna, maksimalna: maksimalna, trenutna: temperatura, vlaznost: vlazn, vetar: vetr, naziv: naziv, pritisak: pritsk, opis: deskripcija)
            
            //print("Deskripcija: \(deskripcija), temp:\(temperatura)\(minimalna)\(maksimalna),vlaznost:\(vlazn),vetar:\(vetr),prit:\(pritsk),naziv:\(naziv)")
            
            gradovi.append(grad)
        }
        //let temp_min:Int = self.kelvinToCelz(deskripcija)
        
        return gradovi
    }
    func procistiDeskripciju(deskripcija:String) -> String{
        if deskripcija.lowercaseString=="overcast clouds".lowercaseString {return "Oblačno"}
        if deskripcija.lowercaseString=="light rain".lowercaseString {return "Slaba kiša"}
        if deskripcija.lowercaseString=="broken clouds".lowercaseString {return "Oblačno"}
        if deskripcija.lowercaseString=="moderate rain".lowercaseString {return "Umerena kiša"}
        if deskripcija.lowercaseString=="Sky is Clear".lowercaseString {return "Vedro"}
        if deskripcija.lowercaseString=="clear sky".lowercaseString {return "Vedro"}
        return "Vedro"
    }

//        {"coord":{"lon":20.47,"lat":44.8},"sys":{"message":0.0308,"country":"RS","sunrise":1470454252,"sunset":1470506219},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"main":{"temp":24.74,"temp_min":24.737,"temp_max":24.737,"pressure":1020.04,"sea_level":1030.58,"grnd_level":1020.04,"humidity":65},"wind":{"speed":4.76,"deg":271.004},"clouds":{"all":56},"dt":1470510615,"id":792680,"name":"Belgrade"}
    
    

}
