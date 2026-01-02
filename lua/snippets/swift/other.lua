local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require("luasnip.extras").rep

return {
	s("available_deprecated", {
		t('@available(*, deprecated, message: "'),
		i(1, "message"),
		t('")'),
		i(0),
	}),
	s("dispatch_main", {
		t("DispatchQueue.main.async {"),
		t({ "", "" }),
		t("    "),
		i(1, "// Code to execute on main thread"),
		t({ "", "" }),
		t("}"),
	}),
	s("dispatch_async", {
		t("DispatchQueue.global.async {"),
		t({ "", "" }),
		t("    "),
		i(1, "// Code to execute on main thread"),
		t({ "", "" }),
		t("}"),
	}),
	s("dispatch_after", {
		t("DispatchQueue.main.asyncAfter(deadline: .now() + "),
		i(1, "2.0"),
		t(") {"),
		t({ "", "" }),
		t("    "),
		i(2, "// Code to execute after delay"),
		t({ "", "" }),
		t("}"),
	}),
	s("weakSelf", {
		t("guard let self else { return }"),
	}),
}
