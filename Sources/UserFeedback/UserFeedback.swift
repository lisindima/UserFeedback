//
//  UserFeedback.swift
//  UserFeedback
//
//  Created by Дмитрий Лисин on 26.10.2020.
//  Copyright © 2020 Дмитрий Лисин. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var typeFeedback: TypeFeedback = .bug
    @State private var typeReproduce: TypeReproduce = .yes_every_time
    @State private var diagnosticsInclude: Bool = false
    @State private var name: String = "Дмитрий"
    @State private var email: String = "lisindima1996@gmail.com"
    
    var body: some View {
        Form {
            Section(header: Text("Выберите подходящий вариант из списка").fontWeight(.bold)) {
                Picker(
                    selection: $typeFeedback,
                    label: Text("")
                ) {
                    Text("Ошибка в приложении")
                        .tag(TypeFeedback.bug)
                    Text("Запрос функции")
                        .tag(TypeFeedback.feature_request)
                    Text("Другое")
                        .tag(TypeFeedback.other)
                }
            }
            if typeFeedback == .bug {
                Section(header: Text("Вы можете воспроизвести ошибку?").fontWeight(.bold)) {
                    Picker(
                        selection: $typeReproduce,
                        label: Text("")
                    ) {
                        Text("Да, каждый раз")
                            .tag(TypeReproduce.yes_every_time)
                        Text("Да, иногда")
                            .tag(TypeReproduce.yes_sometimes)
                        Text("Да, редко")
                            .tag(TypeReproduce.yes_rarely)
                        Text("Нет")
                            .tag(TypeReproduce.no)
                    }
                }
                Section(header: Text("Диагностика").fontWeight(.bold)) {
                    Toggle("Прикрепить файл диагностики", isOn: $diagnosticsInclude)
                }
            }
            Section(header: Text("Укажите вашу контактную информацию").fontWeight(.bold)) {
                TextField("Имя", text: $name)
                TextField("Почта", text: $email)
            }
        }
    }
}

enum TypeFeedback: String {
    case bug = "Ошибка в приложении"
    case feature_request = "Запрос функции"
    case other = "Другое"
}

enum TypeReproduce: String {
    case yes_every_time = "Да, каждый раз"
    case yes_sometimes = "Да, иногда"
    case yes_rarely = "Да, редко"
    case no = "Нет"
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
