    import Foundation
    import Supabase

    class SupabaseManager: ObservableObject {
        static let shared = SupabaseManager()
        
        private let supabase: SupabaseClient
        
        // Replace with your actual Supabase credentials
        private let supabaseURL = "https://hxdawsweedvqxufuhzco.supabase.co"
        private let supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh4ZGF3c3dlZWR2cXh1ZnVoemNvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYxMzEyNTksImV4cCI6MjA3MTcwNzI1OX0.SrMzVQNn6QsHvW9h7zCJV7eFOQKCu2VTdbZzW_BK9LE"
        
        private init() {
            supabase = SupabaseClient(
                supabaseURL: URL(string: supabaseURL)!,
                supabaseKey: supabaseKey
            )
        }
        
        func fetchExpenses() async throws -> [ExpenseModel] {
               let response: [ExpenseModel] = try await supabase
                   .from("expenses")
                   .select()
                   .execute()
                   .value
               return response
           }
           
           func addExpense(_ expense: ExpenseModel) async throws {
               try await supabase
                   .from("expenses")
                   .insert(expense)
                   .execute()
           }
           
           func updateExpense(_ expense: ExpenseModel) async throws {
               guard let id = expense.id else { return }
               
               try await supabase
                   .from("expenses")
                   .update(expense)
                   .eq("id", value: id)
                   .execute()
           }
           
           func deleteExpense(id: Int) async throws {
               try await supabase
                   .from("expenses")
                   .delete()
                   .eq("id", value: id)
                   .execute()
           }
       }
