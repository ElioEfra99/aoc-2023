import Foundation

let filename = "input"
let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

let fileURL = documentDirURL.appendingPathComponent(filename).appendingPathExtension("txt")
var fileString = ""

do {
    fileString = try String(contentsOf: fileURL)
} catch {
    fatalError("Failed reading from URL: \(fileURL), Error: \(error.localizedDescription)")
}

// 1. Build a 2D array from the input
let engineSchematic: [[Character]] = fileString.split(separator: "\n").map { Array($0) }
var visitedIndices = [[Int]]()

var engineSchematicSum = 0

// 2. Traverse the entirety of the 2D array and look for symbols other than . and numbers
for rowIdx in 0..<engineSchematic.count {
    for colIdx in 0..<engineSchematic[rowIdx].count {
        if engineSchematic[rowIdx][colIdx] == "*" {
            // engineSchematic[rowIdx][colIdx] // This is our special character we're looking for
            
            // 3. For every symbol you find, look for numbers up, left, right, down and diagonally
            engineSchematicSum += lookForSuroundingNumbers(
                in: engineSchematic,
                row: rowIdx,
                col: colIdx,
                maxRowIdx: engineSchematic.count - 1,
                maxColIdx: engineSchematic[rowIdx].count - 1,
                visitedIndices: &visitedIndices,
                engineSchematicSum: &engineSchematicSum
            )
        }
    }
}

print("Engine Schematic Sum: \(engineSchematicSum)")

private func lookForSuroundingNumbers(
    in schematic: [[Character]],
    row: Int,
    col: Int,
    maxRowIdx: Int,
    maxColIdx: Int,
    visitedIndices: inout [[Int]],
    engineSchematicSum: inout Int
) -> Int {
    var ratios = [Int]()
    var foundNumbers = 0
    
    // Up-left
    if row > 0 && col > 0 {
        if let number = lookForNumberInDirection(
            targetRow: row - 1, targetCol: col - 1,
            schematic: schematic, visitedIndices: &visitedIndices
        ) {
            ratios.append(number)
            foundNumbers += 1
        }
    }
    
    // Up
    if row > 0 {
        if let number = lookForNumberInDirection(
            targetRow: row - 1, targetCol: col,
            schematic: schematic, visitedIndices: &visitedIndices
        ) {
            ratios.append(number)
            foundNumbers += 1
        }
    }
    
    // Up-right
    if row > 0 && col < maxColIdx {
        if let number = lookForNumberInDirection(
            targetRow: row - 1, targetCol: col + 1,
            schematic: schematic, visitedIndices: &visitedIndices
        ) {
            ratios.append(number)
            foundNumbers += 1
        }
    }
    
    // Left
    if col > 0 {
        if let number = lookForNumberInDirection(
            targetRow: row, targetCol: col - 1,
            schematic: schematic, visitedIndices: &visitedIndices
        ) {
            ratios.append(number)
            foundNumbers += 1
        }
    }
    
    // Right
    if col < maxColIdx {
        if let number = lookForNumberInDirection(
            targetRow: row, targetCol: col + 1,
            schematic: schematic, visitedIndices: &visitedIndices
        ) {
            ratios.append(number)
            foundNumbers += 1
        }
    }
    
    // Down-left
    if row < maxRowIdx && col > 0 {
        if let number = lookForNumberInDirection(
            targetRow: row + 1, targetCol: col - 1,
            schematic: schematic, visitedIndices: &visitedIndices
        ) {
            ratios.append(number)
            foundNumbers += 1
        }
    }
    
    // Down
    if row < maxRowIdx {
        if let number = lookForNumberInDirection(
            targetRow: row + 1, targetCol: col,
            schematic: schematic, visitedIndices: &visitedIndices
        ) {
            ratios.append(number)
            foundNumbers += 1
        }
    }
    
    // Down-right
    if row < maxRowIdx && col < maxColIdx {
        if let number = lookForNumberInDirection(
            targetRow: row + 1, targetCol: col + 1,
            schematic: schematic, visitedIndices: &visitedIndices
        ) {
            ratios.append(number)
            foundNumbers += 1
        }
    }
    
    // Assuming only 2 adjacencies will occur at most, other numbers would be ignored
    if foundNumbers > 1 {
        return ratios[0] * ratios[1]
    }
    
    return 0
}

private func lookForNumberInDirection(targetRow: Int, targetCol: Int, schematic: [[Character]], visitedIndices: inout [[Int]]) -> Int? {
    let isAdjacentNumber = schematic[targetRow][targetCol].isNumber
    let numberWasVisited = visitedIndices.contains([targetRow, targetCol])
    
    if isAdjacentNumber, !numberWasVisited {
        
        // Identify the entire number if we have a single digit
        return searchFullNumber(
            in: schematic[targetRow],
            currentRowIdx: targetRow,
            currentColIdx: targetCol,
            visitedIndices: &visitedIndices
        )
    }
    
    return nil
}

private func searchFullNumber(
    in row: [Character],
    currentRowIdx: Int,
    currentColIdx: Int,
    visitedIndices: inout [[Int]]
) -> Int {
    // Look for first leftmost idx that is different than a number
    var lastLeftNumIdx = currentColIdx
    for i in stride(from: currentColIdx, through: 0, by: -1) {
        if !row[i].isNumber {
            break
        }
        lastLeftNumIdx = i
    }
    
    // Look for first rightmost idx that is different than a number
    var lastRightNumIdx = currentColIdx
    for i in currentColIdx..<row.count {
        if !row[i].isNumber {
            break
        }
        lastRightNumIdx = i
    }
    
    // You grab the characters in that range and build a Number
    
    let num = Int(row[lastLeftNumIdx...lastRightNumIdx].map { String($0) }.joined(separator: ""))!
    
    
    // Add indices to visitedIndices
    for idx in lastLeftNumIdx...lastRightNumIdx {
        visitedIndices.append([currentRowIdx, idx])
    }
    
    return num
}
