//
//  CreationViewController.swift
//  Social Mediafy
//
//  Created by Juan Pablo Martinez Ruiz on 13/05/24.
//

import UIKit

final class CreationViewController: UIViewController {
    private var viewModel: CreationViewModelProtocol
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bold(withSize: .content)
        label.text = viewModel.title
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .normal(withSize: .content)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray.cgColor
        textView.layer.cornerRadius = 8
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    init(viewModel: CreationViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
        bindViewModel()
        
        textView.becomeFirstResponder()
    }
    
    private func setup() {
        navigationItem.title = viewModel.navTitle
        
        view.backgroundColor = .white
        
        let postButton = UIBarButtonItem(barButtonSystemItem: .save,
                                         target: self,
                                         action: #selector(postButtonTap))

        postButton.tintColor = .black
        navigationItem.rightBarButtonItem = postButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector(cancelButtonTap))

        cancelButton.tintColor = .black
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    private func layout() {
        view.addSubview(titleLabel)
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80)
        ])
    }
    
    private func bindViewModel() {
        viewModel.state.bind { state in
            guard let state = state else { return }
            switch state {
            case .success:
                DispatchQueue.main.async { [weak self] in
                    self?.dismiss(animated: true)
                }
            case .loading, .failure:
                break
            }
        }
    }
    
    @objc
    private func postButtonTap() {
        viewModel.sendData(text: textView.text)
    }
    
    @objc
    private func cancelButtonTap() {
        dismiss(animated: true)
    }
}
