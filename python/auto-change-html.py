import os
import re
def func1(filename):
    with open(filename, "r", encoding='utf-8') as f:
        c = f.read()
    data = c.split("\n")
    str1 = '''
            this.token = localStorage.getItem("token")
            this.authenticate = localStorage.getItem("authenticate")
            if(!this.token || !this.authenticate){
                landConfig.popupCover({
                    content: '请验证'
                })
                return;
            }
    '''
    str2 = '''
    <script>
        window.onload = function () {
            // 初始化
            new YpRiddler({
                expired: 10,
                mode: 'dialog',
                winWidth: '70%',
                lang: 'zh-cn', // 界面语言, 目前支持: 中文简体 zh-cn, 英语 en
                // langPack: LANG_OTHER, // 你可以通过该参数自定义语言包, 其优先级高于lang
                container: document.getElementById('cbox'),
                appId: '32f40fbbcf0445adb708708dcaf51cbd',
                version: 'v1',
                onError: function (param) {
                        if (!param.code) {
                            console.error('错误请求');
                        }
                        else if (parseInt(param.code / 100) == 5) {
                            // 服务不可用时，开发者可采取替代方案
                            console.error('验证服务暂不可用');
                        }
                        else if (param.code == 429) {
                            console.warn('请求过于频繁，请稍后再试');
                        }
                        else if (param.code == 403) {
                            console.warn('请求受限，请稍后再试');
                        }
                        else if (param.code == 400) {
                            console.warn('非法请求，请检查参数');
                        }
                    // 异常回调
                    console.error('验证服务异常')
                },
                onSuccess: function (validInfo, close, useDefaultSuccess) {
                    // 成功回调
                    // alert('验证通过! token=' + validInfo.token + ', authenticate=' + validInfo.authenticate)
                    // this.token =  validInfo.token
                    // this.authenticate =  validInfo.authenticate
                    localStorage.setItem('token', validInfo.token)
                    localStorage.setItem('authenticate', validInfo.authenticate)
    
                    // 验证成功默认样式
                    useDefaultSuccess(true)
                    close()
                },
                onFail: function (code, msg, retry) {
                    // 失败回调
                    alert('出错啦：' + msg + ' code: ' + code)
                    retry()
                },
                beforeStart: function (next) {
                    console.log('验证马上开始')
                    next()
                },
                onExit: function () {
                    // 退出验证 （仅限dialog模式有效）
                    console.log('退出验证')
                }
            })
        }
    </script>
    '''
    tmp = 0
    lst = []
    for str in data:
        lst.append(str)
        if tmp != 0:
            tmp += 1
        if str.strip().startswith('<script src="https://sshua.oss-cn-shanghai.aliyuncs.com/static/js/jquery.min.js'):
            lst.append('<script src="https://www.yunpian.com/static/official/js/libs/riddler-sdk-0.2.2.js"></script>')
        if str.strip().startswith("function sendemail"):
            for t1 in str1.split("\n"):
                lst.append(t1)
        if str.strip().startswith('<input type="button"  class="getcode_btn" id="getCodeBtn" value="获取验证码" onclick="sendem'):
            print("true")
            tmp = 1
        if tmp == 3:  # 到了某个节点
            lst.append('<div id="cbox"></div>')
        if str.strip().startswith('<script src="./vendor/js/statistics.js"></script> -->'):
            for t2 in str2.split("\n"):
                lst.append(t2)
    lst2 = []
    for x in lst:
        s = x + "\n"
        lst2.append(s)
    with open(filename + "_gen",'w',encoding='utf-8') as f:
        f.writelines(lst2)
for c in os.listdir('.'):
    bo = re.match('\d+\.html', c)
    if bo:
        func1(c)