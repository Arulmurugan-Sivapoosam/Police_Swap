//
//  Model.swift
//  Police_Ghost_Swap
//
//  Created by Arul on 07/06/23.
//

import Foundation

struct Position: Equatable {
  var row, column: Int
}

/// Generate random positions.
final class PositionGenerator {
  static func generateNewPosition(boundaries: Position, secondPosition: Position?) -> Position {
    guard let nextPosition = secondPosition else { return .init(row: 0, column: 0) }
    let generatedPersonRandomIndex = PositionGenerator.generateNewIndex(range: boundaries)
    let isValidPosition = PositionGenerator.validatePositions(position1: generatedPersonRandomIndex, position2: nextPosition)
    return isValidPosition ? generatedPersonRandomIndex : PositionGenerator.generateNewPosition(boundaries: boundaries, secondPosition: nextPosition)
  }
  
  static func generateNewIndex(range: Position) -> Position {
    let random_row = Int.random(in: 0..<range.row)
    let random_column = Int.random(in: 0..<range.column)
    return Position(row: random_row, column: random_column)
  }
  
  static func validatePositions(position1: Position ,position2: Position) -> Bool {
    return position1.column != position2.column && position1.row != position2.row
  }
}
