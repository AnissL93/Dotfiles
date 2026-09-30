// load chrome/userChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
// web page monospace (code blocks): IBM VGA, Chinese falls back to the CJK font (set-cjk-font)
user_pref("font.name.monospace.x-western", "PxPlus IBM VGA 8x16");
user_pref("font.name.monospace.zh-CN", "PxPlus IBM VGA 8x16");
user_pref("font.size.monospace.x-western", 16);
user_pref("font.size.monospace.zh-CN", 16);
// explicit Chinese fallback (fontconfig would pick Noto CJK for zh pages)
user_pref("font.name-list.monospace.x-western", "PxPlus IBM VGA 8x16, Cubic 11");
user_pref("font.name-list.monospace.zh-CN", "PxPlus IBM VGA 8x16, Cubic 11");

// force my fonts on every page: ignore page-supplied fonts, all generic families -> IBM VGA + CJK font (set-cjk-font)
user_pref("browser.display.use_document_fonts", 0);
user_pref("font.name-list.monospace.x-unicode", "PxPlus IBM VGA 8x16, Cubic 11");
user_pref("font.name-list.monospace.zh-HK", "PxPlus IBM VGA 8x16, Cubic 11");
user_pref("font.name-list.monospace.zh-TW", "PxPlus IBM VGA 8x16, Cubic 11");
user_pref("font.name-list.sans-serif.x-unicode", "PxPlus IBM VGA 8x16, Cubic 11");
user_pref("font.name-list.sans-serif.x-western", "PxPlus IBM VGA 8x16, Cubic 11");
user_pref("font.name-list.sans-serif.zh-CN", "PxPlus IBM VGA 8x16, Cubic 11");
user_pref("font.name-list.sans-serif.zh-HK", "PxPlus IBM VGA 8x16, Cubic 11");
user_pref("font.name-list.sans-serif.zh-TW", "PxPlus IBM VGA 8x16, Cubic 11");
user_pref("font.name-list.serif.x-unicode", "PxPlus IBM VGA 8x16, Cubic 11");
user_pref("font.name-list.serif.x-western", "PxPlus IBM VGA 8x16, Cubic 11");
user_pref("font.name-list.serif.zh-CN", "PxPlus IBM VGA 8x16, Cubic 11");
user_pref("font.name-list.serif.zh-HK", "PxPlus IBM VGA 8x16, Cubic 11");
user_pref("font.name-list.serif.zh-TW", "PxPlus IBM VGA 8x16, Cubic 11");
user_pref("font.name.monospace.x-unicode", "PxPlus IBM VGA 8x16");
user_pref("font.name.monospace.zh-HK", "PxPlus IBM VGA 8x16");
user_pref("font.name.monospace.zh-TW", "PxPlus IBM VGA 8x16");
user_pref("font.name.sans-serif.x-unicode", "PxPlus IBM VGA 8x16");
user_pref("font.name.sans-serif.x-western", "PxPlus IBM VGA 8x16");
user_pref("font.name.sans-serif.zh-CN", "PxPlus IBM VGA 8x16");
user_pref("font.name.sans-serif.zh-HK", "PxPlus IBM VGA 8x16");
user_pref("font.name.sans-serif.zh-TW", "PxPlus IBM VGA 8x16");
user_pref("font.name.serif.x-unicode", "PxPlus IBM VGA 8x16");
user_pref("font.name.serif.x-western", "PxPlus IBM VGA 8x16");
user_pref("font.name.serif.zh-CN", "PxPlus IBM VGA 8x16");
user_pref("font.name.serif.zh-HK", "PxPlus IBM VGA 8x16");
user_pref("font.name.serif.zh-TW", "PxPlus IBM VGA 8x16");
user_pref("font.size.monospace.x-unicode", 16);
user_pref("font.size.monospace.zh-HK", 16);
user_pref("font.size.monospace.zh-TW", 16);
user_pref("font.size.variable.x-unicode", 16);
user_pref("font.size.variable.x-western", 16);
user_pref("font.size.variable.zh-CN", 16);
user_pref("font.size.variable.zh-HK", 16);
user_pref("font.size.variable.zh-TW", 16);
