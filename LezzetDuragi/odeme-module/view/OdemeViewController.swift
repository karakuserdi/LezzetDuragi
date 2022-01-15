//
//  OdemeViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 15.01.2022.
//

import UIKit

class OdemeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var kartListesi = [Kart]()
    var odemePresenterNesnesi:ViewToPresenterOdemeProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        OdemeRouter.createModule(ref: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier, segue.destination) {
            // Check that the segue identifer matches and destination controller is a ModalViewController
        case ("toKartEkle", let destination as OdemeEkleViewController):
            destination.delegate = self
        case ("toKartGuncelle", let destination as OdemeGuncelleViewController):
            let kart = sender as? Kart
            destination.delegate = self
            destination.kart = kart
        case _:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        odemePresenterNesnesi?.al(kisi_id: UserDefaults.standard.integer(forKey: "currentUserId"))
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension OdemeViewController: OdemeEkleViewControllerProtocol, OdemeGuncelleViewControllerProtocol{
    func odemeEkleWillDisapear(_ modal: UIViewController) {
        odemePresenterNesnesi?.al(kisi_id: UserDefaults.standard.integer(forKey: "currentUserId"))
        self.tableView.reloadData()
    }
    func odemeGuncelleWillDisapear(_ modal: UIViewController) {
        odemePresenterNesnesi?.al(kisi_id: UserDefaults.standard.integer(forKey: "currentUserId"))
        self.tableView.reloadData()
    }
}

extension OdemeViewController:PresenterToViewOdemeProtocol{
    func viewaVeriGonder(kart: Array<Kart>) {
        kartListesi = kart
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension OdemeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kartListesi.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "odemeCell", for: indexPath) as! OdemeCell
        let kart = kartListesi[indexPath.row]
        cell.kardSahibiAdLabel.text = kart.kart_isim
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let silAction = UIContextualAction(style: .destructive, title: "Sil"){ (contextualAction,view,bool) in
            let kart = self.kartListesi[indexPath.row]
            self.odemePresenterNesnesi?.sil(kart_id: kart.kart_id!)
            self.odemePresenterNesnesi?.al(kisi_id: UserDefaults.standard.integer(forKey: "currentUserId"))
            tableView.reloadData()
        }

        return UISwipeActionsConfiguration(actions: [silAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let kart = kartListesi[indexPath.row]
        performSegue(withIdentifier: "toKartGuncelle", sender: kart)
    }
}
