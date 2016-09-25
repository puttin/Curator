# Curator
[![Build Status](https://travis-ci.org/puttin/Curator.svg?branch=master)](https://travis-ci.org/puttin/Curator)
[![Codecov](https://codecov.io/gh/puttin/Curator/branch/master/graph/badge.svg)](https://codecov.io/gh/puttin/Curator)

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
`pod 'Curator', :git => 'https://github.com/puttin/Curator.git'`

### Carthage
`github "puttin/Curator"`

### Manually
use `git submodule` or anyway you like to add Curator as `Embedded Framework` or vendor sources.

## License
Curator is released under the MIT license. See LICENSE for details.
