//
//  Copyright © 2018 Essential Developer. All rights reserved.
//

import UIKit

protocol UIViewControllerLifecycleObserver {
	func remove()
}

extension UIViewController {
	@discardableResult
	func onViewWillAppear(run callback: @escaping () -> Void) -> UIViewControllerLifecycleObserver {
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
		super.viewWillAppear(false)
		
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
