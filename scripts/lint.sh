#!/bin/bash
set -euxo pipefail

poetry run cruft check
poetry run mypy -p isort -p tests
poetry run black --target-version py36 --check .
poetry run isort --profile hug --check --diff isort/ tests/
poetry run isort --profile hug --check --diff example_*/
poetry run flake8 isort/ tests/
poetry run safety check -i 39462 -i 40291 -i 43453 -i 44717 -i 44716 -i 44715 -i 47794
poetry run bandit -r isort/ -x isort/_vendored
