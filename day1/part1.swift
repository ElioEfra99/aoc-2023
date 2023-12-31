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

for value in calibrationValues {
    let array = Array(value.split(separator: ""))
    
    var ptr1 = 0
    var ptr2 = array.count - 1
    
    while !isNumber(String(array[ptr1])) {
        ptr1 += 1
    }
    
    while !isNumber(String(array[ptr2])) {
        ptr2 -= 1
    }
    
    let calibrationValue = Int("\(array[ptr1])\(array[ptr2])")!
    calibrationValueSum += calibrationValue
}

print(calibrationValueSum)

func isNumber(_ string: String) -> Bool {
    let validNumbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    return validNumbers.contains(string)
}
