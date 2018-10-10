//
//  CategoryCell.swift
//  NYTimes
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var lblDisplayCat: UILabel!
    @IBOutlet weak var lblOldestDate: UILabel!
    @IBOutlet weak var lblNewestDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: CELL CONTENT HANDLERS
    func populateCellContent(cat : Category){
        lblDisplayCat.text = cat.displayName
        lblOldestDate.text = cat.oldestPublishedDate
        lblNewestDate.text = cat.newestPublishedDate
    }
    
}
