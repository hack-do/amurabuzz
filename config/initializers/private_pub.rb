Thread.new do
  system("rackup private_pub.ru -s puma -E production")
end