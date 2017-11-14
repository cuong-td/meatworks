//
//  AboutViewController.swift
//  MeatWorks
//
//  Created by Phan Quoc Thanh on 10/2/17.
//  Copyright © 2017 PQT. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var imgGallery: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbAllOur: UILabel!
    @IBOutlet weak var lbAbout1: UILabel!
    @IBOutlet weak var lbQuality: UILabel!
    @IBOutlet weak var lbAbout2: UILabel!
    @IBOutlet weak var lbAboutUs: UILabel!
    @IBOutlet weak var lbAbout3: UILabel!
    @IBOutlet weak var lbGalerry: UILabel!
    
    var photosGallery = [#imageLiteral(resourceName: "img1"), #imageLiteral(resourceName: "img2"), #imageLiteral(resourceName: "img3")]
    var currentIndex = 0
    //var timer : Timer = Timer()
    
//    deinit {
//        timer.invalidate()
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgGallery.image = photosGallery[currentIndex]
        //timer.invalidate()
        //timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(self.changePhotoGallery), userInfo: nil, repeats: true)
        
        self.lbTitle.text = "WHYSHOPHERE".localized()
        self.lbAllOur.text = "ALLOUR".localized()
        self.lbAbout1.text = "About1".localized()
        self.lbQuality.text = "FINESTQUALITY".localized()
        self.lbAbout2.text = "About2".localized()
        self.lbAboutUs.text = "ABOUTM".localized()
        self.lbAbout3.text = "About3".localized()
        self.lbGalerry.text = "GALLERRY".localized()

        self.title = "About".localized()
    }

    @IBAction func openMenu(_ sender: AnyObject) {
        self.openLeft()
    }
    
    func changePhotoGallery() {
        DispatchQueue.main.async { [weak self] in
            self?.currentIndex += 1
            if self?.currentIndex == self?.photosGallery.count {
                self?.currentIndex = 0
            }
            self?.changePhotoWith(imageIndex: self?.currentIndex, animation: self?.animationRight())
        }
    }
    
    @IBAction func previousTapped(_ sender: UIButton) {
        currentIndex -= 1
        if currentIndex < 0 {
            currentIndex = 0
            return
        }
        
        changePhotoWith(imageIndex: currentIndex, animation: animationLeft())
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        currentIndex += 1
        if currentIndex > photosGallery.count - 1 {
            currentIndex = photosGallery.count - 1
            return
        }
        
        changePhotoWith(imageIndex: currentIndex, animation: animationRight())
    }
    
    func changePhotoWith(imageIndex: Int?, animation: CATransition?) {
        guard let index = imageIndex, let ani = animation else {return}
        imgGallery.image = photosGallery[index]
        imgGallery.layer.add(ani, forKey: nil)
    }
    
    func animationRight() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.2
        transition.subtype = kCATransitionFromRight
        transition.type = kCATransitionPush
        return transition
    }
    
    func animationLeft() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.2
        transition.subtype = kCATransitionFromLeft
        transition.type = kCATransitionPush
        return transition
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
