all: serve

help:
	@echo 'create new articles:'
	@echo '    octopress new post "installing pip" --dir articles'

drafts:
	jekyll serve --watch --drafts

serve:
	jekyll serve --config _local.yml
	#jekyll serve --watch 

build:
	jekyll build

publish:
	ssh-add ~/.ssh/osvaldotoja
	jekyll build
	git add .
	git commit -am"site update" 
	git checkout gh-pages
	rsync -av _site/* .
	rm -fr _site/
	git commit -am"site update" ; git push
	git checkout working
	#git checkout master
	ssh-add -D

