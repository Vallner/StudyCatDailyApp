//
//  NetManager.swift
//  StudyCatDailyApp
//
//  Created by Danila Savitsky on 20.07.25.
//

import Foundation

// MARK: - Image
struct Image: Codable {
    let memes: [Meme]
    let available: Int
}

// MARK: - Meme
struct Meme: Codable {
    let id: Int
    let description: String
    let url: String
    let type: String
}

class NetManager {
    var shared: NetManager {
        return self
    }
    let urlSession = URLSession(configuration: .default)
    let urlString = "https://api.humorapi.com/memes/search?keywords=cats,kitten,kitty,gnarp,gleeble&api-key=c853c3fea712427aa9b17e2f0aa5a156"
    let jsonDecoder = JSONDecoder()
    func fetchImageURL() async throws -> (String?,String?) {
        let url = URL(string: urlString)!
        let data = try await urlSession.data(from: url)
        print(data.0)
        let image = try? JSONDecoder().decode(Image.self, from: data.0)
        return (image?.memes[0].url,image?.memes[0].description)
    }
}
