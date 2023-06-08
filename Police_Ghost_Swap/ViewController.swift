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
  @IBOutlet var policePositionLabel: UITextField!
  @IBOutlet var thiefPositionLabel: UITextField!
  @IBOutlet var gridView: GridView!

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
    policePositionLabel.text = "\(policePosition.column) X \(policePosition.row)"
    thiefPositionLabel.text = "\(thiefPosition.column) X \(thiefPosition.row)"
    gridView.prepareGrid(policePosition: policePosition, thiefPosition: thiefPosition, currentGrid: currentGrid)
  }
}
