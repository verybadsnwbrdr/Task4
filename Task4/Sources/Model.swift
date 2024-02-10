import Foundation

final class Model {
	var isSelected: Bool
	let index: Int
	
	init(isSelected: Bool = false, index: Int) {
		self.isSelected = isSelected
		self.index = index
	}
}

extension Model: Hashable {
	static func == (lhs: Model, rhs: Model) -> Bool {
		lhs.hashValue == rhs.hashValue
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(index)
		hasher.combine(isSelected)
	}
}
