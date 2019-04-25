//  Created by Alex Cuello on 25/04/2019.
//  Copyright © 2019 eironeia. All rights reserved.

import Foundation

protocol EmployeeListViewModelInterface {
    var employeeList: [Employee] { get }
}

struct EmployeeListViewModel: EmployeeListViewModelInterface {

    //MARK: - Stored properties
    private var directory: EmployeDirectoryInterface

    //MARK: - EmployeeListViewModelInterface
    var employeeList: [Employee] {
        return directory.employees as? [Employee] ?? [] //TODO: Test
    }

    //MARK: - Init
    init(directory: EmployeDirectoryInterface) {
        self.directory = directory
    }
}
