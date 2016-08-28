//
//  CommentTableViewCell.swift
//  TabbedAplikacija
//
//  Created by Radomir Popovic on 7.8.16..
//  Copyright © 2016. Radomir Popovic. All rights reserved.
//

import UIKit

protocol TabelaDelegat {
    func userDaoOcenu(id:Int) -> Bool
    
}


class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var brLajkSlika: UIButton!
    @IBOutlet weak var brDislSlika: UIButton!
    
    
    var delegate:TabelaDelegat?=nil
    
    var daoOcenu = [Int:Bool]()
    
    
    
    @IBAction func dislajkuj(sender: AnyObject) {
        
        //if(daoOcenu[sender.tag]==true){return}
        
        //print("Treba da doda komentar: \(brDislSlika.tag)")
        

        if (delegate != nil){
            
            if(delegate!.userDaoOcenu(brDislSlika.tag)){
                var upit:String = "UPDATE Komentar SET brojDislajkova=brojDislajkova+1 WHERE idKomentar=\(brDislSlika.tag)"
                
                MySqlKlasa.update(false, id: brDislSlika.tag)
                //SqlKlasa.izvrsiUpit(upit)
                print(upit)
            }
            
        }
        
        
    }
    @IBAction func lajkuj(sender: AnyObject) {


        if (delegate != nil){
            
            if(delegate!.userDaoOcenu(brLajkSlika.tag)){
                    //SqlKlasa.izvrsiUpit("UPDATE Komentar SET brojLajkova=brojLajkova+1 WHERE idKomentar=\(brLajkSlika.tag)")
                MySqlKlasa.update(true, id: brLajkSlika.tag)
            }
            
        }
        
    }
    @IBOutlet weak var brLajk: UILabel!
    @IBOutlet weak var osoba: UILabel!
    
    @IBOutlet weak var brDisl: UILabel!
    @IBOutlet weak var komentar: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
