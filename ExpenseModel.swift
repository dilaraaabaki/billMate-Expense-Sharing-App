import Foundation

// Single, clean Expense model - no conflicts
struct ExpenseModel: Codable, Identifiable {
    let id: Int?
    let title: String
    let amount: Double
    let category: String
    let date: Date
    let userId: String?
    
    // Map to database columns
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case amount
        case category
        case date
        case userId = "user_id"
    }
    
    // For creating new expenses
    init(title: String, amount: Double, category: String) {
        self.id = nil
        self.title = title
        self.amount = amount
        self.category = category
        self.date = Date()
        self.userId = nil
    }
}
