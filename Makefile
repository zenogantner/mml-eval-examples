.PHONY: download-movielens

clean:
	echo "Nothing right now."

veryclean: clean
	rm -rf data/

data:
	mkdir data/

data/ml-100k/u.data:
	scripts/download_movielens.sh

download-movielens: data
	scripts/download_movielens.sh

download-imdb: data
	scripts/download_imdb.sh

##### Examples from the Berlin Buzzwords talk

help:
	item_recommendation --help

interaction-data:
	echo "user item rating timestamp"
	head data/ml-100k/u1.base
	item_recommendation --training-file=data/ml-100k/u1.base --test-file=data/ml-100k/u1.test
