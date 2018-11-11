//
//  SerializationReport.swift
//  FishProduct
//
//  Created by ohashi on 2018/11/11.
//  Copyright © 2018年 PPLINGO. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class SerializationReport: NSObject {
    static let instance: SerializationReport = SerializationReport()
    class func shareSerialization() -> SerializationReport {
        return instance
    }
    /*
    func SerializationData(dataArr:JSON) -> NSArray {
        let fishlistArr:NSMutableArray = NSMutableArray.init()
        for (_,subJson):(String, JSON) in dataArr {
            print(index)
            let reportmodel = ReportModel.init();
     
            fishmodel.commonnames = subJson["commonnames"].string!
            fishmodel.fish_description = subJson["description"].string!
            fishmodel.fish_id = subJson["fishid"].string!
            fishmodel.image = subJson["image"].string!
            fishmodel.fish_name = subJson["name"].string!
            fishmodel.fish_regions = subJson["regions"].string!
            fishmodel.fish_restriction = subJson["restrictions"].string!
            fishmodel.scientificname = subJson["scientificname"].string!
            DispatchQueue.main.async {
                CoreDataManage.sharedCoreData().InsertFish(fish:fishmodel)
            }
            fishlistArr.add(fishmodel)
        }
 
        return fishlistArr
    }
 */
        
}
