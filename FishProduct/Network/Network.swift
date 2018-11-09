//
//  Network.swift
//  FishProduct
//
//

import UIKit
import SwiftyJSON
import Alamofire

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
        //print(url);
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
    
    func IdentifyFish(image:UIImage,date_Str:String,time_Str:String,lon:String,lat:String,callBack:@escaping (Bool) ->()) -> Void {
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append("photo.jpeg".data(using: String.Encoding.utf8)!, withName: "photo")
                multipartFormData.append("identifyfish".data(using: String.Encoding.utf8)!, withName: "action")
                multipartFormData.append(date_Str.data(using: String.Encoding.utf8)!, withName: "date")
                multipartFormData.append(time_Str.data(using: String.Encoding.utf8)!, withName: "time")
                multipartFormData.append(lon.data(using: String.Encoding.utf8)!, withName: "longitude")
                multipartFormData.append(lat.data(using: String.Encoding.utf8)!, withName: "latitude")
        },
            to: "http://partiklezoo.com/fish/",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseString { response in
                        switch(response.result) {
                        case .success(_):
                            if let data = response.result.value{
                                print(data)
                                if data.contains("true") {
                                    print("identify info uploaded")
                                    callBack(true)
                                } else {
                                    callBack(false)
                                }
                            }
                        case .failure(_):
                            callBack(false)
                            
                        }
                    }
                case .failure(let encodingError):
                    callBack(false)
                    print(encodingError)
                }
                
        }
        )
    }
    private func getRandomBoundary() -> String {
        return String(format: "WebKitFormBoundary%08x%08x", arc4random(), arc4random())
    }
}


