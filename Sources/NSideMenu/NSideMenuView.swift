//
//  NSideMenuView.swift
//  
//
//  Created by Najim on 12/1/21.
//

import SwiftUI

public struct NSideMenuView<V1, V2>: View where V1: View, V2: View {
    
    private let content: () -> TupleView<(Menu<V1>, Main<V2>)>
    
    @ObservedObject var options: NSideMenuOptions
    
    public init(
    @ViewBuilder _ content: @escaping () -> TupleView<(Menu<V1>, Main<V2>)>
    ) {
        self.init(options: NSideMenuOptions(), content)
    }
    
    public init(options: NSideMenuOptions,
    @ViewBuilder _ content: @escaping () -> TupleView<(Menu<V1>, Main<V2>)>
    ) {
        self.options = options
        self.content = content
    }
    
    public var isRTL: Bool{
        if let langCode = Bundle.main.preferredLocalizations.first{
            let direction = Locale.characterDirection(forLanguage: langCode)
            return direction == .leftToRight ? false : true
        }
        return false
    }
    
    private func getMainScale() -> CGFloat{
        return (options.style == .scale || options.style == .rotate) ? (options.show ? 0.82 : 1) : 1
    }
    
    private func getShowMenuOffset() -> CGFloat{
        return options.side == .leading && !isRTL ? options.width : -options.width;
    }
    
    private func getSkeletonOffset() -> CGFloat{
        return options.side == .leading && !isRTL ? -24 : 24;
    }
    
    // TODO
    /*
    @GestureState private var dragOffset = CGSize.zero
    enum PanDirection{
        case left
        case right
        case none
    }
    private var currentPanDirection:PanDirection = .none
    */
    
    public var body: some View {
        let (menu, main) = self.content().value
        return ZStack{
            menu
                .frame(maxWidth: options.style == .slideAbove ? options.width : .infinity)
                .offset(x: (options.style == .slideAbove || options.style == .slideAside) && !options.show ? -1*getShowMenuOffset() : 0)
            
                .frame(maxWidth: .infinity, alignment: options.side.getAlignment())
                .zIndex(options.menuZIndex)
                .onAnimationCompleted(for: options.animatableShow) {
                    //print("onAnimationCompleted "+options.animatableShow.description)
                    if(!options.show){
                        options.menuZIndex = 0
                        options.onDidClose()
                    }else{
                        options.onDidOpen()
                    }
                }
            
            ZStack{
                if(options.showSkeletonStack && options.show){
                    options.skeletonStackColor
                        .opacity(0.5)
                        .cornerRadius(options.show && (options.style == .scale || options.style == .rotate) ? (options.cornerRaduisIfNeeded/2) : 0)
                        .shadow(color: .black.opacity(0.07), radius: 8, x: -5, y: 0)
                        .offset(x: options.show ? getSkeletonOffset() : 0)
                        .padding(.vertical, 32)
                    options.skeletonStackColor
                        .opacity(0.36)
                        .cornerRadius(options.show && (options.style == .scale || options.style == .rotate) ? (options.cornerRaduisIfNeeded/3) : 0)
                        .shadow(color: .black.opacity(0.07), radius: 8, x: -5, y: 0)
                        .offset(x: options.show ? getSkeletonOffset()*2 : 0)
                        .padding(.vertical, 64)
                }
                main
                    .if((options.show && (options.style == .scale || options.style == .rotate)), transform: { view in
                        view.cornerRadius(options.cornerRaduisIfNeeded)
                    })
            }
            .scaleEffect(
                getMainScale()
            )
            .offset(x: options.show && options.style != NSideMenuStyle.slideAbove ? getShowMenuOffset() : 0)
            .rotationEffect(.init(degrees: options.show && options.style == .rotate ? (options.side == .leading && !isRTL ? -1 : 1)*options.rotationDegreeIfNeeded : 0))
            .zIndex((options.menuZIndex == 1) ? 0 : 1)
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity)
    }
}

struct NSideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        NSideMenuView{
            Menu{
                Text("Menu")
            }
            Main{
                Text("Main")
            }
        }
    }
}
