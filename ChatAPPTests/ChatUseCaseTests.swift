//
//  ChatUseCaseTests.swift
//  ChatAPPTests
//
//  Created by Vignesh Ravichandran on 01/09/25.
//

import Testing
import Combine
@testable import ChatAPP

struct ChatUseCaseTests {
    
    @Test
    func testSendMessagePublishesUserAndBotMessages() async throws {
        let chatUseCase = ChatUseCase()
        var receivedMessages: [[ChatMessage]] = []
        
        // Convert Combine publisher to AsyncSequence
        let messageStream = chatUseCase.messagesPublisher
            .handleEvents(receiveOutput: { messages in
                receivedMessages.append(messages)
            })
            .values  // Converts to AsyncPublisherSequence

        var iterator = messageStream.makeAsyncIterator()

        chatUseCase.sendMessage("Hello, bot!")

        // Collect first two emissions
        let first = await iterator.next()
        let second = await iterator.next()

        // Assert
        #expect(first?.count == 1)
        #expect(first?[0].sender == .user)
        #expect(first?[0].content == "Hello, bot!")

        #expect(second?.count == 2)
        #expect(second?[1].sender == .bot)
        #expect(second?[1].content.contains("Hello, bot!") == true)
    }
    
    @Test("bot reply is appended after 5 seconds") 
    func botReplyDelayTest() async {
        let chatUseCase = ChatUseCase()
        let message = "Test message"
        var receivedMessages: [[ChatMessage]] = []

        // Subscribe to publisher updates (using AsyncPublisherSequence if available)
        let subscription = Task {
            for await messages in chatUseCase.messagesPublisher.values {
                receivedMessages.append(messages)
            }
        }

        // Send user message
        chatUseCase.sendMessage(message)

        // Wait asynchronously for 5.5 seconds to give time for the delay
        try? await Task.sleep(for: .seconds(5.5))

        #expect(receivedMessages.last?.contains(where: { $0.sender == .bot }) == true)

        // Cancel the subscription task
        subscription.cancel()
    }
}
