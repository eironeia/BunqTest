//  Created by Alex Cuello on 23/04/2019.
//  Copyright © 2019 eironeia. All rights reserved./

import UIKit

class EmployeeListViewController: UIViewController {

    let ed = EmployeeDirectory()
    var viewModel: EmployeeListViewModelInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        ed.update()
        NotificationCenter.default.addObserver(self, selector: #selector(printEmployees), name: .employeeDirectoryDidUpdate, object: nil)
        view.backgroundColor = .lightGray
    }

    @objc
    func printEmployees() {
        let employees = ed.employees as! [Employee]
        let employee = employees.first!
        employee.salaryWithCurrency()
        
//        employees.forEach { print($0.name) }
    }
}
