//  Created by Alex Cuello on 23/04/2019.
//  Copyright © 2019 eironeia. All rights reserved./

import UIKit

class EmployeeListViewController: UIViewController {

    // MARK: - Stored properties
    private var datasource: [EmployeeListCellDescriptor] = []

    // MARK: - Relationship
    var viewModel: EmployeeListViewModelInterface!

    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(EmployeeListCell.self, forCellReuseIdentifier: EmployeeListCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
}

// MARK: - Private extension
private extension EmployeeListViewController {
    func setupUI() {
        setupLayout()
    }

    func setupLayout() {
        view.addSubviewWithAutolayout(tableView)
        tableView.fillSuperview()
    }

    func bindViewModel() {
        viewModel.employeeList = { [weak self] employeList in
            self?.datasource = employeList
            self?.tableView.reloadData()
        }

        viewModel.getEmployeeList()
    }
}

extension EmployeeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeListCell.identifier) as? EmployeeListCell else {
            assertionFailure("Wrong cell identifier")
            return UITableViewCell()
        }
        cell.setup(descriptor: datasource[indexPath.row])
        return cell
    }


}
