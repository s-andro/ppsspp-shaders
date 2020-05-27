# postprocessing shaders for PPSSPP
### 必要なもの
PPSSPP [1.9.3-859以降](https://buildbot.orphis.net/ppsspp/)

### インストール
このリポジトリごとダウンロードしてiniとfshファイルを`(PPSSPPのインストール先)\assets\shaders`にコピー

## Ainme4K + CASの推奨設定
PPSSPPの設定

    レンダリング解像度         = 自動 (画像の境界線が見える場合1x)
    ウィンドウサイズ           = 2x
    テクスチャフィルタリング   = Linear
    画像スケーリングのフィルタ = Linear
    テクスチャスケーリング     = オフ

シェーダーの設定

    Push Strength      = 0.3
    Push Grad Strength = 0.5 (大きいほど平面感が増す)
    Sharpness          = 1.0 (ぼやけない程度まで下げても良い)

ウィンドウサイズを大きくしたい場合`Push Strength`を大きくする  
しかし`2x`での使用が最も無難

## 参考
[Anime4K](https://github.com/bloc97/Anime4K)  
[FidelityFX CAS](https://github.com/GPUOpen-Effects/FidelityFX-CAS)
