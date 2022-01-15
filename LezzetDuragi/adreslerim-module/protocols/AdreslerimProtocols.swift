//
//  AdreslerimProtocols.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation


protocol PresenterToInteractorAdreslerimProtocol{
    var adreslerimPresenter:InteractorToPresenterAdreslerimProtocol? {get set}
    
    func adresAl(kisi_id: Int)
    func adresSil(adres_id: Int)
}

protocol ViewToPresenterAdreslerimProtocol{
    var adreslerimInteractor:PresenterToInteractorAdreslerimProtocol? {get set}
    var adreslerimView:PresenterToViewAdreslerimProtocol? {get set}
    
    func adres(kisi_id: Int)
    func sil(adres_id: Int)
}

protocol InteractorToPresenterAdreslerimProtocol{
    func presenteraVeriGonder(adres: Array<Adres>)
}

protocol PresenterToViewAdreslerimProtocol{
    func viewaVeriGonder(adres: Array<Adres>)
}

protocol PresenterToRouterAdreslerimProtocol{
    static func createModule(ref: AdreslerimViewController)
}
