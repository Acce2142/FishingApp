
import UIKit

class FishDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var detailTb : UITableView?
    var fm:FishModel = FishModel.init()
    let infoArray :NSMutableArray = NSMutableArray.init()
    var subTitleArr = ["Common Name:","Scientific:","Description:","Regions:","Restriction:"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "Fish Detail"
        self.initinfoArr()
        detailTb = UITableView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height-64) , style: .plain)
        detailTb?.tableFooterView = UIView()
        detailTb?.delegate = self
        detailTb?.dataSource = self
        detailTb?.estimatedRowHeight = 60
        detailTb?.rowHeight = UITableView.automaticDimension
        view.addSubview(detailTb!)
        
        detailTb?.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
        // Do any additional setup after loading the view.
    }
    func initinfoArr() -> Void {
        infoArray.add(fm.commonnames)
        infoArray.add(fm.scientificname)
        infoArray.add(fm.fish_description)
        infoArray.add(fm.fish_regions)
        infoArray.add(fm.fish_restriction)
    }



    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        if indexPath.section == 0 {
            return 230
        }else {
            let string =  self.infoArray[indexPath.row] as! String
            let size = string.boundingRect(with: CGSize(width: self.view.frame.size.width - 30, height: 1000), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)], context: nil)
            let height = CGFloat(size.height + 45)
            if (height > 80) {
                return height
            }else {
                return 80
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = (tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)) as UITableViewCell
        for view in cells.contentView.subviews{
            view.removeFromSuperview()
        }
        if indexPath.section == 0 {
            let url = URL(string: String(format: "http://partiklezoo.com/fish/%@", fm.image))
            let fish_imageView = UIImageView(frame:CGRect(origin:CGPoint(x:0,y:0),size:CGSize(width:view.frame.width,height:200)))
            fish_imageView.kf.setImage(with: url)
            cells.contentView.addSubview(fish_imageView)
            
            let name_lb=UILabel(frame:CGRect(origin:CGPoint(x:20,y:200),size:CGSize(width:200,height:25)))
            name_lb.backgroundColor=UIColor.white
            name_lb.text = fm.fish_name
            name_lb.textColor = UIColor.black
            name_lb.font=UIFont.boldSystemFont(ofSize: 20)
            cells.contentView.addSubview(name_lb)
        }else {
            let subtitle_lb=UILabel(frame:CGRect(origin:CGPoint(x:20,y:8),size:CGSize(width:200,height:25)))
            subtitle_lb.backgroundColor=UIColor.white
            subtitle_lb.text = self.subTitleArr[indexPath.row]
            subtitle_lb.textColor = UIColor.black
            subtitle_lb.font=UIFont.boldSystemFont(ofSize: 18)
            cells.contentView.addSubview(subtitle_lb)
            
            let string =  self.infoArray[indexPath.row] as! String
            let size = string.boundingRect(with: CGSize(width: self.view.frame.size.width - 30, height: 1000), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
            
            let content_lb=UILabel(frame:CGRect(origin:CGPoint(x:20,y:35),size:CGSize(width:self.view.frame.size.width - 30,height:size.height + 10)))
            content_lb.backgroundColor=UIColor.white
            content_lb.text = string
            content_lb.textColor = UIColor.lightGray
            content_lb.numberOfLines = 0
            content_lb.font=UIFont.systemFont(ofSize: 14)
            cells.contentView.addSubview(content_lb)
        }
        return cells;
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
