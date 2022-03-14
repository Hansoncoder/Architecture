//
//  UserViewTests.swift
//  ArchitectureTests
//
//  Created by Hanson on 2022/3/14.
//

import UIKit
@testable import Architecture
import XCTest

class UserViewTests: XCTestCase {

    var testVC: UserViewController?
    var testVC1: UserViewController1?
    var testPresenter: UserView1Presenter?
    var testViewModel: UserViewModel?
    
    override func setUpWithError() throws {
        testVC = UserViewController()
        testVC1 = UserViewController1()
        testPresenter = UserView1Presenter(delegate: testVC1!)
        testViewModel = UserViewModel()
    }

    override func tearDownWithError() throws {
        testVC = nil
        testVC1 = nil
        testPresenter = nil
        testViewModel = nil
    }

    func testExample() throws {
        testPresenter?.getUserInfo()
        
    }
}
