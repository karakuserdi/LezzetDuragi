//
//  AdreslerimRouter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class AdreslerimRouter:PresenterToRouterAdreslerimProtocol{
    static func createModule(ref: AdreslerimViewController) {
        let presenter = AdreslerimPresenter()
        
        ref.adreslerimPresenterNesnesi = presenter
        ref.adreslerimPresenterNesnesi?.adreslerimInteractor = AdreslerimInteractor()
        ref.adreslerimPresenterNesnesi?.adreslerimView = ref
        ref.adreslerimPresenterNesnesi?.adreslerimInteractor?.adreslerimPresenter = presenter
    }
}
