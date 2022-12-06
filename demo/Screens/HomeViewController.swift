//
//  ViewController.swift
//  demo
//
//  Created by 平石　太郎 on 2022/12/07.
//

import UIKit
import Combine
import THLogger

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let viewModel: HomeViewModel = .init()
    
    private var cancellables: Set<AnyCancellable> = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        subscribeRepositories()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

// MARK: - SUBSCRIBE
extension HomeViewController {
    private func subscribeRepositories() {
        viewModel.githubReposSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] repositories in
                guard let self = self else { return }
                
                THLogger.debug(repositories.count)
                
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// MARK: - SETUP
extension HomeViewController {
    private func setup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            .init(nibName: "TableViewCell", bundle: nil),
            forCellReuseIdentifier: "TableViewCell"
        )
        
        searchBar.searchTextField.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.githubReposSubject.value.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        else { return .init() }
        
        let repository = viewModel.githubReposSubject.value[indexPath.row]
        cell.setup(repository: repository)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        viewModel.onSearchRepositories(text)
        textField.resignFirstResponder()
        return true
    }
}
