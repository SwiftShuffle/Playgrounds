//: Illustration of `hashValue` behaviour and how this interacts with a `Set`'s `first` property
//: See [this `Swift: Shuffle All` post](https://sean.systems/swift-shuffle-all/2016/2/3/struct-set-var-first-get-) for details.

"a".hashValue // 4799450059485595655
"b".hashValue // 4799450059485595656
"z".hashValue   // 4799450059485595728
"ab".hashValue  // 4799450059485098232
"zz".hashValue  // 4799450059484804847
"aaa".hashValue // 4799450059707603575

//: Observe how the behaviour changes as a function of the `minimumCapacity`
var set = Set<String>(minimumCapacity: 1023)
set.insert("a") // {"a"}
set.insert("zz") // {"zz", "a"}
set.insert("ab") // {"ab", "zz", "a"}
set.insert("aaa") // {"aaa", "ab", "zz", "a"}
set.insert("z") // {"aaa", "z", "ab", "zz", "a"}
set.insert("b") // {"aaa", "z", "ab", "zz", "b", "a"}


set.first // "aaa"