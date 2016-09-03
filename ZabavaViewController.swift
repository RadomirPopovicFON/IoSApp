//
//  ZabavaViewController.swift
//  TabbedAplikacija
//
//  Created by Radomir Popovic on 7.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import UIKit
import Polyglot
import SwiftyJSON

class Horoskop{
    var znak:String = ""
    var opis:String = ""
}




class ZabavaViewController: UIViewController {

    

    
    @IBOutlet weak var imageViewHoroskop: UIImageView!
    var horoskopi:[String:String]!
    @IBAction func segmentHoroskopAction(sender: AnyObject) {
        if(self.segmentLabel.selectedSegmentIndex==0){
            self.webView.hidden = true
            self.segmentLabelHoroskop.hidden = false
            self.datumLabel.hidden = false
            self.prognozaLabel.hidden = false
            self.znakLabel.hidden = false

            let dateFormater = NSDateFormatter()
            dateFormater.dateFormat = "dd. MM. yyyy."
            dateFormater.locale = NSLocale(localeIdentifier: "sr_Latn")
            dateFormater.dateStyle = NSDateFormatterStyle.MediumStyle
            var danas:String = dateFormater.stringFromDate(NSDate())
            
            switch self.segmentLabelHoroskop.selectedSegmentIndex {
                
            case 0:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["aries"]
                self.znakLabel.text="Ovan"
            case 1:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["taurus"]
                self.znakLabel.text="Bik"
            case 2:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["gemini"]
                self.znakLabel.text="Blizanci"
            case 3:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["cancer"]
                self.znakLabel.text="Rak"
            case 4:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["leo"]
                self.znakLabel.text="Lav"
            case 5:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["virgo"]
                self.znakLabel.text="Devica"
            case 6:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["libra"]
                self.znakLabel.text="Vaga"
            case 7:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["scorpio"]
                self.znakLabel.text="Škorpija"
            case 8:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["sagittarius"]
                self.znakLabel.text="Strelac"
            case 9:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["capricorn"]
                self.znakLabel.text="Jarac"
            case 10:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["aquarius"]
                self.znakLabel.text="Vodolija"
            case 11:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["pisces"]
                self.znakLabel.text="Ribe"
                
            default:
                print("Default")
            }
            
            
        }
    }
    
    @IBOutlet weak var datumLabel: UILabel!
    @IBOutlet weak var segmentLabelHoroskop: UISegmentedControl!
    @IBOutlet weak var prognozaLabel: UITextView!
    @IBOutlet weak var znakLabel: UILabel!
    @IBOutlet weak var segmentLabel: UISegmentedControl!
    
    @IBAction func promena(sender: AnyObject) {
        
        let dateFormater = NSDateFormatter()
        dateFormater.dateFormat = "dd.MM.yyyy."
        dateFormater.locale = NSLocale(localeIdentifier: "sr_Latn")
        dateFormater.dateStyle = NSDateFormatterStyle.MediumStyle
        var danas:String = dateFormater.stringFromDate(NSDate())

        if(self.segmentLabel.selectedSegmentIndex==0){
            self.imageViewHoroskop.hidden = false
            self.webView.hidden = true

            self.segmentLabelHoroskop.hidden = false
            self.datumLabel.hidden = false
            self.prognozaLabel.hidden = false
            self.znakLabel.hidden = false
            
            switch self.segmentLabelHoroskop.selectedSegmentIndex {
                
            case 0:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["aries"]
                self.znakLabel.text="Ovan"
            case 1:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["taurus"]
                self.znakLabel.text="Bik"
            case 2:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["gemini"]
                self.znakLabel.text="Blizanci"
            case 3:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["cancer"]
                self.znakLabel.text="Rak"
            case 4:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["leo"]
                self.znakLabel.text="Lav"
            case 5:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["virgo"]
                self.znakLabel.text="Devica"
            case 6:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["libra"]
                self.znakLabel.text="Vaga"
            case 7:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["scorpio"]
                self.znakLabel.text="Škorpija"
            case 8:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["sagittarius"]
                self.znakLabel.text="Strelac"
            case 9:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["capricorn"]
                self.znakLabel.text="Jarac"
            case 10:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["aquarius"]
                self.znakLabel.text="Vodolija"
            case 11:
                self.datumLabel.text = danas
                self.prognozaLabel.text=self.horoskopi["pisces"]
                self.znakLabel.text="Ribe"
                
            default:
                print("Default")
            }
            
        }
        if(self.segmentLabel.selectedSegmentIndex==1){
            self.imageViewHoroskop.hidden = true
            self.webView.hidden = false
 
            
            self.segmentLabelHoroskop.hidden = true
            self.datumLabel.hidden = true
            self.prognozaLabel.hidden = true
            self.znakLabel.hidden = true
            
            
            let youtubeURL = "https://www.youtube.com/embed/65rQw_f9gBM"
            webView.allowsInlineMediaPlayback=true
            let text:String = "<iframe width=\"\(webView.frame.width)\" height=\"\(webView.frame.height)\" src=\"\(youtubeURL)\" frameborder=\"0\" allowfullscreen></iframe>"
            
            
            webView!.loadHTMLString(text, baseURL: nil)

            
        }
        
//        <iframe width="309.0" height="423.0" src="https://www.youtube.com/watch?v=Rg6GLVUnnpM?playsinline=1" frameborder="0" allowfullscreen></iframe>
        
        if(self.segmentLabel.selectedSegmentIndex==2){
            self.imageViewHoroskop.hidden = true
            self.segmentLabelHoroskop.hidden = true
            self.datumLabel.hidden = true
            self.prognozaLabel.hidden = true
            self.znakLabel.hidden = true
            
            self.webView.hidden = false
            
            
            let text = "http://www.businessinsider.com/100-trips-everyone-should-take-in-their-lifetime-2016-5?utm_content=buffer158e1&utm_medium=social&utm_source=facebook.com&utm_campaign=buffer"
            let url = NSURL(string: text)
            let request = NSURLRequest(URL: url!)
            
            self.webView.loadRequest(request)
        }
        

        
    }
    @IBOutlet weak var webView: UIWebView!
        override func viewDidLoad() {
        super.viewDidLoad()
            
                       // prevedi("")
             var imageHor: UIImage = UIImage(named: "ikonice/horoskop.png")!
            imageViewHoroskop.image = imageHor
        horoskopi = vratiHoroskope()
            self.webView.hidden = true
            
            let dateFormater = NSDateFormatter()
            dateFormater.dateFormat = "dd.MM.yyyy."
            dateFormater.locale = NSLocale(localeIdentifier: "sr_Latn")
            dateFormater.dateStyle = NSDateFormatterStyle.MediumStyle
            var danas:String = dateFormater.stringFromDate(NSDate())

            if !SqlKlasa.daLiImaKonekcije() {
                let Alert = UIAlertController(title: "Info", message: "Molimo konektujte se na internet", preferredStyle: .Alert)
                
                let DismissButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {
                    
                    (alert: UIAlertAction!) -> Void in
                    self.navigationController?.popViewControllerAnimated(true)
                })
                
                Alert.addAction(DismissButton)
                
                self.presentViewController(Alert, animated: true, completion: nil)
            }
            
