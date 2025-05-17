<h1 align="center">
  <br>
  <img src="https://github.com/user-attachments/assets/b6e83eff-8b74-4dcc-b740-08e653f95a3b" alt="diarlies logo" width="256">
  <br>
</h1>

# Diarlies
Diarlies is a diary generation app based on your multimedia information, such as photos, locations, etc.

## Contribute

### Getting started
* .env ファイルを設置
  * backend/.env
  * mobile/dart_defines/.env.dev
  * mobile/dart_defines/.env.prod
* Docker
  * docker-compose up -d
  * docker-compose run cli (DB に接続)
    * pass: password
* Start server
  * pnpm i
  * npm run fire:start
  * npm run dev:node
* Run flutter app
  * Install fvm or flutter 3.29.3
  * fvm flutter run --debug --dart-define-from-file=dart_defines/.env.dev
  * fvm flutter build <ipa|apk|appbundle> --dart-define-from-file=dart_defines/.env.dev

## Git rules
* Branch name: `<user-id>/<easy-to-understand-message>#<issue-number>`
* Commit message: no prefix, simple message.
