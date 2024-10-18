//
//  Ext+UIView.swift
//  MoviesApp
//
//  Created by Tami on 17.10.2024.
//

import UIKit
import SnapKit

extension UIView{
    
    func add(_ subview: UIView, _ closure: ((_ make: ConstraintMaker) -> Void)) {
        self.addSubview(subview)
        subview.snp.makeConstraints(closure)
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
