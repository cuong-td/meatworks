//
//  CheckoutViewController.swift
//  MeatWorks
//
//  Created by fwThanh on 10/8/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit
import SVProgressHUD

class CheckoutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var cTableView: UITableView!
    @IBOutlet var btnCheckout: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Checkout".localized()
        // Do any additional setup after loading the view.
        btnCheckout.layer.cornerRadius = 5.0
        self.cTableView.tableFooterView = UIView()
        
        self.changeText()
        
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.show()
        
        MService.shared.getCartItems(saleId: SData.shared.current_saleId!) { (listCartItems) in
            SData.shared.listCartItems?.removeAll()
            SData.shared.listCartItems = listCartItems
            self.cTableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }

    func changeText() {
        self.btnCheckout.setTitle("Checkout".localized(), for: .normal)
    }
    
    
    @IBAction func backAction(_ sender: AnyObject) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func checkoutAction(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "Delivery", sender:nil)
    }
    
    // MARK: - UICollectionViewDelegate protocol
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SData.shared.listCartItems != nil ? SData.shared.listCartItems!.count : 0
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CheckoutViewCell = tableView.dequeueReusableCell(withIdentifier: "CheckoutViewCellId") as! CheckoutViewCell!
        let value: Cart = SData.shared.listCartItems![indexPath.row] as Cart
        let urlImg = "http://online.meatworksasia.com/photo.aspx?id=\(value.photo ?? "")".replacingOccurrences(of: " ", with: "%20")
        cell.imgView.image = UIImage.image(fromURL: urlImg, placeholder: UIImage(named: "Header")!, shouldCacheImage: true) { (image) in
            cell.imgView.image = nil
            cell.imgView.image = image
        }
        cell.lbName.text = value.product_name
        cell.lbUnit.text = "x\(value.input_quantity ?? "")(\(value.unit_name ?? ""))"
        
        let dValue: Double = Double(value.unit_price ?? "0")!
        cell.lbPrice.text = dValue.formatAsCurrency(currencyCode: value.currency_id ?? "VND")
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action:#selector(self.deleteItem), for: .touchUpInside)
        
        return cell
    }
    
    func deleteItem(sender: UIButton!) {
        let index = sender.tag
        let value: Cart = SData.shared.listCartItems![index] as Cart
        SVProgressHUD.show()
        MService.shared.removeProduct(sale_detail_id: value.sale_detail_id!, pos_id: SData.shared.current_posId!) { (success) in
            SData.shared.listCartItems?.remove(at: index)
            SData.shared.listDetailId.remove(at: index)
            self.cTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            SVProgressHUD.dismiss()
            if SData.shared.listDetailId.count == 0 {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Delivery" {
            let _:DeliveryViewController = segue.destination as! DeliveryViewController
        }
    }
}

extension Double {
    func formatAsCurrency(currencyCode: String) -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = NumberFormatter.Style.currency
        currencyFormatter.currencyCode = currencyCode
        currencyFormatter.locale = (currencyCode == "VND" ? Locale(identifier: "vi") : Locale(identifier: "en"))
        currencyFormatter.maximumFractionDigits = floor(self) == self ? 0 : 2
        let locale = NSLocale(localeIdentifier: currencyCode)
        let currencySymbol = locale.displayName(forKey: .currencySymbol, value: currencyCode) ?? currencyCode
        return currencyFormatter.string(from: NSNumber(value: self))?.replacingOccurrences(of: currencySymbol, with: "").replacingOccurrences(of: " ", with: "")
    }
}
