//
//  LoaderViewController.swift
//  Glasor
//
//  Created by Teodik Abrami on 11/19/18.
//  Copyright © 2018 Teodik Abrami. All rights reserved.
//

import UIKit

class LoaderViewController: UIViewController {

    fileprivate let dispathGroup = DispatchGroup()
    
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    override func viewWillLayoutSubviews() {
        firstImageView.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        firstImageView.alpha = 0
        secondImageView.transform = CGAffineTransform.init(translationX: 0, y: 300).scaledBy(x: 0, y: 0)
        secondImageView.alpha = 0
        print(DataManager.shared.userDatail)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        APIServices.instance.getLoad { (_) in
            //
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {

        // animation
        UIView.animate(withDuration: 3) {
            self.firstImageView.transform = CGAffineTransform.identity
            self.firstImageView.alpha = 1
        }
        
        UIView.animate(withDuration: 3) {
            self.secondImageView.alpha = 1
        }
        UIView.animate(withDuration: 2, animations: {
            self.secondImageView.transform = CGAffineTransform.init(translationX: 0, y: -70)
        }) { (_) in
            UIView.animate(withDuration: 1, animations: {
                self.secondImageView.transform = CGAffineTransform.identity
            })
        }
        
        
        dispathGroup.notify(queue: .main) {
            print("Complete fetch all data from ferfere server, Ready to Go!")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                if Authentication.auth.isLoggedIn {
                    self.performSegue(withIdentifier: CUSTOM_VIEW_CONTROLLER_SEGUE, sender: nil)
                } else {
                    self.performSegue(withIdentifier: LOADER_TO_LOGIN, sender: nil)
                }
            }
        }
    }
    
    


}
