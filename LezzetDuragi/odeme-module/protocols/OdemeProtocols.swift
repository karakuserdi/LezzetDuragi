//
//  OdemeProtocols.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

protocol PresenterToInteractorOdemeProtocol{
    var odemePresenter:InteractorToPresenterOdemeProtocol? {get set}
    
    func kartAl(kisi_id: Int)
    func kartSil(kart_id: Int)
}

protocol ViewToPresenterOdemeProtocol{
    var odemeInteractor:PresenterToInteractorOdemeProtocol? {get set}
    var odemeView:PresenterToViewOdemeProtocol? {get set}
    
    func al(kisi_id: Int)
    func sil(kart_id: Int)
}

protocol InteractorToPresenterOdemeProtocol{
    func presenteraVeriGonder(kart: Array<Kart>)
}

protocol PresenterToViewOdemeProtocol{
    func viewaVeriGonder(kart: Array<Kart>)
}

protocol PresenterToRouterOdemeProtocol{
    static func createModule(ref: OdemeViewController)
}
