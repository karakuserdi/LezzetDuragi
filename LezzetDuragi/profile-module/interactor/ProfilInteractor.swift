//
//  ProfilInteractor.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 11.01.2022.
//

import Foundation
import Alamofire

class ProfilInteractor:PresenterToInteractorProfilProtocol{
    var profilPresenter: InteractorToPresenterProfilProtocol?
    
    let db:FMDatabase?

    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("yemekler.sqlite")

        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func yemekBegenildiMi(yemek_id: Int, yemek_isLiked: String) {
        db?.open()
        do {
            try db!.executeUpdate("UPDATE yemekler SET yemek_isLiked = ? WHERE yemek_id = ?", values: [yemek_isLiked,yemek_id])
            yemekAl()
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
 
    func yemekAl() {
        var liste = [YemeklerBegeni]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM yemekler WHERE yemek_isLiked = 'true'", values: nil)
            while rs.next() {
                let yemek = YemeklerBegeni(yemek_id: Int(rs.string(forColumn: "yemek_id")!)!, yemek_isLiked: rs.string(forColumn: "yemek_isLiked")!)
                liste.append(yemek)
            }
            
            
            
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        //fetch
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response { response in
            if let data = response.data{
                do {
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    var yemekler = [Yemekler]()
                    
                    if let gelenListe = cevap.yemekler{
                        for i in gelenListe{
                            for j in liste{
                                if Int(i.yemek_id!) == j.yemek_id{
                                    yemekler.append(i)
                                }
                            }
                        }
                    }
                    
                    self.profilPresenter?.presenteraVeriGonder(yemekler: yemekler)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
