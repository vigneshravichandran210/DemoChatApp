//
//  ChatMessageTests.swift
//  ChatAPPTests
//
//  Created by Vignesh Ravichandran on 01/09/25.
//

import Testing
import Foundation

@testable import ChatAPP

@Suite
struct ChatMessageTests {
    
    // Test: messages with same content and sender are equal
    @Test
    func testEquality_sameContentAndSender_shouldBeEqual() {
        let date1 = Date()
        let date2 = date1.addingTimeInterval(10) // Different timestamp
        let message1 = ChatMessage(content: "Hello", sender: .user, timestamp: date1)
        let message2 = ChatMessage(content: "Hello", sender: .user, timestamp: date2)

        #expect(message1 == message2) // Passes because of custom == logic
    }

    // Test: different content results in inequality
    @Test
    func testEquality_differentContent_shouldNotBeEqual() {
        let message1 = ChatMessage(content: "Hello", sender: .user, timestamp: Date())
        let message2 = ChatMessage(content: "Hi", sender: .user, timestamp: Date())

        #expect(message1 != message2)
    }

    // Test: different sender results in inequality
    @Test
    func testEquality_differentSender_shouldNotBeEqual() {
        let message1 = ChatMessage(content: "Hello", sender: .user, timestamp: Date())
        let message2 = ChatMessage(content: "Hello", sender: .bot, timestamp: Date())

        #expect(message1 != message2)
    }

    // Optional: id and timestamp don’t affect equality
    @Test
    func testEquality_differentIdAndTimestamp_shouldStillBeEqual() {
        let message1 = ChatMessage(content: "Test", sender: .bot, timestamp: Date())
        // Force different ID and timestamp
        let message2 = ChatMessage(content: "Test", sender: .bot, timestamp: Date().addingTimeInterval(5))

        #expect(message1 == message2)
    }
}
