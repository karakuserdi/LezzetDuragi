//
//  AdreslerimPresenter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class AdreslerimPresenter:ViewToPresenterAdreslerimProtocol{
    var adreslerimInteractor: PresenterToInteractorAdreslerimProtocol?
    var adreslerimView: PresenterToViewAdreslerimProtocol?
    
    func adres(kisi_id: Int) {
        adreslerimInteractor?.adresAl(kisi_id: kisi_id)
    }
    func sil(adres_id: Int) {
        adreslerimInteractor?.adresSil(adres_id: adres_id)
    }
}

extension AdreslerimPresenter:InteractorToPresenterAdreslerimProtocol{
    func presenteraVeriGonder(adres: Array<Adres>) {
        adreslerimView?.viewaVeriGonder(adres: adres)
    }
}
