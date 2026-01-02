local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
	s("init_view", {
		-- init(frame:)
		t("override init(frame: CGRect) {"),
		t({ "", "    super.init(frame: frame)" }),
		t({ "", "    createSubViews()" }),
		t({ "", "    bindViewModel()" }),
		t({ "", "}" }),
		t({ "", "" }),

		-- required init?(coder:)
		t("@available(*, unavailable)"),
		t({ "", "required init?(coder: NSCoder) {" }),
		t({ "", '    fatalError("init(coder:) has not been implemented")' }),
		t({ "", "}" }),
		t({ "", "" }),

		-- bindViewModel
		t("private func bindViewModel() {"),
		t({ "", "    " }),
		i(1, ""),
		t({ "", "}" }),
		t({ "", "" }),

		-- createSubViews
		t("private func createSubViews() {"),
		t({ "", "    addSubview(" }),
		i(2, "stackV"),
		t(")"),
		t({ "", "    setupLayout()" }),
		t({ "", "}" }),
		t({ "", "" }),

		-- setupLayout
		t("private func setupLayout() {"),
		t({ "", "    " }),
		rep(2),
		t(".snp.makeConstraints { make in"),
		t({ "", "        make.edges.equalToSuperview()" }),
		t({ "", "    }" }),
		t({ "", "}" }),
		t({ "", "" }),

		-- MARK + 懒加载
		t("// MARK: 懒加载"),
		t({ "", "" }),

		-- lazy stack
		t("private lazy var "),
		rep(2),
		t(": UIStackView = {"),
		t({ "", "    let " }),
		rep(2),
		t(" = UIStackView()"),
		t({ "", "    " }),
		rep(2),
		t(".axis = .vertical"),
		t({ "", "    " }),
		rep(2),
		t(".isLayoutMarginsRelativeArrangement = true"),
		t({ "", "    " }),
		rep(2),
		t(".directionalLayoutMargins = .zero"),
		t({ "", "    " }),
		rep(2),
		t(".spacing = 16"),
		t({ "", "    " }),
		rep(2),
		t(".insetsLayoutMarginsFromSafeArea = false"),
		t({ "", "    return " }),
		rep(2),
		t({ "", "}()" }),
	}),
	s("init_viewModel", {
		-- 属性
		t("private let viewModel: "),
		i(1, "ViewModel"),
		t({ "", "" }),

		-- init(viewModel:)
		t("init(viewModel: "),
		rep(1),
		t(") {"),
		t({ "", "    self.viewModel = viewModel" }),
		t({ "", "    super.init(frame: .zero)" }),
		t({ "", "    createSubViews()" }),
		t({ "", "    bindViewModel()" }),
		t({ "", "}" }),
		t({ "", "" }),

		-- required init?(coder:)
		t("@available(*, unavailable)"),
		t({ "", "required init?(coder: NSCoder) {" }),
		t({ "", '    fatalError("init(coder:) has not been implemented")' }),
		t({ "", "}" }),
	}),
	s("init_view_viewModel", {
		-- 属性
		t("private let viewModel: "),
		i(1, "ViewModel"),
		t({ "", "private let disposeBag = DisposeBag()" }),
		t({ "", "" }),

		-- init(viewModel:)
		t("init(viewModel: "),
		rep(1),
		t(") {"),
		t({ "", "    self.viewModel = viewModel" }),
		t({ "", "    super.init(frame: .zero)" }),
		t({ "", "    createSubViews()" }),
		t({ "", "    bindViewModel()" }),
		t({ "", "}" }),
		t({ "", "" }),

		-- required init?(coder:)
		t("@available(*, unavailable)"),
		t({ "", "required init?(coder: NSCoder) {" }),
		t({ "", '    fatalError("init(coder:) has not been implemented")' }),
		t({ "", "}" }),
		t({ "", "" }),

		-- bindViewModel
		t("private func bindViewModel() {"),
		t({ "", "    " }),
		i(2, ""),
		t({ "", "}" }),
		t({ "", "" }),

		-- createSubViews
		t("private func createSubViews() {"),
		t({ "", "    setupLayout()" }),
		t({ "", "}" }),
		t({ "", "" }),

		-- setupLayout
		t("private func setupLayout() {"),
		t({ "", "    " }),
		i(3, ""),
		t({ "", "}" }),
		t({ "", "" }),

		-- MARK
		t("// MARK: 懒加载"),
		t({ "", "" }),
	}),
	s({ trig = "init_table_cell", dscr = "创建cell" }, {
		-- init(style:reuseIdentifier:)
		t("override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {"),
		t({ "", "    super.init(style: style, reuseIdentifier: reuseIdentifier)" }),
		t({ "", "    selectionStyle = .none" }),
		t({ "", "    backgroundColor = .clear" }),
		t({ "", "    contentView.backgroundColor = .clear" }),
		t({ "", "    createSubViews()" }),
		t({ "", "}" }),
		t({ "", "" }),

		-- required init?(coder:)
		t("@available(*, unavailable)"),
		t({ "", "required init?(coder: NSCoder) {" }),
		t({ "", '    fatalError("init(coder:) has not been implemented")' }),
		t({ "", "}" }),
		t({ "", "" }),

		-- createSubViews
		t("private func createSubViews() {"),
		t({ "", "    setupLayout()" }),
		t({ "", "}" }),
		t({ "", "" }),

		-- setupLayout
		t("private func setupLayout() {"),
		t({ "", "    " }),
		i(1, ""),
		t({ "", "}" }),
		t({ "", "" }),

		-- MARK
		t("// MARK: 懒加载"),
		t({ "", "" }),
	}),
}
