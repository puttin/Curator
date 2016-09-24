# Curator

Curator is a lightweight key-value file manager written in Swift.

## Requirements
* iOS 8.0+
* Swift 3

## Usage
```swift
import Curator

data.crt.save(to: "key.data", in: .documents)

let yourData = try! Curator.getData(of: "key.data", in: .documents)
```

more usage can be found in `Tests`

## Installation

### CocoaPods
`not implemnted yet`

### Carthage
`not implemnted yet`

### Manually
use `git submodule` or anyway you like to add Curator as `Embedded Framework` or vendor sources.

## License
Curator is released under the MIT license. See LICENSE for details.
