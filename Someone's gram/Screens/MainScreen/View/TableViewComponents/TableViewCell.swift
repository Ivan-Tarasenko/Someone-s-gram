//
//  TableViewCell.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 19.03.2025.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var onTapLike: (() -> Void)?
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .systemGray
        imageView.layer.cornerRadius = 22
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
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(tapLike), for: .touchUpInside)
        return button
    }()
    
    private lazy var numberOfLikesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        return label
    }()
    
    private lazy var createdDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray2
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
    
    private lazy var skeletonView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
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
        
        onTapLike?()
        
        let isLiked = likeButton.tintColor == .systemRed
        let newColor: UIColor = isLiked ? .systemGray : .systemRed
        let newImage = UIImage(systemName: isLiked ? "heart" : "heart.fill")
        
        UIView.animate(withDuration: 0.2, animations: {
            self.likeButton.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { _ in
            
            UIView.animate(withDuration: 0.2) {
                self.likeButton.transform = .identity
                self.likeButton.setImage(newImage, for: .normal)
                self.likeButton.tintColor = newColor
            }
        }
    }
    
    
    // MARK: - SettingData
    func setAvatar(imageURL: String?) {
        guard let imageURL = imageURL else { return }
        NetworkService.shared.loadImage(from: imageURL, into: avatarImageView)
    }
    
    func setName(_ name: String?) {
        nameLabel.text = name
    }
    
    func setImage(imageURL: String?) {
        guard let imageURL = imageURL else { return }
        showSkeletonLoader()
        startSkeletonAnimation()
        
        NetworkService.shared.loadImage(from: imageURL, into: image) { [weak self] in
            guard let self = self else { return }
            hideSkeletonLoader()
        }
    }
    
    func setDescription(_ description: String?) {
        if description == nil {
            descriptionLabel.textColor = .systemGray2
            descriptionLabel.text = "No description"
        } else {
            descriptionLabel.textColor = .black
            descriptionLabel.text = description
        }
    }
    
    func setNumberOfLikes(_ numberOfLikes: Int64) {
        numberOfLikesLabel.text = "\(numberOfLikes)"
    }
    
    func isLiked(_ isLiked: Bool) {
        let newColor: UIColor = isLiked ? .systemRed : .systemGray
        let newImage = UIImage(systemName: isLiked ? "heart.fill" : "heart")
        likeButton.setImage(newImage, for: .normal)
        likeButton.tintColor = newColor
    }
    
    func setCreatedDate(_ createdDate: String?) {
        guard let createdDate else { return }
        let isoDateFormatter = ISO8601DateFormatter()
        if let date = isoDateFormatter.date(from: createdDate) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let formattedDate = formatter.string(from: date)
            createdDateLabel.text = "Created: \(formattedDate)"
        }
    }
    
    func putALike(in post: PostEntity) {
        post.isLiked.toggle()
        post.likes += post.isLiked ? 1 : -1
        CoreDataService.shared.saveContext()
        numberOfLikesLabel.text = "\(post.likes)"
    }
}


// MARK: - Configuration
private extension TableViewCell {
    
    func configereUI() {
        selectionStyle = .none
    }
    
    private func startSkeletonAnimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1
        animation.toValue = 0.5
        animation.duration = 0.8
        animation.autoreverses = true
        animation.repeatCount = .infinity
        skeletonView.layer.add(animation, forKey: "skeletonAnimation")
    }
    
    func showSkeletonLoader() {
        image.image = nil
        skeletonView.isHidden = false
    }

    func hideSkeletonLoader() {
        skeletonView.isHidden = true
        image.backgroundColor = .clear
        skeletonView.layer.removeAllAnimations()
    }
    
    func configereConstraints() {
        contentView.addSubview(avatarImageView)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatarImageView.widthAnchor.constraint(equalToConstant: 44),
            avatarImageView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        contentView.addSubview(image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            image.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        contentView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        contentView.addSubview(likeButton)
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            likeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            likeButton.widthAnchor.constraint(equalToConstant: 44),
            likeButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        contentView.addSubview(numberOfLikesLabel)
        NSLayoutConstraint.activate([
            numberOfLikesLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            numberOfLikesLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor),
            numberOfLikesLabel.widthAnchor.constraint(equalToConstant: 50),
            
        ])
        
        contentView.addSubview(createdDateLabel)
        NSLayoutConstraint.activate([
            createdDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            createdDateLabel.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor)
        ])
        
        contentView.addSubview(skeletonView)
        NSLayoutConstraint.activate([
            skeletonView.topAnchor.constraint(equalTo: image.topAnchor),
            skeletonView.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            skeletonView.trailingAnchor.constraint(equalTo: image.trailingAnchor),
            skeletonView.bottomAnchor.constraint(equalTo: image.bottomAnchor)
        ])
    }
}
