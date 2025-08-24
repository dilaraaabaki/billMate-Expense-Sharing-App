import Foundation

struct Expense: Codable, Identifiable {
    let id: String
    let amount: Double
    let description: String
    let paidBy: String
    let groupId: String
    let createdAt: Date
    let category: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case amount
        case description
        case paidBy = "paid_by"
        case groupId = "group_id"
        case createdAt = "created_at"
        case category
    }
}

struct Group: Codable, Identifiable {
    let id: String
    let name: String
    let inviteCode: String
    let createdBy: String
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case inviteCode = "invite_code"
        case createdBy = "created_by"
        case createdAt = "created_at"
    }
}

struct GroupMember: Codable, Identifiable {
    let id: String
    let userId: String
    let groupId: String
    let joinedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case groupId = "group_id"
        case joinedAt = "joined_at"
    }
}

struct UserProfile: Codable {
    let id: String
    let email: String
    let fullName: String?
    let avatarUrl: String?
    let createdAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case fullName = "full_name"
        case avatarUrl = "avatar_url"
        case createdAt = "created_at"
    }
}
