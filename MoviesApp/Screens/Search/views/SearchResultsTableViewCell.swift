//
//  SearchResultsTableViewCell.swift
//  MoviesApp
//
//  Created by Tami on 18.10.2024.
//

import UIKit

final class SearchResultTableViewCell: UITableViewCell {
    
    enum Constants {
        static let reuseID = String(describing: SearchResultTableViewCell.self)
    }
    
    private let moviemageView: UIImageView = UIImageView().then {
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.image = UIImage(named: "no-photo")
    }
    
    private let movieNameLabel: UILabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = UIColor.label
        $0.lineBreakMode = .byWordWrapping
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 0.7
        $0.backgroundColor = UIColor.systemBackground
    }
    
    private let movieYearLabel: UILabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = UIColor.secondaryLabel
    }
    
    private let infoStackView: UIStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 8
    }
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubviews([moviemageView,infoStackView])
        infoStackView.addArrangedSubviews([movieNameLabel,movieYearLabel])
    }
        
    private func setupConstraints() {
        moviemageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-8)
            $0.size.equalTo(50)
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(11.5)
            $0.leading.equalTo(moviemageView.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-11.5)
        }
        
        movieNameLabel.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        
        movieYearLabel.snp.makeConstraints {
            $0.height.equalTo(17)
        }
    }
    
    func configureData(movie: Movie) {
        movieNameLabel.text = movie.title
        movieYearLabel.text = movie.year
    }
}
