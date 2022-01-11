//
//  DetayViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import UIKit
import Kingfisher

class DetayViewController: UIViewController {
    //MARK: - Properties
    var yemek:Yemekler?
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var yemekImageView: UIImageView!
    @IBOutlet weak var yemekAdLabel: UILabel!
    @IBOutlet weak var yemekFiyatLabel: UILabel!
    @IBOutlet weak var miktarLabel: UILabel!
    @IBOutlet weak var sepetEkleButton: UIButton!
    
    var isLike = "false"
    
    //like button
    @IBOutlet weak var likeButton: UIButton!
    //Button view
    @IBOutlet weak var miktarView: UIView!
    @IBOutlet weak var eksiButtonView: UIView!
    @IBOutlet weak var artiButtonView: UIView!
    //Button
    @IBOutlet weak var eksiButton: UIButton!
    @IBOutlet weak var artiButton: UIButton!
    //Puan view
    @IBOutlet weak var puanView: UIView!
    
    
    var detayPresenterNesnesi:ViewToPresenterDetayProtocol?
    var miktar:Int = 0
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        DetayRouter.createModule(ref: self)
        
        if let yemek = yemek {
            yemekAdLabel.text = yemek.yemek_adi
            yemekFiyatLabel.text = "₺ \(yemek.yemek_fiyat!)"
            detayPresenterNesnesi?.al(yemek_id: Int(yemek.yemek_id!)!)
            
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi!)"){
                DispatchQueue.main.async {
                    self.yemekImageView.kf.setImage(with: url)
                }
            }
        }
    }
    
    //MARK: - Helpers
    func configureUI(){
        sepetEkleButton.layer.cornerRadius = 25
        
        bgView.layer.cornerRadius = 50
        bgView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        
        miktarView.layer.cornerRadius = 26
        
        eksiButtonView.layer.cornerRadius = 25
        eksiButtonView.layer.borderColor = UIColor.lightGray.cgColor
        eksiButtonView.layer.borderWidth = 0.1
        
        artiButtonView.layer.cornerRadius = 25
        artiButtonView.layer.borderColor = UIColor.lightGray.cgColor
        artiButtonView.layer.borderWidth = 0.1
        
        eksiButton.layer.cornerRadius = 20
        artiButton.layer.cornerRadius = 20
        
        puanView.layer.cornerRadius = 5
        
    }
    
    //MARK: - Actions
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        if let yemek = yemek {
            if isLike == "false" {
                detayPresenterNesnesi?.begenildiMi(yemek_id: Int(yemek.yemek_id!)!, yemek_isLiked: "true")
            }else{
                detayPresenterNesnesi?.begenildiMi(yemek_id: Int(yemek.yemek_id!)!, yemek_isLiked: "false")
            }
        }
    }
    
    @IBAction func eksiButtonPressed(_ sender: Any) {
        if miktar <= 0 {
            return
        }
        miktar -= 1
        miktarLabel.text = "\(miktar)"
    }
    
    @IBAction func artiButtonPressed(_ sender: Any) {
        if miktar >= 10 {
            return
        }
        miktar += 1
        miktarLabel.text = "\(miktar)"
    }
    
    @IBAction func sepetEkleButtonPressed(_ sender: Any) {
        if miktar == 0{
            alertTimer(title: nil, mesaj: "Lütfen ürün adet seçiniz!")
            return
        }
        if let yemek = yemek {
            alertTimer(title: nil, mesaj: "\(miktar) adet \(yemek.yemek_adi!) \n sepetinize eklendi.")
            detayPresenterNesnesi?.ekle(yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: miktar*Int(yemek.yemek_fiyat!)!, yemek_siparis_adet: Int(miktar), kullanici_adi: AppDelegate().getUser()!)
        }
    }
}

//MARK: - PresenterToViewDetayProtocol
extension DetayViewController:PresenterToViewDetayProtocol{
    func viewaVeriGonder(yemek_isLikes: String) {
        isLike = yemek_isLikes
        if isLike == "false"{
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }else{
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
}
