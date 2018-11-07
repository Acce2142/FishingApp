//
//  SearchFishTableViewController.swift
//  FishProduct
//
//  Created by wangbo on 2018/10/31.
//  Copyright © 2018年 PPLINGO. All rights reserved.
//

import UIKit

class SearchFishTableViewController: UITableViewController,UISearchBarDelegate {
    var searchBar = UISearchBar.init()
    var fishesarray:[FishModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar = UISearchBar.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        searchBar.delegate = self;
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cellID")
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "searchBarID")
        self.view.backgroundColor = UIColor.white
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchFishByKeyword(detail: searchBar.text)
    }
   
    func searchFishByKeyword(detail:String?) -> Void {
        let results = CoreDataManage.sharedCoreData().SearchFishByKeyword(text: detail!)
        fishesarray.removeAll()
        fishesarray.append(contentsOf: results)
        self.tableView.reloadData()
    }
    // MARK: - Table view data source
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }else {
            return fishesarray.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchBarID", for: indexPath)
            for view in cell.contentView.subviews{
                view.removeFromSuperview()
            }
            cell.contentView.addSubview(searchBar)
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
            // Configure the cell...
            cell.textLabel?.text = fishesarray[indexPath.row].fish_name
            return cell
        }
        // Configure the cell...
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        tableView.deselectRow(at: indexPath, animated: true)
        let fishdetailVC:FishDetailViewController = FishDetailViewController()
        fishdetailVC.hidesBottomBarWhenPushed = true
        fishdetailVC.fm = fishesarray[indexPath.row]
        self.navigationController?.pushViewController(fishdetailVC, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
