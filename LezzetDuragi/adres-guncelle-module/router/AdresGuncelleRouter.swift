//
//  AdresGuncelleRouter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class AdresGuncelleRouter:PresenterToRouterAdresGuncelleProtocol{
    static func createModule(ref: AdresGuncelleViewController) {
        ref.adresGuncellePresenterNesnesi = AdresGuncellePresenter()
        ref.adresGuncellePresenterNesnesi?.adresGuncelleInteractor = AdresGuncelleInteractor()
    }
}
