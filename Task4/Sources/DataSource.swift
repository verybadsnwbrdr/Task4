import UIKit

final class DataSource: UITableViewDiffableDataSource<Int, Model> {
	private var data: [Model]
	
	init(data: [Model], tableView: UITableView) {
		self.data = data
		super.init(tableView: tableView) { tableView, indexPath, model in
			let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
			cell.accessoryType = model.isSelected ? .checkmark : .none
			cell.textLabel?.text = String(model.index)
			return cell
		}
	}
	
	func shuffle() {
		data.shuffle()
		reload()
	}
	
	func reload() {
		var snapshot = snapshot()
		snapshot.deleteAllItems()
		snapshot.appendSections([0])
		snapshot.appendItems(data)
		apply(snapshot)
	}
	
	private func selectRow(_ row: Int) {
		var snapshot = snapshot()
		let model = data[row]
		
		if model.isSelected == false && row != 0 {
			snapshot.moveItem(model, beforeItem: data[0])
			data.move(fromOffsets: [row], toOffset: 0)
		}
		model.isSelected.toggle()
		snapshot.reloadItems([model])
		apply(snapshot)
	}
}

extension DataSource: UITableViewDelegate {
	func tableView(
		_ tableView: UITableView,
		didSelectRowAt indexPath: IndexPath
	) {
		tableView.deselectRow(at: indexPath, animated: true)
		selectRow(indexPath.row)
	}
}
