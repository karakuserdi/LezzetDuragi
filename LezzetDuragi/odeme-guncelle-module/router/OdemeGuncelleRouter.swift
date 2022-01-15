//
//  OdemeGuncelleRouter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class OdemeGuncelleRouter:PresenterToRouterOdemeGuncelleProtocol{
    static func createModule(ref: OdemeGuncelleViewController) {
        ref.odemeGuncellePresenterNesnesi = OdemeGuncellePresenter()
        ref.odemeGuncellePresenterNesnesi?.odemeGuncelleInteractor = OdemeGuncelleInteractor()
    }
}
