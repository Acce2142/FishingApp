//
//  ReportFishViewController.swift
//  FishProduct
//
//

import UIKit
import CoreLocation
import MapKit
import Kingfisher
class ReportFishViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    var catchtimeStr : String?
    var longitudeStr : String?
    var latitudeStr : String?
    var dateStr : String?
    var timeStr : String?
    
    var locationManager: CLLocationManager?
    var fm:FishModel = FishModel.init()
    @IBOutlet var reportbtn: UIButton!
    @IBOutlet var fish_imageview: UIImageView!
    @IBOutlet var infoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        let url = URL(string: String(format: "http://partiklezoo.com/fish/%@", fm.image))
        fish_imageview.kf.setImage(with: url)
        let tap = UITapGestureRecognizer(target: self, action: #selector(imAction))

        fish_imageview.isUserInteractionEnabled=true
        fish_imageview.addGestureRecognizer(tap)
    
        
        infoTableView.frame = CGRect(x: 0, y: 290, width: view.frame.width, height: view.frame.height - 330)
        infoTableView?.tableFooterView = UIView()
        infoTableView?.delegate = self
        infoTableView?.dataSource = self
        infoTableView?.estimatedRowHeight = 60
        infoTableView?.rowHeight = UITableView.automaticDimension
        infoTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
        let date = NSDate()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyy-MM-dd"
        dateStr = timeFormatter.string(from: date as Date) as String
        timeFormatter.dateFormat = "HH:mm"
        timeStr = timeFormatter.string(from: date as Date) as String
        catchtimeStr = "catch time:" + dateStr! + " " + timeStr!
        longitudeStr = ""
        latitudeStr = ""
        self.locationFunc()
        reportbtn.frame = CGRect(x:self.view.frame.size.width / 2 - 40, y:view.frame.height - 90, width:80, height:30)
        reportbtn.setTitle("Report", for: .normal)
        reportbtn.backgroundColor = UIColor.yellow
        reportbtn.setTitleColor(UIColor.black, for: .normal)
        reportbtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        // Do any additional setup after loading the view.
    }
    @objc func imAction() -> Void {
        choisePhoto()
    }
    func choisePhoto(){
        let photoPicker =  UIImagePickerController()
        photoPicker.delegate = self
        photoPicker.allowsEditing = true
        photoPicker.sourceType = .photoLibrary
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image:UIImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        fish_imageview.image = image
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickReport(_ sender: UIButton) {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined, .restricted, .denied:
            let alertController = UIAlertController(title: "Error",
                                                    message: "Location service is disable", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                action in
                self.navigationController?.popViewController(animated: true)
            })
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        case .authorizedWhenInUse, .authorizedAlways:
            Network.sharedTool().ReportFish(fishid: fm.fish_id,image: fish_imageview.image,fishName: fm.fish_name, date: dateStr!, time: timeStr!, lon: longitudeStr!, lat: latitudeStr!) { (ret) in
                if ret{
                    let alertController = UIAlertController(title: "Tips",
                                                            message: "Report success", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                        action in
                        self.navigationController?.popViewController(animated: true)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else{
                    let alertController = UIAlertController(title: "Tips",
                                                            message: "Report fail", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                        action in
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
        
    }

    func locationFunc() -> Void {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = 100.0
        locationManager?.requestAlwaysAuthorization()
        if (CLLocationManager.locationServicesEnabled()){
            locationManager?.startUpdatingLocation()
            print("star location")
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = (tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)) as UITableViewCell
        let content_lb=UILabel(frame:CGRect(origin:CGPoint(x:20,y:0),size:CGSize(width:300,height:44)))
        content_lb.backgroundColor=UIColor.white
        content_lb.textColor = UIColor.black
        content_lb.font=UIFont.systemFont(ofSize:14)
        cells.contentView.addSubview(content_lb)
        if indexPath.row == 0 {
            content_lb.text = catchtimeStr
        }else if indexPath.row == 1 {
            content_lb.text = longitudeStr
        }else {
            content_lb.text = latitudeStr
        }
        return cells
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currLocation : CLLocation = locations.last!
        longitudeStr = "longitude:" + "\(currLocation.coordinate.longitude)"
        latitudeStr = "latitude:" + "\(currLocation.coordinate.latitude)"
        
        self.infoTableView?.reloadData()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error as Any)
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
