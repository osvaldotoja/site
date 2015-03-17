all: serve

serve:
	jekyll serve -c _config-dev.yml --watch

drafts:
	jekyll serve --watch --drafts

#serve:
#	jekyll serve --watch 

build:
	jekyll build

publish:
	#ssh-add ~/.ssh/osvaldotoja
	ssh-add 
	jekyll build
	git commit -am"site update" 
	git checkout gh-pages
	rsync -av _site/* .
	rm -fr _site/
	git add . ; git commit -am"site update" ; git push
	git checkout master
	#ssh-add -D

