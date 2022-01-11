//
//  OnboardingViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 10.01.2022.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboaringSlide] = []
    var currentPage = 0{
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1{
                nextButton.setTitle("Hadi Başlayalım!", for: .normal)
            }else{
                nextButton.setTitle("Sonraki", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [OnboaringSlide(baslik: "Lezzetli Yemekler", aciklama: "Bütün dünya mutfaklarından en lezzetli yemekler senin için bekliyor.", resim: UIImage(named: "slide1")!),
                  OnboaringSlide(baslik: "Dünyaca ünlü şefler", aciklama: "Bizim yemeklerimiz en iyiler tarafından hazırlanıyor.", resim: UIImage(named: "slide2")!),
                  OnboaringSlide(baslik: "Siparişin anında kapıda", aciklama: "Siparişlerin zaman kaybetmeden hazırlanır ve en kısa sürede kapınızda olur.", resim: UIImage(named: "slide3")!)]
        
        pageControl.numberOfPages = slides.count
        
        veritabaniKopyala()
    }
    
    func veritabaniKopyala(){
        let bundleYolu = Bundle.main.path(forResource: "yemekler", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("yemekler.sqlite")
        
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("Veritabanı zaten var. Kopyalamaya gerek yok")
        }else{
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{
                print(error)
            }
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if currentPage == slides.count - 1{
            UserDefaults.standard.set(true, forKey: "firstTime")
            let controller = storyboard?.instantiateViewController(withIdentifier: "tabbarVC") as! UITabBarController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCell", for: indexPath) as! OnboardingCell
        
        cell.setup(slides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}
