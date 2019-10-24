########################################################################################
# Basic commands
########################################################################################

.DEFAULT_GOAL:=build
.PHONY: init start lint clean
node_bin:=./node_modules/.bin

# Initilize the directory for development
init:
	npm install

# Build the final distribution directory
build: dist

# Start a local server with auto-reloading
start: build
	$(node_bin)/live-server dist

# Check the quality of the distribution directory
lint:
	$(node_bin)/htmlhint dist

# Remove the distribution directory completely
clean:
	rm -rf dist/*

########################################################################################
# Build targets
########################################################################################

# Define the static HTML components 
header := src/header.html
footer := src/footer.html
sidebar := src/sidebar.html

# Define the distribution pages
dist_pages := dist/index.html \
			  dist/les-bases.html \
			  dist/les-produits.html \
			  dist/le-materiel.html

# Build the distribution folder
dist: dist/assets dist/images $(dist_pages)

# Copy the template assets
dist/assets: src/assets
	cp -r $< dist

# Copy the template images
dist/images: src/images
	cp -r $< dist

# Build the content pages
dist/%.html: src/%.html $(header) $(sidebar) $(footer)
	cat $(header) $< $(sidebar) $(footer) > $@


########################################################################################
# Publication targets
########################################################################################

.PHONY: publish

# Define the connection credentials. The password must be set via environment variable
ftp_host := ftp.cluster010.hosting.ovh.net
ftp_user := thibautvu
ftp_password ?= PASSWORD_NOT_SET

# Publish the website
publish:
	ncftpput -R \
		-u $(ftp_user) \
		-p $(ftp_password) \
		$(ftp_host) \
		spatuleetspaghetti/ \
		dist/*