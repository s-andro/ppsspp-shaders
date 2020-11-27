# post-processing shaders for PPSSPP
### 必要なもの
PPSSPP [1.9.3-859以降](https://buildbot.orphis.net/ppsspp/)

### インストール
まるごと[ダウンロード](https://github.com/s-andro/ppsspp-shaders/archive/master.zip)してREADME以外のファイルを`<メモリースティック>/PSP/shaders`にコピー

`1.10.3-741`以降は複数のシェーダーを使用できるようになったので`anime4k-cas.ini`と`soft-anime4k-cas.ini`は必須ではない

## 推奨設定
### PPSSPPの設定

    レンダリング解像度       = 自動 (画像の境界線が見える場合1x)
    ウィンドウサイズ         = 2x
    テクスチャフィルタリング = 自動またはゲームによって調整
    テクスチャスケーリング   = オフ

### 使用するシェーダー

    通常の絵がメインの場合     … Ainme4K + CAS  
    ドット絵を崩したくない場合 … Soft Edge + Ainme4K + CAS

## 設定項目
### Anime4K
    Push Strength      … 大きいほど境界線が薄くなる
    Push Grad Strength … 大きいほど平面感が増す

### Soft Edge
    Edge Peak … 大きいほど縁の弱い部分をぼかしにくくなる。0で全体的にぼかす

## 参考
[Anime4K](https://github.com/bloc97/Anime4K)  
[FidelityFX CAS](https://github.com/GPUOpen-Effects/FidelityFX-CAS)
