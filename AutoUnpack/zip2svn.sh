#!/bin/bash

# 如果在不同的project 使用脚本，请修改以下参数
# 脚本第一个参数是 apk路径
# 脚本第二个参 数是 备注
# 脚本第三个参数是 svn上传路径
# 脚本配置
apkdirDefault="."
apkdirDefault2="build/outputs/apk/"
remarkDefault="E学堂Android打包"
svndirDefault="https://jinxixin.com/svn/DocumentsManage/ELN/Test/Android/"
svnUserDefault="zhongkeng"

# 获取 apk 目录，默认当前目录
apkdir=$1
[ "$apkdir" = "" ] && apkdir=$apkdirDefault
echo "cd "$apkdir
cd $apkdir

# 压缩文件 按时间倒序显示列表，取排第一apk结尾的进行
zipname=""
for filename in `ls -lt`
do
    if [[ $filename =~ "apk" ]]
    then
        zipname=${filename/%.apk/.zip}
	zip ${zipname} ${filename}
        break
    fi
done


# 复制 svn 地址
svndir=$3
[ "$svndir" = "" ] && svndir=${svndirDefault}
# echo "copy zip to "$svndir
# cp $zipname $svndir
# cd $svndir


# 上传svn
remark=$2
[ "$remark" = "" ] && remark=${remarkDefault}
echo svn --username ${svnUserDefault} import ${zipname} ${svndir}${zipname} -m "${remark}"
svn --username ${svnUserDefault} import ${zipname} ${svndir}${zipname} -m "${remark}"
#svn --username ${svnUser} delete ${svndirDefault}${zipname} -m "删除无用包"
