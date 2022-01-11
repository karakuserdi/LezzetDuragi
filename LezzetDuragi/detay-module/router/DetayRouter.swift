//
//  DetayRouter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import Foundation

class DetayRouter:PresenterToRouterDetayProtocol{
    static func createModule(ref: DetayViewController) {
        let presenter = DetayPresenter()
        ref.detayPresenterNesnesi = presenter
        ref.detayPresenterNesnesi?.detayInteractor = DetayInteractor()
        
        ref.detayPresenterNesnesi?.detayView = ref
        
        ref.detayPresenterNesnesi?.detayInteractor?.detayPresenter = presenter
        
        
        
        
    }
}
