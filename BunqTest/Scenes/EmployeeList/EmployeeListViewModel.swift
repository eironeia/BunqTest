//  Created by Alex Cuello on 25/04/2019.
//  Copyright © 2019 eironeia. All rights reserved.

import Foundation

protocol EmployeeListViewModelInterface {
    var employeeList: (([EmployeeListCellDescriptor]) -> Void)? { get set }
    func getEmployeeList()
}

class EmployeeListViewModel: EmployeeListViewModelInterface {

    //MARK: - Stored properties
    private var directory: EmployeeDirectory

    //MARK: - EmployeeListViewModelInterface
    var employeeList: (([EmployeeListCellDescriptor]) -> Void)?

    //MARK: - Init
    init(directory: EmployeeDirectory) {
        self.directory = directory
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateEmployeeList),
                                               name: .employeeDirectoryDidUpdate,
                                               object: nil)
    }

    func getEmployeeList() {
        directory.update()
    }

    @objc
    private func updateEmployeeList() {
        let employees = directory.employees as? [Employee] ?? []
        let cellDescriptor = employees.map { EmployeeListCellDescriptor(name: $0.name,
                                                                        birthday: String(describing: $0.birthYear),
                                                                        salary: $0.salaryWithCurrency()) }
        employeeList?(cellDescriptor)
    }
}
