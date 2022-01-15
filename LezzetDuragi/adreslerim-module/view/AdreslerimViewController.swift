//
//  AdreslerimViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 14.01.2022.
//

import UIKit

class AdreslerimViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var adresListesi = [Adres]()
    var adreslerimPresenterNesnesi:ViewToPresenterAdreslerimProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AdreslerimRouter.createModule(ref: self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination) {
            // Check that the segue identifer matches and destination controller is a ModalViewController
        case ("toAdresEkle", let destination as AdresEkleViewController):
            destination.delegate = self
        case ("toAdresGuncelle", let destination as AdresGuncelleViewController):
            let adres = sender as? Adres
            destination.delegate = self
            destination.adres = adres
        case _:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        adreslerimPresenterNesnesi?.adres(kisi_id: UserDefaults.standard.integer(forKey: "currentUserId"))
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension AdreslerimViewController:PresenterToViewAdreslerimProtocol{
    func viewaVeriGonder(adres: Array<Adres>) {
        adresListesi = adres
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension AdreslerimViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adresListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "adreslerimCell", for: indexPath) as! AdreslerimCell
        let adres = adresListesi[indexPath.row]
        cell.adresBaslik.text = adres.adres_baslik
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction,view,bool) in
            let adres = self.adresListesi[indexPath.row]
            self.adreslerimPresenterNesnesi?.sil(adres_id: adres.adres_id!)
            self.adreslerimPresenterNesnesi?.adres(kisi_id: UserDefaults.standard.integer(forKey: "currentUserId"))
            tableView.reloadData()
        }

        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let adres = adresListesi[indexPath.row]
        performSegue(withIdentifier: "toAdresGuncelle", sender: adres)
    }
}

extension AdreslerimViewController: AdresEkleViewControllerProtocol,AdresGuncelleViewControllerProtocol {
    func adresEkleWillDisapear(_ modal: UIViewController) {
        adreslerimPresenterNesnesi?.adres(kisi_id: UserDefaults.standard.integer(forKey: "currentUserId"))
        self.tableView.reloadData()
    }
    func adresGuncelleWillDisapear(_ modal: UIViewController) {
        adreslerimPresenterNesnesi?.adres(kisi_id: UserDefaults.standard.integer(forKey: "currentUserId"))
        self.tableView.reloadData()
    }
}
