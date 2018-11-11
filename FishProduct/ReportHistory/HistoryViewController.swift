//
//  HistoryViewController.swift
//  FishProduct
//
//  Created by ohashi on 2018/11/11.
//  Copyright © 2018年 PPLINGO. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    let history :NSMutableArray = NSMutableArray.init()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history.count
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getReportList()
    }
    func getReportList() -> Void {
        DispatchQueue.main.async {
            let arr:[ReportModel] = CoreDataManage.sharedCoreData().getAllReports()
            if arr.count > 0 {
                self.history.removeAllObjects()
                self.history.addObjects(from: arr as! [Any])
                self.mytableView?.reloadData()
            }
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = (tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)) as UITableViewCell
        for view in cells.contentView.subviews{
            view.removeFromSuperview()
        }
        let rm:ReportModel = self.history[indexPath.row] as! ReportModel
        
        let name_lb=UILabel(frame:CGRect(origin:CGPoint(x:100,y:8),size:CGSize(width:200,height:20)))
        name_lb.backgroundColor=UIColor.white
        name_lb.text = rm.fish_name
        name_lb.textColor = UIColor.black
        name_lb.font=UIFont.systemFont(ofSize:14)
        cells.contentView.addSubview(name_lb)
        
        
        let commonName_lb = UILabel(frame:CGRect(origin:CGPoint(x:100,y:30),size:CGSize(width:200,height:20)))
        commonName_lb.backgroundColor = UIColor.white
        commonName_lb.text = rm.date
        commonName_lb.textColor = UIColor.black
        commonName_lb.font = UIFont.systemFont(ofSize:14)
        cells.contentView.addSubview(commonName_lb)
        
        return cells
    }
    

    @IBOutlet weak var mytableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        mytableView?.tableFooterView = UIView()
        mytableView?.delegate = self
        mytableView?.dataSource = self
        mytableView?.estimatedRowHeight = 60
        mytableView?.rowHeight = UITableView.automaticDimension
        mytableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        // Do any additional setup after loading the view.
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
