//
//  DetailViewController.swift
//  MoviesApp
//
//  Created by Tami on 17.10.2024.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var item: Int?

    private let movieImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.image = UIImage(named: "ex_icon")
    }
    
    private let detailView: DetailsView = .init().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "242A32")
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        view.addSubviews([movieImageView,detailView])

    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        movieImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        detailView.snp.makeConstraints{
            $0.top.equalTo(movieImageView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        

    }
    
}
