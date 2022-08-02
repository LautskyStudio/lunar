# Lansiny Game Studio Godot Plugins "Lunar"

> 🌕 渌水净素月，月明白鹭飞

Lunar 是为 Godot 4 上实现 [Lansiny Game Studio](https://github.com/Lansiny/game_studio) 的功能而开发的一组插件。

## 使用

您需要在 Godot 4 中打开本项目源代码。
目前最新的 Godot 官方构建版本是 [4.0.alpha13](https://downloads.tuxfamily.org/godotengine/4.0/alpha13/)。

## 开发

由于 Godot 4 尚未正式发布，因此在查阅文档时，需要查看 [latest](https://docs.godotengine.org/en/latest/) 分支的文档。

### 已知限制

- 由于 Godot 4.0 暂不支持导出自定义 Resource 类型，因此导出 Resource 类型只能是 Resource 基类。这给使用自定义 Resource 类型的代码的静态类型检查带来了一点麻烦。受影响的代码主要是 `res://addons/lansiny_game_database/objects/` 中的代码。
