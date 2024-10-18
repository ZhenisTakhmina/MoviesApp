//
//  SearchViewController.swift
//  MoviesApp
//
//  Created by Tami on 17.10.2024.
//

import UIKit
import Combine

final class SearchViewController: UIViewController{
    private let viewModel = MovieViewModel()
    private var cancellables = Set<AnyCancellable>()
    private var filteredMovies: [Movie] = []
    
    
    private lazy var searchContainerView: SearchContainerView = SearchContainerView()
    
    private lazy var searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SearchResultTableViewCell.self,
                           forCellReuseIdentifier: SearchResultTableViewCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "242A32")
        setupViews()
        setupConstraints()
        
        viewModel.getAllTrendingMovies()
        viewModel.$movies.sink { [weak self] movies in
            self?.filteredMovies = movies
            self?.searchTableView.reloadData()
        }.store(in: &cancellables)
        
        self.searchContainerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupViews() {
        view.addSubview(searchContainerView)
        view.addSubview(searchTableView)
        view.backgroundColor = UIColor(hex: "242A32")
    }
    
    private func setupConstraints() {
        searchContainerView.snp.makeConstraints {
            $0.leading.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.height.equalTo(48)
        }
        
        searchTableView.snp.makeConstraints {
            $0.top.equalTo(searchContainerView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

extension SearchViewController: SearchContainerViewDelegate {
    func searchCompleted(word: String) {
        filterMovies(with: word)
    }
    
   
    func clearButtonTapped(isTapped: Bool) {
        filterMovies(with: "")
    }

    
    private func filterMovies(with query: String) {
        if query.isEmpty {
            filteredMovies = viewModel.movies
        } else {
            filteredMovies = viewModel.movies.filter { $0.title.lowercased().contains(query.lowercased()) }
        }
        searchTableView.reloadData()
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultTableViewCell.reuseID,
            for: indexPath
        ) as? SearchResultTableViewCell else {
            fatalError("recent not found")
        }
        let movie = filteredMovies[indexPath.row]
        cell.configureData(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        let movie = filteredMovies[indexPath.row]
        detailViewController.item = movie.imdbID
        present(detailViewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
