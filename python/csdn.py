import re
from selenium import webdriver
import requests

# url = 'https://blog.csdn.net/u010853261/article/details/85231944'
url = 'https://blog.csdn.net/love666666shen/article/details/117606549?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522163017230716780264047326%2522%252C%2522scm%2522%253A%252220140713.130102334..%2522%257D&request_id=163017230716780264047326&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduend~default-1-117606549.first_rank_v2_pc_rank_v29&utm_term=go%E5%86%85%E5%AD%98%E7%AE%A1%E7%90%86&spm=1018.2226.3001.4187'
prefix = "channel"

i = 0


def save_image(url):
    global i
    img = requests.get(url)
    image_name = 'images/' + prefix + '-' + str(i) + ".jpg"

    with open(image_name, 'wb') as f:
        f.write(img.content)
        f.close()
    i += 1
    return


driver = webdriver.Chrome()
driver.get(url)
# driver.maximize_window()
html = driver.page_source
lst = re.findall(r'<img src="(.*?)"', html)
image_url_list = []
for item in lst:
    if str(item).find("x-oss-process=image/resize,m_fixed,h_64,w_64") != -1:
        continue
    if str(item).startswith("https://img-blog.csdnimg.cn/"):
        image_url_list.append(item)
    if str(item).startswith("https://img-blog.csdn.net"):
        image_url_list.append(item)

for img_url in image_url_list:
    save_image(img_url)

driver.close()
