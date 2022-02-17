import UIKit

class MeaningCell: UITableViewCell {
   
    static let identifier = "MeaningCell"
    
    //MARK: Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        return label
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
        contentView.addSubviewForAutoLayout(titleLabel)
        contentView.addSubviewForAutoLayout(subtitleLabel)
    }
    
    private func makeConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor , constant: Constants.UI.Layout.defaultPadding),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10 ),
     
            subtitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.UI.Layout.defaultPadding),
            subtitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10)
        ])
    }
}

