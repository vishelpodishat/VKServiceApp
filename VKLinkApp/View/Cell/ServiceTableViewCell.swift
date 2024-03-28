//
//  ServiceTableViewCell.swift
//  VKLinkApp
//
//  Created by Alisher Saideshov on 28.03.2024.
//

import UIKit

final class ServiceTableViewCell: UITableViewCell {

    // MARK: - Identifer
    static let identifier = String(describing: ServiceTableViewCell.self)

    // MARK: - UI
    private lazy var appImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titlelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        return label
    }()

    private let descriptionlabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()

    private let linkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
extension ServiceTableViewCell {
    // MARK: - Setup Views
    private func setupViews() {
        backgroundColor = .black
        [appImageView, titlelabel, descriptionlabel, linkImageView].forEach(contentView.addView)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            appImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            appImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            appImageView.widthAnchor.constraint(equalToConstant: 56),
            appImageView.heightAnchor.constraint(equalToConstant: 56),

            titlelabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlelabel.leadingAnchor.constraint(equalTo: appImageView.trailingAnchor, constant: 10),

            descriptionlabel.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 8),
            descriptionlabel.leadingAnchor.constraint(equalTo: appImageView.trailingAnchor, constant: 10),
            descriptionlabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionlabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

            linkImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            linkImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
    }
}


// MARK: - Configure
extension ServiceTableViewCell {
    func configure(with model: Service) {
        guard let url = URL(string: model.iconURL) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    self.appImageView.image = UIImage(data: data)
                }
            } else {
                print("\(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()

        titlelabel.text = model.name
        descriptionlabel.text = model.description
    }
}
