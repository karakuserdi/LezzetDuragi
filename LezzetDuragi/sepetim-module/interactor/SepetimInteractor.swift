//
//  SepetimInteractor.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import Foundation
import Alamofire

class SepetimInteractor:PresenterToInteractorSepetimProtocol{
    var sepetimPresenter: InteractorToPresenterSepetimProtocol?
    var yemekler = [SepetYemekler]()
    
    func tumSepetiGetir(kullanici_adi:String) {
        let params:Parameters = ["kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).response { response in

            
            if let data = response.data {
                    do {
                        let cevap = try JSONDecoder().decode(SepetYemeklerCevap.self, from: data)
                        
                        if let gelenListe = cevap.sepet_yemekler{
                            self.yemekler = gelenListe
                            
                            if gelenListe.isEmpty{
                                print("Sepet liste silindi")
                            }
                            
                            UserDefaults.standard.set(self.yemekler.count, forKey: "sepet")
                        }
                        
                        self.sepetimPresenter?.presenteraVeriGonder(sepetim: self.yemekler)
                    } catch {
                        self.sepetimPresenter?.presenteraVeriGonder(sepetim: [])
                        print(error.localizedDescription)
                    }
            }else{
                self.sepetimPresenter?.presenteraVeriGonder(sepetim: [])
            }
        }
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
                        self.sepetimPresenter?.presenteraVeriGonder(sepetim: self.yemekler)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sepettenYemekSil(sepet_yemek_id: Int, kullanici_adi: String) {
        let params:Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post, parameters: params).response { response in
            if let data = response.data{
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        
                        //sepet sayi
                        var sayi = UserDefaults.standard.integer(forKey: "sepet")
                        if sayi != 0{
                            sayi = sayi - 1
                        }
                        UserDefaults.standard.set(sayi, forKey: "sepet")
                        self.tumSepetiGetir(kullanici_adi: kullanici_adi)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sepetinHepsiniSil(sepet_yemek_id:[Int],kullanici_adi: String) {
        for ids in sepet_yemek_id {
            let params:Parameters = ["sepet_yemek_id":ids,"kullanici_adi":kullanici_adi]

            AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post, parameters: params).response { response in
                if let data = response.data{
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            print(json)
                            self.tumSepetiGetir(kullanici_adi: kullanici_adi)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}
