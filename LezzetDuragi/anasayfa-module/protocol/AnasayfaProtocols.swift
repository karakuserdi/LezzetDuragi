//
//  AnasayfaProtocols.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import Foundation

protocol PresenterToInteractorAnasayfaProtocol{
    var anasayfaPresenter:InteractorToPresenterAnasayfaProtocol? {get set}

    func tumYemekleriGetir()
}

protocol ViewToPresenterAnasayfaProtocol{
    var anasayfaInteractor:PresenterToInteractorAnasayfaProtocol? {get set}
    var anasayfaView:PresenterToViewAnasayfaProtocol? {get set}
    
    func getir()
}

protocol InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(yemeklerListesi:Array<Yemekler>)
}

//Taşıyıcı Protocol
protocol PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(yemeklerListesi:Array<Yemekler>)
}

protocol PresenterToRouterAnasayfaProtocol {
    static func createModule(ref:AnasayfaViewController)
}

