-- === WindUI 載入區塊（已驗證成功的方式） ===
local code = game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua", true)
print("[DEBUG] WindUI 原始碼長度:", #code)

local func, loadErr = loadstring(code)
if not func then
    error("[ERROR] loadstring 失敗: " .. (loadErr or "未知錯誤"))
end

local success, loadedWindUI = pcall(func)
if not success then
    error("[ERROR] func() 執行失敗: " .. tostring(loadedWindUI))
end

if loadedWindUI == nil then
    error("[ERROR] func() 回傳 nil！WindUI 載入失敗")
end

-- 強制設成 global
_G.WindUI = loadedWindUI

print("[DEBUG] _G.WindUI 是否存在:", _G.WindUI \~= nil)
print("[DEBUG] CreateWindow 是否 function:", type(_G.WindUI.CreateWindow) == "function")

-- 服務與玩家變數
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer

-- 初始通知
StarterGui:SetCore("SendNotification", {
    Title = "🔥 Nova中心 - 載入中",
    Text = "頂級通用腳本中心正在初始化...",
    Duration = 4,
    Icon = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
})

-- 主題與透明度
_G.WindUI:SetTheme("Dark")
_G.WindUI.TransparencyValue = 0.18

-- 建立主視窗
local Window = _G.WindUI:CreateWindow({
    Title = "Nova中心",
    Icon = "sparkles",
    Author = "by eert602",
    Folder = "NovaHub",
    Size = UDim2.fromOffset(620, 520),
    Acrylic = true,
    Theme = "Dark"
})

-- 測試通知
_G.WindUI:Notify({
    Title = "測試成功",
    Content = "WindUI 已載入並建窗！如果沒看到，按 Insert / 右 Ctrl 開啟",
    Duration = 10,
    Icon = "check-circle"
})

-- 通知函數
local function showNotification(title, content, duration, icon)
    _G.WindUI:Notify({
        Title = title,
        Content = content,
        Duration = duration or 4,
        Icon = icon or "check-circle"
    })
end

-- 載入腳本函數
local function loadScript(scriptName, scriptUrl, description, gameName)
    showNotification("🔄 載入中...", scriptName .. " 正在載入...", 2)
    
    local success, result = pcall(function()
        local scriptContent = game:HttpGet(scriptUrl, true)
        if not scriptContent or scriptContent == "" then
            error("內容為空")
        end
        local loadedFunction = loadstring(scriptContent)
        if not loadedFunction then
            error("編譯失敗")
        end
        loadedFunction()
        return true
    end)
    
    if success then
        showNotification("✅ " .. scriptName, "🎮 " .. description .. "\n✨ 已成功載入於 " .. gameName, 5, "rocket")
    else
        showNotification("❌ " .. scriptName, "載入失敗：" .. tostring(result), 6, "alert-triangle")
    end
end

-- 建立按鈕函數
local function createScriptButton(tab, name, description, url, gameName, emoji)
    tab:Button({
        Title = emoji .. " " .. name,
        Desc = description,
        Icon = "external-link",
        Callback = function()
            loadScript(name, url, description, gameName)
        end
    })
end

-- 建立所有 Tab
local HomeTab = Window:Tab({Title = "🏠 首頁", Icon = "home"})
local PopularTab = Window:Tab({Title = "⭐ 熱門遊戲", Icon = "trending-up"})
local MM2Tab = Window:Tab({Title = "🗡️ 殺手疑雲2", Icon = "swords"})
local BedwarsTab = Window:Tab({Title = "🛏️ 床戰", Icon = "bed"})
local RivalsTab = Window:Tab({Title = "⚔️ 對手", Icon = "trophy"})
local DoorsTab = Window:Tab({Title = "🚪 門", Icon = "door-closed"})
local ArsenalTab = Window:Tab({Title = "🎯 軍火庫", Icon = "crosshair"})
local BrookhavenTab = Window:Tab({Title = "🏡 布魯克海文RP", Icon = "city"})
local DeadRailsTab = Window:Tab({Title = "🚂 死亡鐵路", Icon = "train"})
local ForsakenTab = Window:Tab({Title = "🔪 被遺棄", Icon = "skull"})
local InkGameTab = Window:Tab({Title = "🖊️ 墨水遊戲", Icon = "pen-tool"})
local StrongestBattlegroundsTab = Window:Tab({Title = "✋ 最強戰場", Icon = "fist"})
local NightsForestTab = Window:Tab({Title = "🌲 森林99夜", Icon = "tree"})
local OtherGamesTab = Window:Tab({Title = "🎮 其他遊戲", Icon = "gamepad"})
local UniversalTab = Window:Tab({Title = "⚒️ 通用", Icon = "tool"})
local ESPTab = Window:Tab({Title = "👀 ESP", Icon = "eye"})
local PrisonLifeTab = Window:Tab({Title = "🔒 監獄人生", Icon = "lock"})
local DesyncTab = Window:Tab({Title = "🌀 Desync", Icon = "shield-off"})
local CriminalityTab = Window:Tab({Title = "💀 Criminality", Icon = "skull-crossed"})
local MusicTab = Window:Tab({Title = "🎶 音樂播放器", Icon = "shield"})
local SettingsTab = Window:Tab({Title = "⚡ 設定", Icon = "settings"})

-- HomeTab 內容
HomeTab:Section({ Title = "🎉 歡迎來到 Nova中心", TextSize = 22 })
HomeTab:Divider()

HomeTab:Paragraph({
    Title = "🔥 Nova中心 - 二代",
    Desc = "Nova中心二代，更好看的Ui\n✨ 無需密鑰 • 定期更新 • 最佳效能"
})

HomeTab:Paragraph({
    Title = "最優質的團隊",
    Desc = "join No_Green_beans team in today!!"
})

HomeTab:Paragraph({
    Title = "👤 使用者資訊",
    Desc = "歡迎，" .. LocalPlayer.Name .. "！\n🎯 準備好提升你的遊戲體驗了嗎！"
})

HomeTab:Section({ Title = "🚀 快速操作", TextSize = 18 })
HomeTab:Divider()

HomeTab:Button({
    Title = "📱 加入 Discord",
    Desc = "加入社群獲取最新更新與支援！",
    Icon = "users",
    Callback = function()
        setclipboard("https://discord.gg/4WSmx666DP")
        showNotification("📱 Discord", "邀請連結已複製到剪貼簿！", 4, "users")
    end
})

HomeTab:Button({
    Title = "🔄 重新整理中心",
    Desc = "重新載入中心以獲取最新內容",
    Icon = "refresh-cw",
    Callback = function()
        showNotification("🔄 重新整理中", "Nova中心正在重新載入...", 3, "refresh-cw")
        wait(2)
        Window:SelectTab(HomeTab)
    end
})

HomeTab:Button({
    Title = "📊 查看伺服器狀態",
    Desc = "顯示當前伺服器名稱、ID、人數資訊",
    Icon = "server",
    Callback = function()
        local currentPlayers = #Players:GetPlayers()
        local maxPlayers = Players.MaxPlayers
        local serverName = game.JobId \~= "" and game.JobId or "本地/私人伺服器"
        local placeId = game.PlaceId
        
        local message = string.format(
            "伺服器名稱: %s\nPlace ID: %d\n目前人數: %d / 滿人數 %d",
            serverName, placeId, currentPlayers, maxPlayers
        )
        
        showNotification("📊 伺服器狀態", message, 8, "server")
    end
})
-- PopularTab 內容
PopularTab:Section({ Title = "⭐ 最熱門腳本", TextSize = 20 })
PopularTab:Divider()

createScriptButton(PopularTab, "通用靜默自瞄", "幾乎全遊戲通用", "https://atlasteam.live/silentaim", "全遊戲", "🚀")
createScriptButton(PopularTab, "Infinite Yield", "進階管理指令，功能豐富", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", "全遊戲", "👑")
createScriptButton(PopularTab, "Orca Hub", "多遊戲通用腳本中心", "https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua", "全遊戲", "🐋")
createScriptButton(PopularTab, "Dark Dex", "強大的腳本瀏覽與反編譯工具", "https://raw.githubusercontent.com/infyiff/backup/main/dex.lua", "全遊戲", "🔍")
createScriptButton(PopularTab, "Nova中心（舊版）", "已落幕，但是最經典", "https://pastebin.com/raw/v4DkDbpU", "全遊戲", "⭐")
createScriptButton(PopularTab, "TX腳本中心", "國內最強", "https://github.com/devslopo/DVES/raw/main/XK%20Hub", "全遊戲", "🇨🇳")
createScriptButton(PopularTab, "BS黑洞中心", "強力通用腳本", "https://gitee.com/BS_script/script/raw/master/BS_Script.Luau", "全遊戲", "🕳️")
createScriptButton(PopularTab, "kral", "Xi團隊破解", "https://raw.githubusercontent.com/2721284198-dev/kj/refs/heads/main/kanl", "全遊戲", "⚡")

PopularTab:Button({
    Title = "🎮 Aham Hub 腳本",
    Desc = "全遊戲通用腳本 - 支援25+遊戲",
    Icon = "cpu",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-AHAM-HUB-52379"))()
        showNotification("🎮 Aham Hub", "已載入 Aham Hub！", 4, "cpu")
    end
})

PopularTab:Button({
    Title = "⚡ YARHM 腳本",
    Desc = "全遊戲通用腳本 - 全遊戲支援",
    Icon = "zap",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-YARHM-12403"))()
        showNotification("⚡ YARHM", "已載入 YARHM！", 4, "zap")
    end
})

-- MM2Tab
MM2Tab:Section({ Title = "🗡️ 殺手疑雲2 腳本", TextSize = 18 })
MM2Tab:Divider()

createScriptButton(MM2Tab, "MM2 TravHub", "完整功能 - 無需密鑰", "https://raw.githubusercontent.com/mm2scripthub/TravHub/refs/heads/main/MurderMystery2", "殺手疑雲2", "🌙")
createScriptButton(MM2Tab, "MM2 自動農場", "管理指令與工具 - 無需密鑰", "https://raw.githubusercontent.com/renardofficiel/game/refs/heads/main/MurderMystery2/main.lua", "殺手疑雲2", "🛡️")

-- BedwarsTab
BedwarsTab:Section({ Title = "🛏️ 床戰 腳本", TextSize = 18 })
BedwarsTab:Divider()

createScriptButton(BedwarsTab, "BedWars Rust Hub", "完整床戰功能 - 無需密鑰", "https://raw.githubusercontent.com/0xEIite/rust/main/NewMainScript.lua", "床戰", "🦀")
createScriptButton(BedwarsTab, "BedWars Vape V4", "高級床戰腳本，功能強大", "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", "床戰", "💨")

-- RivalsTab
RivalsTab:Section({ Title = "⚔️ 對手 腳本", TextSize = 18 })
RivalsTab:Divider()

createScriptButton(RivalsTab, "kiciahook2.0", "目前最強腳本", "https://raw.githubusercontent.com/kiciahook/kiciahook/refs/heads/main/loader.luau", "對手", "🌟")
createScriptButton(RivalsTab, "RIVALS Rise", "進階對手腳本，自動功能齊全", "https://raw.githubusercontent.com/ShadowBey01/SHWX-Team-Rise-Scripts/refs/heads/main/Games/Rise%20(Rivals).lua", "對手", "🚀")

-- DoorsTab
DoorsTab:Section({ Title = "🚪 門 腳本", TextSize = 18 })
DoorsTab:Divider()

createScriptButton(DoorsTab, "DOORS Saturn Hub", "完整門腳本，實體規避", "https://raw.githubusercontent.com/JScripter-Lua/Saturn_Hub_Products/refs/heads/main/Saturn_Hub_Doors.lua", "門", "🪐")
createScriptButton(DoorsTab, "DOORS Velocity X", "速度與生存功能", "https://raw.githubusercontent.com/DasVelocity/VelocityX/refs/heads/main/VelocityX.lua", "門", "💨")

-- ArsenalTab
ArsenalTab:Section({ Title = "🎯 軍火庫 腳本", TextSize = 18 })
ArsenalTab:Divider()

createScriptButton(ArsenalTab, "Arsenal Vapa v2 Hub", "瞄準與透視功能", "https://raw.githubusercontent.com/Nickyangtpe/Vapa-v2/refs/heads/main/Vapav2-Arsenal.lua", "軍火庫", "🎨")
createScriptButton(ArsenalTab, "Arsenal Tbao Hub", "完整軍火庫腳本套裝", "https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubArsenal", "軍火庫", "🐯")

-- BrookhavenTab
BrookhavenTab:Section({ Title = "🏡 布魯克海文RP 腳本", TextSize = 18 })
BrookhavenTab:Divider()

BrookhavenTab:Button({
    Title = "🏠 MOLYN 布魯克海文腳本",
    Desc = "無需密鑰的布魯克海文腳本 - Credits: BRUTON",
    Icon = "city",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/XDZB6xCY/raw"))()
        showNotification("🏙️ MOLYN 布魯克海文", "已載入 MOLYN 布魯克海文腳本！", 4, "city")
    end
})

-- DeadRailsTab
DeadRailsTab:Section({ Title = "🚂 死亡鐵路 腳本", TextSize = 18 })
DeadRailsTab:Divider()

DeadRailsTab:Button({
    Title = "💰 MOLYN 死亡鐵路腳本",
    Desc = "自動農債券 - Credits: HANG/Tora",
    Icon = "dollar-sign",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/XDZB6xCY/raw"))()
        showNotification("🚂 MOLYN 死亡鐵路", "已載入 MOLYN 死亡鐵路腳本！", 4, "train")
    end
})

-- ForsakenTab
ForsakenTab:Section({ Title = "🔪 被遺棄 腳本", TextSize = 18 })
ForsakenTab:Divider()

ForsakenTab:Button({
    Title = "Nol",
    Desc = "keyless",
    Icon = "shield-off",
    Callback = function()
        setclipboard("NOL_KEY")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SyndromeXph/Nolsaken/refs/heads/main/Loader.luau"))()
        showNotification("🔪 Nol", "已複製 NOL_KEY 並載入 Nol 腳本！", 5, "shield-off")
    end
})

-- InkGameTab
InkGameTab:Section({ Title = "🖊️ 墨水遊戲 腳本", TextSize = 18 })
InkGameTab:Divider()

InkGameTab:Button({
    Title = "AX",
    Desc = "Need Key",
    Icon = "key",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/AX%20CN"))()
        showNotification("🖊️ AX", "已載入 AX 腳本！", 4, "key")
    end
})

InkGameTab:Button({
    Title = "Ringta",
    Desc = "keyless（舊版）",
    Icon = "circle",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/Ringta"))()
        showNotification("🖊️ Ringta", "已載入 Ringta 舊版腳本！", 4, "circle")
    end
})

-- StrongestBattlegroundsTab
StrongestBattlegroundsTab:Section({ Title = "✋ 最強戰場 腳本", TextSize = 18 })
StrongestBattlegroundsTab:Divider()

createScriptButton(StrongestBattlegroundsTab, "VexonHub", "最強腳本", "https://raw.githubusercontent.com/Tax-Script/TaxHub/refs/heads/main/VexonHub%20汉化", "最強戰場", "⚡")

-- CriminalityTab
CriminalityTab:Section({ Title = "💀 Criminality 腳本", TextSize = 18 })
CriminalityTab:Divider()

CriminalityTab:Button({
    Title = "kenny漢化",
    Desc = "容易被踢",
    Icon = "skull",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/Kenny1.5.txt"))()
        showNotification("💀 kenny漢化", "已載入 kenny漢化腳本（注意容易被踢）", 5, "skull")
    end
})

-- NightsForestTab
NightsForestTab:Section({ Title = "🌲 森林99夜 腳本", TextSize = 18 })
NightsForestTab:Divider()

NightsForestTab:Button({
    Title = "🌙 MOLYN 99夜腳本",
    Desc = "生存腳本 - 森林99夜專用",
    Icon = "moon",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/XDZB6xCY/raw"))()
        showNotification("🌲 MOLYN 99夜", "已載入 MOLYN 99夜腳本！", 4, "tree")
    end
})

-- PrisonLifeTab
PrisonLifeTab:Section({ Title = "🔒 監獄人生 腳本", TextSize = 18 })
PrisonLifeTab:Divider()

PrisonLifeTab:Button({
    Title = "腳本一",
    Desc = "監獄人生專用腳本",
    Icon = "lock",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zenss555a/script/refs/heads/main/Prison-Life.lua"))()
        showNotification("🔒 腳本一", "監獄人生腳本已載入！", 4, "lock")
    end
})
-- DesyncTab
DesyncTab:Section({ Title = "🌀 Desync 腳本", TextSize = 18 })
DesyncTab:Divider()

DesyncTab:Button({
    Title = "desync(keyless)",
    Desc = "無須密鑰，但是ui不好看",
    Icon = "shield-off",
    Callback = function()
        loadstring(game:HttpGet("https://api.junkie-development.de/api/v1/luascripts/public/a4a51edce7d45e520ef282f1adb6a3cd5414c04ac0e87bd21577c13cf2f5e4df/download"))()
        showNotification("🌀 Desync", "keyless 版已載入", 4, "shield-off")
    end
})

DesyncTab:Button({
    Title = "desync(need key)",
    Desc = "Ui更好看",
    Icon = "shield",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/kingdos227/-/refs/heads/main/⃝.lua"))()
        showNotification("🌀 Desync", "需密鑰版已載入", 4, "shield")
    end
})

-- UniversalTab 內容
UniversalTab:Section({ Title = "通用 工具", TextSize = 20 })
UniversalTab:Divider()

-- 快速互動
local fastInteractEnabled = false
local originalPrompts = {}

local function toggleFastInteract(state)
    fastInteractEnabled = state
    
    if state then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                originalPrompts[obj] = obj.HoldDuration
                obj.HoldDuration = 0
            end
        end
        showNotification("⚡ 快速互動", "已啟用（所有長按改為即時）", 4, "zap")
    else
        for prompt, duration in pairs(originalPrompts) do
            if prompt and prompt.Parent then
                prompt.HoldDuration = duration
            end
        end
        originalPrompts = {}
        showNotification("⚡ 快速互動", "已關閉，恢復原長按時間", 4, "zap-off")
    end
end

UniversalTab:Toggle({
    Title = "⚡ 快速互動",
    Desc = "將所有需要長按的 UI 改為 0 秒（再按恢復）",
    Value = false,
    Callback = function(state)
        toggleFastInteract(state)
    end
})

UniversalTab:Button({
    Title = "💀 自殺",
    Desc = "立即讓角色死亡",
    Icon = "skull",
    Callback = function()
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Health = 0
                showNotification("💀 自殺", "已執行自殺", 3, "skull")
            end
        end
    end
})

UniversalTab:Divider()

-- Anti-AFK (1)
UniversalTab:Button({
    Title = "Anti-AFK (1)",
    Desc = "Unc 低於 90% 可用",
    Icon = "mouse-pointer",
    Callback = function()
        _G.WindUI:Notify({
            Title = "Anti-AFK 已啟動",
            Content = "模擬點擊模式，每 19 分鐘自動點中間防止 AFK",
            Duration = 5,
            Icon = "mouse-pointer"
        })

        spawn(function()
            while true do
                task.wait(1)
                if tick() - lastInputTime > IDLE_THRESHOLD then
                    local cam = workspace.CurrentCamera
                    if cam then
                        local centerX = cam.ViewportSize.X / 2
                        local centerY = cam.ViewportSize.Y / 2

                        VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
                        task.wait(0.05)
                        VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)

                        lastInputTime = tick()
                        print("Anti-AFK: 已模擬中間點擊一次")
                    end
                end
            end
        end)
    end
})

-- Anti-AFK (2)
UniversalTab:Button({
    Title = "Anti-AFK (2)",
    Desc = "Unc 高於 90% 可用",
    Icon = "shield",
    Callback = function()
        local mt = getrawmetatable(game)
        local oldNamecall = mt.__namecall

        setreadonly(mt, false)

        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()

            if method == "Kick" and self == LocalPlayer then
                local args = {...}
                local msg = tostring(args[1] or "")
                if msg:lower():find("afk") or msg:lower():find("idle") or msg:lower():find("anti-afk") then
                    print("Anti-AFK: 攔截到 AFK Kick → " .. msg)
                    return
                end
            end

            return oldNamecall(self, ...)
        end)

        setreadonly(mt, true)

        _G.WindUI:Notify({
            Title = "Anti-AFK Kick 已啟動",
            Content = "Enjoy",
            Duration = 5,
            Icon = "shield-check"
        })
    end
})

