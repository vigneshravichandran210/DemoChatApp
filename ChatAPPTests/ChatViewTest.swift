//
//  ChatViewTest.swift
//  ChatAPPTests
//
//  Created by Vignesh Ravichandran on 02/09/25.
//

import ViewInspector
import Testing
import SwiftUI
@testable import ChatAPP

@MainActor
struct ChatViewTests {
    
    @Test
    func testChatViewHierarchy() throws {
        // Given
        let sut = ChatView(viewModel: ChatViewModel())
        ViewHosting.host(view: sut)
        
        // When
        let inspected = try sut.inspect()
        let rootVStack = try inspected.vStack()
        #expect(rootVStack.count == 3)
        
        let scrollViewReader = try rootVStack.scrollViewReader(0)
        let scrollView = try scrollViewReader.scrollView()
        let lazyVStack = try scrollView.lazyVStack()
        
        #expect(lazyVStack.count == 1)
        
        // Divider at index 1
        _ = try rootVStack.divider(1)
        
        // FooterSearchView at index 2
        _ = try rootVStack.view(FooterSearchView.self, 2)
    }
}
