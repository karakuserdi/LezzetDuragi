//
//  DetayInteractor.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import Foundation
import Alamofire

class DetayInteractor:PresenterToInteractorDetayProtocol{
    var detayPresenter: InteractorToPresenterDetayProtocol?
    
    let db:FMDatabase?

    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("yemekler.sqlite")

        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func yemekAl(yemek_id: Int){
        var begeni:String?
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM yemekler WHERE yemek_id = \(yemek_id)", values: nil)
            
            while rs.next() {
                let yemek = YemeklerBegeni(yemek_id: Int(rs.string(forColumn: "yemek_id")!)!, yemek_isLiked: rs.string(forColumn: "yemek_isLiked")!)
                begeni = yemek.yemek_isLiked!
                detayPresenter?.presenteraVeriGonder(yemek_isLikes: begeni!)
            }
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func yemekBegenildiMi(yemek_id: Int, yemek_isLiked: String) {
        db?.open()
        do {
            try db!.executeUpdate("UPDATE yemekler SET yemek_isLiked = ? WHERE yemek_id = ?", values: [yemek_isLiked,yemek_id])
            yemekAl(yemek_id: yemek_id)
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func sepeteYemekEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
        //print(yemek_adi,yemek_resim_adi,yemek_fiyat,yemek_siparis_adet,kullanici_adi)
        let params:Parameters = ["yemek_adi":yemek_adi,
                                 "yemek_resim_adi":yemek_resim_adi,
                                 "yemek_fiyat":yemek_fiyat,
                                 "yemek_siparis_adet":yemek_siparis_adet,
                                 "kullanici_adi":kullanici_adi
        ]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post, parameters: params).response { response in
            if let data = response.data{

                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let success = json["success"] as? Int{
                            if success == 1{
                                //sepet sayi işlemleri
                                var sayi = UserDefaults.standard.integer(forKey: "sepet")
                                sayi = sayi + 1
                                UserDefaults.standard.set(sayi, forKey: "sepet")
                            }
                        }
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
