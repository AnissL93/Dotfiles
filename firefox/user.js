// load chrome/userChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
// web page monospace (code blocks): IBM VGA, Chinese falls back to the CJK font (set-cjk-font)
user_pref("font.name.monospace.x-western", "Iosevka SS14");
user_pref("font.name.monospace.zh-CN", "Iosevka SS14");
user_pref("font.size.monospace.x-western", 16);
user_pref("font.size.monospace.zh-CN", 16);
// explicit Chinese fallback (fontconfig would pick Noto CJK for zh pages)
user_pref("font.name-list.monospace.x-western", "Iosevka SS14, Sarasa Mono SC");
user_pref("font.name-list.monospace.zh-CN", "Iosevka SS14, Sarasa Mono SC");

// force my fonts on every page: ignore page-supplied fonts, all generic families -> IBM VGA + CJK font (set-cjk-font)
user_pref("browser.display.use_document_fonts", 0);
user_pref("font.name-list.monospace.x-unicode", "Iosevka SS14, Sarasa Mono SC");
user_pref("font.name-list.monospace.zh-HK", "Iosevka SS14, Sarasa Mono SC");
user_pref("font.name-list.monospace.zh-TW", "Iosevka SS14, Sarasa Mono SC");
user_pref("font.name-list.sans-serif.x-unicode", "Iosevka SS14, Sarasa Mono SC");
user_pref("font.name-list.sans-serif.x-western", "Iosevka SS14, Sarasa Mono SC");
user_pref("font.name-list.sans-serif.zh-CN", "Iosevka SS14, Sarasa Mono SC");
user_pref("font.name-list.sans-serif.zh-HK", "Iosevka SS14, Sarasa Mono SC");
user_pref("font.name-list.sans-serif.zh-TW", "Iosevka SS14, Sarasa Mono SC");
user_pref("font.name-list.serif.x-unicode", "Iosevka SS14, Sarasa Mono SC");
user_pref("font.name-list.serif.x-western", "Iosevka SS14, Sarasa Mono SC");
user_pref("font.name-list.serif.zh-CN", "Iosevka SS14, Sarasa Mono SC");
user_pref("font.name-list.serif.zh-HK", "Iosevka SS14, Sarasa Mono SC");
user_pref("font.name-list.serif.zh-TW", "Iosevka SS14, Sarasa Mono SC");
user_pref("font.name.monospace.x-unicode", "Iosevka SS14");
user_pref("font.name.monospace.zh-HK", "Iosevka SS14");
user_pref("font.name.monospace.zh-TW", "Iosevka SS14");
user_pref("font.name.sans-serif.x-unicode", "Iosevka SS14");
user_pref("font.name.sans-serif.x-western", "Iosevka SS14");
user_pref("font.name.sans-serif.zh-CN", "Iosevka SS14");
user_pref("font.name.sans-serif.zh-HK", "Iosevka SS14");
user_pref("font.name.sans-serif.zh-TW", "Iosevka SS14");
user_pref("font.name.serif.x-unicode", "Iosevka SS14");
user_pref("font.name.serif.x-western", "Iosevka SS14");
user_pref("font.name.serif.zh-CN", "Iosevka SS14");
user_pref("font.name.serif.zh-HK", "Iosevka SS14");
user_pref("font.name.serif.zh-TW", "Iosevka SS14");
user_pref("font.size.monospace.x-unicode", 16);
user_pref("font.size.monospace.zh-HK", 16);
user_pref("font.size.monospace.zh-TW", 16);
user_pref("font.size.variable.x-unicode", 16);
user_pref("font.size.variable.x-western", 16);
user_pref("font.size.variable.zh-CN", 16);
user_pref("font.size.variable.zh-HK", 16);
user_pref("font.size.variable.zh-TW", 16);

// web pages' light/dark (prefers-color-scheme) follows the system (portal color-scheme, set by `theme`)
user_pref("layout.css.prefers-color-scheme.content-override", 2);

// hardware video decoding through VA-API (nvidia-vaapi-driver; env vars in desktop/linux/x11/xinitrc)
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.hardware-video-decoding.force-enabled", true);
user_pref("widget.dmabuf.force-enabled", true);
