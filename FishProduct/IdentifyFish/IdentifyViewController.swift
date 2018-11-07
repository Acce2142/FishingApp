//
//  IdentifyViewController.swift
//  FishProduct
//
//  Created by wangbo on 2018/10/27.
//  Copyright © 2018年 PPLINGO. All rights reserved.
//

import UIKit
import SwiftyJSON
class IdentifyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var questionTbview: UITableView!
    var count = 0
    let questionArr :NSMutableArray = NSMutableArray.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        questionTbview.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height)
        questionTbview?.tableFooterView = UIView()
        questionTbview?.delegate = self
        questionTbview?.dataSource = self
        questionTbview?.estimatedRowHeight = 60
        questionTbview?.rowHeight = UITableView.automaticDimension

        questionTbview?.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        count = 0
        self.getQuestions()
    }

    @objc func clickYesBtn() -> Void {
        let questionObj = questionArr[count] as! QuestionModel
        let answerArr = JSON.init(parseJSON: questionObj.responses)
        let action :String = answerArr[0]["action"].string!
        if (action.contains("q")) {
            count = count + 1
            questionTbview.reloadData()
        }
        else if (action.contains("f")){
            let fms = CoreDataManage.sharedCoreData().SearchFishByID(fishid:action)
            let tempfmodel = fms[0]
            let alertController = UIAlertController(title: "Tips", message: String(format: "You have caught %@?", tempfmodel.fish_name ), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "YES", style: .default) { (UIAlertAction) in
                self.pushFishDetail(fishid: action)
            }
            let cancelAction = UIAlertAction(title: "Report", style: .default, handler: {
                action in
                self.tabBarController?.selectedIndex = 1
            })
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func  pushFishDetail(fishid:String) -> Void {
        let fms = CoreDataManage.sharedCoreData().SearchFishByID(fishid:fishid)
        if fms.count > 0 {
            let fishdetailVC:FishDetailViewController = FishDetailViewController()
            fishdetailVC.hidesBottomBarWhenPushed = true
            fishdetailVC.fm = fms[0]
            self.navigationController?.pushViewController(fishdetailVC, animated: true)
        }
    }
    
    @objc func clicknoBtn() -> Void {
        let questionObj = questionArr[count] as! QuestionModel
        let answerArr = JSON.init(parseJSON: questionObj.responses)
        let action :String = answerArr[1]["action"].string!
        if (action.contains("q")) {
            count = count + 1
            questionTbview.reloadData()
        }
        else if (action.contains("f")){
            let fms = CoreDataManage.sharedCoreData().SearchFishByID(fishid:action)
            let tempfmodel = fms[0]
            let alertController = UIAlertController(title: "Tips", message: String(format: "You have caught %@?", tempfmodel.fish_name ), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "YES", style: .default) { (UIAlertAction) in
                self.pushFishDetail(fishid: action)
            }
            let cancelAction = UIAlertAction(title: "Report", style: .default, handler: {
                action in
                self.tabBarController?.selectedIndex = 4
            })
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func getQuestions() -> Void {
        Network.sharedTool().GetQuestions(urlstr: "http://partiklezoo.com/fish/?action=questions") { (dataArray, true) in
            if dataArray == nil{
                return
            }else {
                DispatchQueue.main.async {
                    self.questionArr.removeAllObjects()
                    self.questionArr.addObjects(from: dataArray as! [Any])
                    self.questionTbview?.reloadData()
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if questionArr.count > 0{
            return 1
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = (tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)) as UITableViewCell
        for view in cells.contentView.subviews{
            view.removeFromSuperview()
        }
        let qm:QuestionModel = self.questionArr[count] as! QuestionModel
        
        let title_lb=UILabel(frame:CGRect(origin:CGPoint(x:20,y:5),size:CGSize(width:300,height:35)))
        title_lb.backgroundColor=UIColor.white
        title_lb.text = qm.question
        title_lb.textColor = UIColor.black
        title_lb.numberOfLines = 0
        title_lb.font=UIFont.systemFont(ofSize:14)
        cells.contentView.addSubview(title_lb)
        
        let yesBtn = UIButton(frame:CGRect(x:20, y:45, width:100, height:40))
        yesBtn.setTitle("YES", for: .normal)
        yesBtn.backgroundColor = UIColor.clear
        yesBtn.setTitleColor(UIColor.black, for: .normal)
        yesBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        let no_selectImage = UIImage(named:"no_select")?.withRenderingMode(.alwaysOriginal)
        yesBtn.setImage(no_selectImage, for:.normal)
        let selectImage = UIImage(named:"select")?.withRenderingMode(.alwaysOriginal)
        yesBtn.setImage(selectImage, for:.selected)
        yesBtn.addTarget(self, action:#selector(clickYesBtn), for: .touchUpInside)
        cells.contentView.addSubview(yesBtn)
        
        let noBtn = UIButton(frame:CGRect(x:20, y:90, width:95, height:40))
        noBtn.setTitle("NO", for: .normal)
        noBtn.backgroundColor = UIColor.clear
        noBtn.setTitleColor(UIColor.black, for: .normal)
        noBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        noBtn.setImage(no_selectImage, for:.normal)
        noBtn.setImage(selectImage, for:.selected)
        noBtn.addTarget(self,action:#selector(clicknoBtn), for: .touchUpInside)

        cells.contentView.addSubview(noBtn)
        return cells
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        tableView.deselectRow(at: indexPath, animated: true)
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
