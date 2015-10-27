# -----STEPS-----
# load "#{Rails.root}/lib/encryption.rb"
# e = Encryption.new
# plain = "vineet"
# encrypted = e.encrypt(plain)
# plain = e.decrypt(encrypted)

class Encryption
	def initialize
		@cipher = OpenSSL::Cipher::AES.new(128, :CBC)
	end

	def encrypt(plain)
		@cipher.encrypt
		# @key = @cipher.random_key
		# @iv = @cipher.random_iv
		@cipher.key = @key = "amurabuzz"
		@cipher.iv = @iv = Date.today.to_s*5

		@cipher.update(plain) + @cipher.final
	end

	def decrypt(encrypted)
		@cipher = OpenSSL::Cipher::AES.new(128, :CBC)
		@cipher.decrypt
		@cipher.key = @key
		@cipher.iv = @iv

		@cipher.update(encrypted) + @cipher.final
	end
end