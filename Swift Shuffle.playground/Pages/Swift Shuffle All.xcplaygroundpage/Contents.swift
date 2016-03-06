//: [Previous](@previous)

/*:
# Playground page for fetching all SwiftDoc pages and choosing one at random.
 */

import Freddy
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let SwiftDocURLs = NSURL(string: "http://api.swiftdoc.org/urls")!

let task = NSURLSession.sharedSession().dataTaskWithURL(SwiftDocURLs) { (data, response, error) in
    guard let data = data else {
        dump(error)
        return
    }
    do {
/*:
This expects the data returned to be a dictionary of `["name":"URL"]` values
- note: The first component of the URLs path can be used to categorise the names.
*/
        let json = try JSON(data: data)
        if case let .Dictionary(dictionary) = json {
            var categories = [String: [String]]()
            for (name, url) in dictionary {
                if case let .String(urlString) = url,
                    let urlValue = NSURL(string: urlString),
                    let category = urlValue.path?.componentsSeparatedByString("/")[1] {
                    if categories[category] == nil {
                        categories[category] = [String]()
                    }
                    categories[category]?.append(name)
                }
            }

/*:
 Now some spare categories are removed and then a random category and name within that category care chosen.
- important: Operators are removed as these are of limited interest in isolation.
*/
            ["404", "operator"].forEach { categories.removeValueForKey($0) }
            
            let keyIndexInt = arc4random_uniform(UInt32(categories.keys.count))
            let keyIndex = categories.keys.startIndex.advancedBy(Int(keyIndexInt))
            let chosenCategory = categories[keyIndex]
            let valuesIndexInt = arc4random_uniform(UInt32((chosenCategory.1).count))
            let valueIndex = (chosenCategory.1).startIndex.advancedBy(Int(valuesIndexInt))
            "Category: \(chosenCategory.0) Value: \(chosenCategory.1[valueIndex])"
        }
    } catch {
        dump(error)
    }
}

task.resume()



//: [Next](@next)
