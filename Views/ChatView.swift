//
//  ChatView.swift
//  ChatAPP
//
//  Created by Vignesh Ravichandran on 01/09/25.
//

import SwiftUI

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel
    
    var body: some View {
        VStack {
            ScrollViewReader { scrollView in
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.messages) { message in
                            HStack {
                                if message.sender == .bot {
                                    // Bot messages on left
                                    messageView(message)
                                    Spacer()
                                } else {
                                    // User messages on right
                                    Spacer()
                                    messageView(message)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .onChange(of: viewModel.messages.count) {
                    if let last = viewModel.messages.last {
                        withAnimation {
                            scrollView.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            Divider()
            
            FooterSearchView(viewModel: viewModel)
            
        }
    }
    
    @ViewBuilder
    private func messageView(_ message: ChatMessage) -> some View {
        Text(message.content)
            .padding()
            .background(message.sender == .user ? Color.blue.opacity(0.7) : Color.gray.opacity(0.3))
            .foregroundColor(message.sender == .user ? .white : .black)
            .cornerRadius(12)
            .frame(maxWidth: 250, alignment: message.sender == .user ? .trailing : .leading)
            .id(message.id)
    }
}

struct FooterSearchView: View {
    
    @ObservedObject var viewModel: ChatViewModel
    
    var body: some View {
        HStack {
            TextField("Enter message", text: $viewModel.inputText)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: viewModel.send) {
                Text("Send")
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}

#Preview {
    ChatView(viewModel: ChatViewModel())
}
