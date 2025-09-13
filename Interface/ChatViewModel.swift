//
//  ChatViewModel.swift
//  ChatAPP
//
//  Created by Vignesh Ravichandran on 01/09/25.
//

import SwiftUI
import Combine

// MARK: - Interface Layer (ViewModel)

final class ChatViewModel: ObservableObject {
    @Published var inputText: String = ""
    @Published var messages: [ChatMessage] = []
    
    private var cancellables: Set<AnyCancellable> = []
    private let chatUseCase: ChatUseCaseProtocol
    
    init(chatUseCase: ChatUseCaseProtocol = ChatUseCase()) {
        self.chatUseCase = chatUseCase
        
        chatUseCase.messagesPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.messages, on: self)
            .store(in: &cancellables)
    }
    
    func send() {
        guard !inputText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        chatUseCase.sendMessage(inputText)
        inputText = ""
    }
}
