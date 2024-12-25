//
//  LoginViewModel.swift
//  TVMaze
//
//  Created by Thiago Santiago on 25/12/24.
//

import LocalAuthentication
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var errorMessage: String?
    @Published var showPinScreen = false
    @Published var isTouchIdavailable: Bool = false
    @Published var isFaceIdavailable: Bool = false
    @Published var pinAlreadyCreated: Bool = false

    private let context = LAContext()
    private let defaults = UserDefaults.standard

    init(isAuthenticated: Bool = false, errorMessage: String? = nil, showPinScreen: Bool = false) {
        self.isAuthenticated = isAuthenticated
        self.errorMessage = errorMessage
        self.showPinScreen = showPinScreen
        self.pinAlreadyCreated = defaults.string(forKey: "userId") != nil

        isFaceIdavailable = context.biometryType == .faceID
        isTouchIdavailable = context.biometryType == .touchID
    }

    func authenticateWithBiometrics() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate using your biometrics"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                    } else {
                        self.errorMessage = authenticationError?.localizedDescription ?? "Authentication failed"
                    }
                }
            }
        } else if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Authenticate using your device passcode"

            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isAuthenticated = true
                    } else {
                        self.errorMessage = authenticationError?.localizedDescription ?? "Authentication failed"
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                self.errorMessage = "Biometric authentication is not available"
            }
        }
    }

    func authenticateWithPin(_ pin: String, confirmationPin: String) {
        if let id = defaults.string(forKey: "userId"), pin == id {
            isAuthenticated = true
            showPinScreen = false
        } else if !pinAlreadyCreated, pin == confirmationPin {
            defaults.set(pin, forKey: "userId")
            isAuthenticated = true
            showPinScreen = false
        } else {
            errorMessage = pinAlreadyCreated ? "Incorrect PIN" : "PIN does not match"
        }
    }
}
