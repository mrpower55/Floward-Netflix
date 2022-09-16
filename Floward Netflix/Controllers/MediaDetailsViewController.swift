//
//  MediaDetailsViewController.swift
//  Floward Netflix
//
//  Created by Mahmoud Shurrab on 16/09/2022.
//

import Foundation
import UIKit
import SnapKit

class MediaDetailsViewController: UIViewController {
    private let scrollView = UIScrollView()
    
    private let mediaHeaderView: MediaHeaderView = {
        let mediaHeaderView = MediaHeaderView()
        return mediaHeaderView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.text = ""
        label.textColor = AppColors.white
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.text = ""
        label.textColor = AppColors.white
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        label.text = ""
        label.textColor = AppColors.white
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.text = ""
        label.textColor = AppColors.white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.black
        
        configureScrollView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.updateContentView()
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.centerX.width.top.bottom.equalToSuperview()
        }
        
        configureViews()
    }
    
    func configureViews(){
        scrollView.addSubview(mediaHeaderView)
        mediaHeaderView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(500)
        }
        
        scrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mediaHeaderView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(20)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        scrollView.addSubview(releaseDateLabel)
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(20)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        scrollView.addSubview(ratingLabel)
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(10)
            make.leading.trailing.equalTo(20)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        scrollView.addSubview(detailsLabel)
        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(20)
            make.width.equalToSuperview().multipliedBy(0.9)
        }
    }
    
    public func configure(with media: Media) {
        mediaHeaderView.configureMediaDetailsView(with: media)
        mediaHeaderView.delegate = self
        
        titleLabel.text = "\(media.getTitle())"+media.getMediaType()
        
        if media.release_date?.isEmpty ?? true {
            releaseDateLabel.text = "First Air Date: \(media.first_air_date ?? "")"
        } else {
            releaseDateLabel.text = "Release Date: \(media.release_date ?? "")"
        }
        
        
        ratingLabel.text = "Rating: \(media.vote_average ?? 0.0)"
        
        detailsLabel.text = media.overview ?? ""
    }
}

extension MediaDetailsViewController: MediaHeaderViewDelegate {
    func mediaInfoButtonTapped(media: Media?) {}
    
    func mediaPlayButtonTapped(media: Media?) {
        if let media = media {
            Toast.show(message: "Play (\(media.getTitle()))", controller: self)
        }
    }
}
