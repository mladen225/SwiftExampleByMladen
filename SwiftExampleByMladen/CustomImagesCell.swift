//
//  CustomImagesCell.swift
//  SwiftExampleByMladen
//
//  Created by codepool on 12. 2. 2023..
//

import UIKit

class CustomImagesCell: UITableViewCell {
    
    @IBOutlet var viewCell: UIView!
    
    @IBOutlet var outwardTVSV: UIStackView!
    
    @IBOutlet var landscapeImage: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
