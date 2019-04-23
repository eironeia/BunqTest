//
//  ViewController.swift
//  BunqTest
//
//  Created by Alex Cuello on 23/04/2019.
//  Copyright © 2019 eironeia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let ed = EmployeeDirectory()

    override func viewDidLoad() {
        super.viewDidLoad()
        ed.update()
        NotificationCenter.default.addObserver(self, selector: #selector(printEmployees), name: .employeeDirectoryDidUpdate, object: nil)

    }

    @objc
    func printEmployees() {
        let employees = ed.employees as! [Employee]
        let employee = employees.first!
        employee.salaryWithCurrency()
        
//        employees.forEach { print($0.name) }


    }
}

extension Employee {

    func magic() {
        
    }
}
