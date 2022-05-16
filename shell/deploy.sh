#!/bin/bash

########################################################
#####       在本地开发环境，一键部署到 Linux 生产环境
#####             必须在 shell 目录下执行脚本
########################################################

# 更新流程
# 1. 在本地执行一键部署脚本： bash deploy.sh
# 2. 浏览器强制刷新页面后，即可正常加载最新的 Web 资源文件，无需重启 Web 服务器

# 读取INI配置文件
function __readINI() {
 	INIFILE=$1; SECTION=$2; ITEM=$3
 	_readContent=`awk -F '=' '/\['$SECTION'\]/{a=1}a==1&&$1~/'$ITEM'/{print $2;exit}' $INIFILE`
	echo ${_readContent}
}

# 初始化连接参数
_HOST=( $( __readINI /etc/rsyncd.ini MarkdownWeiXin host ) )
_USER=( $( __readINI /etc/rsyncd.ini MarkdownWeiXin user ) )
_MODULE=( $( __readINI /etc/rsyncd.ini MarkdownWeiXin module ) )
_PASSWORD_FILE=( $( __readINI /etc/rsyncd.ini MarkdownWeiXin password_file ) )

# 源目录
_DIST_DIR='./docs/'

# 切换目录
cd ..

# 清理文件
npm run clean

# 编译构建
npm run build

# 同步文件到生产服务器（使用 "--delete" 参数删除目标目录比源目录多余的文件）
rsync -avzP --delete --no-o --no-g $_DIST_DIR $_USER@$_HOST::$_MODULE/ --password-file=$_PASSWORD_FILE
