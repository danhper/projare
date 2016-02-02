## [Project API](https://givery-codecheck.herokuapp.com/)

### 作品の説明

Project API

### 独自で実装した内容

### 創意工夫した点

### 利用した技術（言語・フレームワーク・ライブラリ等）

Elixir, Phoenix

### 参照したサイト・解答・リファレンス等

### その他

DELETE returns 200 with no response.
To be consistent with the HTTP RFC, it would be better to return 204.

> A successful response SHOULD be 200 (OK) if the response includes an
> entity describing the status, 202 (Accepted) if the action has not
> yet been enacted, or 204 (No Content) if the action has been enacted
> but the response does not include an entity.
