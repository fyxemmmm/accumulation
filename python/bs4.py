from bs4 import BeautifulSoup
import requests
import os
from urllib.request import urlretrieve
from concurrent.futures import ThreadPoolExecutor
import time
class Girl(object):
    def __init__(self):
        self.header = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebK\
             it/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36'
        }
    def spider(self,url):
        print(url)
        html = requests.get(url=url, headers=self.header)
        html.encoding = 'gbk'
        soup = BeautifulSoup(html.text, 'lxml')
        info = soup.select('#main > div.mains .pre_b>div')
        for item in info:
            img = item.select('.pre_b_classes_pic>a>img')
            title = item.select('.pre_b_classes_text h1 a')
            if not img or not title:
                continue
            title = title[0].string
            pic = img[0]['src']
            self.downImage(title, pic)
    @staticmethod
    def downImage(title, pic):
        if not os.path.exists('./girl'):
            os.mkdir('./girl')
        urlretrieve(pic, './girl/' + title + '.jpg')
if __name__ == '__main__':
    print(time.strftime('%Y-%m-%d %H:%M:%d'))
    obj = Girl()
    pool = ThreadPoolExecutor(15)
    start_page = 2
    end_page = 101
    spider_urls = ['xxx'.format(i) for i in range(start_page, end_page)]
    for url in spider_urls:
        pool.submit(obj.spider, url)
    print(time.strftime('%Y-%m-%d %H:%M:%d'))