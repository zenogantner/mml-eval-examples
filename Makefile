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
	# user item rating timestamp
	@head data/ml-100k/u1.base
	item_recommendation --training-file=data/ml-100k/u1.base --test-file=data/ml-100k/u1.test

random-split:
	item_recommendation --training-file=data/ml-100k/u.data --test-ratio=0.25

cross-validation:
	item_recommendation --training-file=data/ml-100k/u.data --cross-validation=4

chronological-split-by-ratio:
	rating_prediction --training-file=data/ml-1m/ratings.dat --file-format=movielens_1m --chronological-split=0.2

chronological-split-by-date:
	rating_prediction --training-file=data/ml-1m/ratings.dat --file-format=movielens_1m --chronological-split=01/01/2002

metrics:
	item_recommendation --training-file=data/ml-100k/u1.base --test-file=data/ml-100k/u1.test --measures="prec@5,NDCG"

baseline-most-popular:
	item_recommendation --training-file=data/ml-100k/u1.base --test-file=data/ml-100k/u1.test --recommender=MostPopular

baseline-most-popular-by-attribute:
	item_recommendation --training-file=data/ml-100k/u1.base --test-file=data/ml-100k/u1.test --recommender=MostPopularByAttributes --item-attributes=data/ml-100k/item-attributes-genres.txt

hyperparameter-search:
	rating_prediction --training-file=data/ml-1m/ratings.txt --search-hp --test-ratio=0.2

random-seed:
	# Without random seed: different results for different runs
	item_recommendation --training-file=data/ml-100k/u.data --test-ratio=0.1
	item_recommendation --training-file=data/ml-100k/u.data --test-ratio=0.1
	# With random seed: same result for each run
	item_recommendation --training-file=data/ml-100k/u.data --test-ratio=0.1 --random-seed=1
	item_recommendation --training-file=data/ml-100k/u.data --test-ratio=0.1 --random-seed=1

external-predictions:
	rating_prediction --training-file=data/ml-100k/u1.base --test-file=data/ml-100k/u.data --prediction-file=pred.txt
	item_recommendation --training-file=data/ml-100k/u1.base --test-file=data/ml-100k/u1.test --recommender=ExternalItemRecommender --recommender-options="prediction_file=pred.txt"
	rm pred.txt
