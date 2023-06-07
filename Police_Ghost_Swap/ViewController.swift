//
//  ViewController.swift
//  Police_Ghost_Swap
//
//  Created by Arul on 07/06/23.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var rowField: UITextField!
  @IBOutlet var columField: UITextField!
  @IBOutlet var columnStack: UIStackView!
  
  @IBOutlet var policePositionLabel: UITextField!
  @IBOutlet var thiefPositionLabel: UITextField!
  
  var currentGrid: Position = .init(row: 3, column: 3)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    changePosition()
  }
  
  @IBAction func changePosition() {
    if let row = Int(rowField.text ?? ""),
       let column = Int(columField.text ?? "") {
      currentGrid = .init(row: row, column: column)
    }
    let policePosition: Position = PositionGenerator.generateNewPosition(boundaries: currentGrid, secondPosition: nil)
    let thiefPosition: Position = PositionGenerator.generateNewPosition(boundaries: currentGrid, secondPosition: policePosition)
    
    print(policePosition, thiefPosition)
    prepareGrid(policePosition: policePosition, thiefPosition: thiefPosition)
  }
  
  func prepareGrid(policePosition: Position, thiefPosition: Position) {
    columnStack.arrangedSubviews.forEach { arrangedSubView in
      columnStack.removeArrangedSubview(arrangedSubView)
      arrangedSubView.removeFromSuperview()
    }
    
    var policeGrid: UIStackView?
    var thiefGrid: UIStackView?

    for columnIndex in 0..<currentGrid.column {
      let rowStack = UIStackView()
      rowStack.distribution = .fillEqually
      rowStack.spacing = 5
      rowStack.axis = .horizontal
      rowStack.translatesAutoresizingMaskIntoConstraints = false
      for rowIndex in 0..<currentGrid.row {
        let gridView = UIStackView()
        gridView.backgroundColor = UIColor(red: 6/255, green: 137/255, blue: 52/255, alpha: 0.25)
        rowStack.addArrangedSubview(gridView)
        if policePosition == .init(row: rowIndex, column: columnIndex) {
          policeGrid = gridView
        }
        if thiefPosition == .init(row: rowIndex, column: columnIndex) {
          thiefGrid = gridView
        }
      }
      columnStack.addArrangedSubview(rowStack)
    }
    
    addEmoji(to: policeGrid!, thiefGrid: thiefGrid!)
    policePositionLabel.text = "\(policePosition.column) X \(policePosition.row)"
    thiefPositionLabel.text = "\(thiefPosition.column) X \(thiefPosition.row)"
  }
  
  
  /// Method adds emoji to the grid
  func addEmoji(to policeGrid: UIStackView, thiefGrid: UIStackView) {
    let policeLabel = UILabel()
    policeLabel.text = "👮‍♀️"
    policeLabel.textAlignment = .center
    policeGrid.alignment = .center
    policeGrid.addArrangedSubview(policeLabel)
    
    let thiefLabel = UILabel()
    thiefLabel.text = "👻"
    thiefLabel.textAlignment = .center
    thiefGrid.alignment = .center
    thiefGrid.addArrangedSubview(thiefLabel)
  }
}

/// Position generate randomly generates grids
final class PositionGenerator {
  static func generateNewPosition(boundaries: Position, secondPosition: Position?) -> Position {
    guard let nextPosition = secondPosition else { return .init(row: 0, column: 0) }
    let generatedPersonRandomIndex = PositionGenerator.generateNewIndex(range: boundaries)
    let isValidPosition = PositionGenerator.validatePositions(person1: generatedPersonRandomIndex, person2: nextPosition)
    return isValidPosition ? generatedPersonRandomIndex : PositionGenerator.generateNewPosition(boundaries: boundaries, secondPosition: nextPosition)
  }
  
  static func generateNewIndex(range: Position) -> Position {
    let random_row = Int.random(in: 0..<range.row)
    let random_column = Int.random(in: 0..<range.column)
    
    return Position(row: random_row, column: random_column)
  }
  
  static func validatePositions(person1: Position , person2: Position) -> Bool {
    return person1.column != person2.column && person1.row != person2.row
  }
  
}
