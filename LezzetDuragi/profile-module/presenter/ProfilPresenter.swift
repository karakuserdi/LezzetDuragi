//
//  ProfilPresenter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 11.01.2022.
//

import Foundation

class ProfilPresenter:ViewToPresenterProfilProtocol{
    var profilInteractor: PresenterToInteractorProfilProtocol?
    var profilView: PresenterToViewProfilProtocol?
    
    func al() {
        profilInteractor?.yemekAl()
    }
}

extension ProfilPresenter:InteractorToPresenterProfilProtocol{
    func presenteraVeriGonder(yemekler: Array<Yemekler>) {
        profilView?.viewaVeriGonder(yemekler: yemekler)
    }
}
