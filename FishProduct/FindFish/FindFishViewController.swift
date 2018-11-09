//
//  FindFishViewController.swift
//  FishProduct
//
//  Created by wangbo on 2018/10/27.
//  Copyright © 2018年 PPLINGO. All rights reserved.
//

import UIKit
import Kingfisher

class FindFishViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
  
    @IBOutlet var mytableView: UITableView!
    var internet:Bool = true;
    let fishes :NSMutableArray = NSMutableArray.init()
//    var mytableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        mytableView?.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height)
        mytableView?.tableFooterView = UIView()
        mytableView?.delegate = self        
        mytableView?.dataSource = self
        mytableView?.estimatedRowHeight = 60
        mytableView?.rowHeight = UITableView.automaticDimension
        mytableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         self.getFishesList()
    }
    func getFishesList() -> Void {
        Network.sharedTool().GetFishList(urlstr: "http://www.partiklezoo.com/fish/?action=fishlist") { (dataArray, true) in
            if dataArray == nil{
                
                self.internet = false
                DispatchQueue.main.async {
                    let arr:[FishModel] = CoreDataManage.sharedCoreData().FindAllFish()
                    if arr.count > 0 {
                        self.fishes.removeAllObjects()
                        self.fishes.addObjects(from: arr as! [Any])
                        self.mytableView?.reloadData()
                    }
                }
                
            }else {
                DispatchQueue.main.async {
                    self.fishes.removeAllObjects()
                    self.fishes.addObjects(from: dataArray as! [Any])
                    self.mytableView?.reloadData()
                }
            }
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fishes.count
    }
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = (tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)) as UITableViewCell
        for view in cells.contentView.subviews{
            view.removeFromSuperview()
        }
        let fm:FishModel = self.fishes[indexPath.row] as! FishModel
       
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
        let fishdetailVC:FishDetailViewController = FishDetailViewController()
        fishdetailVC.hidesBottomBarWhenPushed = true
        fishdetailVC.fm = fishes[indexPath.row] as! FishModel
        self.navigationController?.pushViewController(fishdetailVC, animated: true)
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
