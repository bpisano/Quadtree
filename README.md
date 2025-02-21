# Quadtree

A modern Quadtree implementation in Swift.

## Installation

Add the following dependency to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/bpisano/quadtree", .upToNextMajor(from: "0.5.1"))
]
```

## Usage

You can initialize a Quadtree with a bounding box and a capacity:

```swift
import Quadtree

let boundingRect = CGRect(x: 0, y: 0, width: 10, height: 10)
let quadtree = Quadtree(boundary: boundingRect, capacity: 4)

// Insert a point
let point = CGPoint(x: 2, y: 2)
await quadtree.insert(point)

// Query the tree
let queryRect = CGRect(x: 0, y: 0, width: 5, height: 5)
let points: [CGPoint] = await quadtree.query(in: queryRect) // [CGPoint(x: 2, y: 2)]
```

## Conception

This Quadtree package is based on 3 fondamental protocols:

- `QuadtreePoint`: A protocol that represent a point in a 2D space.
- `QuadtreeElement`: A protocol that represent an element that can be inserted in the Quadtree.
- `QuadtreeRect`: A protocol that represent a rectangle in a 2D space.

### QuadTreePoint

The `QuadtreePoint` protocol represent a point in a 2D space. It is represented as so:

```swift
public protocol QuadtreePoint: Sendable {
    var coordinateX: Double { get }
    var coordinateY: Double { get }

    init(coordinateX: Double, coordinateY: Double)
}
```

For convenience, the following types conform to the `QuadtreePoint` protocol:

- `CGPoint`
- `CLLocationCoordinate2D`
- `MKMapPoint`

### QuadtreeElement

The `QuadtreeElement` protocol represent an element that can be inserted in the Quadtree.
This protocol is generic over the `QuadtreePoint` type.

```swift
public protocol QuadtreeElement: Hashable {
    associatedtype Point: QuadtreePoint

    var position: Point { get }
}
```

Each element you want to insert in the Quadtree must conform to this protocol.

### QuadtreeRect

The `QuadtreeRect` protocol represent a rectangle in a 2D space. It is represented as so:

```swift
public protocol QuadtreeRect: Sendable {
    associatedtype Point: QuadtreePoint

    var rectOrigin: Point { get }
    var rectWidth: Double { get }
    var rectHeight: Double { get }
    var rectAnchor: QuadtreeAnchor { get }

    init(point: Point, width: Double, height: Double)
    init(x: Double, y: Double, width: Double, height: Double)

    func contains(point: Point) -> Bool
    func intersects(with rect: Self) -> Bool
}
```

For convenience, you only need to implement the following properties:

- `rectOrigin`: The origin of the rectangle.
- `rectWidth`: The width of the rectangle.
- `rectHeight`: The height of the rectangle.

Example:

```swift
struct MyRect: QuadtreeRect {
    // This rect will use CGPoint as its origin type
    var rectOrigin: CGPoint 

    // This rect will use CGFloat as its size type
    var rectWidth: CGFloat 
    var rectHeight: CGFloat
}
```

You can also define a custom anchor for the rectangle. By default, the anchor is `.topLeading`. This can change for other types. For example, the `MKCoordinateRegion` type uses the `.center` anchor.

Here is an example of how the anchor can affect the behavior of a query:

```swift
struct TopLeadingRect: QuadtreeRect {
    var rectOrigin: CGPoint
    var rectWidth: CGFloat
    var rectHeight: CGFloat
    var rectAnchor: QuadtreeAnchor = .topLeading
}

let boundary = TopLeadingRect(point: .zero, width: 10, height: 10)
let point = CGPoint(x: 3, y: 3)
let quadtree = Quadtree(boundary: boundary, capacity: 4)

await quadtree.insert(point)

// [CGPoint(x: 0, y: 0)]
await quadtree.query(in: CGRect(x: 0, y: 0, width: 5, height: 5))
// []
await quadtree.query(in: CGRect(x: 5, y: 5, width: 5, height: 5))
```

```swift
struct CenterRect: QuadtreeRect {
    var rectOrigin: CGPoint
    var rectWidth: CGFloat
    var rectHeight: CGFloat
    var rectAnchor: QuadtreeAnchor = .center
}

let boundary = CenterRect(point: .zero, width: 10, height: 10)
let point = CGPoint(x: 3, y: 3)
let quadtree = Quadtree(boundary: boundary, capacity: 4)

await quadtree.insert(point)

// []
await quadtree.query(in: CGRect(x: 0, y: 0, width: 5, height: 5))

// [CGPoint(x: 0, y: 0)]
await quadtree.query(in: CGRect(x: 5, y: 5, width: 5, height: 5))
```

## Contributing

The `Quadtree` class is probably missing some feature that could be useful. It's the reason why this package has still not reached version `1.0.0`. Feel free to open an issue or a pull request if you'd like to contribute!

## License

This package is licensed under the MIT License.
