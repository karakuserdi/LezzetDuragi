//
//  Kisilerdao.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 14.01.2022.
//

import Foundation

class Kisilerdao{
    let db:FMDatabase?

    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("yemekler.sqlite")

        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func kisiEkle(kisi_ad:String,kisi_email:String,kisi_sifre:String){

        db?.open()
        do {
            
            try db!.executeUpdate("INSERT INTO kisi (kisi_ad,kisi_email,kisi_sifre) VALUES (?,?,?)", values: [kisi_ad,kisi_email,kisi_sifre])
            print("Kisi eklendi")
        } catch  {
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func kullaniciAra(kisi_email:String,kisi_sifre:String) -> [Kisi] {
        var kisim = [Kisi]()
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM kisi WHERE kisi_email = ? and kisi_sifre = ?", values: [kisi_email,kisi_sifre])
            
            while rs.next(){
                let kisi = Kisi(kisi_id: Int(rs.string(forColumn: "kisi_id")!)!, kisi_ad: rs.string(forColumn: "kisi_ad")!, kisi_email: rs.string(forColumn: "kisi_email")!, kisi_sifre: rs.string(forColumn: "kisi_sifre")!)
                
                kisim.append(kisi)
            }
            
        } catch  {
            print(error.localizedDescription)
            return [Kisi]()
        }
        
        
        db?.close()
        
        return kisim

    }
    
    
    
    func adresAl(kisi_id: Int)-> [Adres] {
        var liste = [Adres]()
        
        db?.open()

        do {
            let rs = try db!.executeQuery("SELECT * FROM kisi,adres WHERE adres.kisi_id = kisi.kisi_id and adres.kisi_id = ?", values: [kisi_id])

            while rs.next(){
                let list = Kisi(kisi_id: Int(rs.string(forColumn: "kisi_id")!)!, kisi_ad: rs.string(forColumn: "kisi_ad")!, kisi_email: rs.string(forColumn: "kisi_email")!, kisi_sifre: rs.string(forColumn: "kisi_sifre")!)

                let adres = Adres(adres_id: Int(rs.string(forColumn: "adres_id")!)!, adres_baslik: rs.string(forColumn: "adres_baslik")!, adres_il: rs.string(forColumn: "adres_il")!, adres_ilce: rs.string(forColumn: "adres_ilce")!, adres_mahalle: rs.string(forColumn: "adres_mahalle")!, adres_aciklama: rs.string(forColumn: "adres_aciklama")!, kisi: list)

                liste.append(adres)
            }

        } catch {
            print(error.localizedDescription)
        }

        db?.close()
        return liste
    }
    
    func kartAl(kisi_id: Int) -> [Kart] {
        var liste = [Kart]()
        db?.open()

        do {
            let rs = try db!.executeQuery("SELECT * FROM kisi,kart WHERE kart.kisi_id = kisi.kisi_id and kart.kisi_id = ?", values: [kisi_id])

            while rs.next(){
                let kisi = Kisi(kisi_id: Int(rs.string(forColumn: "kisi_id")!)!, kisi_ad: rs.string(forColumn: "kisi_ad")!, kisi_email: rs.string(forColumn: "kisi_email")!, kisi_sifre: rs.string(forColumn: "kisi_sifre")!)

                let kart = Kart(kart_id: Int(rs.string(forColumn: "kart_id")!)!, kart_numara: rs.string(forColumn: "kart_numara")!, kart_isim: rs.string(forColumn: "kart_isim")!, kart_son_kullanim: rs.string(forColumn: "kart_son_kullanim")!, kart_cvc: rs.string(forColumn: "kart_cvc")!, kisi: kisi)

                liste.append(kart)
            }
            
        } catch {
            print(error.localizedDescription)
        }

        db?.close()
        return liste
    }
}
