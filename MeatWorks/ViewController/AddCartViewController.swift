//
//  AddCartViewController.swift
//  MeatWorks
//
//  Created by fwThanh on 10/8/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding
import SVProgressHUD

class AddCartViewController: UIViewController, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {

    @IBOutlet var txtRemark: UITextView!
    @IBOutlet var btnAdd: UIButton!
    @IBOutlet var avoidingView: UIView!
    @IBOutlet var tfValue: UITextField!
    @IBOutlet var lbUnits: UILabel!
    @IBOutlet var btnUnits: UIButton!
    @IBOutlet var lbProduct: UILabel!
    @IBOutlet var lbPrice: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lbOrderUnits: UILabel!
    @IBOutlet var imgSelect: UIImageView!
    @IBOutlet var btnOrder: UIButton!
    @IBOutlet var stepper: UIStepper!
    
    var product: Product?
    var listUnits: [GroupUnit]?
    var currentUnit: GroupUnit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cart".localized()
        // Do any additional setup after loading the view.
        txtRemark.layer.borderWidth = 1.0
        txtRemark.layer.cornerRadius = 5.0
        txtRemark.layer.borderColor = UIColor.black.cgColor
        btnAdd.layer.cornerRadius = 5.0
        
        KeyboardAvoiding.avoidingView = self.avoidingView
        
        self.lbProduct.text = self.product?.product_name
//        self.lbPrice.text = (self.product?.unit_price ?? "") + (self.product?.currency_id ?? "") + "/" + (self.product?.unit_name ?? "")
        self.lbPrice.text = "\(self.product?.unit_price?.numFormat() ?? "")\(self.product?.currency_id ?? "")/\(self.product?.unit_name ?? "")"
        let urlImg = "http://online.meatworksasia.com/photo.aspx?id=\(self.product?.photo ?? "")".replacingOccurrences(of: " ", with: "%20")
        self.imgView.image = UIImage.image(fromURL: urlImg, placeholder: UIImage(named: "Header")!, shouldCacheImage: true) { (image) in
            //self.imgView.image = image
        }
        self.changeText()
        
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
        MService.shared.getGroupUnit(unitId: (product?.unit_id!)!) { (listUnits) in
            if listUnits != nil {
                self.listUnits = listUnits
                self.currentUnit = listUnits![0]
                self.btnUnits.setTitle(self.currentUnit?.unit_name, for: .normal)
                
                if self.currentUnit.factor == "1" {
                    self.tfValue.text = "1"
                }
                else {
                    self.tfValue.text = "100"
                }
            }
            SVProgressHUD.dismiss()
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if SData.shared.listDetailId.count > 0 {
            self.addBadgeIcon(num: SData.shared.listDetailId.count)
        }
        else {
            if let badgeIco = self.btnOrder.viewWithTag(12) as? UILabel {
                badgeIco.removeFromSuperview()
            }
        }
    }
    
    func addBadgeIcon(num: Int) {
        let badgeIco = UILabel(frame: CGRect(x: btnOrder.frame.size.width - 30, y: -10, width: 20, height: 20))
        //badgeIco.layer.borderWidth = 1.0
        badgeIco.layer.cornerRadius = 10
        badgeIco.layer.masksToBounds = true
        //badgeIco.layer.borderColor = UIColor.red.cgColor
        badgeIco.text = "\(num)"
        badgeIco.font = UIFont.boldSystemFont(ofSize: 15)
        badgeIco.textColor = UIColor.white
        badgeIco.backgroundColor = UIColor.red
        badgeIco.textAlignment = NSTextAlignment.center
        badgeIco.tag = 12
        self.btnOrder.addSubview(badgeIco)
    }
    
    func changeText () {
        self.lbUnits.text = "units".localized()
        self.lbOrderUnits.text = "orderUnits".localized()
        self.btnAdd.setTitle("Add2Cart".localized(), for: .normal)
    }
    
    @IBAction func cartAction(_ sender: AnyObject) {
        if (SData.shared.listDetailId.count) > 0 {
            self.performSegue(withIdentifier: "AddToCart", sender:nil)
        }
    }
    
