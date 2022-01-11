//
//  YemekCell.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import UIKit
import Kingfisher

class YemekCell: UICollectionViewCell {
    var yemek:Yemekler?{
        didSet{
            configure()
        }
    }
    
    @IBOutlet weak var imageContentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var fiyatLabel: UILabel!
    @IBOutlet weak var adLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        imageContentView.layer.cornerRadius = 10
        imageContentView.layer.shadowColor = UIColor.black.cgColor
        imageContentView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        imageContentView.layer.shadowRadius = 2
        imageContentView.layer.shadowOpacity = 0.3
        imageContentView.layer.masksToBounds = false
    }
    
    func configure(){
        if let yemek = yemek {
            fiyatLabel.text = "₺ \(yemek.yemek_fiyat!)"
            adLabel.text = yemek.yemek_adi
            
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
                DispatchQueue.main.async {
                    self.imageView.kf.setImage(with: url)
                }
            }
        }
    }
    @IBAction func likeButtonPressed(_ sender: Any) {
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
