import sys
from Crypto.Cipher import AES
from Crypto import Random
from Crypto.Cipher import PKCS1_v1_5
from Crypto.PublicKey import RSA
from Crypto.Hash import SHA
BS = AES.block_size

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

class RSADecrypt:
	
	def __init__(self, privkey_file):
		self.privkey = RSA.importKey(open(privkey_file).read())

	def decrypt(self, enc):
		dsize = SHA.digest_size
		sentinel = Random.new().read(15+dsize)

		cipher = PKCS1_v1_5.new(self.privkey)
		message = cipher.decrypt(enc, sentinel)

		digest = SHA.new(message[:-dsize]).digest()
		if digest == message[-dsize:]:
			return message[:-dsize]
		else:
			print "Decryption failed, encryption not correct"
			return null
encKey = open(sys.argv[1]).read()
encText = open(sys.argv[2]).read()
privKey_file = 'privkey.pem'
rsa = RSADecrypt(privKey_file)

aesKey = rsa.decrypt(encKey)
cipher = AESCipher(aesKey)
text = cipher.decrypt(encText)

out_file = open(sys.argv[2] + ".dec", "wb")
out_file.write(text)
out_file.close()


