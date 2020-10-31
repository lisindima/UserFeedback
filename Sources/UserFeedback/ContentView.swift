//
//  ContentView.swift
//  UserFeedback
//
//  Created by Дмитрий Лисин on 26.10.2020.
//  Copyright © 2020 Дмитрий Лисин. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var typeFeedback: TypeFeedback = .bug
    @State private var typeReproduce: TypeReproduce = .yes_every_time
    @State private var diagnosticsInclude: Bool = true
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var titleFeedback: String = ""
    @State private var descriptionFeedback: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Основное").fontWeight(.bold).padding(.horizontal)) {
                Picker(selection: $typeFeedback, label: Text("Какой тип отзыва вы хотите отправить?")) {
                    Text("Ошибка в приложении")
                        .tag(TypeFeedback.bug)
                    Text("Запрос функции")
                        .tag(TypeFeedback.feature_request)
                    Text("Другое")
                        .tag(TypeFeedback.other)
                }
                if typeFeedback == .bug {
                    Picker(selection: $typeReproduce, label: Text("Вы можете воспроизвести ошибку?")) {
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
            }
            if typeFeedback == .bug {
                Section(header: Text("Диагностика").fontWeight(.bold).padding(.horizontal), footer: Text("Файлы диагностики могут включать такую ​​информацию, как модель вашего устройства, версия операционной системы.").padding(.horizontal)) {
                    Toggle("Прикрепить файл диагностики", isOn: $diagnosticsInclude)
                }
            }
            Section(header: Text("Контактная информация").fontWeight(.bold).padding(.horizontal)) {
                TextField("Имя", text: $name)
                TextField("Email", text: $email)
            }
            Section(header: Text("Описание").fontWeight(.bold).padding(.horizontal)) {
                TextField("Краткое описание проблемы", text: $titleFeedback)
                #if os(watchOS)
                TextField("Полное описание проблемы", text: $descriptionFeedback)
                #else
                TextEditor(text: $descriptionFeedback)
                    .frame(height: 300)
                #endif
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
