//
//  DetailViewController.swift
//  Someone's gram
//
//  Created by Иван Тарасенко on 20.03.2025.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private lazy var fullImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        return image
    }()
    
   private lazy var shareButton = UIBarButtonItem(
        barButtonSystemItem: .action,
        target: self,
        action: #selector(DetailViewController.shareButtonTapped)
    )
    
    private lazy var saveButton = UIBarButtonItem(
        barButtonSystemItem: .save,
        target: self,
        action: #selector(DetailViewController.saveButtonTapped)
    )
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    var urlImage: String?
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonNavBar()
        configureView()
        setImage(imageURL: urlImage)
        view.backgroundColor = .white
    }
    
    // MARK: - Actions
    @objc private func shareButtonTapped() {
        guard let image = fullImage.image else { return }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }

    @objc private func saveButtonTapped() {
        guard let image = fullImage.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            AlertService.shared.showAlert(title: "Внимание", massage: "Изображение успешно сохранено в фотобиблиотеку.")
        }
    }
}


// MARK: - Configuration
private extension DetailViewController {
    
    func setImage(imageURL: String?) {
        guard let imageURL = imageURL else { return }
//        fullImage.image = nil
        activityIndicator.startAnimating()
        NetworkService.shared.loadImage(from: imageURL, into: fullImage) { [weak self] in
            guard let self = self else { return }
            remoteActivityIndicator()
        }
    }
    
     func configureView() {
        view.addSubview(fullImage)
         fullImage.frame = view.bounds
         
         view.addSubview(activityIndicator)
         NSLayoutConstraint.activate([
             activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
         ])
    }

     func addButtonNavBar() {
        navigationItem.rightBarButtonItems = [shareButton, saveButton]
    }
    
    func remoteActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
}
