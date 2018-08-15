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
	
	// MARK: View Did Appear Tests
	
	func testViewDidAppearObserverIsAddedAsChild() {
		assertObserverIsAddedAsChild(when: { sut in
			sut.onViewDidAppear {}
		})
	}
	
	func testViewDidAppearObserverViewIsAddedAsSubview() {
		assertObserverViewIsAddedAsSubview(when: { sut in
			sut.onViewDidAppear {}
		})
	}
	
	func testViewDidAppearObserverViewIsInvisible() {
		assertObserverViewIsInvisible(when: { sut in
			sut.onViewDidAppear {}
		})
	}
	
	func testViewDidAppearObserverFiresCallback() {
		assertObserver(
			firesCallback: { $0.onViewDidAppear },
			when: { $0.viewDidAppear(false) })
	}
	
	func testCanRemoveViewDidAppearObserver() {
		assertCanRemoveObserver(when: { sut in
			sut.onViewDidAppear {}
		})
	}
	
	func testCanRemoveViewDidAppearObserverView() {
		assertCanRemoveObserverView(when: { sut in
			sut.onViewDidAppear {}
		})
	}
	
	// MARK: View Will Disappear Tests
	
	func testViewWillDisappearObserverIsAddedAsChild() {
		assertObserverIsAddedAsChild(when: { sut in
			sut.onViewWillDisappear {}
		})
	}
	
	func testViewWillDisappearObserverViewIsAddedAsSubview() {
		assertObserverViewIsAddedAsSubview(when: { sut in
			sut.onViewWillDisappear {}
		})
	}
	
	func testViewWillDisappearObserverViewIsInvisible() {
		assertObserverViewIsInvisible(when: { sut in
			sut.onViewWillDisappear {}
		})
	}
	
	func testViewWillDisappearObserverFiresCallback() {
		assertObserver(
			firesCallback: { $0.onViewWillDisappear },
			when: { $0.viewWillDisappear(false) })
	}
	
	func testCanRemoveViewWillDisappearObserver() {
		assertCanRemoveObserver(when: { sut in
			sut.onViewWillDisappear {}
		})
	}
	
	func testCanRemoveViewWillDisappearObserverView() {
		assertCanRemoveObserverView(when: { sut in
			sut.onViewWillDisappear {}
		})
	}
	
	// MARK: View Did Disappear Tests
	
	func testViewDidDisappearObserverIsAddedAsChild() {
		assertObserverIsAddedAsChild(when: { sut in
			sut.onViewDidDisappear {}
		})
	}
	
	func testViewDidDisappearObserverViewIsAddedAsSubview() {
		assertObserverViewIsAddedAsSubview(when: { sut in
			sut.onViewDidDisappear {}
		})
	}
	
	func testViewDidDisappearObserverViewIsInvisible() {
		assertObserverViewIsInvisible(when: { sut in
			sut.onViewDidDisappear {}
		})
	}
	
	func testViewDidDisappearObserverFiresCallback() {
		assertObserver(
			firesCallback: { $0.onViewDidDisappear },
			when: { $0.viewDidDisappear(false) })
	}
	
	func testCanRemoveViewDidDisappearObserver() {
		assertCanRemoveObserver(when: { sut in
			sut.onViewDidDisappear {}
		})
	}
	
	func testCanRemoveViewDidDisappearObserverView() {
		assertCanRemoveObserverView(when: { sut in
			sut.onViewDidDisappear {}
		})
	}
	
	// MARK: Integration Tests
	
	func testObserversWorkingWithNavigationControllerAnimatedTransitions() {
		let navigation = UINavigationController()
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.rootViewController = navigation
		window.makeKeyAndVisible()
		
		let exp = expectation(description: "Wait for lifecycle callbacks")
		let view = UIViewController()
		
		view.onViewWillAppear { [weak view, weak navigation] in
			view?.onViewDidAppear {
				view?.onViewWillDisappear {
					view?.onViewDidDisappear {
						exp.fulfill()
					}
				}
				
				navigation?.setViewControllers([], animated: true)
			}
		}
		
		navigation.pushViewController(view, animated: true)
		wait(for: [exp], timeout: 1)
	}
	
	func testObserversWorkingWithNavigationControllerNonAnimatedTransitions() {
		let navigation = UINavigationController()
		let window = UIWindow(frame: UIScreen.main.bounds)
		window.rootViewController = navigation
		window.makeKeyAndVisible()
		
		let exp = expectation(description: "Wait for lifecycle callbacks")
		let view = UIViewController()
		
		view.onViewWillAppear { [weak view, weak navigation] in
			view?.onViewDidAppear {
				view?.onViewWillDisappear {
					view?.onViewDidDisappear {
						exp.fulfill()
					}
				}
				
				navigation?.setViewControllers([], animated: false)
			}
		}
		
		navigation.pushViewController(view, animated: false)
		wait(for: [exp], timeout: 1)
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
		firesCallback callback: (UIViewController) -> ((@escaping () -> Void) -> Observer), when action: @escaping (UIViewController) -> Void, file: StaticString = #file, line: UInt = #line) {
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
	
	func assertCanRemoveObserver(when action: @escaping (UIViewController) -> Observer, file: StaticString = #file, line: UInt = #line) {
		let sut = UIViewController()
		
		action(sut).remove()
		
		XCTAssertEqual(sut.childViewControllers.count, 0, file: file, line: line)
	}
	
	func assertCanRemoveObserverView(when action: @escaping (UIViewController) -> Observer, file: StaticString = #file, line: UInt = #line) {
		let sut = UIViewController()
		
		action(sut).remove()
		
		XCTAssertEqual(sut.view.subviews.count, 0, file: file, line: line)
	}
}
