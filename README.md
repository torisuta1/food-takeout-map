# Food-TakeOut-Map
テイクアウトに対応しているお店や、テイクアウト独自の商品情報を共有する飲食のテイクアウト専門サービスです。  
<br>
![トップ画像](https://i.gyazo.com/aff95a87b3a93bbe8b31503cc88cc7cd.jpg)
<br>
<br>

* 遅くなってしまったお仕事の帰りに晩ご飯をテイクアウトで頼みたい時や、のんびり持ち帰って自宅で食べたい時などに
  お店の情報を参照して参考にできます。  
* 実際に頼んだ商品の情報を投稿することで他者と共有でき、おすすめのお店の商品を広めていくことができます。  
<br>

### サービスの制作背景
新型コロナウイルスの影響で多くの飲食店は営業時間を縮小して営業していたり、店内での飲食可能時間を限定的にしてテイクアウト
のみでの体制に変更してお店を稼働させている状況が続いております。お店側としてはコロナウイルスによる影響前の営業時間や体制
で営業することが難しくなっており、心理的にも経済的にも負担が続いております。また利用者側としても従来のように好きな時間に
来店し飲食をすることができなくなっており、注文できる商品もテイクアウトのみという制限下で限定されている状況です。
このような状況下で双方の負担を軽減できるサービスはないかと思案し、お店の商品情報を共有できるサービスにたどり着きました。
純粋な飲食店情報であれば既に大手のサービスが展開されておりますが、コロナウイルス情勢下でのテイクアウトによる体制が反映さ
れているものはなく、また店舗情報までの記載がメインであり個別での商品情報が載っているものはありませんでした。
テイクアウトに対応しているお店の情報と実際の商品情報、この２点に着目してサービスを作ることでお店側としてはテイクアウト
限定であっても利用者に商品情報を認識してもらえ、利用者側としてはお店の情報を共有できることで縮小体制に困惑することなく、
テイクアウトでの利用が円滑に進み、先に挙げました双方の負担の解消を狙えると思いこのサービスを制作致しました。
<br>
<br>

## App URL
https://food-takeout-map.work  
<br>
<br>

## 基本的な利用方法の流れ
ログイン後ヘッダータブから「投稿する」ボタンを押し、投稿画面から投稿
<br>

![投稿画面](https://i.gyazo.com/274fb4e2bd8e506e2ff7e09bc69adf52.png)
<br>
<br>
投稿一覧から各投稿内容を確認でき店舗情報の確認
<br>

![投稿一覧画面](https://i.gyazo.com/7e3e2019032cf41d16b55be026509e85.png)
<br>
<br>

## 制作にあたり意識した点
<br>

### 技術面
* DBでのN+1問題について余分なSQLが発行されないようにgemのbulletを使用し意識しました
* RuboCopを用い規約に沿ったコードになるよう可読性に努めました
* サービスの品質を維持し向上させるためテストコードを大事に行いました(184examples)
<br>

### 開発面
* 実際の現場でのチーム開発を意識しissueの発行からプルリクまでの流れを想定し開発しました
* ユーザーの利便性を図るため各種画面遷移の連結を意識しました
<br>
<br>

## 機能一覧
* ユーザー認証機能（サインアップ、サインイン、サインアウト）
* メールアドレス認証機能
* パスワード再設定機能
* ユーザー編集機能
* ゲストログイン機能
* 管理者機能
* 店舗情報投稿機能
* 投稿一覧機能
* 投稿検索機能
* マイ投稿表示機能
* マイページ詳細機能
* 投稿詳細表示機能
* いいね機能（非同期）
* ユーザーフォロー機能（非同期）
<br>

## 使用技術
<br>

バックエンド
* Ruby 3.0.1
* Rails 6.1.3.2
<br>

フロンドエンド
* HTML
* CSS
* jQuery
* Bootstrap
<br>

インフラ
* MYSQL 8.0.26
* Nginx
* Puma
* AWS
  * VPC
  * EC2
  * RDS
  * ELB
  * Route53
  * S3
  * ACM
<br>

テスト
* RSpec
<br>

## 画面遷移フロー
![画面遷移フロー](https://i.gyazo.com/e7038ef83bb49abfb5ea009866b4cbad.png)
<br>
<br>
<br>

## ER図
![ER図](https://i.gyazo.com/aa5e27bccc2f9ce92ee921e366fd940a.png)
<br>
<br>
<br>

## インフラ構成図
![インフラ構成図](https://i.gyazo.com/b0b4b8c2debb80aa1c6f03d9a22dc99f.jpg)