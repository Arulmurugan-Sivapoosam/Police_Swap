//
//  ViewController.swift
//  Police_Ghost_Swap
//
//  Created by Arul on 07/06/23.
//

import UIKit

final class ViewController: UIViewController {
  
  @IBOutlet var rowField: UITextField!
  @IBOutlet var columField: UITextField!
  @IBOutlet var columnStack: UIStackView!
  @IBOutlet var policePositionLabel: UITextField!
  @IBOutlet var thiefPositionLabel: UITextField!
  
  private var currentGrid: Position = .init(row: 3, column: 3)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    changePosition()
  }
  
  /// Instance method generates shuffle positions.
  @IBAction func changePosition() {
    if let row = Int(rowField.text ?? ""),
       let column = Int(columField.text ?? "") {
      currentGrid = .init(row: row, column: column)
    }
    let policePosition: Position = PositionGenerator.generateNewPosition(boundaries: currentGrid, secondPosition: nil)
    let thiefPosition: Position = PositionGenerator.generateNewPosition(boundaries: currentGrid, secondPosition: policePosition)
    prepareGrid(policePosition: policePosition, thiefPosition: thiefPosition)
  }
  
  /// Method generates GridUI.
  func prepareGrid(policePosition: Position, thiefPosition: Position) {
    columnStack.removeAllSubviews()
    var policeGrid: UIStackView?
    var thiefGrid: UIStackView?

    for columnIndex in 0..<currentGrid.column {
      let rowStack: UIStackView = .getHStack()
      for rowIndex in 0..<currentGrid.row {
        let gridView = UIStackView()
        gridView.backgroundColor = UIColor(red: 6/255, green: 137/255, blue: 52/255, alpha: 0.25)
        rowStack.addArrangedSubview(gridView)
        /// If condition compares ierating grid with the current position of police and thives.
        /// If grid matches then stores this gridview to add an emoji later.
        if policePosition == .init(row: rowIndex, column: columnIndex) {
          policeGrid = gridView
        }
        if thiefPosition == .init(row: rowIndex, column: columnIndex) {
          thiefGrid = gridView
        }
      }
      columnStack.addArrangedSubview(rowStack)
    }
    if let policeGrid,
       let thiefGrid {
      addEmoji(to: policeGrid, thiefGrid: thiefGrid)
    }
    policePositionLabel.text = "\(policePosition.column) X \(policePosition.row)"
    thiefPositionLabel.text = "\(thiefPosition.column) X \(thiefPosition.row)"
  }
  
  /// Method adds emoji to the grid
  func addEmoji(to policeGrid: UIStackView, thiefGrid: UIStackView) {
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
