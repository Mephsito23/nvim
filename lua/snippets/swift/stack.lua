local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
	s("stackV", {
		t("private lazy var "),
		i(1, "stackV"),
		t(": UIStackView = {"),
		t({ "", "    let " }),
		rep(1),
		t(" = UIStackView()"),
		t({ "", "    " }),
		rep(1),
		t(".axis = .vertical"),
		t({ "", "    " }),
		rep(1),
		t(".isLayoutMarginsRelativeArrangement = true"),
		t({ "", "    " }),
		rep(1),
		t(".directionalLayoutMargins = .init("),
		t({ "", "        top: " }),
		i(2, "0"),
		t({ ",", "        leading: " }),
		i(3, "0"),
		t({ ",", "        bottom: " }),
		i(4, "0"),
		t({ ",", "        trailing: " }),
		i(5, "0"),
		t({ "", "    )" }),
		t({ "", "    " }),
		rep(1),
		t(".spacing = "),
		i(6, "8"),
		t({ "", "    " }),
		rep(1),
		t(".insetsLayoutMarginsFromSafeArea = false"),
		t({ "", "    return " }),
		rep(1),
		t({ "", "}()" }),
	}),
}
