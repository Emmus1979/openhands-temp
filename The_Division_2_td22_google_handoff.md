# The Division 2：td22_google.lua 整合測試交接筆記

> 用途：將本次討論背景、已確認項目與待補資料帶到新的 ChatGPT 對話。
>
> 注意：本文件整理目前對話資訊，不代表已在遊戲內測試成功。不要把未確認的位址或機器碼當成可直接使用的資料。

## 1. 專案背景

- 目標檔案：`td22_google.lua`
- 參考檔案：`1.lua`
- 遊戲：Tom Clancy's The Division 2
- 曾討論將 `1.lua` 的 Auto Loot 功能整合到 `td22_google.lua`，保留原本 RVA／OFF 位址表並避免熱鍵衝突。
- 另評估 Infinite Ammo 與 Damage Multiplier Multi-Pellet 的整合可能性。

## 2. Auto Loot 先前整合資訊

先前曾產生 `td22_autoloot_merged.lua`，當時規劃：

- `F5`：Auto Loot All 開關
- `F7`：Tap Loot（單次拾取）
- `F6`：保留給效能取樣
- `PageUp`／`PageDown`：保留原本 FOV 控制

整合內容包含：
- `auto_loot_all_tick()`
- 稀有度篩選
- Auto Loot UI 區塊

原始 `td22_google.lua` 有 `state.scan_loot`，用於掃描戰利品、稀有度及名稱供 Loot ESP 顯示；原始版本未找到 Auto Loot 自動拾取引擎。

Auto Loot 引擎來源是 `1.lua`。

先前整合檔只做過靜態檢查，沒有在遊戲內執行測試。新對話若要繼續，先確認整合檔是否仍可取得，再檢查目前版本。

## 3. Infinite Ammo：已提供的技術描述

使用者描述包含：

- 彈藥旗標（ammo flag）的核心鎖定／保護處理。
- 射擊事件位置的 16-byte patch：
  - `E9 rel32`
  - 後接 `11 NOP`
- 建立 Code Cave／Shellcode。
- Shellcode 會呼叫 builder。
- 使用偏移：
  - `+0x38`
  - `+0x40`
  - `+0x28`
  - `+0x30`
- 最後跳回原始位置 `site + 0x15`。

### 尚缺少的資料

- 射擊事件 patch 的實際 RVA／位址。
- 被覆蓋位置的完整原始指令位元組。
- 完整 Shellcode 位元組或可重現的組譯來源。
- Code Cave 的配置方式與實際位置。
- builder 的位址、呼叫慣例、參數與回傳方式。
- 上述偏移各自所屬結構與欄位意義。
- 執行緒／記憶體保護處理，以及完整還原原始內容的方法。

原始 `td22_google.lua` 中曾確認 Infinite Ammo 函式目前是 no-op：

```lua
-- Infinite ammo is removed; this function is a no-op kept so existing call sites do not error.
function apply_infinite_ammo()
end

function infinite_ammo_tick()
  -- Removed; no-op. See apply_infinite_ammo.
end