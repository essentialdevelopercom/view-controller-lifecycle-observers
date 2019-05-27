//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import UIKit

public protocol Observer {
	func remove()
}

public extension UIViewController {
    
    /// Event that notifies the view controller is about to be added to a view hierarchy.
    ///
    /// - Parameter callback: The closure to execute.
    /// - Returns: The observer for unsubscribing to event.
	@discardableResult
	func onViewWillAppear(run callback: @escaping () -> Void) -> Observer {
		return ViewControllerLifecycleObserver(
			parent: self,
			viewWillAppearCallback: callback
		)
	}
	
    /// Event that notifies the view controller was added to a view hierarchy.
    ///
    /// - Parameter callback: The closure to execute.
    /// - Returns: The observer for unsubscribing to event.
	@discardableResult
	func onViewDidAppear(run callback: @escaping () -> Void) -> Observer {
		return ViewControllerLifecycleObserver(
			parent: self,
			viewDidAppearCallback: callback
		)
	}
	
    /// Event that notifies the view controller is about to be removed from a view hierarchy.
    ///
    /// - Parameter callback: The closure to execute.
    /// - Returns: The observer for unsubscribing to event.
	@discardableResult
	func onViewWillDisappear(run callback: @escaping () -> Void) -> Observer {
		return ViewControllerLifecycleObserver(
			parent: self,
			viewWillDisappearCallback: callback
		)
	}
	
    /// Event that notifies the view controller was removed from a view hierarchy.
    ///
    /// - Parameter callback: The closure to execute.
    /// - Returns: The observer for unsubscribing to event.
	@discardableResult
	func onViewDidDisappear(run callback: @escaping () -> Void) -> Observer {
		return ViewControllerLifecycleObserver(
			parent: self,
			viewDidDisappearCallback: callback
		)
	}
}

private class ViewControllerLifecycleObserver: UIViewController, Observer {
	private var viewWillAppearCallback: (() -> Void)? = nil
	private var viewDidAppearCallback: (() -> Void)? = nil

	private var viewWillDisappearCallback: (() -> Void)? = nil
	private var viewDidDisappearCallback: (() -> Void)? = nil

	convenience init(
		parent: UIViewController,
		viewWillAppearCallback: (() -> Void)? = nil,
		viewDidAppearCallback: (() -> Void)? = nil,
		viewWillDisappearCallback: (() -> Void)? = nil,
		viewDidDisappearCallback: (() -> Void)? = nil) {
		self.init()
		self.add(to: parent)
		self.viewWillAppearCallback = viewWillAppearCallback
		self.viewDidAppearCallback = viewDidAppearCallback
		self.viewWillDisappearCallback = viewWillDisappearCallback
		self.viewDidDisappearCallback = viewDidDisappearCallback
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		viewWillAppearCallback?()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		viewDidAppearCallback?()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		viewWillDisappearCallback?()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		viewDidDisappearCallback?()
	}

	private func add(to parent: UIViewController) {
		parent.addChild(self)
		view.isHidden = true
		parent.view.addSubview(view)
		didMove(toParent: parent)
	}

	func remove() {
		willMove(toParent: nil)
		view.removeFromSuperview()
		removeFromParent()
	}
}
