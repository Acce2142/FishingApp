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
        if(!getModel()){
            let name_lb=UILabel(frame:CGRect(origin:CGPoint(x:20,y:8),size:CGSize(width:view.frame.width,height:20)))
            name_lb.backgroundColor=UIColor.white
            name_lb.text = rm.fish_name
            name_lb.textColor = UIColor.black
            name_lb.font=UIFont.systemFont(ofSize:14)
            cells.contentView.addSubview(name_lb)
            
            
            let date = UILabel(frame:CGRect(origin:CGPoint(x:160,y:8),size:CGSize(width:view.frame.width,height:20)))
            date.backgroundColor = UIColor.white
            date.text = rm.date
            date.textColor = UIColor.black
            date.font = UIFont.systemFont(ofSize:14)
            cells.contentView.addSubview(date)
            
        } else {
            let name_lb=UILabel(frame:CGRect(origin:CGPoint(x:20,y:8),size:CGSize(width:view.frame.width,height:20)))
            name_lb.backgroundColor=UIColor.white
            name_lb.text = rm.fish_name
            name_lb.textColor = UIColor.black
            name_lb.font=UIFont.systemFont(ofSize:14)
            cells.contentView.addSubview(name_lb)
            
            
            let date = UILabel(frame:CGRect(origin:CGPoint(x:160,y:8),size:CGSize(width:view.frame.width,height:20)))
            date.backgroundColor = UIColor.white
            date.text = rm.date
            date.textColor = UIColor.black
            date.font = UIFont.systemFont(ofSize:14)
            cells.contentView.addSubview(date)
            
            let latitube = UILabel(frame:CGRect(origin:CGPoint(x:300,y:8),size:CGSize(width:view.frame.width,height:20)))
            latitube.backgroundColor = UIColor.white
            latitube.text = rm.lat
            latitube.textColor = UIColor.black
            latitube.font = UIFont.systemFont(ofSize:14)
            cells.contentView.addSubview(latitube)
            
            let lon = UILabel(frame:CGRect(origin:CGPoint(x:440,y:8),size:CGSize(width:view.frame.width,height:20)))
            lon.backgroundColor = UIColor.white
            lon.text = rm.lon
            lon.textColor = UIColor.black
            lon.font = UIFont.systemFont(ofSize:14)
            cells.contentView.addSubview(lon)
            
        }
        
        
        
        return cells
    }
    

    @IBOutlet weak var mytableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mytableView?.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height)
        mytableView?.tableFooterView = UIView()
        self.view.backgroundColor = UIColor.white
        
        mytableView?.tableFooterView = UIView()
        mytableView?.delegate = self
        mytableView?.dataSource = self
        mytableView?.estimatedRowHeight = 60
        mytableView?.rowHeight = UITableView.automaticDimension
        mytableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        // Do any additional setup after loading the view.
    }
    
    func getModel()->Bool{
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        print(identifier)
        switch identifier {
            
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return true
        case "iPad3,1", "iPad3,2", "iPad3,3":           return true
        case "iPad3,4", "iPad3,5", "iPad3,6":           return true
        case "iPad4,1", "iPad4,2", "iPad4,3":           return true
        case "iPad5,3", "iPad5,4":                      return true
        case "iPad2,5", "iPad2,6", "iPad2,7":           return true
        case "iPad4,4", "iPad4,5", "iPad4,6":           return true
        case "iPad4,7", "iPad4,8", "iPad4,9":           return true
        case "iPad5,1", "iPad5,2":                      return true
        case "iPad6,7", "iPad6,8":                      return true
        default:                                        return false
        }
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
