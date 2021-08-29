import json
import time

import requests

# 拿到ajax下拉url链接  =&start={}
url = 'https://www.duitang.com/napi/blog/list/by_search/?kw=%E5%88%80%E5%89%91%E7%A5%9E%E5%9F%9F&type=feed&include_fields=top_comments%2Cis_root%2Csource_link%2Citem%2Cbuyable%2Croot_id%2Cstatus%2Clike_count%2Clike_id%2Csender%2Calbum%2Creply_count%2Cfavorite_blog_id&_type=&start={}&_=1630216621787'

prefix = 'djsy'
i = 0


def save_image(url):
    global i
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36'}
    print(url)
    img = requests.get(url, headers=headers)
    image_name = 'images/' + prefix + '-' + str(i) + ".jpg"
    with open(image_name, 'wb') as f:
        f.write(img.content)
        f.close()
    i += 1
    return


# 6 10
def get_image(start_page, end_page):
    step = 24
    number = start_page * step
    range_cnt = end_page - start_page
    for _ in range(0, range_cnt + 1):
        image_url = url.format(number)
        res = requests.get(image_url)
        decoded = json.loads(res.text)
        items = decoded['data']['object_list']
        for item in items:
            img_url = item['photo']['path']
            save_image(img_url)
            time.sleep(0.3)
        # print(number)
        number += step


# 第一页一共4个page 24 * 4 = 96, 第一页 (0, 0)
# get_image(0, 4)
get_image(5, 5)
