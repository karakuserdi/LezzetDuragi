//
//  SepetimRouter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import Foundation

class SepetimRouter:PresenterToRouterSepetimProtocol{
    static func createModule(ref: SepetimViewController) {
        let presenter = SepetimPresenter()
        
        ref.sepetimPresenterNesnesi = presenter
        ref.sepetimPresenterNesnesi?.sepetimInteractor = SepetimInteractor()
        ref.sepetimPresenterNesnesi?.sepetimView = ref
        
        ref.sepetimPresenterNesnesi?.sepetimInteractor?.sepetimPresenter = presenter
    }
}
