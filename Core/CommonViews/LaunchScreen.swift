//
//  LaunchScreen.swift
//  Core
//
//  Created by Kacper Jagiełło on 04/06/2021.
//

import SwiftUI

public struct LaunchScreen: View {
    @State
    var shouldAnimate: Bool = false
    
    @State
    var shouldDissappear: Bool = false
    
    public init() { }
    
    public var body: some View {
        ZStack {
            Color("launchScreenBackground")
            Image("launchScreenLogo")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(
                    contentMode: shouldAnimate ? .fill : .fit
                )
                .frame(
                    width: shouldAnimate ? nil : 120,
                    height: shouldAnimate ? nil : 30
                )
                .scaleEffect(shouldAnimate ? 5 : 1)
                .frame(width: UIScreen.main.bounds.width)
        }
        .ignoresSafeArea(.all, edges: .all)
        .onAppear { transitionAnimation() }
        .opacity(shouldDissappear ? 0 : 1)
    }
    
    private func transitionAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(Animation.easeOut(duration: 0.6)) {
                shouldAnimate.toggle()
            }
            withAnimation(Animation.easeOut(duration: 0.4)) {
                shouldDissappear.toggle()
            }
        }
    }
}
