```Dockerfile
RUN python -m pip install --no-color --no-cache-dir --disable-pip-version-check \
   --no-python-version-warning --no-warn-script-location \
   --break-system-packages --progress-bar off poetry setuptools wheel

RUN mkdir -p dist
RUN poetry export --without-hashes --format constraints.txt --output dist/constraints.txt
RUN poetry run python -m pip wheel --isolated --requirement dist/constraints.txt --wheel-dir dist/vendor

RUN poetry build --format wheel

RUN packages=$(find 'dist' 'dist/vendor' -maxdepth 1 -iname '*.whl' -exec realpath {} \; -print0 | xargs --null)

RUN python -m pip install --isolated --no-index --no-color --no-cache-dir \
  --disable-pip-version-check --no-python-version-warning \
  --no-warn-script-location --no-deps --break-system-packages \
  --progress-bar off ${packages}

RUN python -m counter_backend
```