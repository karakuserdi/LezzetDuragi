//
//  ProfilRouter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 11.01.2022.
//

import Foundation

class ProfilRouter:PresenterToRouterProfilProtocol{
    static func createModule(ref: ProfilViewController) {
        let presenter = ProfilPresenter()
        
        ref.profilPresenterNesnesi = presenter
        ref.profilPresenterNesnesi?.profilInteractor = ProfilInteractor()
        
        ref.profilPresenterNesnesi?.profilView = ref
        ref.profilPresenterNesnesi?.profilInteractor?.profilPresenter = presenter
    }
}
