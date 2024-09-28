//
//  Question.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 24/09/24.
//

import Foundation

struct Question: Codable, Identifiable, Hashable {
    let id: String
    let statement: String
    let options: [String]
}

extension Question: Comparable {
    static func < (lhs: Question, rhs: Question) -> Bool {
        lhs.id < rhs.id
    }
    
    static func == (lhs: Question, rhs: Question) -> Bool {
        lhs.id == rhs.id
    }
}

struct Answer: Codable {
    let answer: String
}

struct AnswerResponse: Codable {
    let result: Bool
}



// MARK: - Mock
extension Question {
    static let mock = Question(id: UUID().uuidString, statement: "Qual personagem folclÃ³rico costuma ser agradado pelos caÃ§adores com a oferta de fumo?", options: ["Negrinho do Pastoreio","Saci","Lobisomem","BoitatÃ¡","Caipora"])
}
