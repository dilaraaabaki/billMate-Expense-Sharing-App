//
//  SplashScreen1.swift
//  billMate
//
//  Created by Dilara Baki on 19.08.2025.
//

import SwiftUI

struct SplashScreen1: View {

    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                
                Text("Masraflarınızı Kolayca Yönetin")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
        
                Image("SplashImage1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 230)
                    .padding(.vertical, 16)
                
                Text("Fatura, kira ve ortak masraflarınızı birkaç tıklamayla ekleyin")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 24)
                
                Spacer(minLength: 60)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemBackground))
            .overlay(alignment: .bottom) {
                HStack(spacing: 16) {

                    Spacer()
                    
                    NavigationLink(destination: SplashScreen2()) {
                        HStack(spacing: 6) {
                            Text("İleri")
                                .font(.body)
                                .fontWeight(.semibold)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.orange)
                        .cornerRadius(22)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 44)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    SplashScreen1()
}
