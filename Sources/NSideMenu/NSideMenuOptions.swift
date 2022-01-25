//
//  NSideMenuOptions.swift
//
//
//  Created by Najim on 12/1/21.
//

import SwiftUI

/// An alignment in both axes.
public enum NSideMenuSide: String{
    case leading = "leading"
    case trailing = "trailing"
    
    public func getHorizontalAlignment()-> HorizontalAlignment{
        return self == .leading ? HorizontalAlignment.leading : HorizontalAlignment.trailing
    }
    
    public func getAlignment()-> Alignment{
        return self == .leading ? Alignment.leading : Alignment.trailing
    }
    
    @available(iOS 14, *)
    public func getToolbarItemPlacement() -> ToolbarItemPlacement{
        return self == .leading ? ToolbarItemPlacement.navigationBarLeading : ToolbarItemPlacement.navigationBarTrailing
    }
}

/// The current side menu presentation style.
public enum NSideMenuStyle{
    case normal
    case scale
    case slideAbove
    case slideAside
    case rotate
}

/// NSideMenuView required configurations and options.
public class NSideMenuOptions: ObservableObject{
    var animatableShow: Double = 0
    @Published var menuZIndex: Double = 0

    /// Menu view visiblity.
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
    
    /// Menu side.
    @Published public var side: NSideMenuSide;
    
    /// Menu content container width.
    @Published public var width: CGFloat;
    
    /// Presentation Style.
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
    
    /// Main view content Skeleton Stack visiblity.
    @Published public var showSkeletonStack: Bool;
    
    /// Main view content Skeleton Stack color.
    @Published public var skeletonStackColor: Color;
    
    /// When style is scale or rotate and the Menu is visible this property will be applied on the Main view container corners.
    @Published public var cornerRaduisIfNeeded: CGFloat;
    
    /// When style is rotate and Menu is visible this property will be applied on the Main view container rotation degree.
    @Published public var rotationDegreeIfNeeded: Double;
    
    /// Fired when 'show' property asigned to false or when calling toggleMenu Method.
    public var onWillClose: () -> () = { }
    
    /// Fired when 'show' property asigned to true or when calling toggleMenu Method.
    public var onWillOpen: () -> () = { }
    
    /// Fired when the side menu close animation did finish.
    public var onDidClose: () -> () = { }
    
    /// Fired when the side menu open animation did finish.
    public var onDidOpen: () -> () = { }
    
    //TODO
    //@Published public var enabled: Bool;
    
    public init(
        style: NSideMenuStyle = .normal,
        side: NSideMenuSide = .leading,
        width: CGFloat = 186,
        showSkeletonStack: Bool = false,
        skeletonStackColor: Color = Color(UIColor.systemBackground),
        cornerRaduisIfNeeded: CGFloat = 16,
        rotationDegreeIfNeeded: Double = 6,
        show: Bool = false,
        //enabled: Bool = true,
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
        self.rotationDegreeIfNeeded = rotationDegreeIfNeeded
        //self.enabled = enabled
        self.onWillClose = onWillClose
        self.onWillOpen = onWillOpen
        self.onDidClose = onDidClose
        self.onDidOpen = onDidOpen
    }
    
    /// This method to toggle the side menu visiblity from open to close or from close to open.
    public func toggleMenu(animation: Animation? = .default){
        withAnimation(animation) {
            self.show.toggle()
        }
    }
    
    /// This method to open the side menu
    public func showMenu(animation: Animation? = .default){
        withAnimation(animation) {
            self.show = true
        }
    }
    
    /// This method to close the side menu
    public func hideMenu(animation: Animation? = .default){
        withAnimation(animation) {
            self.show = false
        }
    }
}
