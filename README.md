<h1 align="center">
  <br>
  <img src="https://github.com/user-attachments/assets/62b29d4c-1f07-4db2-9018-9d28b9b30a4f" alt="diarlies logo" width="256">
  <br>
</h1>

# Diarlies
Diarlies is a diary generation app based on your multimedia information, such as photos, locations, etc.

## Demo video
[![demo](http://img.youtube.com/vi/pn3OrKXGx1Y/0.jpg)](https://www.youtube.com/watch?v=pn3OrKXGx1Y)

## Contributing

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
