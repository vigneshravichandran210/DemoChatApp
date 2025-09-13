//
//  ChatUseCaseProtocol.swift
//  ChatAPP
//
//  Created by Vignesh Ravichandran on 01/09/25.
//

import Combine

protocol ChatUseCaseProtocol: AnyObject {
    var messagesPublisher: AnyPublisher<[ChatMessage], Never> { get }
    func sendMessage(_ message: String)
}
