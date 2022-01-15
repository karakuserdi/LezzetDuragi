//
//  OdemeEkleRouter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class OdemeEkleRouter:PresenterToRouterOdemeEkleProtocol{
    static func createModule(ref: OdemeEkleViewController) {
        ref.odemeEklePresenterNesnesi = OdemeEklePresenter()
        ref.odemeEklePresenterNesnesi?.odemeEkleInteractor = OdemeEkleInteractor()
    }
}
