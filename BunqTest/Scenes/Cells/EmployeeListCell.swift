//  Created by Alex Cuello on 25/04/2019.
//  Copyright © 2019 eironeia. All rights reserved.

import UIKit

struct EmployeeListCellDescriptor {
    let name: String
    let birthday: String
    let salary: String
}

class EmployeeListCell: UITableViewCell {

    // MARK: - UI
    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()

    private let name: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center   
        return label
    }()

    private let attributesContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var birthday: UILabel = getAttributeLabel()
    private lazy var salary: UILabel = getAttributeLabel()
    private lazy var birthdayTitle: UILabel = {
        let label = getAttributeTitleLabel()
        label.text = "Birthday"
        return label
    }()

    private lazy var salaryTitle: UILabel = {
        let label = getAttributeTitleLabel()
        label.text = "Salary"
        return label
    }()



    // MARK: - Stored properties
    static var identifier = String(describing: EmployeeListCell.self)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    // MARK: - Setup
    func setup(descriptor: EmployeeListCellDescriptor) {
        name.text = descriptor.name
        birthday.text = descriptor.birthday
        salary.text = descriptor.salary
    }
}

private extension EmployeeListCell {
    func setupUI() {

        setupLayout()
    }

    func setupLayout() {
        addSubviewWithAutolayout(container)
        container.fillSuperview(withEdges: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        container.addArrangedSubview(name)
        container.addArrangedSubview(attributesContainer)

        [(birthday, birthdayTitle), (salary, salaryTitle)].forEach { (value, title) in
            let container = getAttributeContainer()
            container.addArrangedSubview(value)
            container.addArrangedSubview(title)
            attributesContainer.addArrangedSubview(container)
        }
    }

    func getAttributeLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
    }

    func getAttributeTitleLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.required, for: .vertical)
        return label
    }

    func getAttributeContainer() -> UIStackView {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }


}
