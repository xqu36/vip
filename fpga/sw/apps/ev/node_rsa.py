from Crypto.PublicKey import RSA
from Crypto.Cipher import PKCS1_OAEP

def encrypt_data(data):
  pubkey = RSA.importKey(open('id_rsa.pub').read())
  cipher = PKCS1_OAEP.new(pubkey)
  ciphertext = cipher.encrypt(data)
  return ciphertext

def decrypt_data(data):
  privkey = RSA.importKey(open('id_rsa').read())
  cipher = PKCS1_OAEP.new(privkey)
  datadict = cipher.decrypt(data)
  return datadict
