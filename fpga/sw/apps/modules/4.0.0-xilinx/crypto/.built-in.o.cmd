cmd_crypto/built-in.o :=  arm-xilinx-linux-gnueabi-ld -EL    -r -o crypto/built-in.o crypto/crypto.o crypto/crypto_wq.o crypto/crypto_algapi.o crypto/aead.o crypto/crypto_blkcipher.o crypto/chainiv.o crypto/eseqiv.o crypto/seqiv.o crypto/crypto_hash.o crypto/pcompress.o crypto/cryptomgr.o crypto/crypto_null.o crypto/gf128mul.o crypto/ctr.o crypto/gcm.o crypto/ccm.o crypto/aes_generic.o crypto/arc4.o crypto/crc32c_generic.o crypto/rng.o crypto/krng.o crypto/ghash-generic.o crypto/af_alg.o crypto/algif_hash.o crypto/algif_skcipher.o crypto/algif_rng.o 
