import UIKit

class MeaningCell: UITableViewCell {
   
    static let identifier = "MeaningCell"
    
    //MARK: Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var cellContentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel,
                                                   subtitleLabel])
        stack.axis = .vertical
        stack.spacing = Constants.UI.Layout.contentSpacing
        stack.distribution = .equalCentering
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUserInterface()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    public func configureCell(text: String, translation: String) {
        titleLabel.text = text
        subtitleLabel.text = translation
    }
    
    private func setupUserInterface() {
        contentView.addSubview(cellContentStackView)
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            cellContentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.UI.Layout.defaultOffset),
            cellContentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor , constant: Constants.UI.Layout.defaultPadding),
            cellContentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.UI.Layout.defaultOffset)
        ])
    }
}

