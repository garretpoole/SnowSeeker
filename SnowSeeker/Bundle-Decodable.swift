//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Garret Poole on 3/18/22.
//

import Foundation

extension Bundle {
    //T makes it general so T can be any Codable Type
    func decode<T: Codable>(_ file: String) -> T {
        //find file somewhere in the bundle
        guard let url = self.url(forResource: file, withExtension: nil) else{
            fatalError("Failed to locate \(file) in bundle")
        }
        //load the data into a data instance
        guard let data = try? Data(contentsOf: url) else{
            fatalError("Failed to load \(file) from bundle")
        }
        //decode the data from JSON to local instance
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else{
            fatalError("Failed to decode \(file) from bundle")
        }
        
        return loaded
    }
}
