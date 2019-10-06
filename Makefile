########################################################################################
# Basic commands
########################################################################################

.PHONY: init build start lint clean
.DEFAULT_GOAL:=build
node_bin:=./node_modules/.bin

# Initilize the directory for development
init:
	npm install

# Build the final distribution directory
build: dist/index.html

# Start a local server with auto-reloading
start: build
	$(node_bin)/live-server dist

# Check the quality of the distribution directory
lint:
	$(node_bin)/htmlhint dist

# Remove the distribution directory completely
clean:
	rm -rf dist

########################################################################################
# Build target
########################################################################################

header:=src/header.html
footer:=src/footer.html

# Initialize the distribution directory
dist: src/assets src/images
	mkdir -p dist
	cp -r src/assets dist
	cp -r src/images dist

# Build the home page
dist/index.html: dist $(header) $(footer) src/index.html
	cat $(header) src/index.html $(footer) > dist/index.html
