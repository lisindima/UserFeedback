//
//  UserFeedback.swift
//  UserFeedback
//
//  Created by Дмитрий Лисин on 26.10.2020.
//  Copyright © 2020 Дмитрий Лисин. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedFeedback: TopicFeedback = .bug
    @State private var name: String = "Дмитрий"
    @State private var email: String = "lisindima1996@gmail.com"
    
    var body: some View {
        Form {
            Section(header: Text("Выберите подходящий вариант из списка").fontWeight(.bold)) {
                Picker(
                    selection: $selectedFeedback,
                    label: Text("")
                ) {
                    Text("Ошибка в приложении")
                        .tag(TopicFeedback.bug)
                    Text("Запрос функции")
                        .tag(TopicFeedback.feature_request)
                    Text("Другое")
                        .tag(TopicFeedback.other)
                }
            }
            Section(header: Text("Укажите вашу контактную информацию").fontWeight(.bold)) {
                TextField("Имя", text: $name)
                TextField("Почта", text: $email)
            }
        }
    }
}

enum TopicFeedback: String {
    case bug = "Ошибка в приложении"
    case feature_request = "Запрос функции"
    case other = "Другое"
}

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

public extension View {
    func userFeedback(isPresented: Binding<Bool>) -> some View {
        modifier(UserFeedbackModifier(isPresented: isPresented))
    }
}
