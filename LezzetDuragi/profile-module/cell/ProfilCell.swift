//
//  ProfilCell.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 11.01.2022.
//

import UIKit

class ProfilCell: UITableViewCell {
    
    var yemek:Yemekler?{
        didSet{
            configure()
        }
    }
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var yemekImageView: UIImageView!
    @IBOutlet weak var yemekAdLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.layer.borderWidth = 0.3
        bgView.layer.cornerRadius = 10
        
        bgView.layer.shadowColor = UIColor.lightGray.cgColor
        bgView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        bgView.layer.shadowRadius = 1
        bgView.layer.shadowOpacity = 0.5
        bgView.layer.masksToBounds = false
    }
    
    func configure(){
        if let yemek = yemek {
            yemekAdLabel.text = yemek.yemek_adi
            
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
                DispatchQueue.main.async {
                    self.yemekImageView.kf.setImage(with: url)
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
