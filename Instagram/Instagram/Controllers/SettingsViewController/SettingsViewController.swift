//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Vlad Panchenko on 09.04.2022.
//

import UIKit

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

final class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTable()
        configureModels()
    }

    private func configureModels() {
        let section = [
            SettingCellModel(title: "Log Out", handler: { [weak self] in
                self?.didTapLogOut()
            })
        ]
        data.append(section)
    }

    private func didTapLogOut() {
        let actionSheet = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { _ in
            FirebaseAuthManager.shared.logOut {  [weak self] succes in
                DispatchQueue.main.async {
                    if succes {
                        self?.presentLogin()
                    }
                    else {
                        fatalError("Could not log out user")
                    }
                }
            }
        }))
        present(actionSheet, animated: true)
    }
    
    private func presentLogin() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: false) {
            self.navigationController?.popToRootViewController(animated: false)
            self.tabBarController?.selectedIndex = 0
        }
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
   
    func prepareTable() {
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = data[indexPath.section][indexPath.row].handler()
        
    }

}
