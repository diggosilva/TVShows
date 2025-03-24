//
//  UIViewController+Ext.swift
//  TVShows
//
//  Created by Diggo Silva on 23/03/25.
//

import UIKit

extension UIViewController {
    func presentDSAlert(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alert.addAction(ok)
        present(alert, animated: true)
    }
}
