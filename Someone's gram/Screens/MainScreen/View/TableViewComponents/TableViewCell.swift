//
//  TableViewCell.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 19.03.2025.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle")
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    
    private lazy var image: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .ekaterina02
        return imageView
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapLike), for: .touchUpInside)
        return button
    }()
    
    private lazy var discriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription Discription"
        return label
    }()
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configereUI()
        configereConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    @objc func tapLike() {
        print("Like tapped")
    }
}

// MARK: - Configere
private extension TableViewCell {
    
    func configereUI() {
        selectionStyle = .none
    }
    
    func configereConstraints() {
        addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            avatarImageView.widthAnchor.constraint(equalToConstant: 44),
            avatarImageView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
        
        addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
        
        addSubview(discriptionLabel)
        NSLayoutConstraint.activate([
            discriptionLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            discriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            discriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            discriptionLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        contentView.addSubview(likeButton)
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: discriptionLabel.bottomAnchor, constant: 8),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            likeButton.widthAnchor.constraint(equalToConstant: 44),
            likeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
