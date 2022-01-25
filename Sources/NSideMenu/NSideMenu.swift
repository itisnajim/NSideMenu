import SwiftUI

public typealias Menu<V> = Group<V> where V:View
public typealias Main<V> = Group<V> where V:View

public struct NSideMenu {
    public private(set) var text = "Hello, World!"

    public init() {
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder func disregardSafeArea() -> some View {
        if #available(iOS 14, *) {
            self.ignoresSafeArea()
        } else {
            self.edgesIgnoringSafeArea(.all)
        }
    }
}
