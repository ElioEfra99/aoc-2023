import Foundation

func readInputFile() -> String {
    let filename = "input"

    let documentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

    let fileURL = documentDirURL.appendingPathComponent(filename).appendingPathExtension("txt")
    var fileString = ""

    do {
        fileString = try String(contentsOf: fileURL)
    } catch {
        print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
    }

    return fileString
}
