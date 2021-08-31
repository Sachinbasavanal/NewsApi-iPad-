//
//  TableViewCell.swift
//  Assignment4
//
//  Created by M1066966 on 29/08/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var titleOutlet: UILabel!
    @IBOutlet weak var spinnerView: UIActivityIndicatorView!
    @IBOutlet weak var bgView:UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var cellViewModel:CellModel?{
        didSet{
            titleOutlet.text = cellViewModel?.title
            spinnerView.startAnimating()
            if let imageURL = cellViewModel?.imageUrl{
                imageOutlet.loadImage(url: URL(string: imageURL)!)
            }
            spinnerView.isHidden = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleOutlet.text = nil
        imageOutlet.image = nil
    }
    
}
