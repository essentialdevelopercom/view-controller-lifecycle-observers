# UIViewController Lifecycle Observers

[![Build Status](https://travis-ci.com/essentialdevelopercom/view-controller-lifecycle-observers.svg?branch=master)](https://travis-ci.com/essentialdevelopercom/view-controller-lifecycle-observers)

Useful UIViewController extension for composing/creating reusable view controllers – no swizzling or subclassing needed! Learn more at: https://www.essentialdeveloper.com/articles/composing-view-controllers-part-3-lifecycle-observers-in-swift 

```
controller.onViewWillAppear {
    print("viewWillAppear was called!")
}
```

This extension is very useful when composing view controllers with other modules. For example:

```
let analytics = ItemsAnalytics()
itemsListController.onViewDidAppear(run: analytics.reportListPageView)
```

You can also stop receiving messages by removing observers:

```
let service = ItemsService()
let observer = controller.onViewWillAppear(run: service.reloadItems)
observer.remove()
```
