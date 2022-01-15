//
//  AyarlarViewController.swift
//  LezzetDuragi
//
//  Created by Riza Erdi Karakus on 14.01.2022.
//

import UIKit
import SafariServices

struct AyarlarModel {
    let id: Int
    var baslik: String
    var icon:UIImage
    let handler: (() -> Void)
}


class AyarlarViewController: UIViewController {
    //MARK: - Properties
    
    var cellData = [AyarlarModel]()
    @IBOutlet weak var tableView: UITableView!
    
    enum AyarlarURLType {
        case terms, privacy, help
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        ayarlarCellData()
    }
    
    //
    private func ayarlarCellData(){
        cellData.append(AyarlarModel(id: 1, baslik: "Bizi arkadaşlarınla paylaşmaya ne dersin?", icon: UIImage(systemName: "paperplane.fill")!) {[weak self] in
            self?.didTapShareButton()
        })
        cellData.append(AyarlarModel(id: 1, baslik: "Adreslerim", icon: UIImage(systemName: "house")!) { [weak self] in
            self?.adreslerimButtonPressed()
        })
        cellData.append(AyarlarModel(id: 1, baslik: "Ödeme Bilgilerim", icon: UIImage(systemName: "creditcard")!) { [weak self] in
            self?.kartButtonPressed()
        })
        cellData.append(
            AyarlarModel(id: 3, baslik: "Kullanıcı Sözleşmesi", icon: UIImage(systemName: "person")!) { [weak self] in
                self?.openUrl(type: .terms)
        })
        
        cellData.append(
            AyarlarModel(id: 4, baslik: "Gizlilik Politikası", icon: UIImage(systemName: "lock")!) { [weak self] in
                self?.openUrl(type: .privacy)
        })
        cellData.append(AyarlarModel(id: 5, baslik: "S.S.S. ve İşlem Rehberi", icon: UIImage(systemName: "list.bullet.rectangle.portrait")!) { [weak self] in
                self?.openUrl(type: .help)
        })
        
        cellData.append(AyarlarModel(id: 6, baslik: "Çıkış Yap", icon: UIImage(systemName: "delete.left")!) { [weak self] in
            self?.cikisYapButtonPressed()
        })
    }
    
    private func openUrl(type: AyarlarURLType){
        let urlString: String
        switch type {
        case .terms: urlString = "https://www.yemeksepeti.com/kullanici-sozlesmesi"
        case .privacy: urlString = "https://www.yemeksepeti.com/gizlilik-politikasi#:~:text=Yemek%20Sepeti%20ayr%C4%B1ca%2C%20Kanunu'nun,i%C5%9Fleyebilecek%20ve%20%C3%BC%C3%A7%C3%BCnc%C3%BC%20ki%C5%9Filerle%20payla%C5%9Fabilecektir."
        case .help: urlString = "https://www.yemeksepeti.com/istanbul/sss"
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Buttons
    
    func adreslerimButtonPressed(){
        performSegue(withIdentifier: "toAdreslerim", sender: nil)
    }
    func kartButtonPressed(){
        performSegue(withIdentifier: "toOdeme", sender: nil)
    }
    
    
    private func cikisYapButtonPressed(){
        let actionSheed = UIAlertController(title: "Çıkış Yap", message: "Çıkış yapmak istiyor musunuz?", preferredStyle: .actionSheet)
        actionSheed.addAction(UIAlertAction(title: "Vazgeç", style: .cancel, handler: nil))
        actionSheed.addAction(UIAlertAction(title: "Çıkış Yap", style: .destructive) { _ in
            
            UserDefaults.standard.set(0, forKey: "sepet")
            UserDefaults.standard.set("", forKey: "currentUser")
            UserDefaults.standard.set(0, forKey: "currentUserId")
            UserDefaults.standard.set(false, forKey: "login")
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            self.present(controller, animated: true, completion: nil)
        })
        present(actionSheed, animated: true, completion: nil)
    }
    
    private func didTapShareButton(){
        let avtivityVC = UIActivityViewController(activityItems: ["En lezzetli ve hızlı servis için kesinlikle bu uygulamayı kullanmalısın :)"], applicationActivities: nil)
        avtivityVC.popoverPresentationController?.sourceView = self.view
        self.present(avtivityVC, animated: true, completion: nil)
    }

    
    //MARK: - Actions
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension AyarlarViewController: UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ayarlarCell", for: indexPath) as! AyarlarCell
        let veri = cellData[indexPath.row]
        
        cell.ayarlarLabel.text = veri.baslik
        cell.ayarlarIconImageView.image = veri.icon
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        cellData[indexPath.row].handler()
    }
}
