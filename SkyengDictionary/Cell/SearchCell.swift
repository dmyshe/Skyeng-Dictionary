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
        let soundIconImage = UIImage(systemName: "speaker.2.fill")?.withTintColor(.black,renderingMode: .alwaysOriginal)
        soundIconButton.setBackgroundImage(soundIconImage, for: .normal)
        soundIconButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        return soundIconButton
    }()

    private lazy var  infoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [soundIconButton,
                                                   countClickLabel])
        stack.distribution = .fillEqually
        stack.spacing = 16
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
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor , constant: Constants.UI.Layout.defaultPadding),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10 ),

            subtitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.UI.Layout.defaultPadding),
            subtitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10),

            starImage.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 10),
            starImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),

            infoStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.UI.Layout.defaultPadding),
            infoStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}


