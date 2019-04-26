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
        stackView.spacing = 2
        stackView.axis = .vertical
        return stackView
    }()

    private let name: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        return label
    }()

    private let attributesContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.axis = .horizontal
        return stackView
    }()

    private lazy var birthday: UILabel = getAttributeLabel()
    private lazy var salary: UILabel = {
        let label = getAttributeLabel()
        label.textAlignment = .right
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
        container.fillSuperview(withEdges: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        [name, attributesContainer].forEach(container.addArrangedSubview)
        [birthday, salary].forEach(attributesContainer.addArrangedSubview)
    }

    func getAttributeLabel() -> UILabel {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        return label
    }
}
