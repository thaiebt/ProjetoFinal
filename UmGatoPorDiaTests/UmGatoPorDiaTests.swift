//
//  UmGatoPorDiaTests.swift
//  UmGatoPorDiaTests
//
//  Created by Thaina da Silva Ebert on 01/11/21.
//

import XCTest
@testable import Um_Gato_Por_Dia

class UmGatoPorDiaTests: XCTestCase {
    func testInitWillCallApiOnce() {
        // Setup
        let doubleApi = APISpy()
        let sut = ViewController(api: doubleApi)
        
        // Exercise
        sut.loadViewIfNeeded()
        
        // Verify
        XCTAssertEqual(doubleApi.apiCalls, 1, "A API deve ser chamada somente uma vez")
    }
}
