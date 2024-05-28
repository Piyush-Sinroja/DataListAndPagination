//
//  UIViewController+Extension.swift
//  DataListAndPagination
//
//  Created by Piyush Sinroja on 28/05/24.
//

import UIKit

// MARK: - UIViewController Extension
extension UIViewController {
    /// show alert
    /// - Parameters:
    ///   - title: title string
    ///   - message: message string
    ///   - okButtonTitle: ok button title
    ///   - okAction: ok button action handler
    func showAlert(withTitle title: String? = nil, andMessage message: String, okButtonTitle: String = Constant.Button.okButton, okAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        // Handling OK action
        let okAction = UIAlertAction(title: okButtonTitle, style: .default) { _ in
            okAction?()
        }

        // Adding action buttons to the alert controller
        alert.addAction(okAction)

        DispatchQueue.main.async { [weak self] in
            // Presenting alert controller
            self?.present(alert, animated: true, completion: nil)
        }
    }
    /// show alert
    /// - Parameters:
    ///   - title: title string
    ///   - message: message string
    ///   - okButtonTitle: ok button title
    ///   - cancelButtonTitle: cancel button title
    ///   - okAction: ok button action handler
    ///   - cancelAction: cancel button action handler
    func showAlert(withTitle title: String = Constant.Common.appTitle, andMessage message: String, okButtonTitle: String = Constant.Button.okButton, cancelButtonTitle: String = Constant.Button.cancelButton, okAction: (() -> Void)? = nil, cancelAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: okButtonTitle, style: .default) { _ in
            okAction?()
        }

        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
            cancelAction?()
        }

        alert.addAction(okAction)
        alert.addAction(cancelAction)

        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
