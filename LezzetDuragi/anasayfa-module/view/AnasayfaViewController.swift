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
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var kullaniciAdiLabel: UILabel!
    @IBOutlet weak var adresSecimTextField: UITextField!
    
    var pickerView = UIPickerView()
    var selected = UserDefaults.standard.string(forKey: "selected") ?? "Adres Seçiniz"
    var yemeklerListesi = [Yemekler]()
    var arananYemeklerListesi = [Yemekler]()
    var anasayfaPresenterNesnesi:ViewToPresenterAnasayfaProtocol?
    var adreslerListesi = [String]()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        adresSecimTextField.delegate = self
        adresSecimTextField.inputView = pickerView
        
        kullaniciAdiLabel.text = "Merhaba \(AppDelegate().getUser()!)"
        configureCollectionViewUI()
        AnasayfaRouter.createModule(ref: self)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        //sepet sayi
        adreslerListesi = ["Adres Seçiniz"]

        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[1]
            DispatchQueue.main.async {
                tabItem.badgeValue = "\(UserDefaults.standard.integer(forKey: "sepet"))"
            }
        }

        //picker view için veri çekme
        for adresler in Kisilerdao().adresAl(kisi_id: UserDefaults.standard.integer(forKey: "currentUserId")) {
            adreslerListesi.append(adresler.adres_baslik ?? "")
        }
        adresSecimTextField.text = selected
        
        if adreslerListesi.count == 1{
            UserDefaults.standard.set("Adres Seçiniz", forKey: "selected")
        }
        adresSecimTextField.text = UserDefaults.standard.string(forKey: "selected")
        anasayfaPresenterNesnesi?.getir()
    }

    //MARK: - Helpers
    func configureCollectionViewUI(){
        //sarchbar
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.white
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        
        //profileImage
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.orange.cgColor
        profileImageView.layer.cornerRadius = 40
        
        //collectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let genislik = collectionView.frame.size.width
        let boyut = (genislik - 45) / 3
        
        layout.itemSize = CGSize(width: boyut, height: boyut)
        
        collectionView.collectionViewLayout = layout
    }
}

//MARK: - UIPickerView
extension AnasayfaViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return adreslerListesi.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return adreslerListesi[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(adreslerListesi[row], forKey: "selected")
        adresSecimTextField.text = adreslerListesi[row]
        
        self.view.endEditing(true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
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
extension AnasayfaViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
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
