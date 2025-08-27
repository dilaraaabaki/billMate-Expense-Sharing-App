import Foundation

// MARK: - Data Models

struct Expense: Codable, Identifiable {
    let id: String
    var title: String
    var amount: Double
    var category: String
    var description: String?
    var groupId: String
    var createdBy: String
    var createdAt: Date
    var updatedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case amount
        case category
        case description
        case groupId = "group_id"
        case createdBy = "created_by"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(title: String, amount: Double, category: String, description: String? = nil, groupId: String, createdBy: String) {
        self.id = UUID().uuidString
        self.title = title
        self.amount = amount
        self.category = category
        self.description = description
        self.groupId = groupId
        self.createdBy = createdBy
        self.createdAt = Date()
        self.updatedAt = nil
    }
}

struct Group: Codable, Identifiable {
    let id: String
    var name: String
    var inviteCode: String
    var createdBy: String
    var createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case inviteCode = "invite_code"
        case createdBy = "created_by"
        case createdAt = "created_at"
    }
    
    init(name: String, createdBy: String) {
        self.id = UUID().uuidString
        self.name = name
        self.inviteCode = String.randomString(length: 8)
        self.createdBy = createdBy
        self.createdAt = Date()
    }
}

struct GroupMember: Codable, Identifiable {
    let id: String
    let userId: String
    let groupId: String
    let joinedAt: Date
    var isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case groupId = "group_id"
        case joinedAt = "joined_at"
        case isActive = "is_active"
    }
    
    init(userId: String, groupId: String, joinedAt: Date = Date()) {
        self.id = UUID().uuidString
        self.userId = userId
        self.groupId = groupId
        self.joinedAt = joinedAt
        self.isActive = true
    }
}

// MARK: - String Extension
extension String {
    static func randomString(length: Int) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

// MARK: - Custom Errors
enum SupabaseServiceError: Error, LocalizedError {
    case noDataReturned
    case invalidUserId
    case networkError(String)
    case userNotFound
    
    var errorDescription: String? {
        switch self {
        case .noDataReturned:
            return "Veritabanından veri döndürülmedi"
        case .invalidUserId:
            return "Geçersiz kullanıcı ID'si"
        case .networkError(let message):
            return "Ağ hatası: \(message)"
        case .userNotFound:
            return "Kullanıcı bulunamadı"
        }
    }
}
