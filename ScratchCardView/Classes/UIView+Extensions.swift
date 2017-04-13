//
//  UIView+ScratchCard.swift
//  Pods
//
//  Created by Piotr Gorzelany on 09/04/2017.
//
//

import UIKit

extension UIView {
    
    func addSubviewFullscreen(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[subview]-(0)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["subview": subview]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[subview]-(0)-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["subview": subview]))
    }    
}
