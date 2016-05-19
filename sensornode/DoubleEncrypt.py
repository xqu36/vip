import sys
from Crypto.Cipher import AES
from Crypto import Random
from Crypto.Cipher import PKCS1_v1_5
from Crypto.PublicKey import RSA
from Crypto.Hash import SHA
BS = AES.block_size

def gen_AESKey():
	return Random.new().read(BS)


pad = lambda s : s + (BS - len(s) % BS) * chr(BS - len(s) % BS)
unpad = lambda s : s[0:-ord(s[-1])]

class AESCipher:
	
	def __init__(self, key):
		self.key = key	

	def encrypt(self, raw):
		raw = pad(raw)
		iv = Random.new().read(BS)
		cipher = AES.new(self.key, AES.MODE_CBC, iv)
		return iv + cipher.encrypt(raw)

	def decrypt(self, enc):
		iv = enc[:16]
		cipher = AES.new(self.key, AES.MODE_CBC, iv)
		return unpad(cipher.decrypt(enc[16:]))

class RSAEncrypt:
	def __init__(self, pubkey_file):
		self.pubkey = RSA.importKey(open(pubkey_file).read())

	def encrypt(self, raw):
		h = SHA.new(raw)
		cipher = PKCS1_v1_5.new(self.pubkey)
		return cipher.encrypt(raw + h.digest())

text = open(sys.argv[1]).read()
pubkey_file = 'pubkey.pem'

aesKey = gen_AESKey()
cipher = AESCipher(aesKey)
rsa = RSAEncrypt(pubkey_file)

encText = cipher.encrypt(text)
encKey = rsa.encrypt(aesKey)

out_key = open(sys.argv[1] + '.enckey', 'wb')
out_txt = open(sys.argv[1] + '.enctxt', 'wb')

out_key.write(encKey)
out_txt.write(encText)

