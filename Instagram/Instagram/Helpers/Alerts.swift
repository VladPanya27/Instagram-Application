//
//  Alerts.swift
//  Instagram
//
//  Created by Vlad Panchenko on 10.04.2022.
//

import Foundation
import UIKit


class Alerts {

    static func createAlerts(title: String, message: String, titleAction: String, style: UIAlertAction.Style) -> UIViewController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: titleAction, style: style))
        return alert
    }
}

