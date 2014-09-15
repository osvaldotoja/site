all: serve

drafts:
	jekyll serve --watch --drafts

serve:
	jekyll serve --watch 

build:
	jekyll build

publish:
	make build
	git commit -am"site update" 
	git checkout gh-pages
	rsync -av _site/* .
	rm -fr _site/
	git commit -am"site update" ; git push
	git checkout master

