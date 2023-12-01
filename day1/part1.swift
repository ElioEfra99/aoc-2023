import Foundation

let filename = "input"
let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

let fileURL = documentDirURL.appendingPathComponent(filename).appendingPathExtension("txt")
var readString = ""

do {
    readString = try String(contentsOf: fileURL)
} catch {
    fatalError("Failed reading from URL: \(fileURL), Error: \(error.localizedDescription)")
}

print(readString)
