//
//  FromCell.swift
//  Instagram
//
//  Created by Vlad Panchenko on 26.04.2022.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
    func fromTableViewCell(_ cell: FromCell, didUpdateField updateModel: EditProfileFromModel)
}

class FromCell: UITableViewCell, UITextFieldDelegate {

    static let identifier = "FromCell"
    
    private var model:EditProfileFromModel?
    
    public weak var delegate: TableViewCellDelegate?
    
    private let fromLabel:UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        return label
    }()
    
    private let field:UITextField = {
       let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(fromLabel)
        contentView.addSubview(field)
        field.delegate = self
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with model: EditProfileFromModel) {
        self.model = model
        fromLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fromLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fromLabel.frame = CGRect(x: 5, y: 0, width: contentView.width/3, height: contentView.height)
        field.frame = CGRect(x: fromLabel.right + 5, y: 0, width: contentView.width - 10 - fromLabel.width, height: contentView.height)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else {
            return true
        }

        delegate?.fromTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
}
