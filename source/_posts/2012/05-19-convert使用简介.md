title: "convert使用简介"
id: 3
date: 2012-05-19 16:49:08
tags:
- convert
categories:
- computer
---

最近赶毕业设计，结果出了很多图。要相互比较，还有做动画看物理量随时间的变化。

结果保存在ps文件中，一个包含7张图，每图一个物理量。ps文件是按时间i命名的。为了批量处理，决定用convert配合shell脚本转换他们。

<!--more-->

安装使用ImageMagick
----------------

#### 1. 直接将PS或者PDF文件转成jpg

```bash
 $ convert -density 150 -quality 100 -resize 800x "file.ps" "result.jpg"
```
将file.pdf文件输出为result.jpg文件  
如果PDF有多页，图像将自动以result-0.jpg' , 'result-1.jpg'...形式输出。

> -density 图像分辨率  
 -quality 图像质量

#### 2. 图片截取

指定位置，由于每张图只占一页的部分，靠近左下。
```bash
$ convert -crop widthxheight{+-}x{+-}y{%}
```
> width 子图片宽度  
 height 子图片高度  
 x 为正数时为从区域左上角的x坐标,为负数时,左上角坐标为0,然后从截出的子图片右边减去x象素宽度.  
 y 为正数时为从区域左上角的y坐标,为负数时,左上角坐标为0,然后从截出的子图片上边减去y象素高度.

如:
```bash
$ convert -crop 300x400+10+10 src.jpg dest.jpg # 从src.jpg坐标为x:10 y:10截取300x400的图片存为dest.jpg

$ convert -crop 300x400-10+10 src.jpg dest.jpg # 从src.jpg坐标为x:0 y:10截取290x400的图片存为dest.jpg
```

#### 3. 生成gif

> 把当前目录下的所有bmp文件合成一个gif图片动画, 每帧间隔0ms, 重复播放.  
 -delay n 迟延n*10毫秒
 -loop n 播放n轮, 0表示不断地重复播放

```bash
$ convert -delay 0 *.bmp -loop 0 animated.gif
```

> So to create an animation we use the convert command

```bash
 $ convert -delay 50 frame1.gif frame1.gif frame1.gif -loop 0 animated.gif
```

> Also if we want to add a pause between each loop

```bash
 $ convert -delay 50 frame1.gif -delay 100 frame1.gif -delay 150 frame1.gif -loop 0 -pause 200 animated.gif
```

> Also using convert we can combine 2 animated gifs


```bash
 $ convert anim1.gif anim2.gif combined.gif
```

#### 4. 合并图片

```bash
# 横向
$ convert +append 6-$f.png 7-$f.png tmp4.png
# 纵向
$ convert -append tmp1.png tmp2.png tmp3.png tmp4.png c$f.png
```

最终的脚本
--------------------------------------------

```bash
#!/bin/bash
## ps转换为png,png适合单独引用

echo "converting png ..."
for f in 0 1 2 3 4 5 6 7
do
convert -crop 440x210+60+440 -quality 100 $f.ps $f.png
done
echo  "composit 8 png files"
for f in 0 1 2 3 4 5 6 7
do
convert +append 0-$f.png 1-$f.png tmp1.png
convert +append 2-$f.png 3-$f.png tmp2.png
convert +append 4-$f.png 5-$f.png tmp3.png
convert +append 6-$f.png 7-$f.png tmp4.png
convert -append tmp1.png tmp2.png tmp3.png tmp4.png c$f.png
done
## ps转换成jpg，用于制作动画
echo "converting jpg ..."
for f in 0 1 2 3 4 5 6 7
do
convert -crop 440x210+60+440 -quality 100 $f.ps $f.jpg
done
## jpg做成gif动画，8张
echo "converting gif ..."
for f in 0 1 2 3 4 5 6 7;do convert -delay 50 *-$f.jpg -loop 0 $f.gif; done
## 删除jpg文件
echo "rm all jpg files, tmp files"
rm *.jpg
rm tmp*.png
```
