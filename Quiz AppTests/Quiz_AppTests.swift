//
//  Quiz_AppTests.swift
//  Quiz AppTests
//
//  Created by Rodrigo Cavalcanti on 23/09/24.
//

import XCTest
import Combine

@testable import Quiz_App

class ProfileTests: XCTestCase {
    
    func testProfileInitialization() {
        let profile = Profile(name: "John Doe", icon: 1, maxScore: 100)
        
        XCTAssertEqual(profile.name, "John Doe")
        XCTAssertEqual(profile.icon, 1)
        XCTAssertEqual(profile.maxScore, 100)
        XCTAssertNotNil(profile.id)
    }
    
    func testProfileCoding() throws {
        let profile = Profile(name: "Jane Doe", icon: 2, maxScore: 200)
        let encoder = JSONEncoder()
        let decoder = JSONDecoder()
        
        let encodedData = try encoder.encode(profile)
        let decodedProfile = try decoder.decode(Profile.self, from: encodedData)
        
        XCTAssertEqual(profile.id, decodedProfile.id)
        XCTAssertEqual(profile.name, decodedProfile.name)
        XCTAssertEqual(profile.icon, decodedProfile.icon)
        XCTAssertEqual(profile.maxScore, decodedProfile.maxScore)
    }
}

class NetworkServiceTests: XCTestCase {
    
    var networkService: NetworkService!
    
    override func setUp() {
        super.setUp()
        networkService = NetworkService.shared
    }
    
    override func tearDown() {
        networkService = nil
        super.tearDown()
    }
    
    func testFetchQuestions() {
        let expectation = XCTestExpectation(description: "Fetch questions")
        
        networkService.fetchQuestions()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertFalse(self.networkService.anErrorOccurred)
            XCTAssertEqual(self.networkService.questions.count, 10)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 60)
    }
    
    func testFetchTenQuestions() {
        let expectation = XCTestExpectation(description: "Fetch ten questions")
        
        NetworkService.fetchTenQuestions()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Error fetching questions: \(error.localizedDescription)")
                }
                expectation.fulfill()
            }, receiveValue: { questions in
                XCTAssertEqual(questions.count, 10)
                XCTAssertEqual(Set(questions).count, 10, "All questions should be unique")
            })
            .store(in: &networkService.cancellables)
        
        wait(for: [expectation], timeout: 60)
    }
    
    func testSubmitAnswer() {
        let expectation = XCTestExpectation(description: "Submit answer")
        
        NetworkService.submitAnswer(questionId: "29", answer: "Maquiavel")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    XCTFail("Error submitting answer: \(error.localizedDescription)")
                }
                expectation.fulfill()
            }, receiveValue: { response in
                XCTAssertNotNil(response.result)
            })
            .store(in: &networkService.cancellables)
        
        wait(for: [expectation], timeout: 60)
    }
}

class QuestionTests: XCTestCase {
    
    func testQuestionEquality() {
        let question1 = Question(id: "1", statement: "Test", options: ["A", "B"])
        let question2 = Question(id: "1", statement: "Different", options: ["C", "D"])
        let question3 = Question(id: "2", statement: "Test", options: ["A", "B"])
        
        XCTAssertEqual(question1, question2)
        XCTAssertNotEqual(question1, question3)
    }
    
    func testQuestionComparable() {
        let question1 = Question(id: "1", statement: "Test", options: ["A", "B"])
        let question2 = Question(id: "2", statement: "Test", options: ["A", "B"])
        
        XCTAssertLessThan(question1, question2)
        XCTAssertGreaterThan(question2, question1)
    }
}
