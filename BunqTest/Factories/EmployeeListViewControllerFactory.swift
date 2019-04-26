//  Created by Alex Cuello on 25/04/2019.
//  Copyright © 2019 eironeia. All rights reserved.

import UIKit

protocol EmployeeListViewControllerFactoryInterface {
    func getEmployeeListViewController() -> UIViewController
}

struct EmployeeListViewControllerFactory: EmployeeListViewControllerFactoryInterface {
    func getEmployeeListViewController() -> UIViewController {
        let directory = EmployeeDirectory()
        let viewModel = EmployeeListViewModel(directory: directory)
        let viewController = EmployeeListViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
