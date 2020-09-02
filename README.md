# README

##テーブルスキーマ

Userモデル
|  カラム名  |  データ型  |
| ---- | ---- |
|  name  |  string  |
|  email  |  string  |
|  password_digest  |  string  |

Taskモデル
|  カラム名  |  データ型  |
| ---- | ---- |
|  title  |  string  |
|  description  |  text  |
|  status  |  string  |
|  priority  |  integer  |
|  deadline  |  datetime  |
|  user_id  |  integer  |

TaskLabelAttachmentモデル
|  カラム名  |  データ型  |
| ---- | ---- |
|  task_id  |  integer  |
|  label_id  |  integer  |

Labelモデル
|  カラム名  |  データ型  |
| ---- | ---- |
|  label_name  |  integer  |


##herokuへのデプロイ手順

1デプロイするアプリのディレクトリでHerokuにログイン

```$ heroku login```

2アセットプリコンパイルをする

```$ rails assets:precompile RAILS_ENV=production```

3アプリを追加・コミットする
```
$ git add -A
$ git commit -m "coment"
```

4Heroku上にアプリを作成する
```$ heroku create```

5Herokuにbuildpackを追加する
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```

6Herokuにデプロイする
```
$ git push heroku master
$ git push heroku ブランチ名:master
```

7データベース移行
```$ heroku run rails db:migrate```
