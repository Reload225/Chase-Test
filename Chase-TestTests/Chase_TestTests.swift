//
//  Chase_TestTests.swift
//  Chase-TestTests
//
//  Created by Shamil Imanov on 30.10.2024.
//

import XCTest
@testable import Chase_Test

class PlanetWorkerTests: XCTestCase {
/*
 For example, to test a real network request, 
 we would call the fetchPlanets method from the PlanetWorker class.
 We would then check if the results match the expected data or if an error occurs.

 This could look like this:

	private var worker: PlanetWorker!

	override func setUp() {
		super.setUp()
		worker = PlanetWorker()
	}

	func testFetchPlanets() {
		let expectation = self.expectation(description: "Fetch planets from API")
		
		worker.fetchPlanets(
			onSuccess: { model in
				XCTAssertFalse(model.isEmpty)
				expectation.fulfill()
			},
			onError: { _ in
				XCTFail("We couldn't get the data")
			}
		)

		wait(for: [expectation], timeout: 3.0)
	}

	override func tearDown() {
		worker = nil
		super.tearDown()
	}

*/
	/*
	 A spy is helpful for testing the PlanetWorker.
	 First, it does not use the internet, so tests are not affected by network problems.
	 Second, the spy gives specific answers, helping us see how the app works in different
	 cases without using the real API.
	 Third, the spy can always give the same answers, so tests are reliable.
	 Fourth, tests are faster because we do not wait for the network.
	 Finally, tests are easier to read and understand because we know what we are testing.
	 */

	private let spy = PlanetWorkerSpy()

	func testFetchPlanetsSuccess() {
		let expectedPlanets = [
			PlanetModel(
				name: "Earth",
				climate: "Temperate",
				terrain: "Forest",
				population: "7 billion"
			)
		]
		spy.planetsToReturn = expectedPlanets
		
		let expectation = self.expectation(description: "Fetch planets success")

		spy.fetchPlanets(
			onSuccess: { planets in
				XCTAssertEqual(planets, expectedPlanets, "Expected planets do not match.")
				expectation.fulfill()
			},
			onError: { error in
				XCTFail("Expected success, but got error: \(error)")
			}
		)
		
		waitForExpectations(timeout: 1, handler: nil)
	}
	
	func testFetchPlanetsError() {
		let spy = PlanetWorkerSpy()
		let expectedError = NSError(domain: "Test error", code: -1, userInfo: nil)
		spy.errorToReturn = expectedError

		let expectation = self.expectation(description: "Fetch planets error")

		spy.fetchPlanets(
			onSuccess: { planets in
				XCTFail("Expected error, but got planets: \(planets)")
			},
			onError: { error in
				XCTAssertEqual(error as NSError, expectedError, "Expected error does not match.")
				expectation.fulfill()
			}
		)
		
		waitForExpectations(timeout: 1, handler: nil)
	}
}

private final class PlanetWorkerSpy: PlanetWorkerLogic {
	var planetsToReturn: [PlanetModel]?
	var errorToReturn: Error?
	
	func fetchPlanets(
		onSuccess: (([PlanetModel]) -> Void)?,
		onError: ((Error) -> Void)?
	) {
		if let error = errorToReturn {
			onError?(error)
		} else if let planets = planetsToReturn {
			onSuccess?(planets)
		} else {
			onError?(NSError(domain: "No data or error set", code: -1, userInfo: nil))
		}
	}
}
