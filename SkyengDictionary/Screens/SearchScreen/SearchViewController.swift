import UIKit

class SearchViewController: UIViewController {
    
    var viewModel = SearchViewModel()
    
    // MARK: Views
    private lazy var searchTextField: UITextField = {
        let searchTextField = UITextField()
        searchTextField.placeholder = LocalizeStrings.SearchScreen.search
        searchTextField.setupLeftImage()
        searchTextField.borderStyle = .roundedRect
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.delegate = self
        return searchTextField
    }()
    
    private lazy var cameraIconButton: UIButton = {
        let button = UIButton()
        let image = Constants.UI.Images.cameraIcon
        button.setBackgroundImage(image, for: .normal)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUserInterface()
        makeConstraints()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    private func setupUserInterface() {
        view.backgroundColor = .systemBackground
        view.addSubviewForAutoLayout(searchTextField)
        view.addSubviewForAutoLayout(cameraIconButton)
        view.addSubviewForAutoLayout(tableView)
    }
    
    private func makeConstraints() {
       
        NSLayoutConstraint.activate([
            searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.UI.Layout.defaultPadding),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
       
            cameraIconButton.leftAnchor.constraint(equalTo: searchTextField.rightAnchor, constant: Constants.UI.Layout.defaultPadding),
            cameraIconButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -Constants.UI.Layout.defaultPadding),
            cameraIconButton.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor),
        
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor)
        ])
    }
}

// MARK: SearchViewModelDelegate
extension SearchViewController: SearchViewModelDelegate {
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            self.viewModel.searchWord = updatedText
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.words.count
    }
    
    func tableView(_ tableView: UITableView,leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favorite = createContextualAction(title: LocalizeStrings.SearchScreen.favorite,
                                              style: .normal,
                                              color: .systemBlue,
                                              systemImageName: "star.fill") {
            self.handleMarkAsFavourite(indexPath: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let trash = createContextualAction(title: LocalizeStrings.SearchScreen.delete,
                                           style: .destructive,
                                           color: .red,
                                           systemImageName: "trash") {
            self.handleMoveToTrash(indexPath: indexPath)
        }

        let history = createContextualAction(title: LocalizeStrings.SearchScreen.history,
                                             style: .destructive,
                                             color: .orange,
                                             systemImageName: "clock") {
            self.handleMoveToHistory()
        }
        return UISwipeActionsConfiguration(actions: [trash,history])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedWord = viewModel.words[indexPath.row]

        let controller = TranslationViewController()
        controller.title = selectedWord
        controller.viewModel.meaning = viewModel.translations[indexPath.row].meanings
        controller.viewModel.imageURL = viewModel.translations[indexPath.row].meanings.first?.imageUrl

        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell else {
            return  UITableViewCell()
        }
        let dataTranslation = viewModel.getWordsAndMeaning(in: indexPath.row)
        
        cell.configureCell(text: dataTranslation.text,
                           translation: dataTranslation.meaning)
        
        return cell
    }
}


extension SearchViewController {
        
    func createContextualAction(
        title: String,
        style: UIContextualAction.Style,
        color: UIColor,
        systemImageName: String,
        action: @escaping () -> Void?
    ) -> UIContextualAction {
        let action = UIContextualAction(style: style,
                                        title: title) { [weak self] _, _, completionHandler in
            action()
            completionHandler(true)
        }
        action.backgroundColor = color
        action.image = UIImage(systemName: systemImageName )
        
        return action
    }
    
    func handleMarkAsFavourite(indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SearchCell {
            cell.getStarImage.isHidden = false
        }
        print("Favorite")
    }
    func handleMoveToTrash(indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SearchCell,
           let removedText = cell.getTitle,
           let index = viewModel.words.firstIndex(of: removedText)
        {
            viewModel.words.remove(at: index)
        }
        print("Delete")
    }
    func handleMoveToHistory() {
        print("Moved to history")
    }
}
