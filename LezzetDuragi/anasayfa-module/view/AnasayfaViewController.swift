//
//  AnasayfaViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import UIKit
import Alamofire
import Kingfisher

class AnasayfaViewController: UIViewController{
    
    //MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    var yemeklerListesi = [Yemekler]()
    var arananYemeklerListesi = [Yemekler]()
    var anasayfaPresenterNesnesi:ViewToPresenterAnasayfaProtocol?
    let searchController = UISearchController()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViewUI()
        AnasayfaRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //sepet sayi
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[1]
            DispatchQueue.main.async {
                tabItem.badgeValue = "\(UserDefaults.standard.integer(forKey: "sepet"))"
            }
        }
        
        anasayfaPresenterNesnesi?.getir()
    }

    //MARK: - Helpers
    func configureCollectionViewUI(){
        searchController.searchResultsUpdater = self
        self.navigationItem.searchController = searchController
        
        //collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let genislik = collectionView.frame.size.width
        let boyut = (genislik - 30) / 3
        
        layout.itemSize = CGSize(width: boyut, height: boyut * 1.5)
        
        collectionView.collectionViewLayout = layout
    }
}

//MARK: - UICollectionViewDelegate,UICollectionViewDataSource
extension AnasayfaViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !arananYemeklerListesi.isEmpty{
            return arananYemeklerListesi.count
        }else{
            return yemeklerListesi.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if !arananYemeklerListesi.isEmpty{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "yemekCell", for: indexPath) as! YemekCell
            
            let yemek = arananYemeklerListesi[indexPath.row]
            cell.yemek = yemek
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "yemekCell", for: indexPath) as! YemekCell
            
            let yemek = yemeklerListesi[indexPath.row]
            cell.yemek = yemek
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let yemek:Yemekler?
        if !arananYemeklerListesi.isEmpty{
            yemek = arananYemeklerListesi[indexPath.row]
        }else{
            yemek = yemeklerListesi[indexPath.row]
        }
        
        performSegue(withIdentifier: "toDetay", sender: yemek)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay"{
            let yemek = sender as? Yemekler
            let destinationVC = segue.destination as! DetayViewController
            destinationVC.yemek = yemek
        }
    }
}

//MARK: - UISearchResultsUpdating
extension AnasayfaViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {return}
        arananYemeklerListesi = yemeklerListesi.filter({ yemek -> Bool in
          if searchText.isEmpty { return true }
            return yemek.yemek_adi!.lowercased().contains(searchText.lowercased())
          })
        collectionView.reloadData()
    }
}

//MARK: - PresenterToViewAnasayfaProtocol
extension AnasayfaViewController: PresenterToViewAnasayfaProtocol{
    func vieweVeriGonder(yemeklerListesi: Array<Yemekler>) {
        self.yemeklerListesi = yemeklerListesi
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
