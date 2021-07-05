//
//  LoginView.swift
//  Core
//
//  Created by Kacper Jagiełło on 08/06/2021.
//

import SwiftUI

public enum LoginRoute {
    case signIn
}

struct LoginView: View {
    @StateObject
    var viewModel: LoginViewModel
    
    init(
        viewModel: LoginViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("launchScreenBackground")
                
                Image("regularLogo")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(
                        contentMode: .fit
                    )
                    .frame(
                        width: 120,
                        height: 30
                    )
                    .offset(
                        x: 0,
                        y: viewModel.state == .login ? -200 : 0
                    )
                    .animation(.spring())
                
                LoginTextFields(
                    viewModel: viewModel
                )
                
                VStack {
                    Spacer()
                    Button(action: {
                        viewModel.state = .login
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity, maxHeight: 30)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10.0)
                            .foregroundColor(.black)
                            .padding()
                    }
                    .isHidden(viewModel.state == .login)
                    
                    HStack {
                        Text("Don't have an account?")
                            .foregroundColor(.white)
                        Button(action: {
                            viewModel.signIn()
                        }) {
                            Text("Sign in")
                                .foregroundColor(.white)
                                .bold()
                        }
                    }
                }
                .padding(.bottom, 60)
            }
            .ignoresSafeArea(.all, edges: .all)
            .handleNavigation(viewModel.navigationPublisher)
        }
    }
}

struct LoginTextFields: View {
    @ObservedObject
    var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            TextField(
                "Username",
                text: $viewModel.username
            )
            .autocapitalization(.none)
            .padding()
            .background(Color.white)
            .cornerRadius(10.0)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .padding()
            SecureField(
                "Password",
                text: $viewModel.password
            )
            .autocapitalization(.none)
            .padding()
            .background(Color.white)
            .cornerRadius(10.0)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .padding(.horizontal)
            
            HStack {
                Spacer()
                Button(action: {
                    viewModel.logIn()
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.red)
                        Image(systemName: "arrow.forward")
                            .foregroundColor(.black)
                    }
                }
            }
            .padding()
        }
        .opacity(viewModel.state == .login ? 1 : 0)
    }
}

#if DEBUG
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            viewModel: LoginViewModel(
                coordinator: RootViewCoordinator.shared
            )
        )
    }
}
#endif
