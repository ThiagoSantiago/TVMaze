//
//  PinAuthenticationView.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import SwiftUI

struct PinAuthenticationView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    @State private var enteredPin: String = ""
    @State private var confirmPin: String = ""

    var body: some View {
        VStack {
            Text(viewModel.pinAlreadyCreated ? "Enter your PIN" : "Create your PIN")
                .font(.headline)

            SecureField("PIN", text: $enteredPin)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if !viewModel.pinAlreadyCreated {
                SecureField("Confirm PIN", text: $confirmPin)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }

            Button(action: {
                viewModel.authenticateWithPin(enteredPin, confirmationPin: confirmPin)
            }) {
                Text("Login")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    PinAuthenticationView()
}
