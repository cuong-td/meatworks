//
//  CountryViewController.swift
//  MeatWorks
//
//  Created by fwThanh on 10/19/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit
import Localize_Swift
import SVProgressHUD

class CountryViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnVN: UIButton!
    @IBOutlet weak var btnUS: UIButton!
    @IBOutlet weak var imgSelect: UIImageView!
    @IBOutlet weak var lbSelection: UILabel!
    
    let availableLanguages = Localize.availableLanguages()
    var currentSelect: Country?
    var listPOS: [Country]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnVN.layer.cornerRadius = 22
        btnUS.layer.cornerRadius = 22
        btnOK.layer.cornerRadius = 25
        btnSelect.layer.cornerRadius = 25
        btnSelect.layer.borderColor = UIColor.black.cgColor
        btnSelect.layer.borderWidth = 2.0
        
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
        MService.shared.getPOS() { (listPos) in
            if listPos != nil && listPos!.count > 0 {
                self.listPOS = listPos
                self.currentSelect = self.listPOS?[0]
                self.btnSelect.setTitle(self.currentSelect?.pos_name, for: .normal)
                SData.shared.current_posId = self.currentSelect?.pos_id
            }
            SVProgressHUD.dismiss()
        }
        
        self.changeText()
    }

    func changeText() {
        self.lbSelection.text = "selectCountry".localized()
        btnOK.setTitle("Ok".localized(), for: .normal)
        self.btnSelect.setTitle(self.currentSelect?.pos_name, for: .normal)
    }
    
    @IBAction func selectAction(_ sender: AnyObject) {
        if self.listPOS != nil {
            let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "CountriesId") as! ListCountriesVC
            popoverContent.listItems = self.listPOS!
            
            popoverContent.modalPresentationStyle = UIModalPresentationStyle.popover
            let popover = popoverContent.popoverPresentationController
            popoverContent.preferredContentSize = CGSize(width: 280, height: (popoverContent.listItems.count < 6 ? 45 * popoverContent.listItems.count : 300))
            popover?.delegate = self
            popover?.sourceView = self.imgSelect
            popover?.sourceRect = sender.bounds
            
            popoverContent.selectedCountry = {(_ country: Country) -> Void in
                self.btnSelect.setTitle(country.pos_name, for: .normal)
                SData.shared.current_posId = country.pos_id
                self.currentSelect = country
                popoverContent.dismiss(animated: true, completion: nil)
            }
            
            self.present(popoverContent, animated: true, completion: nil)
        }
    }
    
    @IBAction func VNAction(_ sender: AnyObject) {
        Localize.setCurrentLanguage("vi")
        self.changeText()
    }
    
    @IBAction func USAction(_ sender: AnyObject) {
        Localize.setCurrentLanguage("en")
        self.changeText()
    }
    
    @IBAction func OKAction(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "Product", sender:nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Product" {
            let _:ViewController = segue.destination as! ViewController
        }
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
