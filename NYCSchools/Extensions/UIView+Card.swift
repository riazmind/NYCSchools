//
//  UIView+Card.swift
//  NYCSchools
//

import UIKit

extension UIView {
    
    func cardView() -> Void {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.brown.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.5
    }
}
