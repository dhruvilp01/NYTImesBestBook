//
//  MainVC.swift
//  NYTimes
//

import UIKit
import Alamofire
import ObjectMapper
import SVProgressHUD

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblViewMainCategory: UITableView!
    @IBOutlet weak var lblError: UILabel!
    var categoriesList: [Category]? = []
    
    // MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lblError.isHidden = true
        fetchAllCategories()
    }
    
    // MARK: - Button Tap Event
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "categoryCell"
        var cell:CategoryCell!
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CategoryCell
        if cell == nil {
            tableView.register(UINib.init(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CategoryCell
        }
        cell?.populateCellContent(cat: categoriesList![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let bookListVC = storyBoard.instantiateViewController(withIdentifier: "booksListVC") as! BooksListVC
        bookListVC.selectedCat = categoriesList![indexPath.row]
        self.navigationController?.pushViewController(bookListVC, animated: true)
    }
    
    // MARK: - API Execution
    
    func fetchAllCategories(){
        let manager:ServiceManager = ServiceManager.sharedInstance
        let serviceInputs:NSMutableDictionary = NSMutableDictionary()
        SVProgressHUD.show()
        manager.instantiateServiceWithServiceParams(alertHandler: self, serviceType: ConstantsAPI.FETCH_CATEGORIES, serviceInputs: serviceInputs, serviceNature: .GET, encodingVal: URLEncoding.default, withSuccess: { (result) -> Void in
            SVProgressHUD.dismiss()
            let dict: NSDictionary = (result as! NSDictionary)
            let statusStr : String = dict["status"] as! String
            if (statusStr == "OK"){
                self.lblError.isHidden = true
                let resultArray : NSArray = dict["results"] as! NSArray
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: resultArray)
                    if let jsonStr = String(data: jsonData, encoding: .utf8) {
                        self.categoriesList = Mapper<Category>().mapArray(JSONString: jsonStr)
                        self.tblViewMainCategory.reloadData()
                    }
                } catch {
                    print("something went wrong with parsing json")
                    self.lblError.isHidden = false
                    self.lblError.text = statusStr
                }
            }
            else{
                self.lblError.isHidden = false
                self.lblError.text = statusStr
            }
        }, withFailure: { (error,response) -> Void in
            SVProgressHUD.dismiss()
            let err : NSError = error! as NSError
            self.lblError.isHidden = false
            self.lblError.text = err.description
        })
    }
    
}
