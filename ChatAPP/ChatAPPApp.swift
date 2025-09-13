//
//  ChatAPPApp.swift
//  ChatAPP
//
//  Created by Vignesh Ravichandran on 01/09/25.
//

import SwiftUI

@main
struct ChatAPPApp: App {
    var body: some Scene {
        WindowGroup {
            ChatView(viewModel: ChatViewModel())
        }
    }
}
