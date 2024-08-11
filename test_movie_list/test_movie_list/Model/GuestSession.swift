//
//  GuestSession.swift
//  
//
//  Created by mac on 11.08.2024.
//

import Foundation


// Data Model for Guest Session
struct GuestSession {
    let id: String
    let expiryDate: Date
}

// Response Model for the API call
struct GuestSessionResponse: Codable {
    let success: Bool
    let guestSessionId: String
    let expiresAt: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case guestSessionId = "guest_session_id"
        case expiresAt = "expires_at"
    }
    
    var expiryDate: Date? {
        let dateFormatter = ISO8601DateFormatter()
        return dateFormatter.date(from: expiresAt)
    }
}
