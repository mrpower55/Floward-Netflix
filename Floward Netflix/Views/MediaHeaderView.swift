//
//  MediaHeaderView.swift
//  Floward Netflix
//
//  Created by Mahmoud Shurrab on 14/09/2022.
//

import UIKit
import SDWebImage
import SnapKit

protocol MediaHeaderViewDelegate: AnyObject {
    func mediaInfoButtonTapped(media: Media?)
    func mediaPlayButtonTapped(media: Media?)
}

class MediaHeaderView: UIView {
    private var media: Media?
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [AppColors.transparent.cgColor, AppColors.white.withAlphaComponent(0.9).cgColor]
        return gradientLayer
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Info", for: .normal)
        button.setTitleColor(AppColors.black, for: .normal)
        button.setImage(UIImage.infoIcon, for: .normal)
        button.layer.borderColor = AppColors.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.backgroundColor = AppColors.white
        button.tintColor = AppColors.black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.centerTextAndImage()
        return button
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.setTitleColor(AppColors.black, for: .normal)
        button.setImage(UIImage.playIcon, for: .normal)
        button.layer.borderColor = AppColors.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.backgroundColor = AppColors.white
        button.tintColor = AppColors.black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.centerTextAndImage()
        return button
    }()
    
    weak var delegate: MediaHeaderViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(posterImageView)
        gradientLayer.frame = posterImageView.bounds
        self.layer.addSublayer(gradientLayer)
        
        addSubview(playButton)
        addSubview(infoButton)
        
        infoButton.addTarget(self, action: #selector(mediaInfoButtonTapped), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(mediaPlayButtonTapped), for: .touchUpInside)
        
        applyConstraints()
    }
    
    private func applyConstraints() {
        playButton.snp.makeConstraints { make in
            make.leading.equalTo(50)
            make.bottom.equalTo(-30)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        infoButton.snp.makeConstraints { make in
            make.trailing.equalTo(-50)
            make.bottom.equalTo(-30)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
    }
    
    public func configureHomeView(with media: Media) {
        self.media = media
        self.posterImageView.displayImage(media.poster_path ?? "")
    }
    
    public func configureMediaDetailsView(with media: Media) {
        self.media = media
        
        infoButton.removeFromSuperview()
        playButton.snp.makeConstraints { make in
            make.trailing.equalTo(-50)
        }
        
        self.posterImageView.displayImage(media.poster_path ?? "")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = bounds
        gradientLayer.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @IBAction func mediaInfoButtonTapped() {
        delegate?.mediaInfoButtonTapped(media: media)
    }
    
    @IBAction func mediaPlayButtonTapped() {
        delegate?.mediaPlayButtonTapped(media: media)
    }
}
