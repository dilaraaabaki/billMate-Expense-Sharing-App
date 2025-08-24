// SplashScreen2.swift

import SwiftUI

struct SplashScreen2: View {
    @Environment(\.dismiss) var dismiss
    @State private var isSplashScreen3Active = false

    var body: some View {
        VStack(spacing: 32) {
            
            Text("Masrafları Adil Bir Şekilde Paylaşın!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
                .padding(.horizontal, 20)
                .padding(.top, 40)
    
            Image("SplashImage2")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 230)
                .padding(.vertical, 16)
            
            Text("Ev arkadaşlarınızla masrafları paylaşın ve herkes ne kadar ödediğini görsün")
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
                Button(action: {
                    dismiss()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .medium))
                        Text("Geri")
                            .font(.body)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.primary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color(.systemGray6))
                    .cornerRadius(22)
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        isSplashScreen3Active = true
                    }
                }) {
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
        .navigationDestination(isPresented: $isSplashScreen3Active) {
            SplashScreen3()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    SplashScreen2()
}
