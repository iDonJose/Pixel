/*:
 ## `UIColor`
 */

import Pixel


let color = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)

/*:
 ### `with(alpha:)`
 */

let transparent = color.with(alpha: 0.5)

/*:
 ### `init(rgba:)`
 > See also `init(rgb:)`
 */

let colorFromRGBstring = UIColor(rgb: "#77C344")

/*:
 ### `rgba`
 Gets red, blue, green & alpha component
 > See also `red`, `green`, `blue`, `alpha`
 */

let rgba = color.rgba

/*:
 ### `rgbaHex`
 > See also `rgbHex`
 */

let rgbaHex = color.rgbHex

/*:
 ### `init(hue:saturation:lightness:alpha)`
 */

let colorFromHSLA = UIColor(hue: 95.91, saturation: 0.51, lightness: 0.51, alpha: 1)

/*:
 ### `hsla`
 Gets hue, saturation, lightness & alpha component
 > See also `hue`, `saturation`, `lightness`, `alpha`
 */

let hsla = color.hsla


//: < [Summary](Summary) | [Next](@next) >
