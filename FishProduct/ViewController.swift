//
//  ViewController.swift
//  FishProduct
//
//  Created by wangbo on 2018/10/27.
//  Copyright © 2018年 PPLINGO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var agreement_lb: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        agreement_lb.frame = CGRect(x: 10, y: 64, width: view.frame.width - 20, height: 300)
        agreement_lb.backgroundColor = UIColor.white
        agreement_lb.text = "Privacy Policy.\n\nIf you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.Information Collection and Use\n\nFor a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to fish data, catch time, longitude, latitude. The information that I request will be retained on your device and is not collected by me in any way."
        agreement_lb.textColor = UIColor.black
        agreement_lb.font=UIFont.systemFont(ofSize:14)
        agreement_lb.numberOfLines = 0
 
        let agreebtn = UIButton(frame:CGRect(x:view.frame.width / 2 - 50, y:view.frame.height -  60, width:100, height:30))
        agreebtn.setTitle("Agree", for: .normal)
        agreebtn.backgroundColor = UIColor.red
        agreebtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        agreebtn .addTarget(self, action: #selector(clickAgree(_:)), for: .touchUpInside)
        self.view.addSubview(agreebtn)
        
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func clickAgree(_ sender: UIButton) {
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let tabVC:TabBarViewController = sb.instantiateViewController(withIdentifier: "tabbarviewController") as! TabBarViewController
        UIApplication.shared.keyWindow?.rootViewController = tabVC
    }


}

