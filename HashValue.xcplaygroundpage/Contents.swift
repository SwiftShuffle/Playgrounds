//: Illustration of `hashValue` behaviour and how this interacts with a `Set`'s `first` property
//: See [this `Swift: Shuffle All` post](https://sen-labastille-fql1.squarespace.com/swift-shuffle-all/2016/2/3/struct-set-var-first-get-) for details.

"a".hashValue
"b".hashValue
"z".hashValue
"ab".hashValue
"zz".hashValue
"aaa".hashValue

//: Observe how the behaviour changes as a function of the `minimumCapacity`
var set = Set<String>(minimumCapacity: 1023)
set.insert("a")
set.insert("zz")
set.insert("ab")
set.insert("aaa")
set.insert("z")
set.insert("b")


set.first