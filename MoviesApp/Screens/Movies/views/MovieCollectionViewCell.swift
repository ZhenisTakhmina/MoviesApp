//
//  MovieCollectionViewCell.swift
//  MoviesApp
//
//  Created by Tami on 17.10.2024.
//

import UIKit
import Then

final class MovieCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = String(describing: MovieCollectionViewCell.self)
    
    private let movieImageView: UIImageView = .init().then {
        $0.image = UIImage(named: "ex_icon")
        $0.layer.cornerRadius = 16
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let movieTitle: UILabel = .init().then{
        $0.textAlignment = .left
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupShadows()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        contentView.addSubviews([movieImageView,movieTitle])
        contentView.backgroundColor = UIColor(hex: "242A32")
        contentView.layer.cornerRadius = 16
        
        movieImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().offset(-8)
            $0.height.equalTo(180)
        }
        
        movieTitle.snp.makeConstraints {
            $0.top.equalTo(movieImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-12)
        }
    }
    
    private func setupShadows() {
        let cornerRadius: CGFloat = 14.0
        layer.shadowColor = UIColor(hex: "000000").cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        layer.shadowRadius = 7.0
        
        let cgPath = UIBezierPath(roundedRect: bounds,
                                  byRoundingCorners: [.allCorners],
                                  cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        layer.shadowPath = cgPath
    }
    
    public func setupData(title: String) {
        movieTitle.text = title
    }
    
}
