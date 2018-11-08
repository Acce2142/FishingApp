//
//  SerializationQuestion.swift
//  FishProduct
//
//  Created by wangbo on 2018/10/27.
//  Copyright © 2018年 PPLINGO. All rights reserved.
//

import UIKit
import SwiftyJSON

class SerializationQuestion: NSObject {
    static let instance: SerializationQuestion = SerializationQuestion()
    class func shareSerialization() -> SerializationQuestion {
        return instance
    }
    func SerializationData(dataArr:JSON) -> NSArray {
        let questionArr:NSMutableArray = NSMutableArray.init()
        for (_,subJson):(String, JSON) in dataArr {
            print(index)
            let questionModel = QuestionModel.init()
            questionModel.id = subJson["id"].string!
            questionModel.question = subJson["question"].string!
            questionModel.responses = self.ArrValueString(arr: subJson["responses"].arrayObject! as NSArray)!
            DispatchQueue.main.async {
                CoreDataManage.sharedCoreData().InsertQuestion(q: questionModel)
            }
            questionArr.add(questionModel)
        }
        return questionArr
    }
    func ArrValueString(arr:NSArray) -> String?{
        if (!JSONSerialization.isValidJSONObject(arr)) {
            return ""
        }
        
        let data : NSData = try! JSONSerialization.data(withJSONObject: arr, options: []) as NSData
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
}
