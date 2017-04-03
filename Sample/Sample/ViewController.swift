//
//  ViewController.swift
//  Sample
//
//  Created by Abdullah Selek on 03/04/2017.
//  Copyright © 2017 Abdullah Selek. All rights reserved.
//

import UIKit
import SwiftyNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let notification = SwiftyNotifications.withStyle(style: .info,
                                                         title: "Information Title",
                                                         subtitle: "Information description can be anything to give a description")
        view.addSubview(notification)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

