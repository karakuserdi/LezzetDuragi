//
//  ProfilViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 11.01.2022.
//

import UIKit

class ProfilViewController: UIViewController {
    
    @IBOutlet weak var profilImageView: UIImageView!
    @IBOutlet weak var toplamSiparisLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var profilPresenterNesnesi:ViewToPresenterProfilProtocol?
    var yemekler = [Yemekler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        profilImageView.layer.cornerRadius = 50
        profilImageView.layer.borderWidth = 3
        profilImageView.layer.borderColor = UIColor.orange.cgColor
        
        ProfilRouter.createModule(ref: self)
        profilPresenterNesnesi?.al()
        toplamSiparisLabel.text = "Toplam sipariş sayısı: \(UserDefaults.standard.integer(forKey: "siparisSayi"))\nToplam harcamanız: \(UserDefaults.standard.integer(forKey: "harcama")) ₺"
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProfilViewController:PresenterToViewProfilProtocol{
    func viewaVeriGonder(yemekler: Array<Yemekler>) {
        self.yemekler = yemekler
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ProfilViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favoriler"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemekler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profilCell", for: indexPath) as! ProfilCell
        let yemek = yemekler[indexPath.row]
        
        cell.yemek = yemek
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let sil = UIContextualAction(style: .destructive, title: "sil"){ [self] contextualAction,view,bool in
            let yemek = self.yemekler[indexPath.row]
            profilPresenterNesnesi?.begenildiMi(yemek_id: Int(yemek.yemek_id!)!, yemek_isLiked: "false")
        }
        
        return UISwipeActionsConfiguration(actions: [sil])
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Henüz bir favori eklemedeniz."
        label.textColor = .orange
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return yemekler.count == 0 ? 50 : 0
    }
    
    
    
    
}
