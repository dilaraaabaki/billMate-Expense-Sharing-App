//
//  billMate.swift
//  billMate
//
//  Created by Dilara Baki on 26.08.2025.
//


import Foundation
import Supabase

// Bu importları ekleyerek Models.swift'teki tanımları kullanabilirsin
@preconcurrency import struct billMate.Expense
@preconcurrency import struct billMate.Group
@preconcurrency import struct billMate.GroupMember
@preconcurrency import enum billMate.SupabaseServiceError

class SupabaseService {
    static let shared = SupabaseService()
    private let client = SupabaseManager.shared.client
    
    private init() {}
    
    // MARK: - Expense Operations
    func addExpense(_ expense: Expense) async throws {
        _ = try await client
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
        var updatedExpense = expense
        updatedExpense.updatedAt = Date()
        
        _ = try await client
            .from("expenses")
            .update(updatedExpense)
            .eq("id", value: expense.id)
            .execute()
    }
    
    func deleteExpense(id: String) async throws {
        _ = try await client
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
        
        guard let createdGroup = response.first else {
            throw SupabaseServiceError.noDataReturned
        }
        return createdGroup
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
    
    func getUserGroups(userId: String) async throws -> [Group] {
        // First get group IDs where user is a member
        let memberResponse: [GroupMember] = try await client
            .from("group_members")
            .select("group_id")
            .eq("user_id", value: userId)
            .eq("is_active", value: true)
            .execute()
            .value
        
        let groupIds = memberResponse.map { $0.groupId }
        
        if groupIds.isEmpty {
            return []
        }
        
        // Then get the actual group details
        let groupsResponse: [Group] = try await client
            .from("groups")
            .select()
            .in("id", value: groupIds)
            .execute()
            .value
        
        return groupsResponse
    }
    
    // MARK: - Member Operations
    func addMemberToGroup(userId: String, groupId: String) async throws {
        let member = GroupMember(userId: userId, groupId: groupId)
        
        _ = try await client
            .from("group_members")
            .insert(member)
            .execute()
    }
    
    func getGroupMembers(groupId: String) async throws -> [GroupMember] {
        let response: [GroupMember] = try await client
            .from("group_members")
            .select()
            .eq("group_id", value: groupId)
            .eq("is_active", value: true)
            .execute()
            .value
        
        return response
    }
    
    func removeMemberFromGroup(userId: String, groupId: String) async throws {
        _ = try await client
            .from("group_members")
            .update(["is_active": false])
            .eq("user_id", value: userId)
            .eq("group_id", value: groupId)
            .execute()
    }
    
    // MARK: - User Operations
    func getCurrentUserId() async throws -> String? {
        let session = try await client.auth.session
        return session.user.id.uuidString
    }
    
    func getCurrentUserEmail() async throws -> String? {
        let session = try await client.auth.session
        return session.user.email
    }
}