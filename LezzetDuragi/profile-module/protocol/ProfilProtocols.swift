//
//  ProfilProtocols.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 11.01.2022.
//

import Foundation

protocol PresenterToInteractorProfilProtocol{
    var profilPresenter:InteractorToPresenterProfilProtocol? {get set}
    
    func yemekAl()
}

protocol ViewToPresenterProfilProtocol{
    var profilInteractor:PresenterToInteractorProfilProtocol? {get set}
    var profilView:PresenterToViewProfilProtocol? {get set}
    
    func al()
}

protocol InteractorToPresenterProfilProtocol{
    func presenteraVeriGonder(yemekler: Array<Yemekler>)
}

protocol PresenterToViewProfilProtocol{
    func viewaVeriGonder(yemekler: Array<Yemekler>)
}

protocol PresenterToRouterProfilProtocol{
    static func createModule(ref: ProfilViewController)
}
