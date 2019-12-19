//
//  picoyplacatestTests.swift
//  picoyplacatestTests
//
//  Created by Diego Cando on 17/12/19.
//  Copyright © 2019 Diego Cando. All rights reserved.
//

import XCTest
@testable import picoyplacatest

class picoyplacatestTests: XCTestCase {
    
    func testPlate(){
        //Validate plate correct
        XCTAssertTrue(validatePlate(plate: "AAA-000"))
        XCTAssertTrue(validatePlate(plate: "ABC1000"))
        //Validate plate incorrect
        XCTAssertFalse(validatePlate(plate: "AA-000"))
        XCTAssertFalse(validatePlate(plate: "A0"))
        XCTAssertFalse(validatePlate(plate: "000aaa"))
        XCTAssertFalse(validatePlate(plate: "A%%"))
        
    }
    
    func testDate(){
        //Validate date correct
        XCTAssertTrue(validateDateTime(dateTime:"2019-01-01 01:01:01"))
        
        //Validate date incorrect
        XCTAssertTrue(validateDateTime(dateTime:"2019-01-01 01:01:61"))
        XCTAssertTrue(validateDateTime(dateTime:"2019-31-31 01:01:01"))
        XCTAssertTrue(validateDateTime(dateTime:"2019-02-30 01:01:01"))
        
        
    }
    
  

}
