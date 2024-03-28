//
//  ViewController.swift
//  VKLinkApp
//
//  Created by Alisher Saideshov on 28.03.2024.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - ViewModel
    private let viewModel = ViewModel()

    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ServiceTableViewCell.self,
                           forCellReuseIdentifier: ServiceTableViewCell.identifier)
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
        viewModel.fetchData {
            self.tableView.reloadData()
        }
    }
}

extension ViewController {
    // MARK: - Setup Views
    private func setupViews() {
        title = "Сервисы"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .black
        view.addSubview(tableView)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}


// MARK: - TableView Delegate and Data Source
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.services.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTableViewCell.identifier,
                                                 for: indexPath) as? ServiceTableViewCell else {
            fatalError("Something went wrong with tableview")
        }
        let service = viewModel.services[indexPath.row]
        cell.configure(with: service)
        return cell
    }

    // MARK: - Selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let service = viewModel.services[indexPath.row]
        if let url = URL(string: service.link), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Cannot open URL: \(service.link)")
        }
    }
}
