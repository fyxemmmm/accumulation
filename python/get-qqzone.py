from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.support.ui import WebDriverWait
import time
class QqZone(object):
    def __init__(self):
        self.login_url = 'https://qzone.qq.com/'
        self.driver = None
        self.wait = None
        self.total_page = None
        self.f = open('shuoshuo.txt', 'a', encoding='utf-8')
    def login(self, username, password):
        self.driver = webdriver.Chrome()
        self.driver.get(self.login_url)
        self.driver.maximize_window()
        self.driver.switch_to.frame('login_frame')
        self.wait = WebDriverWait(self.driver, 20)
        input = self.wait.until(EC.presence_of_all_elements_located((By.CSS_SELECTOR, "#switcher_plogin")))[0]
        # print(input)
        input.click()
        user_input = self.wait.until(EC.presence_of_all_elements_located((By.ID, "u")))[0]
        user_input.send_keys(username)
        time.sleep(1)
        password_input = self.wait.until(EC.presence_of_all_elements_located((By.ID, "p")))[0]
        password_input.send_keys(password)
        time.sleep(1)
        subimit = self.wait.until(EC.presence_of_all_elements_located((By.ID, 'login_button')))[0]
        subimit.click()
        time.sleep(2)
    def crawl(self):
        shuoshuo = self.wait.until(EC.presence_of_all_elements_located((By.XPATH, '//*[@id="menuContainer"]/div/ul/li[6]/a')))[0]
        shuoshuo.click()
        self.scroll()
        iframe = self.driver.find_element_by_class_name('app_canvas_frame')
        self.driver.switch_to.frame(iframe)
        self.total_page = self.getLastPage()
    def scroll(self):
        for i in range(1, 3):
            self.driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
            time.sleep(1)
    def getLastPage(self):
        page_last = self.wait.until(EC.presence_of_element_located((By.ID, 'pager_last_0'))).text
        print('总页数' + str(page_last))
        return page_last
    def get_detail(self):
        print('获取说说详情')
        for page in range(1, int(self.total_page)):
            # for page in range(1, 5):
            # print('当前第{}')
            # 拿数据
            page_input = self.wait.until(EC.presence_of_element_located((By.XPATH, '//*[@id="pager"]//input')))
            page_input.send_keys(page)
            submit = self.wait.until(EC.presence_of_element_located((By.XPATH, '//*[@id="pager"]//button')))
            submit.click()
            print('点击成功')
            self.scroll()
            content_list = self.wait.until(EC.presence_of_all_elements_located((By.XPATH, '//div[@class="bd"]//pre[@class="content"]')))
            for content in content_list:
                if len(content.text) != 0:
                    self.f.write('\n' + content.text)
if __name__ == '__main__':
    qqzone = QqZone()
    qqzone.login('账号', '密码')
    qqzone.crawl()
    qqzone.get_detail()
    print('结束')