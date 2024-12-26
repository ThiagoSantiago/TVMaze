//
//  LoginView.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if viewModel.isAuthenticated {
                    SeriesListView(viewModel: .init())
                } else {
                    Text("TVMAze App")
                        .font(.title)
                        .padding(.top, 32)

                    Spacer()

                    Image("logo")
                        .frame(width: 150, height: 150)

                    Spacer()
                    Text("Please log in using biometrics or PIN")
                        .multilineTextAlignment(.center)
                        .padding()

                    if viewModel.isFaceIdavailable || viewModel.isTouchIdavailable {
                        Button(action: {
                            viewModel.authenticateWithBiometrics()
                        }) {
                            HStack {
                                Image(systemName: viewModel.isTouchIdavailable
                                              ? "touchid"
                                              : "faceid")
                                Text("Login with Biometrics")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                    }

                    Button(action: {
                        viewModel.showPinScreen = true
                    }) {
                        Text(viewModel.pinAlreadyCreated 
                             ? "Use PIN Code"
                             : "Create PIN Code")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding()
                    }

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    Spacer()
                }
            }
            .padding()
            .sheet(isPresented: $viewModel.showPinScreen) {
                PinAuthenticationView()
                    .environmentObject(viewModel)
            }
        }
        .background(Color.background)
    }
}

#if DEBUG
#Preview {
    LoginView()
}
#endif
