//
//  ___FILEHEADER___
//
//

import Combine
import SnapKit
import UIKit

class ___VARIABLE_productName___View: UIView {
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: ___VARIABLE_productName___ViewModel

    init(viewModel: ___VARIABLE_productName___ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        createSubViews()
        bindViewModel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        logger.info("___VARIABLE_productName___View 被销毁")
    }

    private func bindViewModel() {}

    // MARK: - 布局

    private func createSubViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        // contentView.addSubview(stackV)

        setupLayout()
    }

    private func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        // stackV.snp.makeConstraints { make in
        //     make.edges.equalToSuperview()
        // }
    }

    // MARK: 懒加载

    //    private lazy var stackV:UIStackView  = {
    //        let stackV = UIStackView()
    //        stackV.axis = .vertical
    //        stackV.isLayoutMarginsRelativeArrangement = true
    //        stackV.directionalLayoutMargins = .init(top: <#T##CGFloat#>, leading: <#T##CGFloat#>, bottom: <#T##CGFloat#>, trailing: <#T##CGFloat#>)
    //        stackV.spacing = 8
    //        return stackV
    //    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
            scrollView.scrollIndicatorInsets = scrollView.contentInset
        }
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
}
