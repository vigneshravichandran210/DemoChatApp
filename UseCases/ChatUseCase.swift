//
//  ChatUseCase.swift
//  ChatAPP
//
//  Created by Vignesh Ravichandran on 01/09/25.
//

import Combine
import SwiftUI

// MARK: - Use Case Layer

final class ChatUseCase: ChatUseCaseProtocol {
    private(set) var messages: [ChatMessage] = []
    
    // Use CurrentValueSubject to publish messages stream
    private let messagesSubject = CurrentValueSubject<[ChatMessage], Never>([])
    var messagesPublisher: AnyPublisher<[ChatMessage], Never> {
        messagesSubject.eraseToAnyPublisher()
    }
    
    func sendMessage(_ message: String) {
        let userMessage = ChatMessage(content: message, sender: .user, timestamp: Date())
        messages.append(userMessage)
        messagesSubject.send(messages)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) { [weak self] in
            guard let self = self else { return }
            let botReply = ChatMessage(content: "\(message)", sender: .bot, timestamp: Date())
            self.messages.append(botReply)
            self.messagesSubject.send(self.messages)
        }
    }
}
