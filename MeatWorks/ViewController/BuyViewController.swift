//
//  BuyViewController.swift
//  MeatWorks
//
//  Created by fwThanh on 10/8/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit
import SVProgressHUD

class BuyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var bTableView: UITableView!
    @IBOutlet var lb1: UILabel!
    @IBOutlet var lb2: UILabel!
    @IBOutlet var lb3: UILabel!
    @IBOutlet var btnPrevious: UIButton!
    @IBOutlet var btnBuy: UIButton!
    @IBOutlet var lbSubTotal: UILabel!
    @IBOutlet var lbValueSubTotal: UILabel!
    @IBOutlet var lbTotal: UILabel!
    @IBOutlet var lbValueTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Checkout".localized()
        
        lb1.layer.cornerRadius = 20.0
        lb2.layer.borderWidth = 5.0
        lb2.layer.borderColor = UIColor(hexString: "#4E549D").cgColor
        lb2.layer.cornerRadius = 20.0
        btnBuy.layer.cornerRadius = 5.0
        btnPrevious.layer.cornerRadius = 5.0
        
        self.bTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        self.changeText()
        SVProgressHUD.setDefaultMaskType(.clear)
        
        var total = 0.0
        for value in SData.shared.listCartItems! {
            let unit: Double    = Double(value.input_quantity!)!
            let price: Double   = Double(value.unit_price!)!
            total = (unit * price) + total
        }
        lbValueSubTotal.text = total.formatAsCurrency(currencyCode: "VND")
        lbValueTotal.text = total.formatAsCurrency(currencyCode: "VND")
    }

    func changeText() {
        self.lbSubTotal.text = "SubTotal".localized()
        self.lbTotal.text = "Total".localized()
        self.lb3.text = "dDelivery".localized()
        self.btnBuy.setTitle("Buy".localized(), for: .normal)
        self.btnPrevious.setTitle("Previous".localized(), for: .normal)
    }
    
    @IBAction func backAction(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func previousAction(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buyAction(_ sender: AnyObject) {
        SVProgressHUD.show()
        let deliveryInfo = Meatworks.deliveryInfo
        MService.shared.postOrder(sale_id: SData.shared.current_saleId!, fullName: (deliveryInfo?.fullname!)!, phone: (deliveryInfo?.phone!)!, address: (deliveryInfo?.address!)!, direction: (deliveryInfo?.direction!)!) { (success) in
            SVProgressHUD.dismiss()
            SData.shared.listDetailId.removeAll()
            SData.shared.listCartItems?.removeAll()
            for controller in self.navigationController!.viewControllers as Array {
                if controller.isKind(of: ViewController.self) {
                    self.slideMenuController()?.addLeftGestures()
                    self.navigationController!.popToViewController(controller, animated: true)
                    break
                }
            }
        }
    }
    
    // MARK: - UICollectionViewDelegate protocol
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SData.shared.listCartItems != nil ? SData.shared.listCartItems!.count : 0
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:BuyTbViewCell = tableView.dequeueReusableCell(withIdentifier: "BuyTbViewCellId") as! BuyTbViewCell!
        let value: Cart = SData.shared.listCartItems![indexPath.row] as Cart
        let urlImg = "http://online.meatworksasia.com/photo.aspx?id=\(value.photo ?? "")".replacingOccurrences(of: " ", with: "%20")
        cell.imgView.image = UIImage.image(fromURL: urlImg, placeholder: UIImage(named: "Header")!, shouldCacheImage: true) { (image) in
            cell.imgView.image = nil
            cell.imgView.image = image
        }
        cell.lbCode.text = "Ref No: \(value.product_code ?? "")"
        cell.lbName.text = value.product_name
        cell.lbUnit.text = "x\(value.input_quantity ?? "")(\(value.unit_name ?? ""))"
        
        let dValue: Double = Double(value.unit_price ?? "0")!
        cell.lbPrice.text = dValue.formatAsCurrency(currencyCode: value.currency_id ?? "VND")
        
        let unit: Double    = Double(value.input_quantity!)!
        let price: Double   = Double(value.unit_price!)!
        cell.lbVPrice.text = (unit * price).formatAsCurrency(currencyCode: value.currency_id ?? "VND")
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
