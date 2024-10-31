//
//  PlanetLocalStorageService.swift
//  Chase-Test
//
//  Created by Shamil Imanov on 30.10.2024.
//

import CoreData
import UIKit

final class PlanetLocalStorageService {
	private var appDelegate: AppDelegate {
		guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
			fatalError("Could not get app delegate")
		}
		return delegate
	}
	
	private var context: NSManagedObjectContext {
		appDelegate.persistentContainer.viewContext
	}

	/// Saves a list of planets to the local storage
	/// - Parameter planets: An array of `PlanetModel` objects to save
	func savePlanets(_ planets: [PlanetModel]) {
		for planet in planets {
			let planetEntity = PlanetLocalEntity(context: context)
			planetEntity.name = planet.name
			planetEntity.climate = planet.climate
			planetEntity.terrain = planet.terrain
			planetEntity.population = planet.population
		}
		saveContext()
	}

	/// Fetches all planets from the local storage
	/// - Returns: An array of `PlanetModel` objects from local storage
	func fetchPlanets() -> [PlanetModel] {
		let fetchRequest: NSFetchRequest<PlanetLocalEntity> = PlanetLocalEntity.fetchRequest()
		
		do {
			let planetEntities = try context.fetch(fetchRequest)
			let planets = planetEntities.map {
				PlanetModel(
					name: $0.name ?? "",
					climate: $0.climate,
					terrain: $0.terrain,
					population: $0.population
				)
			}
			return planets
		} catch {
			debugPrint("Failed to fetch planets: \(error)")
			return []
		}
	}
}

// MARK: - Private Methods
private extension PlanetLocalStorageService {
	func saveContext() {
		guard context.hasChanges else { return }

		do {
			try context.save()
		} catch {
			let nserror = error as NSError
			fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
		}
	}
}
