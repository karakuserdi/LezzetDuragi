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
    
    func begenildiMi(yemek_id: Int, yemek_isLiked: String) {
        profilInteractor?.yemekBegenildiMi(yemek_id: yemek_id, yemek_isLiked: yemek_isLiked)
    }
}

extension ProfilPresenter:InteractorToPresenterProfilProtocol{
    func presenteraVeriGonder(yemekler: Array<Yemekler>) {
        profilView?.viewaVeriGonder(yemekler: yemekler)
    }
}
