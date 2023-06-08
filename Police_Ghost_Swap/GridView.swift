//
//  GridView.swift
//  Police_Ghost_Swap
//
//  Created by Arul on 08/06/23.
//

import UIKit

class GridView: UIStackView {
  
  /// Method generates the GridUI.
  func prepareGrid(policePosition: Position, thiefPosition: Position, currentGrid: Position) {
    removeAllSubviews()
    var policeGrid: UIStackView?
    var thiefGrid: UIStackView?
    
    /// For loop generates rows and columns UI.
    for columnIndex in 0..<currentGrid.column {
      let rowStack: UIStackView = .getHStack()
      for rowIndex in 0..<currentGrid.row {
        let gridView = UIStackView()
        gridView.backgroundColor = UIColor(red: 6/255, green: 137/255, blue: 52/255, alpha: 0.25)
        rowStack.addArrangedSubview(gridView)
        /// If condition compares iterating grid with the current position of police and thives.
        /// If grid matches then stores this gridview to add an emoji later.
        if policePosition == .init(row: rowIndex, column: columnIndex) {
          policeGrid = gridView
        }
        if thiefPosition == .init(row: rowIndex, column: columnIndex) {
          thiefGrid = gridView
        }
      }
      addArrangedSubview(rowStack)
    }
    if let policeGrid,
       let thiefGrid {
      addEmoji(to: policeGrid, thiefGrid: thiefGrid)
    }
  }
  
  /// Method adds emoji to the grid
  private func addEmoji(to policeGrid: UIStackView, thiefGrid: UIStackView) {
    let policeLabel = UILabel()
    policeLabel.setCenterAlignedText("👮‍♀️")
    policeGrid.addArrangedSubview(policeLabel)
    
    let thiefLabel = UILabel()
    thiefLabel.setCenterAlignedText("👻")
    thiefGrid.addArrangedSubview(thiefLabel)
    
    thiefGrid.alignment = .center
    policeGrid.alignment = .center
  }
}
