openapi-generator --version || brew install openapi-generator

# Generate Dart Client
openapi-generator generate -i openapi/openapi.yaml -g dart-dio -o mobile/api.tmp --additional-properties=pubName=api
cp .fvmrc mobile/api.tmp/.fvmrc
(cd mobile/api.tmp && fvm dart run build_runner build -d)
# api.tmp/ を api/ に上書き
(rm -rf mobile/api && mv mobile/api.tmp mobile/api)