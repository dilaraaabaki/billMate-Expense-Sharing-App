//
//  SplashScreen2.swift
//  billMate
//
//  Created by Dilara Baki on 19.08.2025.
//

import SwiftUI

struct SplashScreen1: View {
    @State private var isActive = false
    
    var body: some View {
        VStack(spacing: 20) {
            // Buton
            Button(action: {
                withAnimation {
                    isActive = true
                }
            }) {
                HStack(alignment: .top, spacing: 0.0) {
                    Text("İleri")
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.black)
                .padding(.top)
                }
            Text("Masrafları Kolayca Yönet!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal)
            
            Image("SplashImage1")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding(.top, 30)
            
            Text("Fatura, kira ve ortak masraflarınızı birkaç tıklamayla ekleyin")
                .font(.title3)
                .foregroundColor(.secondary)
                .padding(.vertical)
            }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    SplashScreen1()
}
