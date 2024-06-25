include contrib/config/mk

all: clean build

clean:
	pnpm nx reset

build:
	pnpm build

publish:
	pnpm run pub
