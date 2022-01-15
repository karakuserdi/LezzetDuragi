//
//  AdresEkleRouter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class AdresEkleRouter:PresenterToRouterAdresEkleProtocol{
    static func createModule(ref: AdresEkleViewController) {
        ref.adresEklePresenterNesnesi = AdresEklePresenter()
        ref.adresEklePresenterNesnesi?.adresEkleInteractor = AdresEkleInteractor()
    }
}
