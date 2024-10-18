//
//  SearchContainerView.swift
//  MoviesApp
//
//  Created by Tami on 18.10.2024.
//

import UIKit
import SnapKit


protocol SearchContainerViewDelegate: AnyObject {
    func searchCompleted(word: String)
    func clearButtonTapped(isTapped: Bool)
}

final class SearchContainerView: UIView {
    
    private let searchViewController: SearchViewController = SearchViewController()
    
    var delegate: SearchContainerViewDelegate?
    
    private lazy var searchIconImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(systemName: "magnifyingglass")
    }
    
    private lazy var searchBarTextField: UITextField = UITextField().then {
        $0.placeholder = "Search"
        $0.backgroundColor = UIColor.systemGray5
        $0.layer.cornerRadius = 14
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textColor = UIColor.label
        $0.leftViewMode = .always
        $0.layer.borderColor = UIColor.systemGray.cgColor
        $0.clearButtonMode = .whileEditing
        $0.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupSearchTextfieldFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("did not instantiate coder")
    }
    
    private func setupViews() {
        searchBarTextField.addSubview(searchIconImageView)
        self.addSubview(searchBarTextField)
    }
    
    private func setupConstraints() {
        searchBarTextField.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalToSuperview()
        }
        
        searchIconImageView.snp.makeConstraints {
            $0.leading.top.equalTo(16.25)
            $0.height.width.equalTo(15.5)
        }
    }
    
    private func setupSearchTextfieldFrame() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: self.frame.height))
        searchBarTextField.leftView = paddingView
    }
}

extension SearchContainerView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let currentText = textField.text,
           let textRange = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            if !updatedText.isEmpty {
                delegate?.searchCompleted(word: updatedText)
            } else {
                delegate?.searchCompleted(word: "")
            }
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        delegate?.clearButtonTapped(isTapped: true)
        return true
    }
}
