//
//  CategoryCell.swift
//  NYTimes
//

import UIKit

class BookCell: UITableViewCell {

    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblAutherName: UILabel!
    @IBOutlet weak var lblPublisherName: UILabel!
    @IBOutlet weak var lblWeekOnList: UILabel!
    @IBOutlet weak var lblRank: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: CELL CONTENT HANDLERS
    func populateCellContent(book : Book){
        lblBookName.text = book.title
        lblAutherName.text = book.author
        lblPublisherName.text = book.publisher
        lblRank.text = "\(String(describing: book.rank ?? 0))"
        lblWeekOnList.text = "\(String(describing: book.noOfWeeksOnList ?? 0))"
    }
    
}
