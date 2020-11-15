//
//  ViewModifier.swift
//  
//
//  Created by Дмитрий Лисин on 26.10.2020.
//

import SwiftUI

struct UserFeedbackModifier: ViewModifier {
    @Binding var isPresented: Bool
    
    private func close() {
        isPresented = false
    }
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    ContentView()
                        .navigationTitle("Обратная связь")
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Button(action: close) {
                                    Text("Закрыть")
                                }
                            }
                        }
                }
            }
    }
}
