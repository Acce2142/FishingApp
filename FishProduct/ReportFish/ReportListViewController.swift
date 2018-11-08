//
//  ReportListViewController.swift
//  FishProduct
//
//  Created by wangbo on 2018/10/31.
//  Copyright © 2018年 PPLINGO. All rights reserved.
//

import UIKit

class ReportListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    @IBOutlet var listtableview: UITableView!
    let fishelist :NSMutableArray = NSMutableArray.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        listtableview?.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height)
        listtableview?.tableFooterView = UIView()
        listtableview?.delegate = self
        listtableview?.dataSource = self
        listtableview?.estimatedRowHeight = 60
        listtableview?.rowHeight = UITableView.automaticDimension
        listtableview?.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        self.getFishAllList()
        // Do any additional setup after loading the view.
    }
    
    func getFishAllList(){
        let arr:[FishModel] = CoreDataManage.sharedCoreData().FindAllFish()
        if arr.count > 0 {
            fishelist.removeAllObjects()
            fishelist.addObjects(from: arr)
            self.listtableview?.reloadData()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fishelist.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = (tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)) as UITableViewCell
        let fm:FishModel = self.fishelist[indexPath.row] as! FishModel
        
        let name_lb=UILabel(frame:CGRect(origin:CGPoint(x:100,y:8),size:CGSize(width:200,height:20)))
        name_lb.backgroundColor=UIColor.white
        name_lb.text = fm.fish_name
        name_lb.textColor = UIColor.black
        name_lb.font=UIFont.systemFont(ofSize:14)
        cells.contentView.addSubview(name_lb)
        
        let url = URL(string: String(format: "http://partiklezoo.com/fish/%@", fm.image))
        let fish_imageView = UIImageView(frame:CGRect(origin:CGPoint(x:20,y:5),size:CGSize(width:50,height:50)))
        fish_imageView.layer.cornerRadius = 8
        fish_imageView.layer.masksToBounds = true
        fish_imageView.kf.setImage(with: url)
        cells.contentView.addSubview(fish_imageView)
        
        let commonName_lb = UILabel(frame:CGRect(origin:CGPoint(x:100,y:30),size:CGSize(width:200,height:20)))
        commonName_lb.backgroundColor = UIColor.white
        commonName_lb.text = fm.scientificname
        commonName_lb.textColor = UIColor.black
        commonName_lb.font = UIFont.systemFont(ofSize:14)
        cells.contentView.addSubview(commonName_lb)
        
        return cells
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        tableView.deselectRow(at: indexPath, animated: true)
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let reportdetailVC:ReportFishViewController = sb.instantiateViewController(withIdentifier: "ReportFishViewController") as! ReportFishViewController
        reportdetailVC.title = "Report fish"
        reportdetailVC.fm = fishelist[indexPath.row] as! FishModel
        reportdetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(reportdetailVC, animated: true)
        
//        let reportdetailVC:ReportFishViewController = sb.instantiateViewController(withIdentifier:"ReportFishViewController") as! ReportFishViewController
//        reportdetailVC.hidesBottomBarWhenPushed = true
//        reportdetailVC.fm = fishelist[indexPath.row] as! FishModel
//        self.navigationController?.pushViewController(reportdetailVC, animated: true)
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
