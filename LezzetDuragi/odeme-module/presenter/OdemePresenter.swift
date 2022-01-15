//
//  OdemePresenter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class OdemePresenter:ViewToPresenterOdemeProtocol{
    var odemeInteractor: PresenterToInteractorOdemeProtocol?
    var odemeView: PresenterToViewOdemeProtocol?
    
    func al(kisi_id: Int) {
        odemeInteractor?.kartAl(kisi_id: kisi_id)
    }
    
    func sil(kart_id: Int) {
        odemeInteractor?.kartSil(kart_id: kart_id)
    }
}

extension OdemePresenter:InteractorToPresenterOdemeProtocol{
    func presenteraVeriGonder(kart: Array<Kart>) {
        odemeView?.viewaVeriGonder(kart: kart)
    }
}
