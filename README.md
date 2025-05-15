## Environment setup
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

## Git rules
ブランチ名: `<user-id>/<わかりやすい名前>#<issue番号>`
- 例: `harineko0/test#1`

コミットメッセージ: 'コミットで行った変更を簡潔に' (prefix はつけない)
