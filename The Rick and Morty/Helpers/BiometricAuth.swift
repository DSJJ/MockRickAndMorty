//
//  BiometricAuth.swift
//  The Rick and Morty
//
//  Created by David Jiménez  on 08/07/25.
//

import LocalAuthentication

class BiometricAuth {
  static func authenticate(reason: String = "Autenticarse para ver favoritos") async -> Bool {
    let context = LAContext()
    var error: NSError?

    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let success = await withCheckedContinuation { continuation in
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { result, _ in
          continuation.resume(returning: result)
        }
      }
      return success
    } else {
      return false
    }
  }
}
