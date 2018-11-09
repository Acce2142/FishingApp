//
//  UploadViewController.swift
//  FishProduct
//
//  Created by apple on 8/11/18.
//  Copyright © 2018 PPLINGO. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation
class UploadViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate{
    var dateStr = ""
    var timeStr = ""
    var longtitube = ""
    var latitube = ""
    var locationManager: CLLocationManager?
    @IBOutlet weak var FishImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationFunc()
        
        // Do any additional setup after loading the view.
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currLocation : CLLocation = locations.last!
        longtitube = "\(currLocation.coordinate.longitude)"
        latitube = "\(currLocation.coordinate.latitude)"
    }
    func locationFunc() -> Void {
        locationManager = CLLocationManager()
        locationManager?.delegate = self as? CLLocationManagerDelegate
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = 100.0
        locationManager?.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled()){
            locationManager?.startUpdatingLocation()
            print("start location")
        }else{
            print("location disabled")
        }
    }
    @IBAction func Upload(_ sender: Any) {
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        dateStr = timeFormatter.string(from: date as Date) as String
        timeFormatter.dateFormat = "HH:mm"
        timeStr = timeFormatter.string(from: date as Date) as String
        Network.sharedTool().IdentifyFish(image: FishImage.image!, date_Str: dateStr, time_Str: timeStr, lon: longtitube, lat: latitube) { (ret) in
            if ret{
                //fine
                let alertController = UIAlertController(title: "Tips",
                                                        message: "Upload success", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                    action in
                    self.navigationController?.popViewController(animated: true)
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                //fine
                let alertController = UIAlertController(title: "Tips",
                                                        message: "Upload fail", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                    action in
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        if(FishImage.image == nil){
            let alertController = UIAlertController(title: "Tips",
                                                    message: "Please choose a image first", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                action in
                self.navigationController?.popViewController(animated: true)
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            switch CLLocationManager.authorizationStatus(){
            case .notDetermined, .restricted, .denied :
                let alertController = UIAlertController(title: "Tips",
                                                        message: "Location service is disable", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                    action in
                    self.navigationController?.popViewController(animated: true)
                })
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            case .authorizedAlways, .authorizedWhenInUse:
                Network.sharedTool().IdentifyFish(image: FishImage.image!, date_Str: dateStr, time_Str: timeStr, lon: longtitube, lat: latitube) { (ret) in
                    if ret{
                        let alertController = UIAlertController(title: "Tips",
                                                                message: "Upload success", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                            action in
                            self.navigationController?.popViewController(animated: true)
                        })
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    else{
                        let alertController = UIAlertController(title: "Tips",
                                                                message: "Upload fail", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                            action in
                        })
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }        }
    }
    
    @IBAction func Photo(_ sender: Any) {
        let imagePickerController = UIImagePickerController();
        imagePickerController.delegate = self;
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
                
            } else {
                let warning = UIAlertController(title: "Camera failure", message: "Camera is not available ", preferredStyle: .actionSheet)
                warning.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(warning, animated: true, completion: nil)
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        FishImage.image = image;
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
