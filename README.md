# setup

PopOSをセットアップするためのオレオレスクリプトと全体的な手順

## OSセットアップ後の初期作業

OSをクリーンインストールしたあとにまずやることは以下の通り。再起動が必要なら適宜やること。

### システムの状態を最新に

```
sudo apt update
sudo apt upgrade
sudo apt-get dist-upgrade
```


### ROCm、AMD GPU ドライバのインストール　（手動）

うっかりAMDのGPUを搭載しているので、ここは手作業でやる。

詳しいやり方は[Quick start installation guide](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/install/quick-start.html)を参照する。

ここでrocmとGPUドライバーを入れる。

## セットアップの実行（本人が忘れないために）

初期作業が終わったらセットアップスクリプトを実行

```
cd ~
git clone https://github.com/tonoccho/setup.git
cd setup
./setup.sh
```

## セットアップ後の作業

セットアップスクリプトを実行したあとに一旦再起動し、以下の作業をやる。

### 1 Passwordの設定

設定 -> 開発者 -> SSHエージェントの有効化

これをやらないとgitリポジトリへのアクセスができない、あと、gitリポジトリへのアクセス時には1 Password 起動しとくこと

### 一時的にhttpでクローンしたリポジトリを改めてSSHでクローンし直す

```
yadm clone -f git@github.com:tonoccho/dotfiles.git
cd ~ && rm -rf setup && git clone git@github.com:tonoccho/setup.git
```
### 日本語の設定

1．設定 -> 地域と言語 -> インストールされている言語の管理 -> 指示に従ってインストールを実行
2. 再起動
3. 設定 -> キーボード -> 追加 -> 日本語(Mozc)

### Davinci Resolveのセットアップ

- [Davinci Resolve](https://www.blackmagicdesign.com/jp/products/davinciresolve)

### Localのセットアップ

- [Local](https://localwp.com/)