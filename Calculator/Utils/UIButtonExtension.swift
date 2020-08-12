//
//  UIButtonExtension.swift
//  Calculator
//
//  Created by Vitcord23 on 12/08/2020.
//  Copyright © 2020 IgorDzichkovskii. All rights reserved.
//

import UIKit

extension UIButton {

    // Round corner
    func round() {
        layer.cornerRadius = bounds.height / 2
        clipsToBounds = true
    }
    
    // Buttons shine
    func shine() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0.5
        }) {(completion) in
            UIView.animate(withDuration: 0.1, animations: {
                self.alpha = 1
            })
        }
    }
}
