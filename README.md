# setup

PopOSをセットアップするためのオレオレスクリプト

## やりかた（本人が忘れないために）

```
cd ~
git clone https://github.com/tonoccho/setup.git
cd setup
./setup.sh
```

## 他

自動ではできないものはそれぞれ自分でやること。

### 手動インストールするアプリ

- [Davinci Resolve](https://www.blackmagicdesign.com/jp/products/davinciresolve)

### 日本語の設定

1．設定 -> 地域と言語 -> インストールされている言語の管理 -> 指示に従ってインストールを実行
2. 再起動
3. 設定 -> キーボード -> 追加 -> 日本語(Mozc)

### 一時的にhttpでクローンしたリポジトリを改めてSSHでクローンし直す

```
yadm clone -f git@github.com:tonoccho/dotfiles.git
cd ~ && rm -rf setup && git clone git@github.com:tonoccho/setup.git
```