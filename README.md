# chatwork-challenge

## 概要

Chatwork iOS提出課題

## アプリ仕様・動作・説明

本アプリはChatwork APIを利用して、Chatworkに投稿できるアプリです．

| ログイン | チャット一覧 | チャット |
| ------ | ------ | ------ |
| ![](README_images/Login.png) | ![](README_images/ChatRoomList.png)  | ![](README_images/ChatRoom.png) |

### ログイン
- アプリを開いた直後の画面
- Tokenを入力し，ボタンをタップすることでログインできる
- ログインに成功するとチャット一覧画面に遷移

### チャット一覧
- チャットルーム一覧を表示
- セルをタップすることで該当するチャットルーム画面に遷移

### チャット
- メッセージ一覧, メッセージ投稿フォームによって構成
- メッセージ一覧: 投稿されたメッセージを一覧表示
    - メッセージ: 投稿者の名前，投稿者のアイコン，メッセージ内容，投稿時間を表示
- メッセージ投稿フォーム: メッセージの内容入力部分, 送信ボタンで構成

## セットアップ方法

特になし．

ライブラリは全て`CocoaPods`を用いて導入している．

## コードについて
### 方針

- レイアウトは主に`StoryBoard`を利用, 1`StoryBoard`-1`ViewController`方式を採用
    - 1つの`StotryBoard`で複数画面を管理するのは複数ブランチでの同時作業をしたい場合に非効率だと考えたため

### 使用ライブラリ

| ライブラリ名 | 用途 |
| ------ | ------ |
| [Moya/Combine](https://github.com/Moya/Moya.git) | ネットワーク通信 |
| [Nuke](https://github.com/kean/Nuke.git) | 画像取得 |
| [Instantiate](https://github.com/tarunon/Instantiate.git) | DI用 |
| [ReusableKit](https://github.com/devxoul/ReusableKit.git) | TableViewCellのregister, dequeue |
| [CombineCocoa](https://github.com/CombineCommunity/CombineCocoa.git) | UIKitのPublisher |
| [KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess.git) | キーチェーン |
