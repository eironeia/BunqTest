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
        setupNavigationController()
        setupLayout()
    }

    func setupLayout() {
        view.addSubviewWithAutolayout(tableView)
        tableView.fillSuperview()
        view.addSubviewWithAutolayout(activityIndicator)
        activityIndicator.anchorCenterSuperview()
    }

    func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let sortBarButtonItem = UIBarButtonItem(title: DisplayData.sortText,
                                                style: .plain,
                                                target: self,
                                                action: #selector(sortEmployeeList))
        sortBarButtonItem.tintColor = DisplayData.barButtonItemTintColor
        navigationItem.rightBarButtonItem = sortBarButtonItem
        title = DisplayData.employeesText
        navigationController?.navigationBar.barTintColor = DisplayData.navigationBarTintColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : DisplayData.navigationBarTitleColor]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : DisplayData.navigationBarTitleColor]
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
        DispatchQueue.global().async {
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

// MARK: - DisplayData
private extension EmployeeListViewController {
    enum DisplayData {
        //text
        static var employeesText: String { return "Employees" }
        static var sortText: String { return "Sort" }
        //colors
        static var barButtonItemTintColor: UIColor { return .init(hex: 0x9eed5e) }
        static var navigationBarTintColor: UIColor { return .init(hex: 0x1d8745) }
        static var navigationBarTitleColor: UIColor { return .init(hex: 0x9eed5e) }
    }
}
