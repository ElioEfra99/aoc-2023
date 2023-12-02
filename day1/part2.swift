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

let calibrationValues = fileString.split(separator: "\n")
var calibrationValueSum = 0

for row in calibrationValues {
    let array = Array(row.split(separator: ""))
    
    // Convert the string array into an int array
    // i.e. if we have "four". we convert it into a 4 in a new array
    
    // Build a new substring and inspect it until it matches one of our valid strings below
    // What if it doesn't match anything?
    // I guess
    
    let calibrationValue = Int("\(array[ptr1])\(array[ptr2])")!
    calibrationValueSum += calibrationValue
}

// Part 2
func isNumber(_ string: String) -> Bool {
    let validNumbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
    
    return validNumbers.contains(string)
}
