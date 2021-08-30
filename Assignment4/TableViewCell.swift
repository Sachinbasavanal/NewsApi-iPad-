//
//  TableViewCell.swift
//  Assignment4
//
//  Created by M1066966 on 29/08/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var authorOutlet: UILabel!
    @IBOutlet weak var titleOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var cellViewModel:CellModel?{
        didSet{
            titleOutlet.text = cellViewModel?.title
            authorOutlet.text = cellViewModel?.author
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleOutlet.text = nil
        authorOutlet.text = nil
    }
    
}
