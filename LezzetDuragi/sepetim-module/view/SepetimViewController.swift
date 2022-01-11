//
//  SepetimViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 9.01.2022.
//

import UIKit

class SepetimViewController: UIViewController{
    
    //MARK: - Properties
    var sepetimPresenterNesnesi:ViewToPresenterSepetimProtocol?
    var sepetYemekler = [SepetYemekler]()
    var urunSayisi = [Int]()
    var sepetTutari:Int = 0
    var idArray:[Int] = [Int]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sepetTutarLabel: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        bgView.layer.cornerRadius = 30
        bgView.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
        SepetimRouter.createModule(ref: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sepetimPresenterNesnesi?.getir(kullanici_adi: AppDelegate().getUser()!)
    }
    
    //MARK: - Actions
    @IBAction func siparisTamamlaButtonPressed(_ sender: Any) {
        if sepetYemekler.count != 0{
            sepetimPresenterNesnesi?.hepsiniSil(sepet_yemek_id: idArray, kullanici_adi: AppDelegate().getUser()!)
            UserDefaults.standard.set(0, forKey: "sepet")
            performSegue(withIdentifier: "toSiparisDetay", sender: nil)
            
            var sayi = UserDefaults.standard.integer(forKey: "siparisSayi")
            sayi = sayi + 1
            UserDefaults.standard.set(sayi, forKey: "siparisSayi")
            
            var harcama = UserDefaults.standard.integer(forKey: "harcama")
            harcama = harcama + sepetTutari
            UserDefaults.standard.set(harcama, forKey: "harcama")
        }
    }
}

//MARK: - PresenterToViewSepetimProtocol
extension SepetimViewController:PresenterToViewSepetimProtocol{
    func viewaVeriGonder(sepetim: Array<SepetYemekler>) {
        self.sepetYemekler = sepetim
        if !sepetim.isEmpty{
            sepetTutari = 0
            for sepetim in sepetim {
                urunSayisi.append(Int(sepetim.yemek_siparis_adet!)!)
                idArray.append(Int(sepetim.sepet_yemek_id!)!)
                sepetTutari += Int(sepetim.yemek_fiyat!)!
                sepetTutarLabel.text = "₺ \(sepetTutari)"
            }
        }else{
            sepetTutarLabel.text = "₺ 0"
        }
        
        if let tabItems = tabBarController?.tabBar.items {
            let tabItem = tabItems[1]
            DispatchQueue.main.async {
                self.tableView.reloadData()
                tabItem.badgeValue = "\(self.sepetYemekler.count)"
            }
        }
    }
}

//MARK: - SepetimCellProtocol
extension SepetimViewController:SepetimCellProtocol{
    func stepperControl(value: Int, indexPath: IndexPath) {
        if value == -1 && urunSayisi[indexPath.row] <= 1{
            urunSayisi[indexPath.row] = 1
        }else if value == 1 && urunSayisi[indexPath.row] >= 10 {
            urunSayisi[indexPath.row] = 10
        }else{
            urunSayisi[indexPath.row] += value
        }
        
        print("\(indexPath.row).row ürün sayisi \(urunSayisi[indexPath.row])")
    }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension SepetimViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sepetYemekler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sepetimCell", for: indexPath) as! SepetimCell
        let yemek = sepetYemekler[indexPath.row]
        
        cell.yemek = yemek
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction,view,bool) in
            let yemek = self.sepetYemekler[indexPath.row]
            
            let alert = UIAlertController(title: "", message: "\(yemek.yemek_adi!) sepetten kaldırılsın mı?", preferredStyle: .alert)
            
            let iptalAction = UIAlertAction(title: "İptal", style: .cancel){ action in}
            alert.addAction(iptalAction)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.sepetimPresenterNesnesi?.sil(sepet_yemek_id: Int(yemek.sepet_yemek_id!)!, kullanici_adi: AppDelegate().getUser()!)
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
    //Sepet boşsa footer viewa uyarı mesajı ekle
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let imageView = UIImageView(frame: self.view.frame)
        imageView.image = UIImage(named:"sepet-bos")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sepetYemekler.count == 0 ? 150 : 0
    }
}



