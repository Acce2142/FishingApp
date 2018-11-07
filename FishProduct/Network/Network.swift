//
//  Network.swift
//  FishProduct
//
//  Created by wangbo on 2018/10/27.
//  Copyright © 2018年 PPLINGO. All rights reserved.
//

import UIKit
import SwiftyJSON

class Network: NSObject {
    static let instance: Network = Network()
    class func sharedTool() -> Network {
        return instance
    }
    func GetFishList(urlstr: String, callBack:@escaping (NSArray?,Bool) ->()) -> Void {
        let url = URL(string:urlstr)
        URLSession(configuration: .default).dataTask(with: url!, completionHandler: {
            (data, rsp, error) in
            if error != nil{
                callBack(nil,false)
            }
            else{
                let jsonArr = JSON(data!)
                let serialization = SerializationFish.shareSerialization().SerializationData(dataArr: jsonArr)
                callBack(serialization,true)
            }
        }).resume()
    }
    func GetQuestions(urlstr: String, callBack:@escaping (NSArray?,Bool) ->()) -> Void {
        let url = URL(string:urlstr)
        URLSession(configuration: .default).dataTask(with: url!, completionHandler: {
            (data, rsp, error) in
            if error != nil{
                callBack(nil,false)
            }
            else{
                let jsonArr = JSON(data!)
                print(jsonArr)
                let serialization = SerializationQuestion.shareSerialization().SerializationData(dataArr: jsonArr)
                callBack(serialization,true)
            }
        }).resume()
    }
    typealias postActionClosure = (_ data: Data, _ response: URLResponse) -> Void

    func ReportFish(fishid:String,image:UIImage?,fishName:String, date:String,time:String,lon:String,lat:String,callBack:@escaping (Bool) ->()) -> Void {
        
        let baseUrl = "http://www.partiklezoo.com/fish/?action=reportfish&"
        
        let url = URL(string:String(format: "%@fishid=%@&date=%@&time=%@&longitude=%@&latitude=%@", baseUrl,fishid,date,time,lon,lat))
        
        URLSession(configuration: .default).dataTask(with: url!, completionHandler: {
            (data, rsp, error) in
            if error != nil{
                callBack(false)
            }
            else{
                let dic = JSON(data!)
                if dic["success"].string == "true" {
                    callBack(true)
                }
                else{
                    callBack(false)
                }
            }
        }).resume()
    }
    
    private func getRandomBoundary() -> String {
        return String(format: "WebKitFormBoundary%08x%08x", arc4random(), arc4random())
    }
}


