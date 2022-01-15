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
    
    var timer = Timer()
    
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
        urunSayisi = [Int]()
        let kartlar = Kisilerdao().kartAl(kisi_id: UserDefaults.standard.integer(forKey: "currentUserId"))
        for k in kartlar{
            print(k.kart_isim!)
        }
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
            self.sepetTutari = 0
            for sepetim in sepetim {
                self.urunSayisi.append(Int(sepetim.yemek_siparis_adet!)!)
                self.idArray.append(Int(sepetim.sepet_yemek_id!)!)
                self.sepetTutari += Int(sepetim.yemek_fiyat!)!
                self.sepetTutarLabel.text = "₺ \(self.sepetTutari)"
            }
        }else{
            self.sepetTutarLabel.text = "₺ 0"
        }
            if let tabItems = self.tabBarController?.tabBar.items {
            let tabItem = tabItems[1]
            DispatchQueue.main.async {
                tabItem.badgeValue = "\(self.sepetYemekler.count)"
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


//MARK: - SepetimCellProtocol //ürün adet güncelleme
extension SepetimViewController:SepetimCellProtocol{
    func stepperControl(value: Int, indexPath: IndexPath) {
        let yemek = sepetYemekler[indexPath.row]
        var yenilendi = yemek
        var taneFiyat = 0
        var trash = false
        
        self.sepetimPresenterNesnesi?.sil(sepet_yemek_id: Int(yemek.sepet_yemek_id!)!, kullanici_adi: AppDelegate().getUser()!)

        let fiyat = Int(yenilendi.yemek_fiyat!)
        let adet = Int(yenilendi.yemek_siparis_adet!)
        if let fiyat = fiyat,let adet = adet{
            taneFiyat = fiyat / adet
        }
        
          if value == -1 && self.urunSayisi[indexPath.row] <= 1{
              trash = true
              self.sepetimPresenterNesnesi?.sil(sepet_yemek_id: Int(yemek.sepet_yemek_id!)!, kullanici_adi: AppDelegate().getUser()!)
          }else if value == 1 && self.urunSayisi[indexPath.row] >= 10 {
              self.urunSayisi[indexPath.row] = 10
          }else{
              self.urunSayisi[indexPath.row] += value
          }

        
        //Ekleme işlemi
        if !trash{
            self.sepetimPresenterNesnesi?.ekle(yemek_adi: yenilendi.yemek_adi!, yemek_resim_adi: yenilendi.yemek_resim_adi!, yemek_fiyat: taneFiyat * urunSayisi[indexPath.row], yemek_siparis_adet: self.urunSayisi[indexPath.row], kullanici_adi: AppDelegate().getUser()!)
        }
        trash = false
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: false) { timer in
            self.urunSayisi = []
            taneFiyat = 0
            yenilendi = SepetYemekler()
            self.sepetimPresenterNesnesi?.getir(kullanici_adi: AppDelegate().getUser()!)
        }
        tableView.isUserInteractionEnabled = false

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            self.tableView.isUserInteractionEnabled = true
        }
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
        
        if yemek.yemek_siparis_adet! == "1"{
            cell.eksiButton.setImage(UIImage(systemName: "trash"), for: .normal)
        }else{
            cell.eksiButton.setImage(UIImage(systemName: "minus"), for: .normal)
        }

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
                self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { timer in
                    self.sepetimPresenterNesnesi?.getir(kullanici_adi: AppDelegate().getUser()!)
                }
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



