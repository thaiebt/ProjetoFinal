//
//  IntegrationTests.swift
//  UmGatoPorDiaTests
//
//  Created by Thaina da Silva Ebert on 01/11/21.
//

import XCTest
@testable import Um_Gato_Por_Dia

class IntegrationTests: XCTestCase {

    func testApiIntegration() {
        // Setup
        let sut = ViewController()
        sut.loadViewIfNeeded()
        //Exercise
        sleep(5)
        // Verify
        guard sut.arrayCat.count > 0 else {
            XCTFail()
            return
        }
        let charactersFromTheFirstCatsName = sut.arrayCat[0].name?.count ?? 0
        XCTAssertTrue(charactersFromTheFirstCatsName > 0)
    }

}
