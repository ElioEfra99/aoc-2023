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

// 1. Clean up the input and construct 2 arrays for each row
// 2. Traverse the second array, which I'm calling the myNumbers array
// 3. For each number, look for it within the first array, if it's there, we increase the score
// 4. Return the total score

let pile = fileString.split(separator: "\n").map { $0.split(separator: ":")[1] }
var pileScore = 0

for scratchcard in pile {
    var cardScore = 0
    let results = scratchcard.split(separator: "|")
    
    let winningNumbersArray = results[0].split(separator: " ").map { Int($0)! }
    let myNumbersArray = results[1].split(separator: " ").map { Int($0)! }

    for number in myNumbersArray {
        if winningNumbersArray.contains(number) {
            cardScore = number == 0 ? 1 : cardScore * 2
        }
    }
    
    pileScore += cardScore
}

print("Pile Score: \(pileScore)")