    @IBAction func backAction(_ sender: AnyObject) {
        self.view.endEditing(true)
        self.slideMenuController()?.addLeftGestures()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func stepperValueChanged(_ stepper: UIStepper) {
        if tfValue.isEditing {
            self.view.endEditing(true)
            return
        }
        self.view.endEditing(true)
        let value = Int(stepper.value)
        if self.currentUnit.factor == "1" {
            self.tfValue.text = "\(value)"
        }
        else {
            self.tfValue.text = "\(value*100)"
        }
    }
    
    @IBAction func selectAction(_ sender: AnyObject) {
        let popoverContent = self.storyboard?.instantiateViewController(withIdentifier: "CountriesId") as! ListCountriesVC
        popoverContent.listUnits = self.listUnits!
        
        popoverContent.modalPresentationStyle = UIModalPresentationStyle.popover
        let popover = popoverContent.popoverPresentationController
        popoverContent.preferredContentSize = CGSize(width: 220, height: (self.listUnits!.count < 6 ? 45 * self.listUnits!.count : 300))
        popover?.delegate = self
        popover?.sourceView = imgSelect
        popover?.sourceRect = sender.bounds
        
        popoverContent.selectedUnits = {(_ unit: GroupUnit) -> Void in
            self.btnUnits.setTitle(unit.unit_name, for: .normal)
            self.currentUnit = unit
            if self.currentUnit.factor == "1" {
                self.tfValue.text = "1"
            }
            else {
                self.tfValue.text = "100"
            }
            self.stepper.value = 1
            popoverContent.dismiss(animated: true, completion: nil)
        }
        self.present(popoverContent, animated: true, completion: nil)
    }
    
    @IBAction func addAction(_ sender: AnyObject) {
        self.view.endEditing(true)
        SVProgressHUD.show()
        
        let unitBuy: Double = Double(self.tfValue.text!)!
        let productId = (self.product?.product_id ?? "")!
        let quantity = "\(self.currentUnit.factor == "1" ? unitBuy : unitBuy / 1000)"
        let unit_price = self.product?.unit_price ?? ""
        let unit_id = (self.product?.unit_id ?? "")!
        let description = self.txtRemark.text ?? ""
        let pos_Id = SData.shared.current_posId ?? ""
        var request = AddCardRequest.init(posId: pos_Id, productId: productId, quantity: quantity, unitId: unit_id, unitPrice: Double(unit_price) ?? 0, cartDescription: description)
        
        let sData = "<orders><products><product_id>"
            .appending(productId)
            .appending("</product_id><parent_id></parent_id><collection_id></collection_id><color_id></color_id><quantity>")
            .appending(quantity)
            .appending("</quantity><unit_price>")
            .appending(unit_price)
            .appending("</unit_price><unit_id>")
            .appending(unit_id)
            .appending("</unit_id><description>")
            .appending(description.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")
            .appending("</description></products></orders>")
        
        if SData.shared.current_saleId == nil {
            MService.shared.getSale(pos_id: pos_Id) { (sale_Id, err) in
                if self.showError(err) {
                    SVProgressHUD.dismiss()
                    return
                }
                if sale_Id != nil {
                    SData.shared.current_saleId = sale_Id
                    request.saleId = sale_Id ?? ""
                    self.addProduct(SData.shared.current_saleId ?? "", pos_Id, sData, request)
                } else { SVProgressHUD.dismiss() }
            }
        } else {
            request.saleId = SData.shared.current_saleId ?? ""
            self.addProduct(SData.shared.current_saleId ?? "", pos_Id, sData, request)
        }
    }
    
    func addProduct(_ saleId: String, _ posId: String, _ rawData: String, _ req: AddCardRequest) {
        MService.shared.addProduct(sale_id: saleId, pos_id: posId, data: self.formatXMLString(rawData)) { (saleDetailId, err) in
            SVProgressHUD.dismiss()
            if self.showError(err) { return }
            if saleDetailId != nil {
                SData.shared.listDetailId.append(saleDetailId)
                self.backtoProduct()
            }
        }
//        MService.shared.mwApiCall2(cmd: "add", data: req.parameterDictionary)
        MService.shared.mwApiCall(cmd: "add", data: req.parameterDictionary)

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.currentUnit.factor == "1" {
            self.stepper.value = Double(textField.text! == "" ? "0" : textField.text!)!
        }
        else {
            self.stepper.value = (Double(textField.text! == "" ? "0" : textField.text!)!) / 100
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func formatXMLString(_ text: String) -> String {
        let xmlString = text
            .replacingOccurrences(of: "<", with: "%3C")
            .replacingOccurrences(of: ">", with: "%3E")
            .replacingOccurrences(of: "/", with: "%2F")
            .replacingOccurrences(of: " ", with: "+")
        return xmlString
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddToCart" {
            let _:CheckoutViewController = segue.destination as! CheckoutViewController
            //detailVC.item = ""
        }
    }

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
}
