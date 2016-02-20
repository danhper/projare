## [Projare](https://projare.herokuapp.com/)

https://github.com/tuvistavie/projare

https://projare.herokuapp.com/

### 作品の説明

プロジェクトの共有サービス。

### 独自で実装した内容

  * 認証
      * メール＋パスワードで登録
      * Facebookで登録
  * コメント（投稿・編集・削除）
  * スター
  * 検索
  * カテゴリ分け
  * 人気ランキング
  * バリデーションとちゃんとしたエラー処理
  * プロジェクトでマークダウン使用可能


### 創意工夫した点

* まともなUI
    * 行動のフィードバック（ローディングなど）
    * レスポンスデザイン
    * infinite scroll

* シングルページアプリケーション

* APIのレスポンスタイムが速い

```
» cat /proc/cpuinfo | grep -i 'model name' | head -n1
model name      : Intel(R) Core(TM) i7-3612QM CPU @ 2.10GHz
» cat /proc/cpuinfo | grep -i 'model name' | wc -l
8

# 今回作ったアプリ
» wrk -t12 -c400 -d30s 'http://localhost:3000/api/projects?author_id=1'
Running 30s test @ http://localhost:3000/api/projects?author_id=1
  12 threads and 400 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   262.92ms   38.68ms 394.00ms   71.01%
    Req/Sec   127.91     75.85   323.00     62.80%
  45005 requests in 30.04s, 10.31MB read
Requests/sec:   1498.06
Transfer/sec:    351.35KB

# 同じ規模のRailsアプリ(6 workers)の結果(チューニングなしなので、もうちょい速くはなりますが)
» wrk -t12 -c400 -d30s -H 'Authorization: Bearer 3f24ad7e50b6afc3163448021fa82c4f121f43f4b2efc110bd1b1c24ff3410a5' http://localhost:9292/v1/malls/1/stores
Running 30s test @ http://localhost:9292/v1/malls/1/stores
  12 threads and 400 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   328.65ms  119.80ms   1.58s    84.69%
    Req/Sec    31.94     29.41   151.00     86.10%
  8169 requests in 30.10s, 4.71MB read
Requests/sec:    271.41
Transfer/sec:    160.36KB
```

### 利用した技術（言語・フレームワーク・ライブラリ等）

#### Backend

  * Elixir
  * Phoenix

#### Frontend

  * RiotJS

### 参照したサイト・解答・リファレンス等

それぞれのドキュメンテーション。

### その他
