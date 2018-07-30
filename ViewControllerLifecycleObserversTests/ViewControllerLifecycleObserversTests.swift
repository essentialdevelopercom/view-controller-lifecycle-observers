//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import XCTest
@testable import ViewControllerLifecycleObservers

class ViewControllerLifecycleObserversTests: XCTestCase {
	
	func testViewWillAppearObserverIsAddedAsChild() {
		let sut = UIViewController()
		
		sut.onViewWillAppear {}
		
		XCTAssertEqual(sut.childViewControllers.count, 1)
	}
	
	func testViewWillAppearObserverViewIsAddedAsSubview() {
		let sut = UIViewController()
		
		sut.onViewWillAppear {}
		
		let observer = sut.childViewControllers.first
		XCTAssertEqual(observer?.view.superview, sut.view)
	}
	
	func testViewWillAppearObserverViewIsInvisible() {
		let sut = UIViewController()
		
		sut.onViewWillAppear {}
		
		let observer = sut.childViewControllers.first
		XCTAssertEqual(observer?.view.isHidden, true)
	}
	
	func testViewWillAppearObserverFiresCallback() {
		let sut = UIViewController()
		
		var callCount = 0
		sut.onViewWillAppear { callCount += 1 }
		
		let observer = sut.childViewControllers.first
		XCTAssertEqual(callCount, 0)
		
		observer?.viewWillAppear(false)
		XCTAssertEqual(callCount, 1)
		
		observer?.viewWillAppear(false)
		XCTAssertEqual(callCount, 2)
	}
	
	func testCanRemoveViewWillAppearObserver() {
		let sut = UIViewController()
		
		sut.onViewWillAppear(run: {}).remove()
		
		XCTAssertEqual(sut.childViewControllers.count, 0)
	}
	
	func testCanRemoveViewWillAppearObserverView() {
		let sut = UIViewController()
		
		sut.onViewWillAppear(run: {}).remove()
		
		XCTAssertEqual(sut.view.subviews.count, 0)
	}
    
}
