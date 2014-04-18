title: "goagent"
id: 4
date: 2012-10-12 16:29:18
tags:
- 翻墙
categories:
- computer
---

GoAgent是使用Python和Google App EngineSDK编写的免费代理软件，该软件在中国大陆一般被当作破网软件，用来浏览被中国大陆官方建立的防火长城所屏蔽的网络服务。

<!--more-->

如何部署和使用goagent？
---------------------

1. 申请Google Appengine并创建appid。
2. 下载goagent稳定版 
3. 修改local\proxy.ini中的[gae]下的appid=你的appid(多appid请用|隔开)　
4. 上传，开服务
5. chrome请安装SwitchySharp插件，然后导入这个设置　
6. firefox请安装FoxyProxy，Firefox需要导入证书。

GAE注意点：
---------

[GAE](http://appengine.google.com) 每个帐号最多十个app，每个应用每天有1GB免费流量。如果你经常下载或者观看视频，建议多创建几个Google App Engine应用。

谷歌账户[设置页面](https://www.google.com/settings)，在安全性-两步认证处，点击修改；启用两步验证。

为你的Application创建密码，settings》安全》向应用和网站授权，第一次找了好久，上传应用用的到密码。

goagent注意点
------------

* archlinux用pacman安装，主要是写好了systemd 的servie文件。

配置文件为/etc/goagent  
[gae]下：  
appid = 你的appid(多appid请用|隔开)  
password = app的密码。

* server文件夹里的怎么上传？

自带的可能由于python有问题。换用google的Python版的Google App Engine SDK
地址：https://developers.google.com/appengine/downloads

修改server/python 文件夹内 app.yaml文件，把第一行文字改为 application:(你的appid)

在google_appengine目录下执行：
```bash
$ python2 appcfg.py update path/to/server/python
```

中间询问你的gmail邮箱，密码是app设置的密码，不是他问的邮箱密码，要不会出错。
这样配置就能成功了。

总结：
----

安装，设置appid;

GAE上传，密码，python2 GAE_SDK;

开启服务，浏览器设置代理

ps：
----

1. 解决GoAgent打开https网站SSL证书错误 (安全证书不受信任)  
1）FireFox->选项->高级->加密->查看证书->证书机构->导入证书, 选择local\CA.crt, 勾选所有项，导入。  
2）chrome高级设置https/ssl管理中心》授权中心，导入CA.crt, 询问选项全选。

2. chrome请安装SwitchySharp插件, 导入SwitchySharp配置  
下载地址http://goagent.googlecode.com/files/SwitchyOptions.bak  
进入SwitchySharp设置界面，点击“导入/导出”》“从文件恢复”，导入刚才下载的SwitchyOptions.bak
