//
//  ViewModel.swift
//  VKLinkApp
//
//  Created by Alisher Saideshov on 28.03.2024.
//

import Foundation

final class ViewModel {

    // MARK: - Properties
    private(set) var services: [Service] = []

    // MARK: - Methods
    func fetchData(completion: @escaping() -> Void) {
        guard let url = URL(string: Constants.baseURL) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, responce, error in
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ServiceData.self, from: data)
                self?.services = result.body.services

                DispatchQueue.main.async {
                    completion()
                }
            }
            catch {
                print("Error JSON: \(error)")
            }
        }.resume()
    }
}
