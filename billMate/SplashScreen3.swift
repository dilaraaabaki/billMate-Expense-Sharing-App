//
//  SplashScreen2.swift
//  billMate
//
//  Created by Dilara Baki on 19.08.2025.
//

import SwiftUI

struct SplashScreen3: View {
    var body: some View {
        VStack(spacing: 20) {
            
                    Text("Ev Grubunu Kontrol Altına Al !")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)
                        .padding(.horizontal)
            
                    Text("Fatura, kira ve ortak masraflarınızı birkaç tıklamayla ekleyin")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    Image("SplashImage3")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                        .padding(.top, 30)
                    
                    Button(action: {
                    }) {
                        Text("Grup Oluştur")
                            .font(.headline)
                            .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 1.0, green: 0.9568627450980393, blue: 0.8)/*@END_MENU_TOKEN@*/)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    Button(action: {
                    }) {
                    Text("Gruba Katıl")
                    .font(.headline)
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 1.0, green: 0.9568627450980393, blue: 0.8)/*@END_MENU_TOKEN@*/)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
            }
                    .padding(.horizontal)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground))
            }
    }


#Preview {
    SplashScreen3()
}
