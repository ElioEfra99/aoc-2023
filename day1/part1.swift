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
    string == "0" || string == "1" || string == "2" || string == "3" || string == "4" || string == "5" || string == "6" || string == "7" || string == "8" || string == "9"
}
