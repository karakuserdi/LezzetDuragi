//
//  SepetimCell.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import UIKit
import Kingfisher

protocol SepetimCellProtocol{
    func stepperControl(value: Int, indexPath:IndexPath)
}

class SepetimCell: UITableViewCell {
    
    var yemek:SepetYemekler?{
        didSet{
            configure()
        }
    }
    
    var delegate:SepetimCellProtocol?
    var indexPath:IndexPath?
    
    @IBOutlet weak var yemekView: UIView!
    @IBOutlet weak var yemekImageView: UIImageView!
    @IBOutlet weak var yemekAdLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        yemekView.layer.borderColor = UIColor.lightGray.cgColor
        yemekView.layer.borderWidth = 0.3
        yemekView.layer.cornerRadius = 10
        
        yemekView.layer.shadowColor = UIColor.lightGray.cgColor
        yemekView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        yemekView.layer.shadowRadius = 1
        yemekView.layer.shadowOpacity = 0.5
        yemekView.layer.masksToBounds = false
    }
    
    func configure(){
        if let yemek = yemek {
            yemekAdLabel.text = yemek.yemek_adi
            yemekFiyatLabel.text = "\(yemek.yemek_siparis_adet!) adet ₺\(yemek.yemek_fiyat!)"
            
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
                DispatchQueue.main.async {
                    self.yemekImageView.kf.setImage(with: url)
                }
            }
        }
    }
    
    
    @IBAction func eksiButtonPressed(_ sender: Any) {
        delegate?.stepperControl(value: -1,indexPath: indexPath!)
    }
    @IBAction func artiButtonPressed(_ sender: Any) {
        delegate?.stepperControl(value: 1,indexPath: indexPath!)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
