//
//  PlanetCell.swift
//  Chase-Test
//
//  Created by Shamil Imanov on 30.10.2024.
//

import UIKit

final class PlanetCell: UITableViewCell {
	private enum Constants {
		static let nameFontSize: CGFloat = 16
		static let descriptionsFontSize:CGFloat = 14
		static let topBottomOffset: CGFloat = 8
		static let rightLeftOffset: CGFloat = 16
		static let descriptionsOffset: CGFloat = 4
	}
	
	private let nameLabel = UILabel()
	private let climateLabel = UILabel()
	private let terrainLabel = UILabel()
	private let populationLabel = UILabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Configures the cell with the details of a planet
	/// - Parameter planet: The `PlanetModel` instance containing the planet's data
	func configure(with planet: PlanetModel) {
		nameLabel.text = "\(planet.name)"
		climateLabel.text = "Climate: \(planet.climate ?? "unknown")"
		terrainLabel.text = "Terrain: \(planet.terrain ?? "unknown")"
		populationLabel.text = "Population: \(planet.population ?? "unknown")"

		nameLabel.textAlignment = .center
	}
}

// MARK: - Private Methods
private extension PlanetCell {
	func setupUI() {
		[
			nameLabel,
			climateLabel,
			terrainLabel,
			populationLabel
		].forEach { label in
			contentView.addSubview(label)
			label.translatesAutoresizingMaskIntoConstraints = false
		}

		nameLabel.font = .boldSystemFont(ofSize: Constants.nameFontSize)
		climateLabel.font = .systemFont(ofSize: Constants.descriptionsFontSize)
		terrainLabel.font = .systemFont(ofSize: Constants.descriptionsFontSize)
		populationLabel.font = .systemFont(ofSize: Constants.descriptionsFontSize)

		NSLayoutConstraint.activate([
			nameLabel.topAnchor.constraint(
				equalTo: contentView.topAnchor,
				constant: Constants.topBottomOffset
			),
			nameLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.rightLeftOffset
			),
			nameLabel.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.rightLeftOffset
			),

			climateLabel.topAnchor.constraint(
				equalTo: nameLabel.bottomAnchor,
				constant: Constants.descriptionsOffset
			),
			climateLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.rightLeftOffset
			),
			climateLabel.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.rightLeftOffset
			),

			terrainLabel.topAnchor.constraint(
				equalTo: climateLabel.bottomAnchor,
				constant: Constants.descriptionsOffset
			),
			terrainLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.rightLeftOffset
			),
			terrainLabel.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.rightLeftOffset
			),

			populationLabel.topAnchor.constraint(
				equalTo: terrainLabel.bottomAnchor,
				constant: Constants.descriptionsOffset
			),
			populationLabel.leadingAnchor.constraint(
				equalTo: contentView.leadingAnchor,
				constant: Constants.rightLeftOffset
			),
			populationLabel.trailingAnchor.constraint(
				equalTo: contentView.trailingAnchor,
				constant: -Constants.rightLeftOffset
			),
			populationLabel.bottomAnchor.constraint(
				equalTo: contentView.bottomAnchor,
				constant: -Constants.topBottomOffset
			)
		])
	}
}
