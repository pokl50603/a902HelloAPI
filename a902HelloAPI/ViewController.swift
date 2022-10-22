//
//  ViewController.swift
//  a902HelloAPI
//
//  Created by shengyuan on 2022/10/22.
//

import UIKit
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet var headContainer: UIView!
    @IBOutlet weak var headImage: UIImageView!
    @IBOutlet weak var nameLebel: UILabel!
    @IBOutlet weak var phoneLebel: UILabel!
    @IBOutlet weak var emailLebel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        headImage.clipsToBounds = true
        headImage.backgroundColor = UIColor.white
        headImage.layer.cornerRadius = headImage.frame.height / 2
        headImage.layer.borderColor = UIColor.red.cgColor
        headImage.layer.borderWidth = 5
        
        headContainer.backgroundColor = UIColor.clear
        
        headContainer.clipsToBounds = false
        headContainer.layer.shadowRadius = 20
        headContainer.layer.shadowColor = UIColor.gray.cgColor
        headContainer.layer.shadowOffset = CGSize(width: 20, height: 20)
        
    }
    

    func callAPI(){
        APIModel.share.self.queryRandomUser{rowData, resError in
            if let respError = resError{
                print(resError?.localizedDescription)
                return
            }
            
            if let data = rowData as? Data{
                do{
                    let json = try JSON(data:data)
                    let imageString = json["results"][0]["picture"]["large"].stringValue
                    self.headImage.kf.setImage(with: URL(string: imageString))
                    
                    let nameString = json["results"][0]["name"]["title"].stringValue
                        + ". " + json["results"][0]["name"]["first"].stringValue + " "
                        + json["results"][0]["name"]["last"].stringValue
                    self.nameLebel.text = nameString
                    
                    self.emailLebel.text = json["results"][0]["email"].stringValue
                    self.phoneLebel.text = json["results"][0]["phone"].stringValue
                    
                    
                }catch{
                    
                }
                
            }
        }
        
    }
    
    @IBAction func nextUser(_ sender: Any) {
        callAPI()
    }
}

