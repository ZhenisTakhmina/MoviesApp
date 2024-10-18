import UIKit
import SnapKit
import Then
import Combine

final class HomeViewController: UIViewController {
    
    private let viewModel = MovieViewModel()
    private var cancellables = Set<AnyCancellable>()

    private let welcomeLabel: UILabel = .init().then {
        $0.text = "What do you want to watch?"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let numberOfItemsPerRow: CGFloat = 2
        let interItemSpacing: CGFloat = 20
        let sectionInset: CGFloat = 20
        let aspectRatio: CGFloat = 1.5
        let totalSpacing = (numberOfItemsPerRow - 1) * interItemSpacing + 2 * sectionInset
        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / numberOfItemsPerRow
        let itemHeight = itemWidth * aspectRatio
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.minimumInteritemSpacing = interItemSpacing
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: sectionInset, bottom: 20, right: sectionInset)
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "242A32")
        setupViews()
        setupCollectionView()
        
        viewModel.getAllTrendingMovies()
        viewModel.$movies.sink { [weak self] _ in
                    self?.collectionView.reloadData()
                }.store(in: &cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupViews() {
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = UIColor(hex: "242A32")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseID)
        collectionView.showsVerticalScrollIndicator = false
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.reuseID,
            for: indexPath) as? MovieCollectionViewCell else {
            fatalError("Could not cast to DishesCollectionViewCell")
        }
        let movie = viewModel.movies[indexPath.item]
        cell.configureData(title: movie.title, year: movie.year)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = viewModel.movies[indexPath.item]
        let vc = DetailViewController()
        vc.item = selectedMovie.imdbID
        navigationController?.pushViewController(vc, animated: true)
    }
}

