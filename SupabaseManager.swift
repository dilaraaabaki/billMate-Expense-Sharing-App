import Supabase
import Foundation

class SupabaseManager: ObservableObject {
    static let shared = SupabaseManager()
    
    let client: SupabaseClient
    
    private init() {
        let supabaseURL = URL(string: "https://ghrffsheregoodderrec.supabase.co")!
        let supabaseKey = "SUPABASE_CLIENT_API_KEY" // Info.plist'ten alınacak
        
        self.client = SupabaseClient(
            supabaseURL: supabaseURL,
            supabaseKey: supabaseKey
        )
    }
    
    // Real-time subscription için
    func setupRealtimeListener() {
        let channel = client.realtime.channel("db-changes")
        
        channel.on(.all) { message in
            print("Real-time update: \(message)")
            // Burada gelen verileri işle
        }
        
        Task {
            try await channel.subscribe()
        }
    }
}
