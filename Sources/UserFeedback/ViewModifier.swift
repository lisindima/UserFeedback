//
//  ViewModifier.swift
//  
//
//  Created by Дмитрий Лисин on 26.10.2020.
//

import SwiftUI

struct UserFeedbackModifier: ViewModifier {
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    ContentView()
                        .ignoresSafeArea(edges: .bottom)
                        .navigationTitle("Обратная связь")
                        .toolbar {
                            ToolbarItem(placement: .primaryAction) {
                                Button(action: { isPresented = false }) {
                                    Text("Закрыть")
                                }
                            }
                        }
                }
            }
    }
}
