//
//  Enum.swift
//  
//
//  Created by Дмитрий Лисин on 26.10.2020.
//

import Foundation

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