-- Anti Kick (LocalScript)
UniversalTab:Button({
    Title = "Anti Kick (LocalScript)",
    Desc = "效果有限",
    Icon = "shield",
    Callback = function()
        local count = 0
        
        local oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            
            if self == LocalPlayer then
                if method == "Kick" or method == "Destroy" then
                    count = count + 1
                    print("防禦本地 Kick/Destroy ×" .. count)
                    return
                end
            end
            
            return oldNamecall(self, ...)
        end)
        
        spawn(function()
            while true do
                task.wait(0.1)
                local char = LocalPlayer.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health <= 0 then
                        hum.Health = 1
                        print("防 Health 歸零")
                    end
                end
            end
        end)
        
        print("Anti Kick 已啟用")
    end
})

UniversalTab:Divider()

UniversalTab:Button({
    Title = "重新加入",
    Desc = "重新加入當前伺服器",
    Icon = "refresh-cw",
    Callback = function()
        showNotification("重新加入", "正在重新加入伺服器...", 3, "refresh-cw")
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end
})

-- 其他按鈕如加入少人伺服器、切換伺服器等（可繼續補上你的原碼）

-- 無限體力功能（從你原碼）
UniversalTab:Section({Title = "無限體力", TextSize = 18})
UniversalTab:Divider()

UniversalTab:Paragraph({
    Title = "說明",
    Desc = "通用無限體力腳本"
})

-- 飛行模式
local flyEnabled = false
local flyConnection
local flySpeed = 50
local bodyVelocity, bodyGyro

-- ... (你的飛行 startFly / stopFly 函數保持原樣，但改用 _G.WindUI:Notify)

-- 其他功能如穿牆、行走速度、跳躍、無限跳、ESP、音樂播放器、設定 Tab 等繼續用原碼，但通知改 _G.WindUI:Notify

-- 最後結尾
Window:SelectTab(HomeTab)

wait(1)
loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebulla-Softworks/Luna-Interface/refs/heads/main/source.lua"))()

setclipboard("https://discord.gg/4WSmx666DP")
print("🎉 Nova中心 - 頂級通用腳本中心載入成功！")
print("[NovaHub Debug] 腳本執行完畢，UI 應該已建好，按 Insert 開啟")
