//
//  PlanetViewController.swift
//  Chase-Test
//
//  Created by Shamil Imanov on 30.10.2024.
//

import UIKit

final class PlanetViewController: UIViewController {
	private let tableView = UITableView()
	private let worker = PlanetWorker()
	private let planetLocalStorageService = PlanetLocalStorageService()
	private var model: [PlanetModel] = []

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		fetchData()
		navigationItem.title = "Planets"
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PlanetViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return model.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(
			withIdentifier: PlanetCell.reuseIdentifier,
			for: indexPath
		) as? PlanetCell else {
			return UITableViewCell()
		}

		cell.configure(with: model[indexPath.row])
		return cell
	}
}

// MARK: - Private Methods
private extension PlanetViewController {
	func setupUI() {
		view.addSubview(tableView)

		tableView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])

		setupAppearance()
		setupTableView()
	}

	func setupAppearance() {
		view.backgroundColor = .white
	}

	func setupTableView() {
		tableView.backgroundColor = .clear
		tableView.separatorStyle = .none
		tableView.allowsSelection = false

		tableView.register(PlanetCell.self, forCellReuseIdentifier: PlanetCell.reuseIdentifier)
		tableView.delegate = self
		tableView.dataSource = self
	}

	func fetchData() {
		// We need to show a loading sign when we get planet data
		worker.fetchPlanets(
			onSuccess: { [weak self] planets in
				guard let self else { return }
				DispatchQueue.main.async {
					self.model = planets
					self.planetLocalStorageService.savePlanets(planets)
					self.tableView.reloadData()
				}
			},
			onError: { [weak self] error in
				guard let self else { return }
				let cachedPlanets = self.planetLocalStorageService.fetchPlanets()
				guard cachedPlanets.isEmpty else {
					self.model = cachedPlanets
					self.tableView.reloadData()
					return
				}
				debugPrint("Error fetching planets: \(error)")
			}
		)
	}
}
