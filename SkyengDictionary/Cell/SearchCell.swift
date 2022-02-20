import UIKit

class SearchCell: UITableViewCell {
    
    static let identifier = "SearchCell"
    
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
    
    private lazy var starImage: UIImageView = {
        let image = Constants.UI.Images.starIcon
        let imageView = UIImageView(image: image)
        imageView.isHidden = true
        return imageView
    }()

    private lazy var countClickLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var  soundIconButton: UIButton = {
        let soundIconButton = UIButton()
        let soundIconImage = Constants.UI.Images.speakerIcon
        soundIconButton.setBackgroundImage(soundIconImage, for: .normal)
        soundIconButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        return soundIconButton
    }()

    private lazy var  infoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [soundIconButton,
                                                   countClickLabel])
        stack.distribution = .fillEqually

        stack.spacing = 16
        stack.spacing = Constants.UI.Layout.defaultOffset
        return stack
    }()
    
    private lazy var cellContentStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel,
                                                   subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .equalCentering
        stack.alignment = .leading
        return stack
    }()
    
    public var getTitle: String? {
         titleLabel.text
    }
    
    public var getStarImage: UIImageView {
         starImage
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUserInterface()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func pressed() {
        print("tap")
    }
    
    
    public func configureCell(text: String, translation: String) {
        titleLabel.text = text
        subtitleLabel.text = translation
    }
    
    private func setupUserInterface() {
        contentView.addSubviewForAutoLayout(titleLabel)
        contentView.addSubviewForAutoLayout(subtitleLabel)
        contentView.addSubviewForAutoLayout(starImage)
        contentView.addSubviewForAutoLayout(infoStackView)
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            cellContentStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor , constant: Constants.UI.Layout.defaultPadding),
            cellContentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.UI.Layout.defaultOffset),
            cellContentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.UI.Layout.defaultOffset),

            starImage.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: Constants.UI.Layout.defaultOffset),
            starImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

            infoStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.UI.Layout.defaultPadding),
            infoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}


