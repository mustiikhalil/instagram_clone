//
//  CommentInputAccessoryView.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/28/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

protocol CommentInputAccessoryProtocol {
    func saveCommentToDatabase(text commentText: String, onSuccess: @escaping ()->Void)
}

class CommentInputAccessoryView: UIView {
    
    var delegate: CommentInputAccessoryProtocol?
    
    let sendButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Post", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        return btn
    }()
    
    let lineSeparator: UIView =  {
        let line = UIView()
        line.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return line
    }()
    
    let commentTextView = InputTextView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = .flexibleHeight
        
        addSubview(sendButton)
        addSubview(commentTextView)
        addSubview(lineSeparator)
        backgroundColor = .white
        sendButton.anchor(leading: nil, top: topAnchor, trailing: trailingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, paddingLeading: 12, paddingTop: 0, paddingTailing: 12, paddingBottom: 0, width: 50, height: 0)
        commentTextView.anchor(leading: leadingAnchor, top: topAnchor, trailing: sendButton.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, paddingLeading: 12, paddingTop: 8, paddingTailing: 0, paddingBottom: 8, width: 0, height: 0)
        lineSeparator.anchor(leading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: nil, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0.5)
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    @objc func handleComment() {
        guard let commentText = commentTextView.text, !commentText.isEmpty else { return }
        delegate?.saveCommentToDatabase(text: commentText) {
            self.commentTextView.text = ""
            self.commentTextView.showPlaceHolder()
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
