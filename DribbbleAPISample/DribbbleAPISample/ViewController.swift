//
//  ViewController.swift
//  DribbbleAPISample
//
//  Created by Eduard Panasiuk on 29.05.22.
//

import UIKit
import DribbbleAPI

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    let manager = DBLoginManager(clientID: "efb0eafb4713dd79409d3448771adb52d1678aae2f5df6a8320c4e4fa250fb82",
                                 clientSecret: "31a6e66309707fe6c5ef57f9de68a1aab1341bea9802e4edf057215e1c2f4a30",
                                 callbackURL: URL(string:"dribbbleapi://phone-callback")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance(whenContainedInInstancesOf: [DBNavigationViewController.self]).tintColor = UIColor.white
        UINavigationBar.appearance(whenContainedInInstancesOf: [DBNavigationViewController.self]).backgroundColor = .lightGray
        UINavigationBar.appearance(whenContainedInInstancesOf: [DBNavigationViewController.self]).barTintColor = .lightGray
        UINavigationBar.appearance(whenContainedInInstancesOf: [DBNavigationViewController.self]).isTranslucent = false
        
        updateButton(manager.isLoggedIn())
    }
    
    //MARK: - actions
    @IBAction func login(_ sender: AnyObject) {
        if manager.isLoggedIn() {
            manager.logout(callback: {[weak self] in
                self?.updateButton(false)
            })
            return
        }
        manager.login(from: self, callback: {[weak self] result in
            self?.updateButton(result)
            print("login result: \(result)")
        })
    }
    
    //MARK: - private
    private func updateButton(_ state:Bool) {
        let title = state ? "Log Out" : "Log In"
        button.setTitle(title, for: .normal)
    }
    
    
}

