//
//  DetailsView.swift
//  MoviesApp
//
//  Created by Tami on 18.10.2024.
//

import UIKit

final class DetailsView: UIView {
    
    private let actors: [(name: String, image: String)] = [
        ("Tom Holland", "ex_icon"),
        ("Zendaya", "popcorn"),
        ("Benedict Cumberbatch", "ex_icon"),
        ("Jacob Batalon", "popcorn")
    ]

    private let titleLabel = UILabel().then {
        $0.text = "Spiderman: No Way Home"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .white
    }

    private let ratingLabel = UILabel().then {
        $0.text = "⭐ 9.1/10 IMDb"
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .lightGray
    }

    private let categoryLabel = UILabel().then {
        $0.text = "Action   Adventure   Fantasy"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .lightGray
    }
    
    private let durationLabel = UILabel().then {
        $0.text = "Length: 2h 28min"
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .lightGray
    }

    private let descriptionLabel = UILabel().then {
        $0.text = """
        With Spider-Man's identity now revealed, Peter asks Doctor Strange for help. When a spell goes wrong, dangerous foes from other worlds start to appear, forcing Peter to discover what it truly means to be Spider-Man.
        """
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    private let castStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .center
        $0.distribution = .fillEqually
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews([titleLabel,ratingLabel,categoryLabel,durationLabel,descriptionLabel,castStackView])
    }
    
    private func setupConstraints(){
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
        }

        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(ratingLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
        }

        durationLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(durationLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        castStackView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
    }
    
    private func setupCast() {
        for actor in actors {
            let actorView = createActorView(name: actor.name, imageName: actor.image)
            castStackView.addArrangedSubview(actorView)
        }
    }

    private func createActorView(name: String, imageName: String) -> UIView {
        let view = UIView()
        let imageView = UIImageView()
        let nameLabel = UILabel()

        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10

        nameLabel.text = name
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center

        view.addSubview(imageView)
        view.addSubview(nameLabel)

        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        return view
    }
}
