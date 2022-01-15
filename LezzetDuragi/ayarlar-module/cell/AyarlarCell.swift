//
//  AyarlarCell.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 14.01.2022.
//

import UIKit

class AyarlarCell: UITableViewCell {

    @IBOutlet weak var ayarlarIconImageView: UIImageView!
    @IBOutlet weak var ayarlarLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
