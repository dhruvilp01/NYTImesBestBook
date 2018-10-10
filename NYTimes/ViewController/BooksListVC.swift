//
//  BooksListVC.swift
//  NYTimes
//

import UIKit
import Alamofire
import ObjectMapper
import SVProgressHUD

class BooksListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var lblCategoryName: UILabel!
    @IBOutlet weak var tblViewBooks: UITableView!
    @IBOutlet weak var lblError: UILabel!
    
    var selectedCat : Category = Category.init()
    var booksList: [Book]? = []
    
    // MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCategoryName.text = selectedCat.displayName ?? ""
        lblError.isHidden = true
        fetchAllBooks()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: - Button Tap Event
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapRank(_ sender: Any) {
        booksList = booksList?.sorted(by: { $0.rank ?? 0 < $1.rank ?? 0})
        tblViewBooks.reloadData()
    }
    @IBAction func didTapWeek(_ sender: Any) {
        booksList = booksList?.sorted(by: { $0.noOfWeeksOnList ?? 0 > $1.noOfWeeksOnList ?? 0})
        tblViewBooks.reloadData()
    }
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "bookCell"
        var cell:BookCell!
        cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BookCell
        if cell == nil {
            tableView.register(UINib.init(nibName: "BookCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? BookCell
        }
        cell?.populateCellContent(book: booksList![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let bookDetailsVC = storyBoard.instantiateViewController(withIdentifier: "bookDetailsVC") as! BookDetailsVC
        bookDetailsVC.selectedBook = booksList![indexPath.row]
        self.navigationController?.pushViewController(bookDetailsVC, animated: true)
    }
    
    // MARK: - API Execution
    
    func fetchAllBooks(){
        let manager:ServiceManager = ServiceManager.sharedInstance
        let serviceInputs:NSMutableDictionary = NSMutableDictionary()
        serviceInputs.setValue(selectedCat.listName ?? "", forKey: ConstantsParamKeys.KEY_CAT_NAME)
        SVProgressHUD.show()
        manager.instantiateServiceWithServiceParams(alertHandler: self, serviceType: ConstantsAPI.FETCH_BOOKS, serviceInputs: serviceInputs, serviceNature: .GET, encodingVal: URLEncoding.default, withSuccess: { (result) -> Void in
            SVProgressHUD.dismiss()
            let dict: NSDictionary = (result as! NSDictionary)
            let statusStr : String = dict["status"] as! String
            if (statusStr == "OK"){
                self.lblError.isHidden = true
                let resultArray : NSArray = dict["results"] as! NSArray
                let bookArray = resultArray.map({ ($0 as! NSDictionary)["book_details"] })
                let rankArray = resultArray.map({ ($0 as! NSDictionary)["rank"] })
                let weeksOnArray = resultArray.map({ ($0 as! NSDictionary)["weeks_on_list"] })
                let amazonURLArray = resultArray.map({ ($0 as! NSDictionary)["amazon_product_url"] })
                let bookFinalArray = bookArray.map({ ($0 as! NSArray)[0] })
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: bookFinalArray)
                    if let jsonStr = String(data: jsonData, encoding: .utf8) {
                        self.booksList = Mapper<Book>().mapArray(JSONString: jsonStr)
                    }
                } catch {
                    print("something went wrong with parsing json")
                    self.lblError.isHidden = false
                    self.lblError.text = statusStr
                }
                for i in 0..<self.booksList!.count {
                    self.booksList![i].rank = rankArray[i]! as? Int
                    self.booksList![i].noOfWeeksOnList = weeksOnArray[i]! as? Int
                    self.booksList![i].amazonURL = amazonURLArray[i]! as? String
                }
                self.tblViewBooks.reloadData()
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
