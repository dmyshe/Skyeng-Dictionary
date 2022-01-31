import UIKit

class TranslationViewController: UIViewController {
    
    var viewModel = TranslationViewModel()
    
    // MARK: Views
    private lazy var imageView: UIImageView = {
        let imageContainter = UIImageView()
        imageContainter.translatesAutoresizingMaskIntoConstraints = false
        return imageContainter
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(MeaningCell.self, forCellReuseIdentifier: MeaningCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserInterface()
        makeConstraints()
        configureImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func configureImage() {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let imageData = self.viewModel.getImageData(from: self.viewModel.imageURL ?? "") else { return }

            DispatchQueue.main.async {
                self.imageView.image =  UIImage(data: imageData)
            }
        }
    }
    
    private func setupUserInterface() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(tableView)
    }
    
    private func makeConstraints() {
     
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: Constants.UI.Layout.defaultPadding),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
  
            tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 30),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension TranslationViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.meaning.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == viewModel.selectedIndex {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MeaningCell.identifier, for: indexPath) as? MeaningCell else {
                return  UITableViewCell()
            }
            let dataTranslation = viewModel.getTranslationAndTranscription(in: indexPath.row)
            cell.configureCell(text: dataTranslation.text,
                               translation: dataTranslation.transcription)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.meaning[indexPath.row].translation.text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedRow = viewModel.selectedIndex {
            viewModel.previousSelectedIndex = selectedRow
        }
        viewModel.selectedIndex = indexPath.row
        
        let modifiedRows: [Int] = [viewModel.previousSelectedIndex, viewModel.selectedIndex].compactMap { $0 }
        let indexes: [IndexPath] = modifiedRows.map { IndexPath(row: $0, section: 0) }
        
        tableView.reloadRows(at: indexes, with: .automatic)
        tableView.layoutIfNeeded()
    }
}
