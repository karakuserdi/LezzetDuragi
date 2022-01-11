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
    
    
}
