//
//  SepetimProtocols.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import Foundation

protocol PresenterToInteractorSepetimProtocol{
    var sepetimPresenter:InteractorToPresenterSepetimProtocol? {get set}
    
    func tumSepetiGetir(kullanici_adi:String)
    func sepettenYemekSil(sepet_yemek_id:Int,kullanici_adi:String)
    func sepetinHepsiniSil(sepet_yemek_id:[Int],kullanici_adi:String)
}

protocol ViewToPresenterSepetimProtocol{
    var sepetimInteractor:PresenterToInteractorSepetimProtocol? {get set}
    var sepetimView:PresenterToViewSepetimProtocol? {get set}
    
    func getir(kullanici_adi:String)
    func sil(sepet_yemek_id:Int,kullanici_adi:String)
    func hepsiniSil(sepet_yemek_id:[Int],kullanici_adi:String)
}

protocol InteractorToPresenterSepetimProtocol{
    func presenteraVeriGonder(sepetim: Array<SepetYemekler>)
}


protocol PresenterToViewSepetimProtocol{
    func viewaVeriGonder(sepetim: Array<SepetYemekler>)
}

protocol PresenterToRouterSepetimProtocol{
    static func createModule(ref: SepetimViewController)
}
