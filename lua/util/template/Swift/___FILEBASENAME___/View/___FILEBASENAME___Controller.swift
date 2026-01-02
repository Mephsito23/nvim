//
//  ___FILEHEADER___
//

import Combine
import SnapKit
import UIKit

class ___VARIABLE_productName___Controller: CoordinatedViewController<___VARIABLE_productName___ViewModel> {
    private var cancellables = Set<AnyCancellable>()
    // let viewModel: ___VARIABLE_productName___ViewModel = .init()

    init(viewModel: ___VARIABLE_productName___ViewModel) {
        super.init(viewModel: viewModel)
    }

    @available(*, unavailable)
    @MainActor required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        logger.debug("___VARIABLE_productName___Controller 被销毁")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainV)
        steupLayout()
        bindViewModel()
    }

    private func bindViewModel() {}

    // MARK: - 布局

    private func steupLayout() {
        mainV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - 懒加载

    private lazy var mainV: ___VARIABLE_productName___View = .init(viewModel: viewModel)
}

// MARK: - ___VARIABLE_productName___Coordinator

class ___VARIABLE_productName___Coordinator: Coordinator {
    private var cancellables = Set<AnyCancellable>()
    let controller: ___VARIABLE_productName___Controller
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var rootViewController: UIViewController { controller }

    init(navigationController: UINavigationController) {
        controller = .init(viewModel: .init())
        self.navigationController = navigationController
    }

    func start() {}
}
