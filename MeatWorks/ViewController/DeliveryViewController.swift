//
//  DeliveryViewController.swift
//  MeatWorks
//
//  Created by fwThanh on 10/8/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding

class DeliveryViewController: UIViewController {

    @IBOutlet var lb1: UILabel!
    @IBOutlet var lb2: UILabel!
    @IBOutlet var btnNext: UIButton!
    @IBOutlet var avoidingView: UIView!
    @IBOutlet var lbDetail: UILabel!
    
    @IBOutlet var lbFullname: UILabel!
    @IBOutlet var lbPhone: UILabel!
    @IBOutlet var lbAddress: UILabel!
    
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfAddress: UITextField!
    @IBOutlet var tfPhone: UITextField!
    @IBOutlet var tfDescription: UITextField!
    @IBOutlet var tfDirection: UITextField!
    @IBOutlet var tfFullname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Delivery".localized()
        // Do any additional setup after loading the view.
        lb1.layer.cornerRadius = 20.0
        lb1.layer.borderWidth = 5.0
        lb1.layer.borderColor = UIColor(hexString: "#4E549D").cgColor
        lb2.layer.cornerRadius = 20.0
        btnNext.layer.cornerRadius = 5.0
        
        KeyboardAvoiding.avoidingView = self.avoidingView
        self.changeText()
        
        if let deliveryInfo = Meatworks.deliveryInfo {
            tfEmail.text = deliveryInfo.email
            tfFullname.text = deliveryInfo.fullname
            tfDirection.text = deliveryInfo.direction
            tfDescription.text = deliveryInfo.dDescription
            tfPhone.text = deliveryInfo.phone
            tfAddress.text = deliveryInfo.address
        }
    }

    func changeText() {
        self.lbFullname.text = "Fullname".localized()
        self.lbPhone.text = "Phone".localized()
        self.lbAddress.text = "Address".localized()
        self.lbDetail.text = "dDelivery".localized()
        self.btnNext.setTitle("Next".localized(), for: .normal)
    }
    
    @IBAction func backAction(_ sender: AnyObject) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextAction(_ sender: AnyObject) {
        self.view.endEditing(true)
        
        if tfEmail.text == "" || tfAddress.text == "" || tfPhone.text == "" || tfFullname.text == "" {
            let alert = UIAlertController(title: "alertRequiredFields".localized(), message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok".localized(), style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let deliveryInfo = Delivery(email: tfEmail.text!, address: tfAddress.text!, phone: tfPhone.text!, dDescription: tfDescription.text!, direction: tfDirection.text!, fullname: tfFullname.text!)
        Meatworks.deliveryInfo = deliveryInfo
        self.performSegue(withIdentifier: "NextDelivery", sender:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NextDelivery" {
            let _:BuyViewController = segue.destination as! BuyViewController
            //detailVC.item = ""
        }
    }

}
