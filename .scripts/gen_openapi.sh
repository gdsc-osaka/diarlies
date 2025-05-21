set -e

# Generate OpenAPI spec from local server
curl -o tmp.openapi.json "http://localhost:8080/api/openapi"

# Install OpenAPI Generator if not already installed
openapi-generator --version || brew install openapi-generator

# Generate Dart Client
openapi-generator generate -i tmp.openapi.json -g dart-dio -o mobile/api.tmp --additional-properties=pubName=api
cp mobile/.fvmrc mobile/api.tmp/.fvmrc
(cd mobile/api.tmp && fvm dart run build_runner build -d)

# Overwrite the existing API directory with the new one
rm -rf mobile/api && mv mobile/api.tmp mobile/api

# Clean up temporary files
rm tmp.openapi.json

echo "Adding generated files to git..."
git add -A mobile/api
