from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait
from selenium.common.exceptions import TimeoutException
from lxml import etree
import pandas as pd
import time
import os
def goto_jd(wait, driver):  # 京东的吃鸡主机全弄下来
    input = wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, "#key")))[0]
    input.send_keys(u'吃鸡主机')
    submit = wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, '#search > div > div.form > button > i')))[0]
    submit.click()  # 吃鸡主机
    sale_top = wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, "#J_filter > div.f-line.top > div.f-sort > a:nth-child(2) > span")))[0]
    sale_top.click()  # 按销量排
    list = []  # 用来放插入到Excel中的数据列表
    for i in range(1, 30):    # 抓30页吃鸡主机电脑信息
        print("正在抓取第{}页吃鸡电脑主机的信息".format(str(i)))
        time.sleep(2)
        roll_bottom(driver)   # 拉滚动条到最底下，触发ajax接口
        html = driver.page_source
        html = etree.HTML(html)
        goods_li = html.xpath('//*[@id="J_goodsList"]/ul/li')
        try:
            for good in goods_li:
                good_name = good.xpath('.//div[@class="p-name p-name-type-2"]//em/text()')[0]
                price = good.xpath('.//strong/i/text()')[0]
                try:
                    brand = good.xpath('.//i[@class="goods-icons J-picon-tips J-picon-fix"]/text()')[0]
                except:
                    brand = '非自营'
                list.append([good_name, price, brand])
        except Exception as e:
            print(e)
            print('第{}页抓取失败，继续抓取下一页'.format(str(i)))
            continue
        print(' ------ 吃鸡主机信息收集成功 ---------')
        next_page = wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, "#J_bottomPage > span.p-num > a.pn-next")))[0]
        next_page.click()
        time.sleep(4)
    df = pd.DataFrame(list, columns=['牌子', '价格', '是否自营'])
    if not os.path.exists('jd_computer'):
        os.mkdir('jd_computer')
    df.to_csv('jd_computer/jd.csv', index=False, mode='a', encoding='utf-8')
    # print(list)
    # print(len(list))
def roll_bottom(driver):  # 浏览器进行下滑操作
    for i in range(1, 3):
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(1)
def main():
    url = 'https://www.jd.com/'
    driver = webdriver.Chrome()
    driver.get(url)
    driver.maximize_window()
    wait = WebDriverWait(driver, 20)
    goto_jd(wait, driver)
    print('绝地求生吃鸡主机信息抓取完成！')
    driver.quit()
if __name__ == '__main__':
    main()