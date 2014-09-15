all: serve

drafts:
	jekyll serve --watch --drafts

serve:
	jekyll serve --watch 

build:
	jekyll build
