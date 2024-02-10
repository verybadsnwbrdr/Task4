import UIKit

final class ViewController: UIViewController {

	private lazy var dataSource: DataSource = makeDataSource()
	private let tableView = UITableView(frame: .zero, style: .insetGrouped)
	
	override func loadView() {
		view = tableView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		dataSource.reload()
	}

	private func setup() {
		navigationItem.title = "Task 4"
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Shuffle",
			primaryAction: UIAction { [weak self] _ in self?.rightBarButtonItemAction()}
		)
		
		tableView.delegate = dataSource
		tableView.dataSource = dataSource
		
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
	}
	
	private func rightBarButtonItemAction() {
		dataSource.shuffle()
	}
	
	private func makeDataSource() -> DataSource {
		DataSource(
			data: (0..<30).map { Model(index: $0) },
			tableView: tableView
		)
	}
}
