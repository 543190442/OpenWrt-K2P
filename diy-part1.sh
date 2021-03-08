#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
rm -Rf files/etc/profile.d/sysinfo.sh

find target/linux/ramips/* -maxdepth 0 ! -path '*/patches-5.4' -exec rm -Rf '{}' \;
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips target/linux/ramips
rm -Rf target/linux/ramips/.svn
echo -e "\q" | svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ramips/patches-5.4 target/linux/ramips/patches-5.4

sed -i 's?admin/status/channel_analysis??' package/feeds/luci/luci-mod-status/root/usr/share/luci/menu.d/luci-mod-status.json

sed -i 's/O2/Os/g' include/target.mk

sed -i '/unsplash.com/d' package/feeds/custom/luci-theme-edge/luasrc/view/themes/edge/sysauth.htm

sed -i 's?<img src="<%=media%>/background/3.jpg" alt="img"/>??' package/feeds/custom/luci-theme-edge/luasrc/view/themes/edge/sysauth.htm

rm -f package/feeds/custom/luci-theme-edge/htdocs/luci-static/edge/background/3.jpg

sed -i '/app_update/d' package/feeds/custom/luci-app-bypass/luasrc/controller/bypass.lua

sed -i 's/PKG_VERSION:=1/PKG_VERSION:=2/' package/feeds/custom/luci-app-bypass/Makefile

sed -i 's/ +unzip +lua-maxminddb//' package/feeds/custom/luci-app-bypass/Makefile

sed -i '/status_bottom/d' package/feeds/custom/luci-app-bypass/luasrc/model/cbi/bypass/base.lua

rm -Rf package/feeds/custom/luci-app-bypass/{root/www,root/usr/share/bypass/GeoLite2-Country.mmdb}
