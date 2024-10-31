//
//  PlanetWorker.swift
//  Chase-Test
//
//  Created by Shamil Imanov on 30.10.2024.
//

import Foundation

protocol PlanetWorkerLogic {
	func fetchPlanets(
		onSuccess: (([PlanetModel]) -> Void)?,
		onError: ((Error) -> Void)?
	)
}

final class PlanetWorker: PlanetWorkerLogic {
	private let url = URL(string: "https://swapi.dev/api/planets/")

	func fetchPlanets(
		onSuccess: (([PlanetModel]) -> Void)?,
		onError: ((Error) -> Void)?
	) {
		guard let url else {
			onError?(NSError(domain: "URL error", code: -1, userInfo: nil))
			return
		}

		URLSession.shared.dataTask(with: url) { data, response, error in
			if let error {
				onError?(error)
				return
			}

			guard let data else {
				onError?(NSError(domain: "Data error", code: -1, userInfo: nil))
				return
			}

			do {
				let planets = try JSONDecoder().decode(Planets.self, from: data)
				onSuccess?(planets.results)
			} catch {
				onError?(error)
			}
		}.resume()
	}
}
