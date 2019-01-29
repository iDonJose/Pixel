/*:
 ## `UIEdgeInsets`
 */

import Pixel


/*:
 ### `init(edges:value:)`
 */

let insets = UIEdgeInsets(edges: [.top, .left, .right], value: 2)

/*:
 ### `horizontal`
 > See also `vertical`
 */

let horizontal = insets.horizontal

/*:
 ### `filter(edges:)`
 Creates new insets only keeping values in filter
 > See also `filter(direction:)`
 */

let filteredInsets = insets.filter(edges: [.top, .bottom])


//: < [Summary](Summary) | [Next](@next) >
