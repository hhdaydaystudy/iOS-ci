#! bin/bash
#我的简书:http://www.jianshu.com/u/fe6c0b46d16d  欢迎Star
#Use:命令行进入目录直接执行sh Build+DeployToFir.sh即可完成打包发布到fir.im

#注意:使用本脚本上传到fir.im需要满足以下环境:一. ruby版本>1.9.3 (查看当前ruby版本 ruby -v) 二. ruby安装完毕,安装fir.im命令行插件 (gem install fir-cli)


export LC_ALL=zh_CN.GB2312;
export LANG=zh_CN.GB2312

#一些路径的切换：切换到你的工程文件目录---------①此处需要手动修改项目所在路径
projectPath=/Users/lihu/Desktop/Jenkins_job/AppicAdDemo/proj_pod
cd ..
cd $projectPath

###############设置需编译的项目配置名称
buildConfig="Debug" #编译的方式,有Release,Debug，自定义的AdHoc等

##########################################################################################
##############################以下部分为自动生成部分，不需要手动修改############################
##########################################################################################
#项目名称
projectName=`find . -name *.xcodeproj | awk -F "[/.]" '{print $(NF-1)}'`
echo "项目名称:$projectName"
projectDir=`pwd` #项目所在目录的绝对路径
echo $projectDir
wwwIPADir=~/Desktop/$projectName-IPA #ipa，icon最后所在的目录绝对路径
isWorkSpace=true  #判断是用的workspace还是直接project，workspace设置为true，否则设置为false

echo "~~~~~~~~~~~~~~~~~~~开始编译~~~~~~~~~~~~~~~~~~~"
if [ -d "$wwwIPADir" ]; then
echo $wwwIPADir
echo "文件目录存在"
else
echo "文件目录不存在"
mkdir -pv $wwwIPADir
echo "创建${wwwIPADir}目录成功"
fi

###############进入项目目录
cd $projectDir
rm -rf ./build
buildAppToDir=$projectDir/build #编译打包完成后.app文件存放的目录

###############获取版本号,bundleID
infoPlist="$projectName/*-Info.plist"
bundleVersion=`/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" $infoPlist`
bundleIdentifier=`/usr/libexec/PlistBuddy -c "Print CFBundleIdentifier" $infoPlist`
bundleBuildVersion=`/usr/libexec/PlistBuddy -c "Print CFBundleVersion" $infoPlist`

###############开始编译app
if $isWorkSpace ; then  #判断编译方式
echo  "开始编译workspace...."
xcodebuild  -workspace $projectName.xcworkspace -scheme $projectName  -configuration $buildConfig clean build SYMROOT=$buildAppToDir
else
echo  "开始编译target...."
xcodebuild  -target  $projectName  -configuration $buildConfig clean build SYMROOT=$buildAppToDir
fi
#判断编译结果
if test $? -eq 0
then
echo "~~~~~~~~~~~~~~~~~~~编译成功~~~~~~~~~~~~~~~~~~~"
else
echo "~~~~~~~~~~~~~~~~~~~编译失败~~~~~~~~~~~~~~~~~~~"
exit 1
fi

###############开始打包成.ipa
ipaName=`echo $projectName | tr "[:upper:]" "[:lower:]"` #将项目名转小写
findFolderName=`find . -name "$buildConfig-*" -type d |xargs basename` #查找目录
appDir=$buildAppToDir/$findFolderName/  #app所在路径


outPath=$projectPath/temp
#####检测outPath路径是否存在
if [ -d "$outPath" ]; then
echo $outPath
echo "文件目录存在"
else
echo "文件目录不存在"
mkdir -pv $outPath
echo "创建${outPath}目录成功"
fi

#sudo chmod -R 777 $outPath

echo "开始打包$projectName.app成$projectName.ipa....."

xcrun -sdk iphoneos -v PackageApplication $appDir/$projectName.app  -o $outPath/$projectName.ipa

###############开始拷贝到目标下载目录
#检查文件是否存在
if [ -f "$outPath/$ipaName.ipa" ]
then
echo "打包$ipaName.ipa成功."
else
echo "打包$ipaName.ipa失败."
exit 1
fi

Export_Path=$wwwIPADir/$projectName$(date +%Y%m%d-%H:%M:%S).ipa
cp -f -p $outPath/$ipaName.ipa $Export_Path   #拷贝ipa文件
echo "复制$ipaName.ipa到${wwwIPADir}成功"
rm -rf $outPath
rm -rf ./build
echo "~~~~~~~~~~~~~~~~~~~结束编译，处理成功~~~~~~~~~~~~~~~~~~~"
#open $wwwIPADir






#####开始上传，如果只需要打ipa包出来不需要上传，可以删除下面的代码
export LANG=en_US
export LC_ALL=en_US;
echo "正在上传到fir.im...."
#fir p $Export_Path
changelog=`cat $projectDir/platforms.json`

# 将生成的文件，上传到fir分发网站 -T：后面的是api的token，验证你的身份。使用这个之前，必须先安装fir的命令行工具： $ sudo gem install fir-cli --no-ri --no-rdoc
#-Q 参数, 是否生成发布后二维码, 默认为不生成, 加上 -Q 参数后会在当前目录生成一张二维码图片, 扫描该图片即可下载该应用.
#--open 参数, 设置发布后的应用是否开放给所有人下载, 关闭开放使用 --no-open 参数.--password 参数, 设置发布后的应用密码
#-c 参数, 自定义发布时的 changelog, 支持字符串与文件两种方式, 即 --changelog='this is changelog' 和 --changelog='/Users/fir-cli/changelog'.
fir p $Export_Path -T c1d4249668197b1034d138c59a**** -c "Your test ipa" -Q

echo "\n打包上传更新成功！"
rm -rf $buildAppToDir
rm -rf $projectDir/tmp



