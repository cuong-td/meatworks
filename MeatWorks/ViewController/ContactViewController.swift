//
//  ContactViewController.swift
//  MeatWorks
//
//  Created by Phan Quoc Thanh on 10/2/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit
import MessageUI

class ContactViewController: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "ContactUs".localized()
    }

    @IBAction func openMenu(_ sender: AnyObject) {
        self.openLeft()
    }
    
    @IBAction func callPhone(_ sender: AnyObject) {
        if let url = NSURL(string: "tel://0837442565"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    @IBAction func sendMail(_ sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["thanh@meatworksasia.com"])
            present(mail, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
