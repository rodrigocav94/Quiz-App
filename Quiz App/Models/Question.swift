//
//  Question.swift
//  Quiz App
//
//  Created by Rodrigo Cavalcanti on 24/09/24.
//

import Foundation

struct Question: Codable {
    let id: String
    let statement: String
    let options: [String]
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
