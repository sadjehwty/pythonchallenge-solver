# http://www.pythonchallenge.com/pc/return/disproportional.html
require 'rubygems'
require 'xmlrpc/client'
server = XMLRPC::Client.new2('http://www.pythonchallenge.com/pc/phonebook.php')
puts server.call("phone","Bert")=~/-(.+)/?$1.downcase():""