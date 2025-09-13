//
//  ChatMessage.swift
//  ChatAPP
//
//  Created by Vignesh Ravichandran on 01/09/25.
//

import SwiftUI
import Combine

// MARK: - Entity Layer

struct ChatMessage: Identifiable {
    enum Sender {
        case user
        case bot
    }
    
    let id = UUID()
    let content: String
    let sender: Sender
    let timestamp: Date
}

extension ChatMessage: Equatable {
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        lhs.content == rhs.content && lhs.sender == rhs.sender
    }
}
