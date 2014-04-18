title: "mplayer网络视频"
id: 2
date: 2012-02-21 19:10:54
tags:
- mplayer
categories:
- computer
---

+ **Q: 如何用mplayer录制视频,比如录制在线电影,电视?**

```bash
$ mplayer mms://*.*.*.*/test.asf -dumpstream -dumpfile MyMovie.asf
```
可以把mms ,rtsp.http.ftp….等协议的视频流录制下来,保存为 MyMovie.asf文件.

<!--more-->

+ **Q: 如何用mplayer查看摄像头？**

```bash
$ mplayer tv:// -tv driver=v4l2:input=0:width=640:height=480:fps=25 -vo x11
$ dd if=/dev/video0 | mplayer tv://device=/dev/stdin
```

+ **Q: 如何通过ssh用mplayer查看远程摄像头**

```bash
$ ssh -p xxx xxx@xxx -Y "mplayer tv://device=/dev/video0"
$ ssh -p xxx xxx@xxx -Y "mplayer -tv device=/dev/video0:width=320:height=240:fps=25 tv://"
# 本地测试
$ ssh localhost dd if=/dev/video0 | mplayer tv://device=/dev/stdin
# 播放mp3
$ ssh user@192.168.1.101 "cat music.mp3" | mplayer -
```
接近的
```bash
# 本地
$ ffmpeg  -f video4linux2 -s 640*480 -i /dev/video0  -f flv file
# 远程
$ ssh user@xxx "cat file" | mplayer -

# 整合
$ ssh user@xxx "ffmpeg  -f video4linux2 -s 640*480 -i /dev/video0  -f flv file & sleep 15s;cat file" | mplayer -
```
