//
//  NetManager.swift
//  StudyCatDailyApp
//
//  Created by Danila Savitsky on 20.07.25.
//

import Foundation

//// MARK: - Image
//struct Image: Codable {
//    let memes: [Meme]
//    let available: Int
//}
//
//// MARK: - Meme
//struct Meme: Codable {
//    let id: Int
//    let description: String
//    let url: String
//    let type: String
//}
struct ImageElement: Codable {
    let id: String
    let url: String
    let width, height: Int
}

typealias Image = [ImageElement]

class NetManager {
    static let shared = NetManager()
    let urlSession = URLSession(configuration: .default)
//    let urlString = "https://api.humorapi.com/memes/search?keywords=cats,kitten,kitty&api-key=c853c3fea712427aa9b17e2f0aa5a156"
    let urlString = "https://api.thecatapi.com/v1/images/search"
    let jsonDecoder = JSONDecoder()
//    func fetchImageURL() async throws -> (String?,String?) {
    @MainActor
    func fectchImageURL() async throws -> String? {
        let url = URL(string: urlString)!
        let data = try await urlSession.data(from: url)
        print(data.0)
        let image = try? JSONDecoder().decode(Image.self, from: data.0)
        return image?[0].url
//        return (image?.memes[0].url,image?.memes[0].description)
    }
}
