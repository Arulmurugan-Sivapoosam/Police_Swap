//
//  Extensions.swift
//  Police_Ghost_Swap
//
//  Created by Arul on 08/06/23.
//

import Foundation
import UIKit

extension UIStackView {
  func removeAllSubviews() {
    self.arrangedSubviews.forEach { arrangedSubView in
      self.removeArrangedSubview(arrangedSubView)
      arrangedSubView.removeFromSuperview()
    }
  }
  
  static func getHStack(with spacing: CGFloat = 5) -> UIStackView {
    let hstack = UIStackView()
    hstack.distribution = .fillEqually
    hstack.spacing = spacing
    hstack.axis = .horizontal
    return hstack
  }
}

extension UILabel {
  func setCenterAlignedText(_ str: String) {
    self.text = str
    self.textAlignment = .center
  }
}
