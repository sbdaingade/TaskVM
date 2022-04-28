//
//  Extesions.swift
//  Virtusa-IOS-Developer-Assignment
//
//  Created by Sachin Daingade on 28/04/22.
//

import Foundation
import UIKit

extension UIView {

func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    layer.mask = mask
}

func topRounded() {
    self.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
}

func bottomRounded() {
    self.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10.0)
}

func topBottomRounded() {
    self.roundCorners(corners: [.topLeft, .topRight,.bottomLeft, .bottomRight], radius: 10.0)
}

func defaultStateForBorders() {
    self.roundCorners(corners: [], radius: 0)
}

}
