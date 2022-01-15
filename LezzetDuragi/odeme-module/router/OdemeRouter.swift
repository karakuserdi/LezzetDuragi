//
//  OdemeRouter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import Foundation

class OdemeRouter:PresenterToRouterOdemeProtocol{
    static func createModule(ref: OdemeViewController) {
        let presenter = OdemePresenter()
        
        ref.odemePresenterNesnesi = presenter
        ref.odemePresenterNesnesi?.odemeInteractor = OdemeInteractor()
        ref.odemePresenterNesnesi?.odemeView = ref
        ref.odemePresenterNesnesi?.odemeInteractor?.odemePresenter = presenter
    }
}
