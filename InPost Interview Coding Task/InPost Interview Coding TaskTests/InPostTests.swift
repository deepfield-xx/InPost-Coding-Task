//
//  InPost_Interview_Coding_TaskTests.swift
//  InPost Interview Coding TaskTests
//
//  Created by Damian Piwowarski on 03/11/2022.
//

import XCTest
@testable import InPost_Interview_Coding_Task

final class InPostTests: XCTestCase {
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testPresentingPackListController() {
        let rootViewController = UIApplication.shared.delegate?.window??.rootViewController
        guard let navigationVC = rootViewController as? IPNavigationController else {
            XCTFail("No IPNavigationController in the view stack")
            return
        }
        
        guard let packListController = navigationVC.topViewController as? PackListController else {
            XCTFail("No PackListController in the view stack")
            return
        }
        
        let subviews = packListController.stackView.arrangedSubviews
        let groupHeaders = subviews.filter { $0 is PackListGroupView }
        XCTAssertEqual(groupHeaders.count, 2)
        
        let firstGroupView = groupHeaders.first
        XCTAssertEqual(subviews.firstIndex(of: firstGroupView!), 0)
        let lastGroupView = groupHeaders.last
        XCTAssertEqual(subviews.firstIndex(of: lastGroupView!), 2)
        
        let packViews = subviews.filter { $0 is PackView } as? [PackView]
        XCTAssertEqual(packViews?.count, 7)
        
        let url = Bundle.main.url(forResource: "packs", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let result = try! jsonDecoder.decode([Pack].self, from: data)
        let resultIds = result.map { $0.id }
        
        XCTAssertEqual(resultIds.count, packViews?.count)
        packViews?.forEach {
            XCTAssertTrue(resultIds.contains($0.numberLabel.text ?? ""))
        }
    }
}
