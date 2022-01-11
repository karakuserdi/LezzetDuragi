//
//  AnasayfaRouter.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import Foundation

class AnasayfaRouter:PresenterToRouterAnasayfaProtocol{
    static func createModule(ref: AnasayfaViewController) {
        let presenter = AnasayfaPresenter()
        
        ref.anasayfaPresenterNesnesi = presenter
        ref.anasayfaPresenterNesnesi?.anasayfaInteractor = AnasayfaInteractor()
        ref.anasayfaPresenterNesnesi?.anasayfaView = ref
        ref.anasayfaPresenterNesnesi?.anasayfaInteractor?.anasayfaPresenter = presenter
        
        
    }
}
