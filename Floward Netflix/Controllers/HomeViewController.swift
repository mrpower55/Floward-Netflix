//
//  HomeViewController.swift
//  Floward Netflix
//
//  Created by Mahmoud Shurrab on 14/09/2022.
//

import UIKit

class HomeViewController: UIViewController {
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = AppColors.black
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()
    
    let sectionTitles: [String] = ["Trending Movies", "Trending TV Show", "Upcoming Movies", "Top rated", "Popular"]
    let sections: [HomeViewControllerSections] = [.TrendingMovies, .TrendingTvShow, .UpcomingMovies, .TopRatedMedia, .PopularMedia]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.black
    
        self.configureNavigationBar()
        self.configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    func configureNavigationBar() {
        let netflixLogoImageView: UIImageView = UIImageView(image: UIImage.netflixLogoSmall)
        netflixLogoImageView.contentMode = .scaleAspectFit
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: netflixLogoImageView.image, style: .plain, target: self, action: #selector(homeButtonTapped))
        
        navigationItem.title = "Home"
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage.profileIcon, style: .plain, target: self, action: #selector(profileButtonTapped)),
            UIBarButtonItem(image: UIImage.searchIcon, style: .plain, target: self, action: #selector(searchButtonTapped))
        ]
        
        navigationController?.navigationBar.tintColor = AppColors.systemBackground
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        self.configureNewestMediaView()
    }
    
    func configureNewestMediaView() {
        let mediaHeaderView: MediaHeaderView = MediaHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        mediaHeaderView.delegate = self
        tableView.tableHeaderView = mediaHeaderView
        
        NetworkLayer.shared.getTrendingMovies { results in
            switch results {
                case .success(let mediaList):
                    if let newestMedia: Media = mediaList.randomElement() {
                        mediaHeaderView.configureHomeView(with: newestMedia)
                    }
                    
                case .failure(let error):
                    Toast.show(message: error.localizedDescription, controller: self)
            }
        }
    }
    
    @IBAction func homeButtonTapped() {
        Toast.show(message: "Home", controller: self)
    }
    
    @IBAction func profileButtonTapped() {
        Toast.show(message: "Profile", controller: self)
    }
    
    @IBAction func searchButtonTapped() {
        Toast.show(message: "Search", controller: self)
    }
    
    func goToMediaDetails(with media: Media) {
        let vc = MediaDetailsViewController()
        vc.configure(with: media)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = AppColors.white
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else {
            return UITableViewCell()
        }
        
        switch sections[indexPath.section] {
            case .TrendingMovies:
                self.configureTrendingMovies(cell)
            case .TrendingTvShow:
                self.configureTrendingTVShow(cell)
            case .UpcomingMovies:
                self.configureUpcomingMovies(cell)
            case .TopRatedMedia:
                self.configureTopRatedMedia(cell)
            case .PopularMedia:
                self.configurePopularMedia(cell)
        }
        
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func configureTrendingMovies(_ cell: CollectionTableViewCell) {
        NetworkLayer.shared.getTrendingMovies { result in
            switch result {
                case .success(let mediaList):
                    cell.configure(with: mediaList)
                case .failure(let error):
                    Toast.show(message: error.localizedDescription, controller: self)
            }
        }
    }
    
    func configureTrendingTVShow(_ cell: CollectionTableViewCell) {
        NetworkLayer.shared.getTrendingTVShow { result in
            switch result {
                case .success(let mediaList):
                    cell.configure(with: mediaList)
                case .failure(let error):
                    Toast.show(message: error.localizedDescription, controller: self)
            }
        }
    }
    
    func configureUpcomingMovies(_ cell: CollectionTableViewCell) {
        NetworkLayer.shared.getUpcomingMovies { result in
            switch result {
                case .success(let mediaList):
                    cell.configure(with: mediaList)
                case .failure(let error):
                    Toast.show(message: error.localizedDescription, controller: self)
            }
        }
    }
    
    func configureTopRatedMedia(_ cell: CollectionTableViewCell) {
        NetworkLayer.shared.getTopRatedMedia { result in
            switch result {
                case .success(let mediaList):
                    cell.configure(with: mediaList)
                case .failure(let error):
                    Toast.show(message: error.localizedDescription, controller: self)
            }
        }
    }
    
    func configurePopularMedia(_ cell: CollectionTableViewCell) {
        NetworkLayer.shared.getPopularMedia { result in
            switch result {
                case .success(let mediaList):
                    cell.configure(with: mediaList)
                case .failure(let error):
                    Toast.show(message: error.localizedDescription, controller: self)
            }
        }
    }
}

extension HomeViewController: MediaHeaderViewDelegate {
    func mediaInfoButtonTapped(media: Media?) {
        if let media = media {
            self.goToMediaDetails(with: media)
        }
    }
    
    func mediaPlayButtonTapped(media: Media?) {
        if let media = media {
            Toast.show(message: "Play (\(media.getTitle()))", controller: self)
        }
    }
}

extension HomeViewController: CollectionTableViewCellDelegate {
    func collectionTableViewCellTapped(_ cell: CollectionTableViewCell, media: Media) {
        self.goToMediaDetails(with: media)
    }
}

enum HomeViewControllerSections {
    case TrendingMovies
    case TrendingTvShow
    case UpcomingMovies
    case TopRatedMedia
    case PopularMedia
}
