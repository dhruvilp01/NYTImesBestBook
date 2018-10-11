//
//  BookDetailsVC.swift
//  NYTimes
//

import UIKit

class BookDetailsVC: UIViewController {

    var selectedBook : Book = Book.init()
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblAutherName: UILabel!
    @IBOutlet weak var txtViewAmazonURL: UITextView!
    @IBOutlet weak var txtViewReviewURL: UITextView!
    
    
    // MARK: View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblTitle.text = selectedBook.title ?? ""
        lblDesc.text = selectedBook.bookDesc ?? ""
        lblAutherName.text = selectedBook.author ?? ""
        txtViewAmazonURL.text = selectedBook.amazonURL ?? ""
        txtViewReviewURL.text = selectedBook.reviewURL ?? ""
    }
    
    // MARK: - Button Tap Event
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
