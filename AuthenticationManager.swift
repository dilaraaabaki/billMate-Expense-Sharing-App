//
//  AuthenticationManager.swift
//  billMate
//
//  Created by Dilara Baki on 24.08.2025.
//

import Foundation
import SwiftUI
import AuthenticationServices
import Combine

@MainActor
class AuthenticationManager: ObservableObject {
    
    // MARK: - Published Properties
    @Published var isLoggedIn = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var isLoading = false
    
    // MARK: - Private Properties
    private let appleSignInService = AppleSignInService()
    private let supabaseService = SupabaseService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    // MARK: - Setup
    private func setupBindings() {
        // Apple Sign-In Service bindings
        appleSignInService.$showAlert
            .assign(to: &$showAlert)
        
        appleSignInService.$alertMessage
            .assign(to: &$alertMessage)
        
        appleSignInService.$isLoading
            .assign(to: &$isLoading)
        
        // Supabase Service bindings
        supabaseService.$isLoggedIn
            .assign(to: &$isLoggedIn)
        
        supabaseService.$showAlert
            .sink { [weak self] showAlert in
                if showAlert {
                    self?.showAlert = true
                }
            }
            .store(in: &cancellables)
        
        supabaseService.$alertMessage
            .sink { [weak self] message in
                if !message.isEmpty {
                    self?.alertMessage = message
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Public Methods
    func handleSignInRequest(_ request: ASAuthorizationAppleIDRequest) {
        appleSignInService.configureRequest(request)
    }
    
    func handleSignInCompletion(_ result: Result<ASAuthorization, Error>) {
        appleSignInService.handleCompletion(result) { [weak self] appleSignInData in
            // Forward to Supabase authentication
            self?.supabaseService.authenticateWithApple(data: appleSignInData)
        }
    }
    
    // ADDED: Public method to check authentication status
    func checkAuthenticationStatus() async {
        await supabaseService.checkAuthenticationStatus()
    }
    
    func logout() {
        Task {
            await supabaseService.logout()
            isLoggedIn = false
        }
    }
    
    func dismissAlert() {
        showAlert = false
        alertMessage = ""
    }
}
