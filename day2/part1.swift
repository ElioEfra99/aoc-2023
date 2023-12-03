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

//let games: [[Substring]] = fileString.split(separator: "\n").map { $0.split(separator: ":")[1].split(separator: ";") }
let games: [[String]] = fileString.split(separator: "\n").map {
    $0.split(separator: ":")[1].split(separator: ";").map {
        String($0).trimmingCharacters(in: .whitespaces)
    }
} // Probably don't need to clean the string up

let targetGame = ["red": 12, "green": 13, "blue": 14]
var IDTotal = 0

// For each game you need to figure out if it was possible
for (idx, game) in games.enumerated() {
    var isGamePossible = true
    // For every set, build a map, which later we can use to figure out if we
    for `set` in game {
        
        // Split every set and build our map
        let setArray = `set`.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
        typealias GameColor = String
        var gameMap = [GameColor: Int]()
        
        for cube in setArray {
            let splittedCube = cube.split(separator: " ")
            let (amount, color) = (Int(splittedCube[0])!, String(splittedCube[1]))
            
            gameMap[color] = amount
        }
        
        for (key, value) in gameMap {
            if value > targetGame[key]! {
                isGamePossible = false
                break
            }
        }
        
        print("Game Number \(idx + 1) has: \(gameMap)")
    }
    
    if isGamePossible {
        IDTotal += idx + 1
    }
}

print(IDTotal)
