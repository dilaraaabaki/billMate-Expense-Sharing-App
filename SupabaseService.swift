import Supabase
import Foundation

class SupabaseService {
    static let shared = SupabaseService()
    private let client = SupabaseManager.shared.client
    
    // MARK: - Expense Operations
    func addExpense(_ expense: Expense) async throws {
        try await client
            .from("expenses")
            .insert(expense)
            .execute()
    }
    
    func getExpenses(forGroup groupId: String) async throws -> [Expense] {
        let response: [Expense] = try await client
            .from("expenses")
            .select()
            .eq("group_id", value: groupId)
            .execute()
            .value
        
        return response
    }
    
    func updateExpense(_ expense: Expense) async throws {
        try await client
            .from("expenses")
            .update(expense)
            .eq("id", value: expense.id)
            .execute()
    }
    
    func deleteExpense(id: String) async throws {
        try await client
            .from("expenses")
            .delete()
            .eq("id", value: id)
            .execute()
    }
    
    // MARK: - Group Operations
    func createGroup(_ group: Group) async throws -> Group {
        let response: [Group] = try await client
            .from("groups")
            .insert(group)
            .select()
            .execute()
            .value
        
        return response.first!
    }
    
    func getGroup(inviteCode: String) async throws -> Group? {
        let response: [Group] = try await client
            .from("groups")
            .select()
            .eq("invite_code", value: inviteCode)
            .execute()
            .value
        
        return response.first
    }
    
    // MARK: - Member Operations
    func addMemberToGroup(userId: String, groupId: String) async throws {
        let member = GroupMember(userId: userId, groupId: groupId, joinedAt: Date())
        
        try await client
            .from("group_members")
            .insert(member)
            .execute()
    }
    
    func getGroupMembers(groupId: String) async throws -> [GroupMember] {
        let response: [GroupMember] = try await client
            .from("group_members")
            .select()
            .eq("group_id", value: groupId)
            .execute()
            .value
        
        return response
    }
}
