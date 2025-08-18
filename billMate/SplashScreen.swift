import SwiftUI

struct AnimatedBackgroundView: View {
    @State private var move = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.orange, .yellow, .yellow]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(width: 300)
                .offset(x: move ? 100 : -100, y: move ? 100 : -100)
                .animation(Animation.easeInOut(duration: 8).repeatForever(autoreverses: true), value: move)
            
            Circle()
                .fill(Color.white.opacity(0.05))
                .frame(width: 200)
                .offset(x: move ? -150 : 150, y: move ? -150 : 150)
                .animation(Animation.easeInOut(duration: 10).repeatForever(autoreverses: true), value: move)
    
            VStack {
                Image("SplashImage")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                    .padding(.top, 30)
            }
        }
        .onAppear {
            move.toggle()
        }
    }
}

// Önizleme için ayrı bir struct
struct AnimatedBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedBackgroundView()
    }
}
