// SplashScreen2.swift

import SwiftUI

struct SplashScreen2: View {
    @Environment(\.dismiss) var dismiss
    @State private var isSplashScreen3Active = false

    var body: some View {
        VStack(spacing: 20) {
            
            Spacer(minLength: 40)
            
            Text("Masrafları Adil Bir Şekilde Paylaşın !")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal)
    
            Image("SplashImage2")
                .resizable()
                .scaledToFit()
                .frame(width: 329, height: 249)
                .padding(.top, 30)
            
            Text("Ev arkadaşlarınızla masrafları paylaşın ve herkes ne kadar ödediğini görsün")
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Spacer(minLength: 80)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .overlay(alignment: .bottom) {
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Geri")
                    }
                    .padding()
                    .foregroundColor(.secondary)
                }
                
                Spacer()
                
                
                Button(action: {
                    isSplashScreen3Active = true
                }) {
                    HStack {
                        Text("İleri")
                        Image(systemName: "chevron.right")
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
        }
        .navigationDestination(isPresented: $isSplashScreen3Active) {
            SplashScreen3()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SplashScreen2()
}
  
