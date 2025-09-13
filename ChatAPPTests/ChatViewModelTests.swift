//
//  ChatViewModelTests.swift
//  ChatAPPTests
//
//  Created by Vignesh Ravichandran on 01/09/25.
//
import Testing
import Combine
import Foundation
@testable import ChatAPP

@Suite
struct ChatViewModelTests {
    
    class MockChatUseCase: ChatUseCaseProtocol {
        let messagesSubject = CurrentValueSubject<[ChatMessage], Never>([])
        var messagesPublisher: AnyPublisher<[ChatMessage], Never> {
            messagesSubject.eraseToAnyPublisher()
        }

        private(set) var sentMessages: [String] = []

        func sendMessage(_ message: String) {
            sentMessages.append(message)
        }
    }

    @Test
    func testSendMessageUpdatesUseCaseAndClearsInput() async {
        let mockUseCase = MockChatUseCase()
        let viewModel = ChatViewModel(chatUseCase: mockUseCase)
        viewModel.inputText = "Hello, Chat!"

        viewModel.send()

        // Assert
        #expect(mockUseCase.sentMessages.contains("Hello, Chat!"))
        #expect(viewModel.inputText == "")
    }
    
    @Test
    func testSendMessageIgnoresEmptyInput() async {
        let mockUseCase = MockChatUseCase()
        let viewModel = ChatViewModel(chatUseCase: mockUseCase)
        
        viewModel.inputText = "   " // Only whitespace
        viewModel.send()
        
        #expect(mockUseCase.sentMessages.isEmpty)
    }

}
