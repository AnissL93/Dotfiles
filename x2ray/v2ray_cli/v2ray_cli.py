#! /usr/bin/python3
'''
@Author: Shuying Li <libunko@qq.com>
@Date: 2020-02-14 16:16:53
@LastEditTime: 2020-06-28 12:42:03
@LastEditors: Shuying Li <libunko@qq.com>
@Description: 
@FilePath: /v2ray_cli/v2ray_cli.py
'''

import os
import configparser
from subscribe import Subscribe

cfg_pathname = "./cfg.conf"
json_template_pathname = "./config.json.template"


if __name__ == "__main__":
    # cfg = configparser.ConfigParser()
    # cfg.read(cfg_pathname, encoding='UTF-8')

    url = "https://patriot.ninja//index.php?m=wray&token=rOI%2Fp7RBv4DJS7rd1hhitjq5TLoAdTZshr52NwxgbN3z4tCYf8Cl6XUtysngds8S8Eq8kT7B7mY%3D"
    # if cfg["subscribe"]["url"] == "":
    #     url = input("Please Enter The Subscription Address: ")
    #     cfg["subscribe"] = {"url": url}
    #     with open(cfg_pathname, 'w') as cfg_file:
    #         cfg.write(cfg_file)
    # else:
    #     url = cfg["subscribe"]["url"]

    sub = Subscribe(url, json_template_pathname)
