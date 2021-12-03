import SwiftUI

public typealias Menu<V> = Group<V> where V:View
public typealias Main<V> = Group<V> where V:View

public struct NSideMenu {
    public private(set) var text = "Hello, World!"

    public init() {
    }
}
