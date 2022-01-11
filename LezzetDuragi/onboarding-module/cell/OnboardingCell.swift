//
//  OnboardingCell.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 10.01.2022.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideBaslikLabel: UILabel!
    @IBOutlet weak var slideAciklamaLabel: UILabel!
    
    func setup(_ slide: OnboaringSlide){
        slideImageView.image = slide.resim
        slideBaslikLabel.text = slide.baslik
        slideAciklamaLabel.text = slide.aciklama
    }
}
