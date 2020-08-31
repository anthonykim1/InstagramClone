//
//  SettingsViewController.swift
//  Instagram
//
//  Created by Anthony Kim on 8/26/20.
//  Copyright © 2020 Anthony Kim. All rights reserved.
//
import SafariServices
import UIKit

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

/// View controller to show user settings
final class SettingsViewController: UIViewController { // final class so nobody can sub class it
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped) //default grouped table view section
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    private var data = [[SettingCellModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // this function gets called after all the subviews get/have layouted so we can assign the frame here
    // that way it will count for things like for safe area and what not
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureModels() {
        
        data.append([
            SettingCellModel(title: "Edit Profile") { [weak self] in
                self?.didTapEditProfile()
            },
            SettingCellModel(title: "Invite Friends") { [weak self] in
                self?.didTapInviteFriends()
            },
            SettingCellModel(title: "Save Original Posts") { [weak self] in
                self?.didTapSaveOriginalPosts()
            }
        ])
        
        
        data.append([
            SettingCellModel(title: "Terms of Service") { [weak self] in
                self?.openURL(type: .terms)
            },
            SettingCellModel(title: "Privacy Policy") { [weak self] in
                self?.openURL(type: .privacy)
            },
            SettingCellModel(title: "Help / Feedback") { [weak self] in
                self?.openURL(type: .help)
            }
        ])
        
        data.append([
            SettingCellModel(title: "Log Out") { [weak self] in
                self?.didTapLogOut()
            }
        ])
    }
    
    enum SettingsURLType {
        case terms, privacy, help
    }
    
    private func openURL(type: SettingsURLType){
        let urlString: String
        switch type {
        case .terms: urlString = "https://help.instagram.com/478745558852511/?helpref=hc_fnav"
        case .privacy: urlString = "https://help.instagram.com/155833707900388"
        case .help: urlString = "https://help.instagram.com/"
        }
        
        guard let url = URL(string: urlString) else{
            return
        }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    private func didTapSaveOriginalPosts() {
        
    }
    
    private func didTapInviteFriends() {
        // show share sheet to invite friends
    }
    
    private func didTapEditProfile() {
        let vc = EditProfileViewController()
        vc.title = "Edit Profile"
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    private func didTapLogOut() {
        // before authmanager stuff, lets create action sheet
        let actionSheet = UIAlertController(title: "Log Out",
                                            message: "Are you sure you want to log out",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in // _ in because we want to discard the results
            // show action sheet to the user and make sure they want to log out and then we want to log out
            AuthManager.shared.logOut(completion: { success in
                DispatchQueue.main.async {
                    if success {
                        // present log in
                        let loginVC = LoginViewController()
                        loginVC.modalPresentationStyle = .fullScreen
                        self.present(loginVC, animated: true) {
                            self.navigationController?.popToRootViewController(animated: false)
                            self.tabBarController?.selectedIndex = 0
                            
                        }
                    }else{
                        // error occured
                        fatalError("could not log out user")
                    }
                }
                
                
            })
        }))
        // make sure it doesnt crash on ipad
        actionSheet.popoverPresentationController?.sourceView = tableView
        actionSheet.popoverPresentationController?.sourceRect = tableView.bounds // if you dont present this on a ipad, the actionsheet doesnt know how to present itself so it will crash the app.
        present(actionSheet, animated: true)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // handle cell selection
        data[indexPath.section][indexPath.row].handler() //invoke that model handler
       
    }
}
