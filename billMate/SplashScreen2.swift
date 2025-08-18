//
//  SplashScreen2.swift
//  billMate
//
//  Created by Dilara Baki on 19.08.2025.
//

import SwiftUI

struct SplashScreen2: View {
    var body: some View {
        VStack(spacing: 20) {
            
                    Text("Masrafları Adil Bir Şekilde Paylaşın !")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)
                        .padding(.horizontal)
            
                    Text("Ev arkadaşlarınızla masrafları paylaşın ve herkes ne kadar ödediğini görsün")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                    
                    Image("SplashImage2")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                        .padding(.top, 30)
                    
                    Button(action: {
                    }) {
                        Text("Başla")
                            .font(.headline)
                            .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 1.0, green: 0.9568627450980393, blue: 0.8)/*@END_MENU_TOKEN@*/)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .padding(.top, 40)
                    .padding(.horizontal)
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground))
            }
    }


#Preview {
    SplashScreen2()
}
