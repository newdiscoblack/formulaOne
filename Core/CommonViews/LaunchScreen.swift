//
//  LaunchScreen.swift
//  Core
//
//  Created by Kacper Jagiełło on 04/06/2021.
//

import SwiftUI

public struct LaunchScreen: View {
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    
    @State
    var shouldAnimate: Bool = false
    
    @State
    var shouldDisappear: Bool = false
    
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
                .scaleEffect(shouldAnimate ? 4 : 1)
                .frame(width: UIScreen.main.bounds.width)
        }
        .ignoresSafeArea(.all, edges: .all)
        .onAppear { transitionAnimation() }
        .opacity(shouldDisappear ? 0 : 1)
        .onDisappear {
            print("LaunchScreen disappeared")
        }
    }
    
    private func transitionAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(Animation.easeOut(duration: 0.4)) {
                shouldAnimate.toggle()
            }
            withAnimation(Animation.easeOut(duration: 0.3)) {
                shouldDisappear.toggle()
                removeFromStack()
            }
        }
    }
    
    private func removeFromStack() {
        self.presentationMode.wrappedValue.dismiss()
    }
}
