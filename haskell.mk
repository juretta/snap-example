# You will need to extend this if your cabal build depends on non
# haskell files (here '.lhs' and '.hs' files).
SOURCE = $(shell find src -name '*.lhs' -o -name '*.hs')

all: $(SOURCE)
			cabal build


.PHONY: clean build

compile:
			cabal build

build: clean
			cabal build
			@(strip `find dist/build/monitoring-* -type f -maxdepth 1`)
			@(upx `find dist/build/monitoring-* -type f -maxdepth 1`)

clean:
			cabal clean

dependencies:
			cabal install --only-dependencies

test-setup:
			cabal install --only-dependencies --enable-tests

test-compile:
			cabal clean
			cabal configure --enable-tests
			cabal build

test:
			cabal test --show-details=always

doctest:
			@(doctest -XOverloadedStrings $(SOURCE))


# Ensure `cabal-constraints` is installed as per:
# https://github.com/benarmston/cabal-constraints
freeze:
			@(cabal-constraints dist/dist-sandbox-*/setup-config > cabal.config)
