//
//  SwiftTestCodeGeneratorTests+Options.swift
//  CapriccioLibTests
//
//  Created by Franco on 07/09/2018.
//

import Foundation
import Nimble
import Gherkin
@testable import CapriccioLib

extension SwiftTestCodeGeneratorTests {
    func testItGeneratesTheCorrectCodeWithASimpleFeature() {
        let scenario: Scenario = .simple(ScenarioSimple(name: "Scenario I want to test",
                                                        description: "",
                                                        steps:[Step(name: .given, text: "I'm in a situation"),
                                                               Step(name: .when, text: "Something happens"),
                                                               Step(name: .then, text: "Something else happens")] ))
        let feature = Feature(name: "Feature number one",
                              description: "",
                              scenarios: [scenario])
        
        let expectedResult = """
        import XCTest
        import XCTest_Gherkin

        final class FeatureNumberOne: XCTestCase {
            func testScenarioIWantToTest() {
                Given("I'm in a situation")
                When("Something happens")
                Then("Something else happens")
            }
        }
        """
        
        fileGenerationCheck(feature: feature, expectedResult: expectedResult)
    }
    
    func testItGeneratesTheCorrectCodeWithAMoreComplexFeature() {
        let scenario: Scenario = .simple(ScenarioSimple(name: "Scenario I want to test",
                                                        description: "",
                                                        steps:[Step(name: .given, text: "I'm in a situation"),
                                                               Step(name: .when, text: "Something happens"),
                                                               Step(name: .then, text: "Something else happens")] ))
        
        let scenario2: Scenario = .simple(ScenarioSimple(name: "Other scenario I want to test",
                                                         description: "",
                                                         steps:[Step(name: .given, text: "I'm in another situation"),
                                                                Step(name: .when, text: "Something different happens"),
                                                                Step(name: .then, text: "Something else happens")] ))
        
        let feature = Feature(name: "Feature number one",
                              description: "",
                              scenarios: [scenario, scenario2])
        
        let expectedResult = """
        import XCTest
        import XCTest_Gherkin

        final class FeatureNumberOne: XCTestCase {
            func testScenarioIWantToTest() {
                Given("I'm in a situation")
                When("Something happens")
                Then("Something else happens")
            }

            func testOtherScenarioIWantToTest() {
                Given("I'm in another situation")
                When("Something different happens")
                Then("Something else happens")
            }
        }
        """
        
        fileGenerationCheck(feature: feature, expectedResult: expectedResult)
    }
}