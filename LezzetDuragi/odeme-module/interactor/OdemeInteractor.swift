//
//  OdemeInteractor.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class OdemeInteractor:PresenterToInteractorOdemeProtocol{
    var odemePresenter: InteractorToPresenterOdemeProtocol?
    
    let db:FMDatabase?

    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("yemekler.sqlite")

        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func kartAl(kisi_id: Int) {
        var liste = [Kart]()
        db?.open()

        do {
            let rs = try db!.executeQuery("SELECT * FROM kisi,kart WHERE kart.kisi_id = kisi.kisi_id and kart.kisi_id = ?", values: [kisi_id])

            while rs.next(){
                let kisi = Kisi(kisi_id: Int(rs.string(forColumn: "kisi_id")!)!, kisi_ad: rs.string(forColumn: "kisi_ad")!, kisi_email: rs.string(forColumn: "kisi_email")!, kisi_sifre: rs.string(forColumn: "kisi_sifre")!)

                let kart = Kart(kart_id: Int(rs.string(forColumn: "kart_id")!)!, kart_numara: rs.string(forColumn: "kart_numara")!, kart_isim: rs.string(forColumn: "kart_isim")!, kart_son_kullanim: rs.string(forColumn: "kart_son_kullanim")!, kart_cvc: rs.string(forColumn: "kart_cvc")!, kisi: kisi)

                liste.append(kart)
            }
            odemePresenter?.presenteraVeriGonder(kart: liste)
        } catch {
            print(error.localizedDescription)
        }

        db?.close()
    }
    
    
    
    func kartSil(kart_id: Int) {
        db?.open()
        do {
            try db!.executeUpdate("DELETE FROM kart WHERE kart_id = ?", values: [kart_id])
            
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
    }
}
