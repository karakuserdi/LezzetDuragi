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
    var timer = Timer()
    
    //like button
    @IBOutlet weak var likeButton: UIButton!
    //Button view
    @IBOutlet weak var miktarView: UIView!
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
            yemekAdLabel.text = "\(yemek.yemek_adi!) - ₺\(yemek.yemek_fiyat!)"
            yemekFiyatLabel.text = "0"
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
        
        eksiButton.layer.cornerRadius = 25
        eksiButton.layer.borderColor = UIColor.white.cgColor
        eksiButton.layer.borderWidth = 3
        
        artiButton.layer.cornerRadius = 25
        artiButton.layer.borderColor = UIColor.white.cgColor
        artiButton.layer.borderWidth = 3
        
        
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
        
        guard let yemek = yemek else {
            return
        }

        yemekFiyatLabel.text = "₺ \(miktar * Int((yemek.yemek_fiyat)!)!)"
    }
    
    @IBAction func artiButtonPressed(_ sender: Any) {
        if miktar >= 10 {
            return
        }
        
        miktar += 1
        miktarLabel.text = "\(miktar)"
        
        guard let yemek = yemek else {
            return
        }

        yemekFiyatLabel.text = "₺ \(miktar * Int((yemek.yemek_fiyat)!)!)"
    }
    
    @IBAction func sepetEkleButtonPressed(_ sender: Any) {
        detayPresenterNesnesi?.sepetYemekAl(kullanici_adi: AppDelegate().getUser()!,yemek_ad: (yemek?.yemek_adi!)!)
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
    
    func viewaYemekGonder(sepetYemek:SepetYemekler) {
        if miktar == 0{
            alertTimer(title: nil, mesaj: "Lütfen ürün adet seçiniz!")
            return
        }
        
        if sepetYemek.yemek_adi != nil{
            let yemekSayisi = Int(sepetYemek.yemek_siparis_adet!)! + miktar
            if yemekSayisi > 10{
                alertTimer(title: nil, mesaj: "Eklediğiniz ürün 10'dan fazla olamaz!")
                return
            }
            
            detayPresenterNesnesi?.yemekSil(sepet_yemek_id: Int(sepetYemek.sepet_yemek_id!)!, kullanici_adi: AppDelegate().getUser()!)
            
            if let yemek = yemek{
                let yemekFiyat = Int(sepetYemek.yemek_fiyat!)! + miktar*Int(yemek.yemek_fiyat!)!
    
                timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [self] timer in
                    alertTimer(title: nil, mesaj: "\(miktar) adet \(yemek.yemek_adi!) \n sepetinize eklendi.")
                    detayPresenterNesnesi?.ekle(yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: yemekFiyat, yemek_siparis_adet: yemekSayisi,kullanici_adi:AppDelegate().getUser()!)
                }
            }
        }else{
            if let yemek = yemek {
                alertTimer(title: nil, mesaj: "\(miktar) adet \(yemek.yemek_adi!) \n sepetinize eklendi.")
                detayPresenterNesnesi?.ekle(yemek_adi: yemek.yemek_adi!, yemek_resim_adi: yemek.yemek_resim_adi!, yemek_fiyat: miktar*Int(yemek.yemek_fiyat!)!, yemek_siparis_adet: Int(miktar),kullanici_adi:AppDelegate().getUser()!)
                //sepet sayi işlemleri
                var sayi = UserDefaults.standard.integer(forKey: "sepet")
                sayi = sayi + 1
                UserDefaults.standard.set(sayi, forKey: "sepet")
            }
        }
    }
}
