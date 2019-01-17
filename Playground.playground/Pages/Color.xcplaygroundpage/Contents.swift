/*:
 ## `Color`
 A color representation that is Codable when UIColor is not
 */

import Pixel


let color = Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1))

let encoder = JSONEncoder()
let data = try! encoder.encode(["myColor": color])

let decoder = JSONDecoder()
let json = try! decoder.decode([String: Color].self, from: data)

let decodedColor = json.first!.value


//: < [Summary](Summary) | [Next](@next) >
