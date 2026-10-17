// ==UserScript==
// @name        Bilibili CDN -> mirrorali
// @namespace   local.bili-cdn
// @match       https://www.bilibili.com/*
// @run-at      document-start
// @inject-into page
// @grant       none
// @version     1
// ==/UserScript==
// Rewrites video segment requests (upos/akamai/mcdn) to a faster upos mirror.
// The signed query string stays valid across upos mirrors.
const HOST = 'upos-sz-mirrorali.bilivideo.com' // ponytail: hardcoded fastest from 2026-10-06 speed test; re-test if it gets slow

function rewrite(u) {
  try {
    const url = new URL(u, location.href)
    if (!url.pathname.startsWith('/upgcxcode/')) return u
    if (!/(^upos-.*\.(bilivideo\.com|akamaized\.net)$)|mcdn\.bilivideo\.cn$|szbdyd\.com$/.test(url.hostname)) return u
    url.hostname = HOST
    url.port = ''
    url.protocol = 'https:'
    return url.href
  } catch { return u }
}

if (typeof window !== 'undefined') {
  const open = XMLHttpRequest.prototype.open
  XMLHttpRequest.prototype.open = function (m, u, ...rest) { return open.call(this, m, rewrite(String(u)), ...rest) }
  const f = window.fetch
  window.fetch = function (input, init) {
    if (input instanceof Request) {
      const n = rewrite(input.url)
      return f.call(this, n === input.url ? input : new Request(n, input), init)
    }
    return f.call(this, rewrite(String(input)), init)
  }
} else {
  // self-check: node bili-cdn.user.js
  globalThis.location = { href: 'https://www.bilibili.com/' }
  const assert = require('assert')
  const q = '/upgcxcode/58/34/187313458/187313458-1-30064.m4s?e=x&os=akam'
  assert.equal(rewrite('https://upos-hz-mirrorakam.akamaized.net' + q), 'https://' + HOST + q)
  assert.equal(rewrite('https://xy1x2x3x4xy.mcdn.bilivideo.cn:4483' + q), 'https://' + HOST + q)
  assert.equal(rewrite('https://api.bilibili.com/x/player/playurl'), 'https://api.bilibili.com/x/player/playurl')
  assert.equal(rewrite('https://i0.hdslb.com/upgcxcode/a.jpg'), 'https://i0.hdslb.com/upgcxcode/a.jpg')
  console.log('ok')
}
