//
//  MenuViewController.swift
//  MeatWorks
//
//  Created by fwThanh on 9/30/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var btnProduct: UIButton!
    @IBOutlet var btnAbout: UIButton!
    @IBOutlet var btnContact: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        btnProduct.setBackgroundColor(color: UIColor(hexString: "#D1D0D1"), forUIControlState: .selected)
        btnAbout.setBackgroundColor(color: UIColor(hexString: "#D1D0D1"), forUIControlState: .selected)
        btnContact.setBackgroundColor(color: UIColor(hexString: "#D1D0D1"), forUIControlState: .selected)
        
        if self.slideMenuController()?.mainViewController?.navigationController?.title == "About" {
            self.btnProduct.isSelected = false
            self.btnAbout.isSelected = true
            self.btnContact.isSelected = false
        }
        else if self.slideMenuController()?.mainViewController?.navigationController?.title == "Contact" {
            self.btnProduct.isSelected = false
            self.btnAbout.isSelected = false
            self.btnContact.isSelected = true
        }
        else {
            self.btnProduct.isSelected = true
            self.btnAbout.isSelected = false
            self.btnContact.isSelected = false
        }
    }

    @IBAction func productAction(_ sender: AnyObject) {
        //self.closeLeft()
        self.btnProduct.isSelected = true
        self.btnAbout.isSelected = false
        self.btnContact.isSelected = false
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "ViewControllerId")
        self.slideMenuController()?.changeMainViewController(mainViewController, close: true)
    }
    
    @IBAction func aboutAction(_ sender: AnyObject) {
        //self.closeLeft()
        self.btnProduct.isSelected = false
        self.btnAbout.isSelected = true
        self.btnContact.isSelected = false
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "AboutViewControllerId")
        self.slideMenuController()?.changeMainViewController(mainViewController, close: true)
    }
    
    @IBAction func contactAction(_ sender: AnyObject) {
        //self.closeLeft()
        self.btnProduct.isSelected = false
        self.btnAbout.isSelected = false
        self.btnContact.isSelected = true
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "ContactViewControllerId")
        self.slideMenuController()?.changeMainViewController(mainViewController, close: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIButton {
    
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    func setBackgroundColor(color: UIColor, forUIControlState state: UIControlState) {
        self.setBackgroundImage(imageWithColor(color: color), for: state)
    }
    
}
