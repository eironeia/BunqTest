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
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView()
        tableView.register(EmployeeListCell.self, forCellReuseIdentifier: EmployeeListCell.identifier)
        return tableView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        setupUI()
        bindViewModel()
    }
}

// MARK: - Private extension
private extension EmployeeListViewController {
    func setupUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(sortEmployeeList))
        title = "Employees"
        setupLayout()
    }

    func setupLayout() {
        view.addSubviewWithAutolayout(tableView)
        tableView.fillSuperview()
        view.addSubviewWithAutolayout(activityIndicator)
        activityIndicator.anchorCenterSuperview()
    }

    func bindViewModel() {
        viewModel.employeeList = { [weak self] employeList in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.datasource = employeList
                self?.tableView.reloadData()
            }
        }

        viewModel.getEmployeeList()
    }

    @objc
    func sortEmployeeList() {
        DispatchQueue.main.async {
            self.viewModel.sortEmployeeList()
        }
    }
}

// MARK: - TableViewDatasource
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
