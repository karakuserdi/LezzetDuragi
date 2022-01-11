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
    
    func tumSepetiGetir(kullanici_adi:String) {
        let params:Parameters = ["kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: params).response { response in

            var yemekler = [SepetYemekler]()
            if let data = response.data {
                if data.count < 6{
                    self.sepetimPresenter?.presenteraVeriGonder(sepetim: yemekler)
                    return
                }
                    do {
                        let cevap = try JSONDecoder().decode(SepetYemeklerCevap.self, from: data)
                        
                        
                        if let gelenListe = cevap.sepet_yemekler{
                            yemekler = gelenListe
                            UserDefaults.standard.set(yemekler.count, forKey: "sepet")
                        }
                        
                        self.sepetimPresenter?.presenteraVeriGonder(sepetim: yemekler)
                    } catch {
                        self.sepetimPresenter?.presenteraVeriGonder(sepetim: yemekler)
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
                        self.tumSepetiGetir(kullanici_adi: kullanici_adi)
                        
                        //sepet sayi
                        var sayi = UserDefaults.standard.integer(forKey: "sepet")
                        if sayi != 0{
                            sayi = sayi - 1
                        }
                        UserDefaults.standard.set(sayi, forKey: "sepet")
                        
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
