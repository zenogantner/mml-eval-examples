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

