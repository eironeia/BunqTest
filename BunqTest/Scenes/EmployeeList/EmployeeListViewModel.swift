//  Created by Alex Cuello on 25/04/2019.
//  Copyright © 2019 eironeia. All rights reserved.

import Foundation

protocol EmployeeListViewModelInterface {
    var employeeList: (([EmployeeListCellDescriptor]) -> Void)? { get set }
    func getEmployeeList()
    func sortEmployeeList()
}

class EmployeeListViewModel: EmployeeListViewModelInterface {

    //MARK: - Stored properties
    private var directory: EmployeeDirectory
    private var employees: [Employee] = []

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

    // MARK: - EmployeeListViewModelInterface
    func getEmployeeList() {
        directory.update()
    }

    func sortEmployeeList() {
        employees = employees.sorted { return $0.name < $1.name }
        employeeList?(mapEmployessToCellDescriptor(employees))
    }
}

// MARK: - Private extension
private extension EmployeeListViewModel {
    @objc
    func updateEmployeeList() {
        employees = directory.employees as? [Employee] ?? []
        employeeList?(mapEmployessToCellDescriptor(employees))
    }

    func mapEmployessToCellDescriptor(_ employees: [Employee]) -> [EmployeeListCellDescriptor] {
        return employees.map { EmployeeListCellDescriptor(name: $0.name,
                                                          birthday: String(describing: $0.birthYear),
                                                          salary: $0.salaryWithCurrency()) }
    }
}
