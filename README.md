# Neovim configuration

個人用のNeovim設定です。

## 導入候補

### snacks.nvim

`folke/snacks.nvim`は、入力・選択画面を含むUIや通知、ファイル選択などをまとめて提供するプラグインです。

- リポジトリ: https://github.com/folke/snacks.nvim
- アーカイブされた`dressing.nvim`の代替候補です。
- 現在はNeovim標準の`vim.ui.input()`と`vim.ui.select()`を使い、不便を感じた場合に導入を再検討します。

## 保守上の注意

### plenary.nvim

`nvim-lua/plenary.nvim`は2026年6月30日をもって通常保守を終了しています。

- リポジトリ: https://github.com/nvim-lua/plenary.nvim
- 確認日: 2026年8月4日
- 現在は起動時に無条件で読み込まず、必要とするプラグインの`dependencies`としてのみ定義しています。
- 依存先がまだ利用しているため、現時点では削除しません。

現在の主な依存先と移行状況:

- `nvim-telescope/telescope.nvim`
  - 依存を解消する作業が進行中です。
  - https://github.com/nvim-telescope/telescope.nvim/issues/2552
  - https://github.com/nvim-telescope/telescope.nvim/pull/3647
- `folke/todo-comments.nvim`
  - `vim.system()`などへ置き換えるPRがありますが、まだ取り込まれていません。
  - https://github.com/folke/todo-comments.nvim/pull/395
- `CopilotC-Nvim/CopilotChat.nvim`
  - 一部は置き換え可能ですが、非同期処理についてはNeovim側のAPI整備を待ち、当面はPlenaryを使う方針です。
  - https://github.com/CopilotC-Nvim/CopilotChat.nvim/issues/1545
- `antosha417/nvim-lsp-file-operations`
  - 依存削除のIssueはありますが、具体的な移行方針や期限はまだ示されていません。
  - https://github.com/antosha417/nvim-lsp-file-operations/issues/50

上記プラグインの更新時、またはPlenaryに起因する不具合が発生したときに依存状況を再確認し、不要になっていれば`lua/plugins.lua`から依存宣言を削除します。
