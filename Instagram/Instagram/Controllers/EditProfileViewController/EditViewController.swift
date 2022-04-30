//
//  EditProfileViewController.swift
//  Instagram
//
//  Created by Vlad Panchenko on 09.04.2022.
//

import UIKit

struct EditProfileFromModel {
    let label: String
    let placeholder: String
    var value: String?
}

final class EditProfileViewController: UIViewController {

    private var tableView:UITableView = {
        let table = UITableView()
        return table
    }()
    
    private var models = [[EditProfileFromModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        setupBarButtonItem()
        prepareTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func setupBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: .plain,
                                                            target: self,
                                                           action: #selector(didTapCancel))

    }
    
    @objc private func didTapSave() {
        dismiss(animated: true)
    }
    
    @objc private func didTapCancel() {
        dismiss(animated: true)
    }
    
    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "Profile Picture", message: "Change profile picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { _ in }))
        actionSheet.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated:  true)
    }

    @objc func didTapProfilePhotoButton() {
    }
}

extension EditProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func prepareTableView() {
        tableView.tableHeaderView = createHeaderTableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FromCell.self, forCellReuseIdentifier: FromCell.identifier)
        view.addSubview(tableView)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         guard section == 1 else {
            return nil
        }
        return "Private information"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FromCell.identifier, for: indexPath) as! FromCell
        let models = models[indexPath.section][indexPath.row]
        cell.configure(with: models)
        cell.delegate = self
        return cell
    }
    
    private func createHeaderTableView() -> UIView {
       
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        let size = headerView.height/1.5

        let profilePhotoButton = UIButton(frame: CGRect(x: (view.width - size)/2, y: (headerView.height - size)/2, width: size, height: size))
        headerView.addSubview(profilePhotoButton)

        profilePhotoButton.layer.masksToBounds = true
        profilePhotoButton.layer.cornerRadius = size/2.0
        profilePhotoButton.addTarget(self, action: #selector(didTapProfilePhotoButton), for: .touchUpInside)
        profilePhotoButton.setBackgroundImage(UIImage(systemName: "person"), for: .normal)
        profilePhotoButton.tintColor = .label
        profilePhotoButton.layer.borderWidth = 1
        profilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor

        return headerView
    }
}

extension EditProfileViewController {
    
    private func configureModels() {
        let sections1labels = ["Name", "Username", "Bio"]
        var section1 = [EditProfileFromModel]()
        for label in sections1labels {
            let model = EditProfileFromModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section1.append(model)
        }
        models.append(section1)
        
        let sections2labels = ["Email", "Phone", "Gender"]
        var section2 = [EditProfileFromModel]()
        for label in sections2labels {
            let model = EditProfileFromModel(label: label, placeholder: "Enter \(label)...", value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
}

extension EditProfileViewController: TableViewCellDelegate {
    
    func fromTableViewCell(_ cell: FromCell, didUpdateField updateModel: EditProfileFromModel) {
        print(updateModel.value ?? "nil")
    }
}
