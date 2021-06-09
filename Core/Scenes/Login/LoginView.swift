//
//  LoginView.swift
//  Core
//
//  Created by Kacper Jagiełło on 08/06/2021.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject
    var viewModel: LoginViewModel
    
    var body: some View {
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
                
                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.white)
                    Button(action: {
                        
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            viewModel: LoginViewModel(
                coordinator: MainAppCoordinator()
            )
        )
    }
}
