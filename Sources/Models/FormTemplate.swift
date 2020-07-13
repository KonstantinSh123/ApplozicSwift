//
//  FormTemplate.swift
//  ApplozicSwift
//
//  Created by Mukesh on 08/07/20.
//

import Foundation

struct FormTemplate: Decodable {
    let elements: [Element]

    struct Element: Decodable {
        let type: String
        let label, placeholder, name, value: String?
        let title: String?
        let options: [Option]?
        let requestType, formAction, message: String?

        struct Option: Decodable {
            let label, value: String
        }
    }
}

extension FormTemplate {
    init(payload: [[String: Any]]) throws {
        let json = try JSONSerialization.data(withJSONObject: payload)
        let elements = try JSONDecoder().decode([FormTemplate.Element].self, from: json)
        self = FormTemplate(elements: elements)
    }
}

extension FormTemplate.Element {
    enum ContentType: String {
        case text
        case password
        case multiselect = "checkbox"
        case singleSelect = "radio"
        case hidden
        case submit
        case unknown
    }

    var contentType: ContentType {
        return ContentType(rawValue: type) ?? .unknown
    }
}
