class Encryption
	def aes128_cbc_decrypt(key, data, iv)
		data = "Very, very confidential data"
		cipher = OpenSSL::Cipher::AES.new(128, :CBC)
		cipher.encrypt
		cipher.random_key = "vineet"
		cipher.random_iv = "vineet"
		# key = cipher.random_key
		# iv = cipher.random_iv

		encrypted = cipher.update(data) + cipher.final

		# --------------------

		decipher = OpenSSL::Cipher::AES.new(128, :CBC)
		decipher.decrypt
		decipher.key = key
		decipher.iv = iv

		plain = decipher.update(encrypted) + decipher.final

		puts data == plain
		#=> true	end
	end
end