//
//  SystemUtils.swift
//  Mindful Rest
//
//  Created by Joey Green on 2022/4/18.
//

import Foundation

enum Language {
    case english, zh
}

func getAppLanguage() -> Language {
    let lang = Locale.current.languageCode
    if lang == "zh" {
        return .zh
    } else {
        return .english
    }
}
