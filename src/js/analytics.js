"use strict";

const host = window.location.host;
const google_analytics_id = "UA-135294383-1";
const baidu_tongji_id = "43c937a5b15d4206e725c4d25d1168d2";

function insertScript(src, async) {
	var hm = document.createElement("script");
	hm.src = src;
	if (!async) {
		hm.async = false;
	} else {
		hm.async = true;
	}
	var s = document.getElementsByTagName("script")[0];
	s.parentNode.insertBefore(hm, s);
}

// Google Analytics
function googleAnalytics() {
	insertScript("https://www.googletagmanager.com/gtag/js?id=" + google_analytics_id, true);
	window.dataLayer = window.dataLayer || [];
	function gtag() {
		dataLayer.push(arguments);
	}
	if (host.indexOf("127.0.0.1") == -1 && host.indexOf("localhost") == -1) {
		gtag('js', new Date());
		gtag('config', google_analytics_id);
	}
}

// Baidu TongJi
function baiduTongJi() {
	var _hmt = _hmt || [];
	if (host.indexOf("127.0.0.1") == -1 && host.indexOf("localhost") == -1) {
		insertScript("https://hm.baidu.com/hm.js?" + baidu_tongji_id);
	}
}

function analytics() {
	baiduTongJi();
	googleAnalytics();
}

module.exports = analytics;