//
//  SearchVC.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/13/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

class SearchVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var users: [Profile] = []
    
    var filteredUsers: [Profile] = []
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.barTintColor = .gray
        sb.placeholder = "username"
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        sb.delegate = self
        return sb
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchUsers {
            self.filteredUsers = self.users
            self.collectionView?.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredUsers = users
        } else {
            filteredUsers = users.filter({ (profile) -> Bool in
                return profile.username.lowercased().contains(searchText.lowercased())
            })
            self.collectionView?.reloadData()
        }
    }
    
    fileprivate func fetchUsers(onSuccess: @escaping ()-> Void) {
        let ref = Database.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictonaries = snapshot.value as? [String: Any] else {return}
            dictonaries.forEach({ (key, value) in
                guard let user = value as? [String: Any] else {return}
                self.users.append(Profile(uid: key, dictonary: user))
            })
            self.users.sort(by: {$0.username.compare($1.username) == .orderedAscending})
            onSuccess()
        }) { (err) in
            print(err, "failed to get users")
        }
    }
}
