//
//  UIViewController.swift
//  Pixel-iOS
//
//  Created by José Donor on 27/11/2018.
//


extension UIViewController {

	/// Top ViewController
	public var topViewController: UIViewController? {

		guard let presentedViewController = presentedViewController else { return nil }

		switch presentedViewController {
		case let navigationController as UINavigationController:
			return navigationController.viewControllers.last?.presentedViewController
		case let tabBarController as UITabBarController:
			return tabBarController.selectedViewController?.presentedViewController
		default:
			return presentedViewController.topViewController
		}

	}

	/// Top most ViewController
	public var topMostViewController: UIViewController? {

		var topMostViewController = self

		while let next = topMostViewController.topViewController {
			topMostViewController = next
		}

		return topMostViewController

	}

}
