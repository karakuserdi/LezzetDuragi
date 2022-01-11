//
//  YemeklerBegeni.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 11.01.2022.
//

import Foundation

class YemeklerBegeni{
    var yemek_id:Int?
    var yemek_isLiked:String?
    
    init(){
        
    }
    
    init(yemek_id:Int,yemek_isLiked:String){
        self.yemek_id = yemek_id
        self.yemek_isLiked = yemek_isLiked
    }
}
