//
//  AnasayfaInteractor.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import Foundation
import Alamofire

class AnasayfaInteractor:PresenterToInteractorAnasayfaProtocol{
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol?
    
    func tumYemekleriGetir() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response { response in
            if let data = response.data{
                do {
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    var yemekler = [Yemekler]()
                    if let gelenListe = cevap.yemekler{
                        yemekler = gelenListe
                    }

                    self.anasayfaPresenter?.presenteraVeriGonder(yemeklerListesi: yemekler)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
