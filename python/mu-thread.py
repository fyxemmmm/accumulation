import base64
import requests
import json
from hashlib import md5
from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_v1_5 as Cipher_pkcs1_v1_5
from zk_database import ZkDB
from concurrent.futures import ThreadPoolExecutor
class Zhuangku(object):
    def __init__(self):
        self.api_url = 'xxxxxx'  # 撞库url
        with open('./suishouhua_public.pem', 'r', encoding='utf-8') as f:
            pub = f.read()
        self.pb_key = RSA.import_key(pub)   # 从证书中解析公钥
        # 17340074302 新用户
        # 15640446166 不是你们平台用户
        # self.check_mobile('15640446166')
    def check_mobile(self, mobile, id = None):
        mobile = str(mobile)
        info = {
            "mobile": md5(mobile.encode('utf-8')).hexdigest()
        }
        info = json.dumps(info)
        res = self.encrypt(self.pb_key, info.encode('utf-8'))
        my_dic = {
            'channel': 'suishouh',
            'data': res
        }
        try:
            result = requests.post(self.api_url, my_dic)
            print(result.json(), mobile, id)
        except:
            with open('wrong.txt', 'a', encoding='utf-8') as f:
                f.write(f'{id} {mobile}\n')
    # 将数据进行加密
    @staticmethod
    def encrypt(public_key, message):
        cipher = Cipher_pkcs1_v1_5.new(public_key)
        cipher_text = base64.b64encode(cipher.encrypt(message))
        return cipher_text
if __name__ == '__main__':
    zk = Zhuangku()
    zk_db = ZkDB()
    data = zk_db.get_data()  # id和手机号字典
    pool = ThreadPoolExecutor(15)
    for item in data:
        id = item['id']
        mobile = item['mobile']
        pool.submit(zk.check_mobile, mobile, id)

# sql
import pymysql
class ZkDB(object):
    def __init__(self):
        self.conn = pymysql.connect(
            host='xxxx',
            user='root',
            password='xxxx',
            database='xxxx',
            port=3306,
            charset='utf8'
        )
    def get_data(self):
        cur = self.conn.cursor(cursor=pymysql.cursors.DictCursor)
        sql = 'SELECT id,mobile from user'
        cur.execute(sql)
        result = cur.fetchall()
        return result
if __name__ == '__main__':
    db = ZkDB()
    data = db.get_data()