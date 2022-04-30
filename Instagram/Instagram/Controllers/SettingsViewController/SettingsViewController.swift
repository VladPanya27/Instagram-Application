//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Vlad Panchenko on 09.04.2022.
//

import UIKit
import SafariServices

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

enum SettingsUrlType {
    case terms, privacy, help
}

final class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTable()
        configureModels()
        print(data)
    }

    private func configureModels() {
        let setis = [
            SettingCellModel(title: "Edit Profile", handler: { [weak self] in
                self?.didTapEditProfile()
            }),
            SettingCellModel(title: "Invite Friends", handler: { [weak self] in
                self?.didTapInviteFriends()
            }),
            SettingCellModel(title: "Save Original Posts", handler: { [weak self] in
                self?.didTapSaveOriginalPosts()
            })
        ]
        data.append(setis)
        
        let setis1 = [
            SettingCellModel(title: "Terms of Service", handler: { [weak self] in
                self?.openURL(type: .terms)
            }),
            SettingCellModel(title: "Privacy Policy", handler: { [weak self] in
                self?.openURL(type: .privacy)
            }),
            SettingCellModel(title: "Help / FeedBack", handler: { [weak self] in
                self?.openURL(type: .help)
            })
        ]
        data.append(setis1)
        
        let setis2 = [
            SettingCellModel(title: "Log Out", handler: { [weak self] in
                self?.didTapLogOut()
            })
        ]
        
        data.append(setis2)
        
    }

    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
    }
    
    private func didTapInviteFriends() {
        
    }
    
    private func didTapSaveOriginalPosts() {
        
    }
    
    private func openURL(type: SettingsUrlType) {
        let urlString: String
        switch type {
        case .terms: urlString = "https://help.instagram.com/581066165581870"
        case .privacy: urlString = "https://help.instagram.com/519522125107875/?maybe_redirect_pol=0"
        case .help: urlString = "https://help.instagram.com/"
        }
        guard let url = URL(string: urlString) else {return}
        
        let vc = SFSafariViewController(url: url)
        present(vc,animated: true)
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return ""
        } else if section == 1 {
            return ""
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.section][indexPath.row].handler()
    }
}
