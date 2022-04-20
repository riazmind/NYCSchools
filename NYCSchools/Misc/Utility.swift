//
//  Utility.swift
//  NYCSchools
//

import UIKit

struct Utility {
    
    static func alert(title: String, message: String, contoller: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        contoller.present(alert, animated: true, completion: nil)
    }

    static func open(scheme: String, string: String?, contoller: UIViewController) {
        guard let urlString = string,
                let url = URL(string: "\(scheme)://\(urlString)"),
                UIApplication.shared.canOpenURL(url) else {
                    print("Problem in opening = \(String(describing: string))")
                    Utility.alert(title: "Error", message: "Application not found to open it", contoller: contoller)
                    return
        }
        UIApplication.shared.open(url)
    }
}
