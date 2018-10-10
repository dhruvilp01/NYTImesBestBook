//
//  BookDetailsVC.swift
//  NYTimes
//

import UIKit

class BookDetailsVC: UIViewController {

    @IBOutlet weak var lblBookName: UILabel!
    var selectedBook : Book = Book.init()
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblAutherName: UILabel!
    @IBOutlet weak var lblAmazonUrl: UILabel!
    
    // MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblBookName.text = selectedBook.title ?? ""
        lblTitle.text = selectedBook.title ?? ""
        lblDesc.text = selectedBook.bookDesc ?? ""
        lblAutherName.text = selectedBook.author ?? ""
        lblAmazonUrl.text = selectedBook.amazonURL ?? ""
    }
    
    // MARK: - Button Tap Event
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
