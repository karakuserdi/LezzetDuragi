//
//  AnasayfaPresenter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import Foundation

class AnasayfaPresenter:ViewToPresenterAnasayfaProtocol{
    var anasayfaInteractor: PresenterToInteractorAnasayfaProtocol?
    var anasayfaView: PresenterToViewAnasayfaProtocol?
    
    func getir() {
        anasayfaInteractor?.tumYemekleriGetir()
    }
}

extension AnasayfaPresenter: InteractorToPresenterAnasayfaProtocol{
    func presenteraVeriGonder(yemeklerListesi: Array<Yemekler>) {
        anasayfaView?.vieweVeriGonder(yemeklerListesi: yemeklerListesi)
    }
}
