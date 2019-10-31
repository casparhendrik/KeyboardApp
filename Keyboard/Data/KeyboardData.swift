import Foundation

struct KeyboardData {
  // String representation of each morse signal
  enum Signal: String {
    case letterA = "a"
    case letterB = "b"
    case letterC = "c"
    case letterD = "d"
    case letterE = "e"
    case letterF = "f"
    case letterG = "g"
    case letterH = "h"
    case letterI = "i"
    case letterJ = "j"
    case letterK = "k"
    case letterL = "l"
    case letterM = "m"
    case letterN = "n"
    case letterO = "o"
    case letterP = "p"
    case letterQ = "q"
    case letterR = "r"
    case letterS = "s"
    case letterT = "t"
    case letterU = "u"
    case letterV = "v"
    case letterW = "w"
    case letterX = "x"
    case letterY = "y"
    case letterZ = "z"
    case unknown = "?"
  }

  // Letter to morse signal dictionary
  static var code: [String: [Signal]] = [
    "c": [.letterA],
    "d": [.letterB]
  ]

  /// Converts an array of signals into the associated letter if it exists
  static func letter(fromSignals signals: [Signal]) -> String? {
    return code.filter {
      $0.value == signals
      }.map {
        $0.key
      }.first
  }
}
