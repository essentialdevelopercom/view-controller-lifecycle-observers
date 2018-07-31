//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import UIKit

public protocol UIViewControllerLifecycleObserver {
	func remove()
}

public extension UIViewController {
	public typealias Observer = UIViewControllerLifecycleObserver

	@discardableResult
	public func onViewWillAppear(run callback: @escaping () -> Void) -> Observer {
		return ViewControllerLifecycleObserver(
			parent: self,
			viewWillAppearCallback: callback
		)
	}
}

private class ViewControllerLifecycleObserver: UIViewController, UIViewControllerLifecycleObserver {
	private var viewWillAppearCallback: () -> Void = {}
	
	convenience init(
		parent: UIViewController,
		viewWillAppearCallback: @escaping () -> Void = {}) {
		self.init()
		self.add(to: parent)
		self.viewWillAppearCallback = viewWillAppearCallback
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		viewWillAppearCallback()
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
