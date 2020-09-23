//
//  PostTableViewCell.swift
//  Reddit
//
//  Created by Owen Barrott on 9/23/20.
//  Copyright © 2020 Owen Barrott. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol PresentErrorToUserDelegate: AnyObject {
    func presentError(error: LocalizedError)
}

class PostTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upvotesLabel: UILabel!
    
    // MARK: - Properties
    var post: Post? {
        didSet {
            updateViews()
        }
    }
    
    weak var delegate: PresentErrorToUserDelegate?
    
    
    
    // MARK: - Helper Functions & Methods
    func updateViews() {
        guard let post = post else { return }
        titleLabel.text = post.title
        upvotesLabel.text = "Upvotes:⬆️ \(post.ups)"
        postImageView.image = nil
        
        PostController.fetchThumbnailFor(post: post) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self.postImageView.image = image
                case .failure(let error):
                    self.delegate?.presentError(error: error)
                    print(error.errorDescription)
                }
            }
        }
    }
}
