//
//  DetailViewController.swift
//  MoviesApp
//
//  Created by Tami on 17.10.2024.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var item: String?

    private let movieImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.image = UIImage(named: "ex_icon")
    }
    
    private let titleLabel = UILabel().then {
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
    
    private let lengthLabel = UILabel().then {
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
    
    private let actors: [(name: String, image: String)] = [
        ("Tom Holland", "tom_holland"),
        ("Zendaya", "zendaya"),
        ("Benedict Cumberbatch", "benedict"),
        ("Jacob Batalon", "jacob")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "242A32")
        setupViews()
        setupConstraints()
        setupCast()
        titleLabel.text = item
    }

    private func setupViews() {
        view.addSubview(movieImageView)
        view.addSubview(titleLabel)
        view.addSubview(ratingLabel)
        view.addSubview(categoryLabel)
        view.addSubview(lengthLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(castStackView)
    }

    private func setupConstraints() {
        movieImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(movieImageView.snp.bottom).offset(20)
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

        lengthLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(lengthLabel.snp.bottom).offset(10)
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
