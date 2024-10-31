//
//  PlanetModel.swift
//  Chase-Test
//
//  Created by Shamil Imanov on 30.10.2024.
//

import Foundation

struct Planets: Decodable {
	let results: [PlanetModel]
}

struct PlanetModel: Decodable, Equatable {
	let name: String
	let climate: String?
	let terrain: String?
	let population: String?
}
