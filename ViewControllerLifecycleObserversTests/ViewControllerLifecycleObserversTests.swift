//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import XCTest
import ViewControllerLifecycleObservers

class ViewControllerLifecycleObserversTests: XCTestCase {
	
	// MARK: View Will Appear Tests

	func testViewWillAppearObserverIsAddedAsChild() {
		assertObserverIsAddedAsChild(when: { sut in
			sut.onViewWillAppear {}
		})
	}
	
	func testViewWillAppearObserverViewIsAddedAsSubview() {
		assertObserverViewIsAddedAsSubview(when: { sut in
			sut.onViewWillAppear {}
		})
	}
	
	func testViewWillAppearObserverViewIsInvisible() {
		assertObserverViewIsInvisible(when: { sut in
			sut.onViewWillAppear {}
		})
	}
	
	func testViewWillAppearObserverFiresCallback() {
		assertObserver(
			firesCallback: { $0.onViewWillAppear },
			when: { $0.viewWillAppear(false) })
	}
	
	func testCanRemoveViewWillAppearObserver() {
		assertCanRemoveObserver(when: { sut in
			sut.onViewWillAppear {}
		})
	}
	
	func testCanRemoveViewWillAppearObserverView() {
		assertCanRemoveObserverView(when: { sut in
			sut.onViewWillAppear {}
		})
	}
	
	// MARK: Helpers
	
	func assertObserverIsAddedAsChild(when action: @escaping (UIViewController) -> Void, file: StaticString = #file, line: UInt = #line) {
		let sut = UIViewController()
		
		action(sut)
		
		XCTAssertEqual(sut.childViewControllers.count, 1, file: file, line: line)
	}
	
	func assertObserverViewIsAddedAsSubview(when action: @escaping (UIViewController) -> Void, file: StaticString = #file, line: UInt = #line) {
		let sut = UIViewController()
		
		action(sut)
		
		let observer = sut.childViewControllers.first
		XCTAssertEqual(observer?.view.superview, sut.view, file: file, line: line)
	}
	
	func assertObserverViewIsInvisible(when action: @escaping (UIViewController) -> Void, file: StaticString = #file, line: UInt = #line) {
		let sut = UIViewController()
		
		action(sut)
		
		let observer = sut.childViewControllers.first
		XCTAssertEqual(observer?.view?.isHidden, true, file: file, line: line)
	}
	
	func assertObserver(
		firesCallback callback: (UIViewController) -> ((@escaping () -> Void) -> UIViewController.Observer), when action: @escaping (UIViewController) -> Void, file: StaticString = #file, line: UInt = #line) {
		let sut = UIViewController()
		
		var callCount = 0
		_ = callback(sut)({ callCount += 1 })
		
		let observer = sut.childViewControllers.first!
		XCTAssertEqual(callCount, 0, file: file, line: line)
		
		action(observer)
		XCTAssertEqual(callCount, 1, file: file, line: line)
		
		action(observer)
		XCTAssertEqual(callCount, 2, file: file, line: line)
	}
	
	func assertCanRemoveObserver(when action: @escaping (UIViewController) -> UIViewController.Observer, file: StaticString = #file, line: UInt = #line) {
		let sut = UIViewController()
		
		action(sut).remove()
		
		XCTAssertEqual(sut.childViewControllers.count, 0, file: file, line: line)
	}
	
	func assertCanRemoveObserverView(when action: @escaping (UIViewController) -> UIViewController.Observer, file: StaticString = #file, line: UInt = #line) {
		let sut = UIViewController()
		
		action(sut).remove()
		
		XCTAssertEqual(sut.view.subviews.count, 0, file: file, line: line)
	}
}
