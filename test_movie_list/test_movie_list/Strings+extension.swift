//
//  Strings+extension.swift
//  test_movie_list
//
//  Created by mac on 12.08.2024.
//

import Foundation

extension String {
    
    var localized: String {
        NSLocalizedString(self,comment: "\(self) could not be fount in Localizable.strings")
    }
}
