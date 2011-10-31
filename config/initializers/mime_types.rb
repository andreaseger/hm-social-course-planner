# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register_alias "text/html", :iphone

Mime.send(:remove_const, :JSON)
#Mime::Type.register "text/x-json", :json
Mime::Type.register "application/javascript", :json
