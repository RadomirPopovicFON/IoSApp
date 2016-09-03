//
//  AppDelegate.swift
//  TabbedAplikacija
//
//  Created by Radomir Popovic on 3.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var ip: String = ""
    
    
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        var vest = Vest.init(id: 12, naslov: "Naslov", text: "Text", datumPostavljanja: "22.05.2015.", kategorija: Kategorija.init(id: 1, nazivKategorije: "Glavna", nazivPodKategorije: "Politika"), slika: "1A1.jpg")
        
        var vesti:[Tabela]=MySqlKlasa.get("Vest",whereUslov:"sport")
        
        //SqlKlasa.ubaciVesti(vesti)
        
//        let upitObrisi:String = "DELETE FROM `Vest`"
//        SqlKlasa.izvrsiUpit(upitObrisi)

        
        
        var vestttttt = SqlKlasa.vratiSve("Vest INNER JOIN Kategorija ON Vest.idKategorije = Kategorija.idKategorija",whereUslov: "Kategorija.idKategorija<5")//glavne, idKategorija>4 sport
        
        
        //SqlKlasa.otvoriBazu()
        
        //MySqlKlasa.get("Vest")
        
        //MySqlKlasa.getSesija("Vest")
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
    
    //SqlKlasa.vratiMojIPAdresu()
    
    //        let parametar: String = "Vest INNER JOIN Kategorija ON Vest.idVest = Kategorija.idKategorija;"
    //
    //        let kk = Kategorija(id: 1, nazivKategorije: "", nazivPodKategorije: "")
    //
    //        let v = Vest(id: 1, naslov: "", text: "", datumPostavljanja: "", kategorija: kk, slika: "")
    //        v.id=1
    //        let komentarNovi = Komentar(id: 2, nazivOsobe: "Slavoljub", komentar: "comm", brojLajkova: 0, brojDislajkova: 0, vest: v)
    
    //        SqlKlasa.izvrsiUpit("INSERT INTO Komentar('nazivOsobe','komentar',brojLajkova,brojDislajkova,VestID) VALUES('\(komentarNovi.nazivOsobe)','\(komentarNovi.komentar)',\(komentarNovi.brojLajkova),\(komentarNovi.brojDislajkova),\(komentarNovi.vest.id))")
    //
    //        SqlKlasa.izvrsiUpit("UPDATE Komentar SET brojLajkova=brojLajkova+1 WHERE idKomentar=\(2)")
    //        SqlKlasa.izvrsiUpit("UPDATE Komentar SET brojDislajkova=brojDislajkova+1 WHERE idKomentar=\(2)")
    //        let parametar2: String = "Komentar INNER JOIN Vest ON Komentar.VestID = Vest.idVest INNER JOIN Kategorija ON Vest.idVest = Kategorija.idKategorija;"
    //        Tabela.stampajNiz(SqlKlasa.vratiSve(parametar2, whereUslov: ""))
    //let upitObrisi:String = "DELETE FROM `Vest`"
    
    // Override point for customization after application launch.
    
    
    
    
    


}

