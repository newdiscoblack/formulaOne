//
//  FlagProviderTests.swift
//  formula-oneTests
//
//  Created by Kacper Jagiełło on 10/05/2021.
//

import Foundation
import XCTest
@testable import Core
@testable import FormulaOne

class FlagProviderTests: XCTestCase {
    var sut: FlagProviding!
    
    override func setUp() {
        super.setUp()
        sut = FlagProvider()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_gettingNationalFlag_shouldReturnBritishFlag() {
        // given
        let nationality = "british"
        
        // then
        XCTAssertEqual(sut.nationality(nationality), "🇬🇧")
    }
    
    func test_gettingNationalFlag_whenNationalityStringHasRandomCapitalLetters_shouldReturnBritishFlag() {
        // given
        let nationality = "bRiTisH"
        
        // then
        XCTAssertEqual(sut.nationality(nationality), "🇬🇧")
    }
    
    func test_gettingNationalFlag_whenNationalityStringDoesNotMatchWithAvailableFlags_shouldReturnDefaultCheckeredFlag() {
        // given
        let nationality = "wrong nationality"
        
        // then
        XCTAssertEqual(sut.nationality(nationality), "🏁")
    }
}
