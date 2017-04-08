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

    private var notification: SwiftyNotifications!

    override func viewDidLoad() {
        super.viewDidLoad()

        notification = SwiftyNotifications.withStyle(style: .info,
                                                     title: "Information Title",
                                                     subtitle: "Information description can be anything to give a description")
        view.addSubview(notification)
    }

    @IBAction func show(_ sender: Any) {
        notification.show()
    }

    @IBAction func dismiss(_ sender: Any) {
        notification.dismiss()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

