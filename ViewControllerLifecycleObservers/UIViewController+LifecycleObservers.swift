//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import UIKit

public protocol Observer {
	func remove()
}

public extension UIViewController {
	@discardableResult
	public func onViewWillAppear(run callback: @escaping () -> Void) -> Observer {
		return ViewControllerLifecycleObserver(
			parent: self,
			viewWillAppearCallback: callback
		)
	}
	
	@discardableResult
	public func onViewDidAppear(run callback: @escaping () -> Void) -> Observer {
		return ViewControllerLifecycleObserver(
			parent: self,
			viewDidAppearCallback: callback
		)
	}
	
	@discardableResult
	public func onViewWillDisappear(run callback: @escaping () -> Void) -> Observer {
		return ViewControllerLifecycleObserver(
			parent: self,
			viewWillDisappearCallback: callback
		)
	}
	
	@discardableResult
	public func onViewDidDisappear(run callback: @escaping () -> Void) -> Observer {
		return ViewControllerLifecycleObserver(
			parent: self,
			viewDidDisappearCallback: callback
		)
	}
}

private class ViewControllerLifecycleObserver: UIViewController, Observer {
	private var viewWillAppearCallback: () -> Void = {}
	private var viewDidAppearCallback: () -> Void = {}

	private var viewWillDisappearCallback: () -> Void = {}
	private var viewDidDisappearCallback: () -> Void = {}

	convenience init(
		parent: UIViewController,
		viewWillAppearCallback: @escaping () -> Void = {},
		viewDidAppearCallback: @escaping () -> Void = {},
		viewWillDisappearCallback: @escaping () -> Void = {},
		viewDidDisappearCallback: @escaping () -> Void = {}) {
		self.init()
		self.add(to: parent)
		self.viewWillAppearCallback = viewWillAppearCallback
		self.viewDidAppearCallback = viewDidAppearCallback
		self.viewWillDisappearCallback = viewWillDisappearCallback
		self.viewDidDisappearCallback = viewDidDisappearCallback
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		viewWillAppearCallback()
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		viewDidAppearCallback()
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		viewWillDisappearCallback()
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		
		viewDidDisappearCallback()
	}

	private func add(to parent: UIViewController) {
		parent.addChildViewController(self)
		view.isHidden = true
		parent.view.addSubview(view)
		didMove(toParentViewController: parent)
	}

	func remove() {
		willMove(toParentViewController: nil)
		view.removeFromSuperview()
		removeFromParentViewController()
	}
}
