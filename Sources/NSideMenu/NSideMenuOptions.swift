//
//  NSideMenuOptions.swift
//
//
//  Created by Najim on 12/1/21.
//

import SwiftUI

public enum NSideMenuSide: String{
    case leading = "leading"
    case trailing = "trailing"
    
    public func getHorizontalAlignment()-> HorizontalAlignment{
        return self == .leading ? HorizontalAlignment.leading : HorizontalAlignment.trailing
    }
    
    public func getAlignment()-> Alignment{
        return self == .leading ? Alignment.leading : Alignment.trailing
    }
    
    public func getToolbarItemPlacement() -> ToolbarItemPlacement{
        return self == .leading ? ToolbarItemPlacement.navigationBarLeading : ToolbarItemPlacement.navigationBarTrailing
    }
}

public enum NSideMenuStyle{
    case normal
    case scale
    case slideAbove
    case slideAside
    case rotate
}


public class NSideMenuOptions: ObservableObject{
    var animatableShow: Double = 0
    @Published var menuZIndex: Double = 0

    @Published public var show: Bool = false{
        willSet{
            if(newValue){
                onWillOpen()
            }else{
                onWillClose()
            }
            animatableShow = newValue ? 1 : 0
        }
        didSet{
            if(style == .slideAbove && show){
                menuZIndex = 1
            }
        }
    }
    
    @Published public var side: NSideMenuSide;
    
    @Published public var width: CGFloat;
    
    @Published public var style: NSideMenuStyle{
        didSet{
            if(style == .slideAbove && show){
                menuZIndex = 1
            }else if(style != .slideAbove){
                menuZIndex = 0
            }
            //print("menuZIndex "+menuZIndex.description)
        }
    }
    
    @Published public var showSkeletonStack: Bool;
    
    @Published public var skeletonStackColor: Color;
    
    @Published public var cornerRaduisIfNeeded: CGFloat;
    
    @Published public var rotaionDegree: Double;
    
    //TODO
    public var onWillClose: () -> () = { }
    public var onWillOpen: () -> () = { }
    public var onDidClose: () -> () = { }
    public var onDidOpen: () -> () = { }
    
    //TODO
    @Published public var enabled: Bool;
    
    public init(
        style: NSideMenuStyle = .normal,
        side: NSideMenuSide = .leading,
        width: CGFloat = 186,
        showSkeletonStack: Bool = false,
        skeletonStackColor: Color = Color(UIColor.systemBackground),
        cornerRaduisIfNeeded: CGFloat = 16,
        rotaionDegree: Double = 6,
        show: Bool = false,
        enabled: Bool = true,
        onWillClose: @escaping () -> () = { },
        onWillOpen: @escaping () -> () = { },
        onDidClose: @escaping () -> () = { },
        onDidOpen: @escaping () -> () = { }
    ) {
        self.show = show
        self.side = side
        self.width = width
        self.style = style
        self.showSkeletonStack = showSkeletonStack
        self.skeletonStackColor = skeletonStackColor
        self.cornerRaduisIfNeeded = cornerRaduisIfNeeded
        self.rotaionDegree = rotaionDegree
        self.enabled = enabled
        self.onWillClose = onWillClose
        self.onWillOpen = onWillOpen
        self.onDidClose = onDidClose
        self.onDidOpen = onDidOpen
    }
    
    public func toggleMenu(animation: Animation? = .default){
        withAnimation(animation) {
            self.show.toggle()
        }
    }
    
    public func showMenu(animation: Animation? = .default){
        withAnimation(animation) {
            self.show = true
        }
    }
    
    public func hideMenu(animation: Animation? = .default){
        withAnimation(animation) {
            self.show = false
        }
    }
}
