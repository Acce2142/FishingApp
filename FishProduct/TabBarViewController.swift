//
//  TabBarViewController.swift
//  FishProduct
//
//

import UIKit

class TabBarViewController: UITabBarController {
    var  items:NSArray = []
    let NameArr = ["Home","Find","Report","Idenfity"]
    let VCArr = [HomeViewController(),FindFishViewController(),ReportFishViewController(),IdentifyViewController()]
    var NavVCArr:[NSObject] = [NSObject]()
    var nav:UINavigationController = UINavigationController()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.CreatTabBar()
        // Do any additional setup after loading the view.
    }
    
    func CreatTabBar()  {
//        let  HomeVc  = HomeViewController()
//        HomeVc.title = "Home"
//        let HomeVcNavc = UINavigationController(rootViewController:HomeVc)
//        HomeVcNavc.tabBarItem.title = "Home"
//
//        let  FindFishVc  = FindFishViewController()
//        FindFishVc.title = "Find Fish"
//        let FindFishNaVc = UINavigationController(rootViewController:FindFishVc)
//        FindFishNaVc.tabBarItem.title = "Find"
//
//        let  ReportVc  = ReportFishViewController()
//        ReportVc.title = "Report Fish"
//        let ReportFishNaVc = UINavigationController(rootViewController:ReportVc)
//        ReportFishNaVc.tabBarItem.title = "Report"
//
//        let IdentifyVc  = IdentifyViewController()
//        IdentifyVc.title = "Identify Fish"
//        let IdentifyFishNaVc = UINavigationController(rootViewController:IdentifyVc)
//        IdentifyFishNaVc.tabBarItem.title = "Identify"
//
//        items = [HomeVcNavc,FindFishNaVc,ReportFishNaVc,IdentifyFishNaVc]
//        self.viewControllers = items as? [UIViewController]
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
