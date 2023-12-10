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

let splittedInput = fileString.split(separator: "\n\n")

let instructions: [Character] = splittedInput[0].map { $0 }
let map = splittedInput[1].split(separator: "\n").map { $0.split(separator: "=") }
var currentNode = "AAA"
var lastNode = "ZZZ"

var nodes = [String: [String]]()

for node in map {
    let key = String(node[0]).trimmingCharacters(in: .whitespaces)
    var networkSegment = String(node[1]).trimmingCharacters(in: .whitespaces)
    
    networkSegment.removeLast()
    networkSegment.removeFirst()
    
    let values = networkSegment.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespaces) }
    
    nodes[key] = [values[0], values[1]]
}

private func gatherNecessarySteps(nodes: [String: [String]]) -> Int {
    var steps = 0
    var instructionsCount = 0
    
    while true {
        if instructions[instructionsCount] == "L" {
            currentNode = nodes[currentNode]![0]
        } else {
            currentNode = nodes[currentNode]![1]
        }
        
        if instructionsCount == instructions.count - 1 {
            instructionsCount = 0
        } else {
            instructionsCount += 1
        }
        
        steps += 1
        
        if currentNode == lastNode {
            break
        }
    }
    
    return steps
}

print("Required Steps: \(gatherNecessarySteps(nodes: nodes))")
