//
//  DetailViewController.swift
//  MoviesApp
//
//  Created by Tami on 17.10.2024.
//

import UIKit
import Combine

final class DetailViewController: UIViewController {
    
    private let viewModel = MovieViewModel()
    private var cancellables = Set<AnyCancellable>()
    var item: String?
    
    
    private let movieImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.image = UIImage(named: "banner")
    }
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .white
        $0.textAlignment = .left
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
    }
    
    private let infoStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 5
        $0.alignment = .center
        $0.distribution = .fillEqually
    }
    
    private let ratingLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textColor = .white
    }
    
    private let categoryLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.numberOfLines = 0
        $0.textColor = .white
    }
    
    private let ratedLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = .white
        $0.backgroundColor = .red.withAlphaComponent(0.2)
        $0.textAlignment = .center
    }
    
    private let releaseDateLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = .white
        $0.backgroundColor = .red.withAlphaComponent(0.2)
        $0.textAlignment = .center
    }
    
    private let lengthLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 15)
        $0.textColor = .white
        $0.backgroundColor = .red.withAlphaComponent(0.2)
        $0.textAlignment = .center
    }
    
    private let descriptionTitleLabel = UILabel().then {
        $0.text = "Description:"
        $0.font = UIFont.boldSystemFont(ofSize: 17)
        $0.textColor = .white
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "242A32")
        setupViews()
        setupConstraints()
        bindViewModel()
    }
    
    private func setupViews() {
        view.addSubviews([movieImageView, titleLabel, ratingLabel, infoStackView, categoryLabel, descriptionTitleLabel, descriptionLabel])
        infoStackView.addArrangedSubviews([lengthLabel,ratedLabel,releaseDateLabel])
    }
    
    func bindViewModel() {
        guard let movieId = item else { return }
        viewModel.getMovieById(movieId: movieId)
        
        viewModel.$selectedMovieDetail
            .compactMap { $0 }
            .sink { [weak self] movieDetail in
                self?.updateUI(with: movieDetail)
            }
            .store(in: &cancellables)
    }
    
    private func updateUI(with movieDetail: MovieDetail) {
        titleLabel.text = movieDetail.title ?? "Title unavailable"
        ratingLabel.text = "⭐ \(movieDetail.imdbRating ?? "N/A")/10 IMDb"
        categoryLabel.text = "Genres: \(movieDetail.genres?.joined(separator: ", ") ?? "No categories available")"
        descriptionLabel.text = movieDetail.description ?? "No description available"
        lengthLabel.text = "\(movieDetail.runtime ?? 0) min"
        releaseDateLabel.text = movieDetail.releaseDate ?? "Release date unavailable"
        ratedLabel.text = movieDetail.rated ?? "Unavailable"
    }
    
    private func setupConstraints() {
        movieImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(movieImageView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(titleLabel)
        }
        
        ratedLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        lengthLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        releaseDateLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        infoStackView.snp.makeConstraints{
            $0.top.equalTo(ratingLabel.snp.bottom).offset(20)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(infoStackView.snp.bottom).offset(20)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        descriptionTitleLabel.snp.makeConstraints{
            $0.top.equalTo(categoryLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