            self.datumLabel.text = danas
            self.prognozaLabel.text=self.horoskopi["aries"]
            self.znakLabel.text="Ovan"
            
           //print(horoskopi["scorpio"])
            
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prevedi(prevod:String) -> String {
    
        let translator = Polyglot(clientId: "radomirPopovicTranslate", clientSecret: "Y0uxGTcIRFl9qgRTchlFRBtbSK5E1O2/BX7xRZYdbEk=")
        translator.fromLanguage = Language.Dutch // It will automatically detect the language if you don't set this.
        translator.toLanguage = Language.English
        let dutch = "Ik weet het niet."
        var izlaz: String = ""
        translator.translate(dutch) { translation in
            print("\"\(dutch)\" means \"\(translation)\"")
            izlaz = translation
        }
        return izlaz
    }
    func vratiHoroskope() -> [String:String] {
        var horoskopi = [String:String]()
        
                var datum:String = String(NSDate()).characters.split{$0 == " "}.map(String.init)[0].stringByReplacingOccurrencesOfString("2016", withString: "2010")
        
        var nizHoroskopa:[String] = []
        nizHoroskopa.append("aquarius")
        nizHoroskopa.append("libra")
        nizHoroskopa.append("gemini")
        nizHoroskopa.append("capricorn")
        nizHoroskopa.append("virgo")
        nizHoroskopa.append("taurus")
        nizHoroskopa.append("sagittarius")
        nizHoroskopa.append("leo")
        nizHoroskopa.append("aries")
        nizHoroskopa.append("pisces")
        nizHoroskopa.append("cancer")
        nizHoroskopa.append("scorpio")
        

        
        datum = "2010-08-24"
        //print("datum je :\(datum)")
        
        for index in 0...11{
        var url = NSURL(string: "http://widgets.fabulously40.com/horoscope.json?sign=\(nizHoroskopa[index])&date=\(datum)")
            
            
            
        var jsonData = NSData(contentsOfURL: url!)
            
        
            
            if jsonData==nil {return [:];}
            
            
        var readable = JSON(data: jsonData!)
        horoskopi[String(readable["horoscope"]["sign"])]=precistiTekst(String(readable["horoscope"]["horoscope"]))
            
            
        }
        
        return horoskopi
    }
    func precistiTekst(parametar:String) -> String{
        //&lt; (<), &amp; (&), &gt; (>), &quot; ("), and &apos (')
        return parametar.stringByReplacingOccurrencesOfString("&apos;", withString: "'").stringByReplacingOccurrencesOfString("&quot;", withString: "<<>>").stringByReplacingOccurrencesOfString("&gt;", withString: ">").stringByReplacingOccurrencesOfString("&lt;", withString: "<").stringByReplacingOccurrencesOfString("&amp;", withString: "&")
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
