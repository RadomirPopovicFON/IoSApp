//
//  KontaktGlavniViewController.swift
//  TabbedAplikacija
//
//  Created by Radomir Popovic on 6.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import UIKit
import Social
import MessageUI


class KontaktGlavniViewController: UIViewController,MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate{

    @IBAction func fejsbuk(sender: AnyObject) {
        fejsbuk()
    }
    @IBAction func twit(sender: AnyObject) {
        twitter()
    }
    @IBAction func pozovite(sender: AnyObject) {
        poziv("+38163481691")
    }
    @IBAction func poruka(sender: AnyObject) {
        poruka("+38163481691", tekst: "Kritika, sugestija ili nesto slicno...")
    }
    @IBAction func mejl(sender: AnyObject) {
        posaljiMejl("radomir.popovic@ymail.com", titl: "", messageBody: "")
    }
    @IBAction func mapaNadjite(sender: AnyObject) {
    }
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        //fejsbuk()
        //poruka("+38163481691", tekst: "tekst")
        // Do any additional setup after loading the view.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fejsbuk(){
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            
            let FacebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            FacebookSheet.setInitialText("BLIC VESTI")
            
            self.presentViewController(FacebookSheet, animated: true, completion: nil)
            
        } else {
            
            let Alert = UIAlertController(title: "Accounts", message: "Please log in to your facebook accounts in the settings", preferredStyle: UIAlertControllerStyle.Alert)
            
            Alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(Alert, animated: true, completion: nil)
            
        }
    }
    
    func twitter(){
    
        
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            
            let TwitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            
            TwitterSheet.setInitialText(label.text)
            TwitterSheet.addImage(image.image)
            
            self.presentViewController(TwitterSheet, animated: true, completion: nil)
            
        } else {
            
            let Alert = UIAlertController(title: "Accounts", message: "Logujte se na twitter kako bi ova mogucnost bila dostupna", preferredStyle: UIAlertControllerStyle.Alert)
            
            Alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(Alert, animated: true, completion: nil)
            
        }
        
    }
    func poziv(broj:String){
        UIApplication.sharedApplication().openURL(NSURL(string:"tel://\(broj)")!)
    }
    func poruka(broj:String,tekst:String){
        
        let messageVC = MFMessageComposeViewController()
        
        messageVC.recipients = ["\(broj)"]
        messageVC.body = tekst
        
        
        messageVC.messageComposeDelegate = self
        
        self.presentViewController(messageVC, animated: true, completion: nil)
        
        
    }
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
        switch (result.rawValue) {
            
        case MessageComposeResultCancelled.rawValue:
            
            print("Message was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
            
        case MessageComposeResultFailed.rawValue:
            
            print("Message was Failed")
            self.dismissViewControllerAnimated(true, completion: nil)
            
        case MessageComposeResultSent.rawValue:
            
            print("Message was Sent")
            self.dismissViewControllerAnimated(true, completion: nil)
            
        default:
            break
            
        }
        
    }
    func posaljiMejl(adresa:String,titl:String,messageBody:String){
        
        let toRecipents = ["radomir.popovic@ymail.com"]
        let emailTitle = "Title"
        let messageBody = "Body"
        
        
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        
        mc.mailComposeDelegate = self
        
        
        mc.setToRecipients(toRecipents)
        mc.setSubject(emailTitle)
        mc.setMessageBody(messageBody, isHTML: false)
        
        if MFMailComposeViewController.canSendMail(){
        self.presentViewController(mc, animated: true, completion: nil)
        }else {showSendMailErrorAlert()}
        
    }
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Neuspesno slanje", message: "Nemate povezan mejl account", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        
        switch result.rawValue {
            
        case MFMailComposeResultCancelled.rawValue:
            print("cancelled")
            
        case MFMailComposeResultFailed.rawValue:
            print("failed")
            
        case MFMailComposeResultSaved.rawValue:
            print("saved")
            
        case MFMailComposeResultSent.rawValue:
            print("sent")
            
        default:
            break
            
            
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
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
