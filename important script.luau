loadstring(game:HttpGet("https://raw.githubusercontent.com/Godly-class/NovaHub/refs/heads/main/loading.lua"))()
task.wait(5)

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

print("[DEBUG] _G.WindUI 是否存在:", _G.WindUI ~= nil)

print("[DEBUG] CreateWindow 是否 function:", type(_G.WindUI.CreateWindow) == "function")

-- 服務與玩家變數

local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local StarterGui = game:GetService("StarterGui")

local TweenService = game:GetService("TweenService")

local UserInputService = game:GetService("UserInputService")

local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
print("第一段無問題")

-- 初始通知



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

Window:EditOpenButton({
    Title = "Dev Nova",
    Icon = "terminal",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("#4A90E2"), 
        Color3.fromHex("#8A3FFC")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

Window:Tag({
    Title = "Dev Version",
    Icon = "github",
    Color = Color3.fromHex("#6a5cff"),
    Radius = 13, -- from 0 to 13
})

--// Services
local Stats = game:GetService("Stats")
local RunService = game:GetService("RunService")

--// ===== FPS 計算 =====
local fps = 0
local frames = 0
local lastTime = tick()

RunService.RenderStepped:Connect(function()
    frames += 1
    if tick() - lastTime >= 1 then
        fps = frames
        frames = 0
        lastTime = tick()
    end
end)

--// ===== 建立 Tag =====
local pingTag = Window:Tag({
    Title = "Ping: 0",
    Icon = "arrow-down",
    Color = Color3.fromHex("#5cecff"),
    Radius = 13,
})

local fpsTag = Window:Tag({
    Title = "FPS: 0",
    Icon = "arrow-up",
    Color = Color3.fromHex("#5cff90"),
    Radius = 13,
})

--// ===== 即時更新（每 0.5 秒）=====
task.spawn(function()
    while true do
        local ping = 0

        pcall(function()
            ping = math.floor(
                Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            )
        end)

        -- Wind 通常支援 SetTitle
        if pingTag.SetTitle then
            pingTag:SetTitle("Ping: " .. ping)
        end

        if fpsTag.SetTitle then
            fpsTag:SetTitle("FPS: " .. fps)
        end

        task.wait(0.5)
    end
end)

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

local ArsenalTab = Window:Tab({Title = "⚔️ 刀刃球", Icon = "crosshair"})

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

local RedvsBlueTab = Window:Tab({Title = "✈️ 紅色vs藍色飛機戰爭", Icon = "shield"})

local NTab = Window:Tab({Title = "🌧️ 自然災害模擬器", Icon = "rain"})

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

createScriptButton(PopularTab, "通用靜默自瞄", "幾乎全遊戲通用（已失效，但我們永遠記得他）", "https://atlasteam.live/silentaim", "全遊戲", "🚀")

createScriptButton(PopularTab, "通用靜默2.0", "上一個版本的替代，Ui更好看（但是是英文）", "https://raw.githubusercontent.com/hm5650/HBSS/refs/heads/main/HBSS.lua", "全遊戲", "🤯")

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

ArsenalTab:Section({ Title = "⚔️ 刀刃球 腳本", TextSize = 18 })

ArsenalTab:Divider()

createScriptButton(ArsenalTab, "Keyless script", "無鑰匙推薦腳本", "https://4x.wtf/loader", "刀刃球", "⚔️")

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

-- UniversalTab 內容開始

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
-- 共用變數（放在 Tab 外面，避免衝突）

local lastInputTime = tick()

local IDLE_THRESHOLD = 1140  -- 19 分鐘

-- 監聽所有輸入，更新最後活動時間

UserInputService.InputBegan:Connect(function(input, gameProcessed)

    if not gameProcessed then

        lastInputTime = tick()

    end

end)

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
        -- 安全起見，先包 newcclosure (有些 executor 強制要用)
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
            local method = getnamecallmethod()  -- 取得被呼叫的方法名
            
            -- 範例：攔截 Kick，讓它不真的踢你
            if method == "Kick" and self == game.Players.LocalPlayer then
                print("有人想 Kick 我！理由：" .. tostring(...))
                return -- 不呼叫原本，直接擋掉
            end
            
            -- 範例：改 FireServer 參數（例如無限發送 Remote）
            if method == "FireServer" then
                print("Remote 被呼叫！方法：" .. tostring(...))
                -- 你可以改參數：return oldNamecall(self, "改參數", ...)
            end
            
            -- 正常呼叫原本的
            return oldNamecall(self, ...)
        end))

        print("hookmetamethod __namecall 已安裝！測試 Kick 不會斷線")
        game.Players.LocalPlayer:Kick("測試～")  -- 應該只印訊息，不斷線
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

UniversalTab:Button({

    Title = "加入少人伺服器",

    Desc = "嘗試加入人數 3\~4 人以下的伺服器",

    Icon = "users",

    Callback = function()

        showNotification("加入少人伺服器", "正在搜尋低人數伺服器...", 4, "users")

        local function tryLowPlayer()

            local success = pcall(function()

                game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)

            end)

            if not success then

                wait(1)

                tryLowPlayer()

            end

        end

        tryLowPlayer()

    end

})

UniversalTab:Button({

    Title = "切換伺服器",

    Desc = "隨機切換到全新伺服器",

    Icon = "server",

    Callback = function()

        showNotification("切換伺服器", "正在尋找新伺服器...", 4, "server")

        local servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))

        local server = servers.data[math.random(1, #servers.data or 1)]

        if server and server.id then

            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)

        else

            showNotification("錯誤", "暫時找不到可用伺服器", 5, "alert-triangle")

        end

    end

})

UniversalTab:Divider()

-- 無限體力

UniversalTab:Section({Title = "無限體力", TextSize = 18})

UniversalTab:Divider()

UniversalTab:Paragraph({

    Title = "說明",

    Desc = "通用無限體力腳本"

})

local staminaEnabled = false

local staminaConnection

UniversalTab:Toggle({

    Title = "啟用無限體力",

    Desc = "開啟後體力固定 100，防消耗",

    Value = false,

    Callback = function(state)

        staminaEnabled = state

        

        if state then

            _G.WindUI:Notify({

                Title = "無限體力 已啟用",

                Content = "體力固定 100，防消耗 & 低頻保活中...",

                Duration = 5,

                Icon = "battery-full"

            })

            

            local INF_STAMINA = 100

            

            local function findAndHookStamina()

                for _, v in pairs(getgc(true)) do

                    if type(v) == "table" then

                        local keys = {"_stamina", "Stamina", "_baseMax", "_Max", "maxStamina", "MaxStamina"}

                        for _, key in ipairs(keys) do

                            if rawget(v, key) \~= nil then

                                rawset(v, key, INF_STAMINA)

                                if key \~= "_stamina" then

                                    rawset(v, "_stamina", INF_STAMINA)

                                end

                                print("Hooked stamina table: " .. key .. " -> " .. INF_STAMINA)

                            end

                        end

                    end

                end

            end

            

            local oldNamecall

            local hooked = pcall(function()

                oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)

                    local method = getnamecallmethod()

                    local args = {...}

                    

                    if method == "InvokeServer" or method == "FireServer" then

                        if tostring(self):lower():find("stamina") or getnamecallmethod():lower():find("stamina") then

                            return INF_STAMINA

                        end

                    end

                    

                    if (method == "FireServer" or method == "InvokeServer") and 

                       (tostring(self):find("Stamina") or (args[1] and type(args[1]) == "number")) then

                        return

                    end

                    

                    return oldNamecall(self, ...)

                end)

            end)

            

            if not hooked then

                print("hookmetamethod 失敗，使用備用模式")

            end

            

            if hookfunction then

                for _, func in pairs(getgc(true)) do

                    if type(func) == "function" then

                        local info = debug.getinfo(func)

                        if info and info.name and info.name:lower():find("stamina") then

                            hookfunction(func, function(...)

                                return INF_STAMINA

                            end)

                        end

                    end

                end

            end

            

            pcall(function()

                LocalPlayer:SetAttribute("StaminaConsumeMultiplier", 0)

                LocalPlayer:GetAttributeChangedSignal("StaminaConsumeMultiplier"):Connect(function()

                    LocalPlayer:SetAttribute("StaminaConsumeMultiplier", 0)

                end)

            end)

            

            pcall(function()

                local pg = LocalPlayer:WaitForChild("PlayerGui")

                for _, gui in pairs(pg:GetDescendants()) do

                    if gui:IsA("Frame") or gui:IsA("ImageLabel") then

                        if gui.Name:lower():find("stamina") or gui.Name:lower():find("energy") then

                            gui.Visible = false

                        end

                    end

                end

            end)

            

            local frameCount = 0

            staminaConnection = RunService.Heartbeat:Connect(function()

                if not staminaEnabled then return end

                

                frameCount = frameCount + 1

                if frameCount >= 30 then

                    findAndHookStamina()

                    frameCount = 0

                end

            end)

            

            findAndHookStamina()

            print("Universal Infinite Stamina Activated!")

            

        else

            _G.WindUI:Notify({

                Title = "無限體力 已關閉",

                Content = "體力恢復正常",

                Duration = 4,

                Icon = "battery-low"

            })

            

            if staminaConnection then

                staminaConnection:Disconnect()

                staminaConnection = nil

            end

            

            pcall(function()

                local pg = LocalPlayer.PlayerGui

                for _, gui in pairs(pg:GetDescendants()) do

                    if gui:IsA("Frame") or gui:IsA("ImageLabel") then

                        if gui.Name:lower():find("stamina") or gui.Name:lower():find("energy") then

                            gui.Visible = true

                        end

                    end

                end

            end)

        end

    end

})

-- NovaHub - 顯示並複製當前位置（只執行一次）

UniversalTab:Button({
    Title = "📍 複製當前位置",
    Desc = "點擊後顯示座標並複製到剪貼簿",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character then
            showNotification("位置工具", "角色尚未載入", 5, "alert-triangle")
            return
        end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then
            showNotification("位置工具", "找不到 HumanoidRootPart", 5, "alert-triangle")
            return
        end
        
        local pos = rootPart.Position
        local coordText = string.format("Vector3.new(%.2f, %.2f, %.2f)", pos.X, pos.Y, pos.Z)
        
        -- 顯示通知
        showNotification("當前位置", coordText, 5, "map-pin")
        
        -- 複製到剪貼簿
        if setclipboard then
            setclipboard(coordText)
            showNotification("複製成功", "座標已複製到剪貼簿", 4, "check")
        elseif toclipboard then
            toclipboard(coordText)
            showNotification("複製成功", "座標已複製到剪貼簿", 4, "check")
        else
            showNotification("無法複製", "你的 executor 不支援 setclipboard / toclipboard", 5, "alert-triangle")
        end
    end
})


-- 飛行模式

-- 全域變數（放在腳本頂端）
local flyEnabled = false
local bodyVelocity = nil
local bodyGyro = nil
local flyConnection = nil
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 飛行速度調整（可改）
local flySpeed = 50  -- 基本速度
local ascendSpeed = 30  -- 上昇/下降速度

-- 輸入狀態（PC 用）
local movingForward = false
local movingBackward = false
local movingLeft = false
local movingRight = false
local ascending = false
local descending = false

-- 開始飛行
local function startFly()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    
    -- 關閉舊的
    if bodyVelocity then bodyVelocity:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
    if flyConnection then flyConnection:Disconnect() end
    
    humanoid.PlatformStand = true  -- 讓角色浮起來，不受重力
    
    -- BodyVelocity：控制移動
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.Parent = rootPart
    
    -- BodyGyro：控制旋轉（跟攝影機方向）
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.P = 20000
    bodyGyro.Parent = rootPart
    
    flyEnabled = true
    
    -- 每幀更新（用 Heartbeat 最穩）
    flyConnection = RunService.Heartbeat:Connect(function(deltaTime)
        if not flyEnabled or not rootPart or not character then return end
        
        local camera = workspace.CurrentCamera
        local moveDir = Vector3.new(0, 0, 0)
        
        -- PC 鍵盤輸入
        if UIS.KeyboardEnabled then
            if movingForward then moveDir = moveDir + camera.CFrame.LookVector end
            if movingBackward then moveDir = moveDir - camera.CFrame.LookVector end
            if movingLeft then moveDir = moveDir - camera.CFrame.RightVector end
            if movingRight then moveDir = moveDir + camera.CFrame.RightVector end
            
            local vertical = 0
            if ascending then vertical = vertical + ascendSpeed end
            if descending then vertical = vertical - ascendSpeed end
            moveDir = moveDir + Vector3.new(0, vertical, 0)
        end
        
        -- Mobile：用 Humanoid.MoveDirection（joystick 方向）
        if UIS.TouchEnabled then
            -- MoveDirection 已經是世界空間的前後左右（基於攝影機）
            moveDir = humanoid.MoveDirection * flySpeed
            
            -- 手機升降：可以用 JumpRequest 當「上」，或加雙指捏合（Pinch）偵測
            -- 這裡先簡單用「跳躍按鈕」當上、下（可改成其他）
            -- 如果想更好，可以加 TouchPinch 偵測雙指距離變化
        end
        
        -- 統一處理速度
        if moveDir.Magnitude > 0 then
            moveDir = moveDir.Unit * flySpeed
        end
        
        bodyVelocity.Velocity = moveDir
        
        -- 讓角色面向攝影機方向（平滑）
        bodyGyro.CFrame = camera.CFrame
    end)
    
    showNotification("🚀 飛行", "飛行模式已開啟\nPC: WASD+Space/Shift\n手機: 搖桿移動", 5, "landmark")
end

-- 停止飛行
local function stopFly()
    flyEnabled = false
    
    if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
    if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.PlatformStand = false end
    end
    
    showNotification("🚀 飛行", "飛行模式已關閉", 3, "landmark")
end

-- PC 鍵盤偵測（放在 Toggle 外面，全域）
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed or not flyEnabled then return end
    
    if input.KeyCode == Enum.KeyCode.W then movingForward = true end
    if input.KeyCode == Enum.KeyCode.S then movingBackward = true end
    if input.KeyCode == Enum.KeyCode.A then movingLeft = true end
    if input.KeyCode == Enum.KeyCode.D then movingRight = true end
    if input.KeyCode == Enum.KeyCode.Space then ascending = true end
    if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then descending = true end
end)

UIS.InputEnded:Connect(function(input)
    if not flyEnabled then return end
    
    if input.KeyCode == Enum.KeyCode.W then movingForward = false end
    if input.KeyCode == Enum.KeyCode.S then movingBackward = false end
    if input.KeyCode == Enum.KeyCode.A then movingLeft = false end
    if input.KeyCode == Enum.KeyCode.D then movingRight = false end
    if input.KeyCode == Enum.KeyCode.Space then ascending = false end
    if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then descending = false end
end)

-- 手機 JumpRequest（跳躍按鈕當「上」）
UIS.JumpRequest:Connect(function()
    if flyEnabled and UIS.TouchEnabled then
        -- 這裡可以切換 ascending = not ascending（或加計時器）
        ascending = true
        task.delay(0.5, function() ascending = false end)  -- 短暫上升
    end
end)

-- Toggle 部分（不變）
UniversalTab:Toggle({
    Title = "🚀 飛行模式",
    Desc = "開啟飛行（PC: WASD+Space/Shift | 手機: 搖桿移動）",
    Value = false,
    Callback = function(state)
        if state then
            startFly()
        else
            stopFly()
        end
    end
})

UniversalTab:Slider({

    Title = "🎯 飛行速度",

    Desc = "調整飛行移動速度",

    Value = { Min = 20, Max = 200, Default = 50 },

    Callback = function(value)

        flySpeed = value

    end

})

LocalPlayer.CharacterAdded:Connect(function()

    task.wait(1.5)

    if flyEnabled then

        startFly()

    end

end)

-- 穿牆模式

local noclipEnabled = false

UniversalTab:Toggle({

    Title = "👻 穿牆模式",

    Desc = "可穿過牆壁與物體行走",

    Value = false,

    Callback = function(state)

        noclipEnabled = state

        showNotification("👻 穿牆", state and "穿牆模式已啟動！" or "穿牆模式已關閉", 3, "ghost")

    end

})

-- 行走速度

local walkSpeedValue = 16

UniversalTab:Slider({

    Title = "💨 行走速度",

    Desc = "調整角色移動速度",

    Value = { Min = 16, Max = 200, Default = 16 },

    Callback = function(value)

        walkSpeedValue = value

        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid then humanoid.WalkSpeed = value end

    end

})

-- 跳躍高度

local jumpPowerValue = 50

UniversalTab:Slider({

    Title = "🦘 跳躍高度",

    Desc = "調整角色跳躍高度",

    Value = { Min = 50, Max = 500, Default = 50 },

    Callback = function(value)

        jumpPowerValue = value

        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid then humanoid.JumpPower = value end

    end

})

-- 無限跳躍

local infiniteJumpEnabled = false

UniversalTab:Toggle({

    Title = "∞ 無限跳躍",

    Desc = "按住空白鍵可無限跳躍",

    Value = false,

    Callback = function(state)

        infiniteJumpEnabled = state

        showNotification("∞ 跳躍", state and "無限跳躍已啟動！" or "無限跳躍已關閉", 3, "activity")

    end

})

RunService.RenderStepped:Connect(function()

    if noclipEnabled and LocalPlayer.Character then

        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do

            if part:IsA("BasePart") then

                part.CanCollide = false

            end

        end

    end

end)

UserInputService.JumpRequest:Connect(function()

    if infiniteJumpEnabled and LocalPlayer.Character then

        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid then humanoid:ChangeState("Jumping") end

    end

end)


local floatConnection
local isFloating = false
local floatPart = nil
local fixedY = nil
local lastFollowPosition = nil

-- 建立超大透明穿牆平台
local function createFloatPlatform()
    if floatPart then floatPart:Destroy() end
    
    floatPart = Instance.new("Part")
    floatPart.Name = "FloatPlatform"
    floatPart.Size = Vector3.new(500, 1, 500)           -- 更大一點，邊界更寬裕
    floatPart.Transparency = 1
    floatPart.CanCollide = false                        -- 完全穿牆
    floatPart.CanQuery = false                          -- 不會被 Raycast 等偵測到
    floatPart.Anchored = true
    floatPart.Material = Enum.Material.ForceField
    floatPart.Color = Color3.fromRGB(0, 0, 0)
    floatPart.Parent = workspace
    
    local hrp = game.Players.LocalPlayer.Character 
        and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        floatPart.CFrame = CFrame.new(hrp.Position.X, hrp.Position.Y - 3, hrp.Position.Z)
        fixedY = hrp.Position.Y - 3
    end
end

-- 檢查是否需要跟隨（距離 > 50 就跟隨一次）
local function checkAndFollowIfNearEdge()
    if not floatPart or not fixedY then return end
    
    local player = game.Players.LocalPlayer
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local currentPos = hrp.Position
    local partPos = floatPart.Position
    
    -- 只比對 X,Z 平面距離
    local horizontalDistance = (Vector3.new(currentPos.X, 0, currentPos.Z) - Vector3.new(partPos.X, 0, partPos.Z)).Magnitude
    
    if horizontalDistance > 50 then
        -- 直接瞬移到玩家正下方
        floatPart.CFrame = CFrame.new(currentPos.X, fixedY, currentPos.Z)
        lastFollowPosition = currentPos
    end
end

-- 開啟浮空
local function enableFloat()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char then return end
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not hrp then return end
    
    isFloating = true
    fixedY = hrp.Position.Y - 3
    
    createFloatPlatform()
    lastFollowPosition = hrp.Position
    
    -- 每幀強制鎖定 Y + 檢查邊界
    floatConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not isFloating or not hrp or not hrp.Parent then return end
        
        -- 鎖定 Y 軸（保持玩家相對平台高度）
        local currentPos = hrp.Position
        hrp.CFrame = CFrame.new(currentPos.X, fixedY + 3, currentPos.Z) * hrp.CFrame.Rotation
        
        -- 檢查是否接近邊緣並跟隨
        checkAndFollowIfNearEdge()
    end)
end

-- 關閉浮空
local function disableFloat()
    isFloating = false
    
    if floatConnection then
        floatConnection:Disconnect()
        floatConnection = nil
    end
    
    if floatPart then
        floatPart:Destroy()
        floatPart = nil
    end
end

-- UI 元件
UniversalTab:Toggle({
    Title = "浮空模式（Y鎖定 + 接近50單位自動跟隨 + 穿牆）",
    Default = false,
    Callback = function(value)
        if value then
            enableFloat()
        else
            disableFloat()
        end
    end
})

-- 手動重置按鈕（緊急用）
UniversalTab:Button({
    Title = "強制重置平台到腳下",
    Callback = function()
        if isFloating then
            local hrp = game.Players.LocalPlayer.Character 
                and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp and floatPart then
                floatPart.CFrame = CFrame.new(hrp.Position.X, fixedY, hrp.Position.Z)
                lastFollowPosition = hrp.Position
            end
        end
    end
})

-- 角色重生自動關閉
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    disableFloat()
end)

UniversalTab:Divider()


local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()

local EnergyEnabled = false
local EnergyConnection
local OriginalData = {}

UniversalTab:Button({
    Title = "玩家透明",
    Callback = function()
        EnergyEnabled = not EnergyEnabled
        Char = LP.Character

        if EnergyEnabled then
            -- 保存原始數據
            for _,v in pairs(Char:GetDescendants()) do
                if v:IsA("BasePart") then
                    OriginalData[v] = {
                        Material = v.Material,
                        Transparency = v.Transparency,
                        Color = v.Color
                    }
                    v.Material = Enum.Material.ForceField
                    v.Transparency = 0.2
                end
            end

            -- 彩虹循環
            local hue = 0
            EnergyConnection = RunService.RenderStepped:Connect(function(dt)
                hue = (hue + dt * 0.1) % 1
                local color = Color3.fromHSV(hue,1,1)
                for part,_ in pairs(OriginalData) do
                    if part and part.Parent then
                        part.Color = color
                    end
                end
            end)

        else
            -- 恢復
            if EnergyConnection then
                EnergyConnection:Disconnect()
            end

            for part,data in pairs(OriginalData) do
                if part and part.Parent then
                    part.Material = data.Material
                    part.Transparency = data.Transparency
                    part.Color = data.Color
                end
            end

            OriginalData = {}
        end
    end
})

local Players = game:GetService("Players")
local LP = Players.LocalPlayer

local SavedNeckC0 = {}
local Headless = false

UniversalTab:Toggle({
    Title = "背後漂浮頭（碰撞消失）",
    Default = false,
    Callback = function(Value)
        local Char = LP.Character or LP.CharacterAdded:Wait()
        local Hum = Char:FindFirstChildOfClass("Humanoid")
        if not Hum then return end

        local Rig = Hum.RigType
        Headless = Value

        if Rig == Enum.HumanoidRigType.R6 then
            local Torso = Char:FindFirstChild("Torso")
            local Neck = Torso and Torso:FindFirstChild("Neck")
            local Head = Char:FindFirstChild("Head")
            if not Neck or not Head then return end

            if Headless then
                SavedNeckC0[Neck] = Neck.C0

                Head.CanCollide = false

                -- 往身體後面 + 微往上，臉朝上
                Neck.C0 = CFrame.new(0, 1, 2) * CFrame.Angles(math.rad(-90), 0, 0)

            else
                if SavedNeckC0[Neck] then
                    Neck.C0 = SavedNeckC0[Neck]
                    Head.CanCollide = true
                end
            end

        elseif Rig == Enum.HumanoidRigType.R15 then
            local UpperTorso = Char:FindFirstChild("UpperTorso")
            local Neck = UpperTorso and UpperTorso:FindFirstChild("Neck")
            local Head = Char:FindFirstChild("Head")
            if not UpperTorso or not Neck or not Head then return end

            if Headless then
                SavedNeckC0[Neck] = Neck.C0

                Head.CanCollide = false

                -- 往身體後面 + 微往上，臉朝上
                Neck.C0 = CFrame.new(0, 1, 2) * CFrame.Angles(math.rad(-90), 0, 0)

            else
                if SavedNeckC0[Neck] then
                    Neck.C0 = SavedNeckC0[Neck]
                    Head.CanCollide = true
                end
            end
        end
    end
})

UniversalTab:Divider()




getgenv().TranslateConfig = {
    Enabled = true,                    -- 總開關
    TranslateUI = true,                -- 新增：是否翻譯 UI 文字
    AutoChatTranslate = true,
    TargetLanguage = "zh-CN",
    DisplayTime = 5,
    UIScanInterval = 3                 -- UI 掃描間隔（秒），避免太頻繁
}

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local TranslateCache = {}              -- 文字 → 翻譯結果
local TranslatedInstances = {}         -- 已處理過的 Instance 避免重複

local LanguageOptions = {
    ["簡體中文"] = "zh-CN",
    ["繁體中文"] = "zh-TW",
    ["英文"] = "en",
    ["日文"] = "ja"
}

--==============================
-- 判斷是否需要翻譯（非中文）
--==============================
local function IsForeign(text)
    if typeof(text) \~= "string" or text == "" then
        return false
    end
    -- 包含任何中文字符就不翻
    if text:find("[\228-\233]") then
        return false
    end
    return true
end

--==============================
-- Google 翻譯核心函數
--==============================
local function Translate(text)
    if not getgenv().TranslateConfig.Enabled then
        return text
    end

    if TranslateCache[text] then
        return TranslateCache[text]
    end

    local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl="
        .. getgenv().TranslateConfig.TargetLanguage
        .. "&dt=t&q=" .. HttpService:UrlEncode(text)

    local success, response = pcall(function()
        return game:HttpGet(url, true)
    end)

    if not success or not response then
        warn("[翻譯] 請求失敗:", text)
        return text
    end

    local success2, data = pcall(function()
        return HttpService:JSONDecode(response)
    end)

    if not success2 or not data or not data[1] or not data[1][1] or not data[1][1][1] then
        warn("[翻譯] 解析失敗:", text)
        return text
    end

    local translated = data[1][1][1]
    TranslateCache[text] = translated
    return translated
end

--==============================
-- 翻譯單個 Text 屬性（支援 TextLabel, TextButton, TextBox 等）
--==============================
local function TryTranslateInstance(inst)
    if not inst:IsA("GuiObject") then return end
    if TranslatedInstances[inst] then return end

    local properties = {"Text", "PlaceholderText"}

    for _, prop in ipairs(properties) do
        local original = inst[prop]
        if typeof(original) == "string" and IsForeign(original) then
            task.spawn(function()
                local translated = Translate(original)
                if translated \~= original then
                    -- 安全覆蓋（用 pcall 避免 Locked property 錯誤）
                    pcall(function()
                        inst[prop] = translated
                    end)
                end
            end)
        end
    end

    TranslatedInstances[inst] = true
end

--==============================
-- 掃描並翻譯所有 UI（PlayerGui + CoreGui）
--==============================
local function ScanAndTranslateUI()
    if not getgenv().TranslateConfig.TranslateUI then return end
    if not getgenv().TranslateConfig.Enabled then return end

    local containers = {
        game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui", 10),
        game:GetService("CoreGui")
    }

    for _, container in ipairs(containers) do
        if not container then continue end

        for _, obj in ipairs(container:GetDescendants()) do
            TryTranslateInstance(obj)
        end

        -- 監聽新加入的物件
        obj.ChildAdded:Connect(function(child)
            task.wait(0.1)  -- 稍微延遲確保文字載入
            TryTranslateInstance(child)
            for _, sub in ipairs(child:GetDescendants()) do
                TryTranslateInstance(sub)
            end
        end)
    end
end

-- 週期性掃描（處理動態生成的 UI）
task.spawn(function()
    while true do
        if getgenv().TranslateConfig.Enabled and getgenv().TranslateConfig.TranslateUI then
            pcall(ScanAndTranslateUI)
        end
        task.wait(getgenv().TranslateConfig.UIScanInterval or 3)
    end
end)

-- 初次執行一次完整掃描
task.delay(1, ScanAndTranslateUI)

--==============================
-- 聊天翻譯（維持原功能）
--==============================
for _, player in ipairs(Players:GetPlayers()) do
    player.Chatted:Connect(function(message)
        if not getgenv().TranslateConfig.AutoChatTranslate then return end
        if not IsForeign(message) then return end

        task.spawn(function()
            local translated = Translate(message)
            if translated \~= message then
                _G.WindUI:Notify({
                    Title = player.Name,
                    Content = translated,
                    Duration = getgenv().TranslateConfig.DisplayTime
                })
            end
        end)
    end)
end

-- 新玩家加入時也要監聽
Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        -- 同上邏輯
        if not getgenv().TranslateConfig.AutoChatTranslate then return end
        if not IsForeign(message) then return end

        task.spawn(function()
            local translated = Translate(message)
            if translated \~= message then
                _G.WindUI:Notify({
                    Title = player.Name,
                    Content = translated,
                    Duration = getgenv().TranslateConfig.DisplayTime
                })
            end
        end)
    end)
end)

--==============================
-- UI 控制項（新增 UI 翻譯開關）
--==============================
UniversalTab:Toggle({
    Title = "啟用翻譯（總開關）",
    Default = true,
    Callback = function(Value)
        getgenv().TranslateConfig.Enabled = Value
    end
})

UniversalTab:Toggle({
    Title = "翻譯遊戲內 UI 文字",
    Default = true,
    Callback = function(Value)
        getgenv().TranslateConfig.TranslateUI = Value
        -- 開啟時立即掃描一次
        if Value then
            task.spawn(ScanAndTranslateUI)
        end
    end
})

UniversalTab:Toggle({
    Title = "自動翻譯聊天訊息",
    Default = true,
    Callback = function(Value)
        getgenv().TranslateConfig.AutoChatTranslate = Value
    end
})

UniversalTab:Dropdown({
    Title = "目標語言",
    Values = {"簡體中文", "繁體中文", "英文", "日文"},
    Default = 1,
    Callback = function(Value)
        local lang = LanguageOptions[Value]
        if lang then
            getgenv().TranslateConfig.TargetLanguage = lang
            -- 語言變更 → 清空快取並重新掃描 UI
            TranslateCache = {}
            TranslatedInstances = {}
            task.spawn(ScanAndTranslateUI)
        end
    end
})

UniversalTab:Slider({
    Title = "聊天通知顯示秒數",
    Min = 1,
    Max = 15,
    Default = 5,
    Callback = function(Value)
        getgenv().TranslateConfig.DisplayTime = Value
    end
})

UniversalTab:Slider({
    Title = "UI 掃描間隔（秒）",
    Min = 1,
    Max = 10,
    Default = 3,
    Callback = function(Value)
        getgenv().TranslateConfig.UIScanInterval = Value
    end
})

-- 清除快取按鈕（debug 用）
UniversalTab:Button({
    Title = "清除翻譯快取並重新掃描",
    Callback = function()
        TranslateCache = {}
        TranslatedInstances = {}
        task.spawn(ScanAndTranslateUI)
        _G.WindUI:Notify({
            Title = "系統",
            Content = "已清除快取並重新掃描 UI",
            Duration = 3
        })
    end
})

-- ESPTab

ESPTab:Section({ Title = "👀 ESP 設定", TextSize = 20 })

ESPTab:Divider()

-- =============================================
-- ESP 全功能腳本（Wind UI 版）
-- Tab 名稱：ESPTab
-- 完全符合你列出的 8 項需求
-- =============================================
getgenv().ESPConfig = {
    Enabled = false,           -- 總開關
    Highlight = false,
    Lines = false,
    LinePosition = "下",       -- 上 / 中 / 下
    Radar = false,
    Box = false,
    ExtraDisplayEnabled = false,
    ExtraSelected = {"名稱", "距離"}  -- 預設可複選
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ESPObjects = {}      -- [player] = {boxLines, tracer, nameText, distText, healthBG, healthBar, highlight}
local RadarDots = {}       -- [player] = Drawing.Circle
local MainConnection = nil

-- ====================== 繪圖輔助 ======================
local function NewLine()
    local l = Drawing.new("Line")
    l.Thickness = 1.5
    l.Color = Color3.fromRGB(255, 255, 255)
    l.Transparency = 1
    l.Visible = false
    return l
end

local function NewText()
    local t = Drawing.new("Text")
    t.Size = 13
    t.Center = true
    t.Outline = true
    t.Color = Color3.fromRGB(255, 255, 255)
    t.Transparency = 1
    t.Visible = false
    return t
end

local function NewSquare()
    local s = Drawing.new("Square")
    s.Thickness = 1.5
    s.Color = Color3.fromRGB(255, 255, 255)
    s.Filled = false
    s.Visible = false
    return s
end

-- ====================== 雷達繪圖 ======================
local RadarSize = 160
local RadarPos = Vector2.new(Camera.ViewportSize.X - RadarSize - 30, 30)

local RadarBG = NewSquare()
RadarBG.Size = Vector2.new(RadarSize, RadarSize)
RadarBG.Position = RadarPos
RadarBG.Color = Color3.fromRGB(0, 0, 0)
RadarBG.Transparency = 0.6
RadarBG.Filled = true

local RadarBorder = NewSquare()
RadarBorder.Size = Vector2.new(RadarSize, RadarSize)
RadarBorder.Position = RadarPos
RadarBorder.Color = Color3.fromRGB(255, 255, 255)
RadarBorder.Transparency = 1

local CenterDot = Drawing.new("Circle")
CenterDot.Radius = 3
CenterDot.Color = Color3.fromRGB(0, 255, 0)
CenterDot.Filled = true
CenterDot.Visible = false

-- ====================== 建立單人 ESP ======================
local function CreateESP(player)
    if player == LocalPlayer or ESPObjects[player] then return end

    local objs = {
        -- 方框 (4條線)
        BoxTop    = NewLine(),
        BoxLeft   = NewLine(),
        BoxRight  = NewLine(),
        BoxBottom = NewLine(),

        -- 線條 (Tracer)
        Tracer = NewLine(),

        -- 文字
        NameText = NewText(),
        DistText = NewText(),

        -- 血量條
        HealthBG  = NewLine(),
        HealthBar = NewLine(),

        -- 高亮
        Highlight = nil
    }

    -- 高亮實例
    objs.Highlight = Instance.new("Highlight")
    objs.Highlight.FillColor = Color3.fromRGB(255, 0, 0)
    objs.Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    objs.Highlight.FillTransparency = 0.5
    objs.Highlight.OutlineTransparency = 0

    ESPObjects[player] = objs
end

-- ====================== 更新單人 ESP ======================
local function UpdateESP(player)
    local objs = ESPObjects[player]
    if not objs then return end

    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Head") or not char:FindFirstChild("Humanoid") then
        -- 隱藏所有
        for _, v in pairs(objs) do
            if typeof(v) == "Instance" and v:IsA("Highlight") then
                v.Adornee = nil
            elseif v.Visible \~= nil then
                v.Visible = false
            end
        end
        return
    end

    local root = char.HumanoidRootPart
    local head = char.Head
    local hum = char.Humanoid

    local rootPos, onScreen = Camera:WorldToViewportPoint(root.Position)
    if not onScreen or rootPos.Z < 0 then
        for _, v in pairs(objs) do
            if v.Visible \~= nil then v.Visible = false end
        end
        objs.Highlight.Adornee = nil
        return
    end

    -- 計算 2D 方框
    local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
    local legPos  = Camera:WorldToViewportPoint(root.Position - Vector3.new(0, 3, 0))
    local height  = math.abs(headPos.Y - legPos.Y)
    local width   = height * 0.55

    local boxTopLeft    = Vector2.new(rootPos.X - width/2, headPos.Y)
    local boxTopRight   = Vector2.new(rootPos.X + width/2, headPos.Y)
    local boxBottomLeft = Vector2.new(rootPos.X - width/2, legPos.Y)
    local boxBottomRight= Vector2.new(rootPos.X + width/2, legPos.Y)

    -- === 方框 ===
    if getgenv().ESPConfig.Box then
        objs.BoxTop.From = boxTopLeft
        objs.BoxTop.To   = boxTopRight
        objs.BoxLeft.From = boxTopLeft
        objs.BoxLeft.To   = boxBottomLeft
        objs.BoxRight.From = boxTopRight
        objs.BoxRight.To   = boxBottomRight
        objs.BoxBottom.From = boxBottomLeft
        objs.BoxBottom.To   = boxBottomRight

        for _, line in pairs({objs.BoxTop, objs.BoxLeft, objs.BoxRight, objs.BoxBottom}) do
            line.Visible = true
        end
    else
        for _, line in pairs({objs.BoxTop, objs.BoxLeft, objs.BoxRight, objs.BoxBottom}) do
            line.Visible = false
        end
    end

    -- === 線條 (Tracer) ===
    if getgenv().ESPConfig.Lines then
        local startPos
        local vp = Camera.ViewportSize
        if getgenv().ESPConfig.LinePosition == "上" then
            startPos = Vector2.new(vp.X / 2, 20)
        elseif getgenv().ESPConfig.LinePosition == "中" then
            startPos = Vector2.new(vp.X / 2, vp.Y / 2)
        else
            startPos = Vector2.new(vp.X / 2, vp.Y - 20)
        end

        objs.Tracer.From = startPos
        objs.Tracer.To   = Vector2.new(rootPos.X, rootPos.Y)
        objs.Tracer.Visible = true
    else
        objs.Tracer.Visible = false
    end

    -- === 高亮 ===
    if getgenv().ESPConfig.Highlight then
        objs.Highlight.Adornee = char
        objs.Highlight.Parent = game.CoreGui
    else
        objs.Highlight.Adornee = nil
    end

    -- === 額外顯示 (只在有方框時生效) ===
    if getgenv().ESPConfig.Box and getgenv().ESPConfig.ExtraDisplayEnabled then
        local selected = getgenv().ESPConfig.ExtraSelected

        -- 血量
        if table.find(selected, "血量") then
            local healthPct = hum.Health / hum.MaxHealth
            local barHeight = height * healthPct
            local barPosY = legPos.Y - barHeight

            objs.HealthBG.From = Vector2.new(boxTopLeft.X - 6, legPos.Y)
            objs.HealthBG.To   = Vector2.new(boxTopLeft.X - 6, headPos.Y)
            objs.HealthBG.Color = Color3.fromRGB(30, 30, 30)
            objs.HealthBG.Visible = true

            objs.HealthBar.From = Vector2.new(boxTopLeft.X - 5, legPos.Y)
            objs.HealthBar.To   = Vector2.new(boxTopLeft.X - 5, barPosY)
            objs.HealthBar.Color = healthPct > 0.5 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            objs.HealthBar.Visible = true
        else
            objs.HealthBG.Visible = false
            objs.HealthBar.Visible = false
        end

        -- 名稱 + 距離
        local namePos = Vector2.new(rootPos.X, headPos.Y - 22)
        local dist = math.floor((root.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude)

        if table.find(selected, "名稱") and table.find(selected, "距離") then
            -- 名稱靠左，距離靠右
            objs.NameText.Position = namePos + Vector2.new(-25, 0)
            objs.NameText.Text = player.Name
            objs.NameText.Visible = true

            objs.DistText.Position = namePos + Vector2.new(25, 0)
            objs.DistText.Text = dist .. " studs"
            objs.DistText.Visible = true
        elseif table.find(selected, "名稱") then
            objs.NameText.Position = namePos
            objs.NameText.Text = player.Name
            objs.NameText.Visible = true
            objs.DistText.Visible = false
        elseif table.find(selected, "距離") then
            objs.DistText.Position = namePos
            objs.DistText.Text = dist .. " studs"
            objs.DistText.Visible = true
            objs.NameText.Visible = false
        else
            objs.NameText.Visible = false
            objs.DistText.Visible = false
        end
    else
        objs.NameText.Visible = false
        objs.DistText.Visible = false
        objs.HealthBG.Visible = false
        objs.HealthBar.Visible = false
    end
end

-- ====================== 更新雷達 ======================
local function UpdateRadar()
    if not getgenv().ESPConfig.Radar or not getgenv().ESPConfig.Enabled then
        RadarBG.Visible = false
        RadarBorder.Visible = false
        CenterDot.Visible = false
        for _, dot in pairs(RadarDots) do dot.Visible = false end
        return
    end

    RadarBG.Visible = true
    RadarBorder.Visible = true
    CenterDot.Visible = true
    CenterDot.Position = RadarPos + Vector2.new(RadarSize/2, RadarSize/2)

    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    local scale = RadarSize / 100  -- 100 studs = RadarSize 像素

    for player, dot in pairs(RadarDots) do
        if player == LocalPlayer then continue end
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then
            dot.Visible = false
            continue
        end

        local relative = (root.Position - myRoot.Position)
        local x = relative.X * scale
        local z = relative.Z * scale

        -- 限制在雷達範圍內
        if math.abs(x) > RadarSize/2 or math.abs(z) > RadarSize/2 then
            dot.Visible = false
            continue
        end

        dot.Position = RadarPos + Vector2.new(RadarSize/2 + x, RadarSize/2 + z)
        dot.Visible = true
    end
end

-- ====================== 主循環 ======================
local function ESPLoop()
    if not getgenv().ESPConfig.Enabled then
        -- 全部隱藏
        for _, objs in pairs(ESPObjects) do
            for _, v in pairs(objs) do
                if typeof(v) == "Instance" and v:IsA("Highlight") then
                    v.Adornee = nil
                elseif v.Visible \~= nil then
                    v.Visible = false
                end
            end
        end
        RadarBG.Visible = false
        RadarBorder.Visible = false
        CenterDot.Visible = false
        return
    end

    for _, player in ipairs(Players:GetPlayers()) do
        if player \~= LocalPlayer then
            UpdateESP(player)
        end
    end

    UpdateRadar()
end

-- ====================== 啟用/關閉 ======================
local function EnableESP()
    if MainConnection then return end

    -- 建立已存在玩家
    for _, p in ipairs(Players:GetPlayers()) do
        if p \~= LocalPlayer then
            CreateESP(p)
            if p.Character then
                -- 雷達點
                local dot = Drawing.new("Circle")
                dot.Radius = 4
                dot.Color = Color3.fromRGB(255, 100, 100)
                dot.Filled = true
                RadarDots[p] = dot
            end
        end
    end

    MainConnection = RunService.RenderStepped:Connect(ESPLoop)
end

local function DisableESP()
    if MainConnection then
        MainConnection:Disconnect()
        MainConnection = nil
    end

    for player, objs in pairs(ESPObjects) do
        for _, v in pairs(objs) do
            if typeof(v) == "Instance" then
                if v:IsA("Highlight") then v:Destroy() else v:Destroy() end
            else
                v:Remove()
            end
        end
        ESPObjects[player] = nil
    end

    for _, dot in pairs(RadarDots) do
        dot:Remove()
    end
    RadarDots = {}

    RadarBG.Visible = false
    RadarBorder.Visible = false
    CenterDot.Visible = false
end

-- ====================== UI 元件 ======================
ESPTab:Toggle({
    Title = "ESP 總開關",
    Default = false,
    Callback = function(val)
        getgenv().ESPConfig.Enabled = val
        if val then
            EnableESP()
        else
            DisableESP()
        end
    end
})

ESPTab:Toggle({
    Title = "高亮 (Highlight)",
    Default = false,
    Callback = function(val) getgenv().ESPConfig.Highlight = val end
})

ESPTab:Toggle({
    Title = "線條 (Tracer)",
    Default = false,
    Callback = function(val) getgenv().ESPConfig.Lines = val end
})

ESPTab:Dropdown({
    Title = "線條位置",
    Values = {"上", "中", "下"},
    Default = 3,  -- 預設「下」
    Callback = function(val)
        getgenv().ESPConfig.LinePosition = val
    end
})

ESPTab:Toggle({
    Title = "雷達 (右上角小地圖)",
    Default = false,
    Callback = function(val) getgenv().ESPConfig.Radar = val end
})

ESPTab:Toggle({
    Title = "方框 (Box)",
    Default = false,
    Callback = function(val) getgenv().ESPConfig.Box = val end
})

ESPTab:Dropdown({
    Title = "選擇額外顯示 (可複選)",
    Values = {"血量", "名稱", "距離"},
    Multi = true,
    Default = {"名稱", "距離"},
    Callback = function(selectedTable)
        getgenv().ESPConfig.ExtraSelected = selectedTable
    end
})

ESPTab:Toggle({
    Title = "顯示額外功能 (需開啟方框)",
    Default = false,
    Callback = function(val)
        getgenv().ESPConfig.ExtraDisplayEnabled = val
    end
})

-- ====================== 玩家加入處理 ======================
Players.PlayerAdded:Connect(function(player)
    if player == LocalPlayer then return end
    player.CharacterAdded:Connect(function()
        CreateESP(player)
        local dot = Drawing.new("Circle")
        dot.Radius = 4
        dot.Color = Color3.fromRGB(255, 100, 100)
        dot.Filled = true
        RadarDots[player] = dot
    end)
end)

-- 初始載入已存在玩家
for _, p in ipairs(Players:GetPlayers()) do
    if p \~= LocalPlayer then
        CreateESP(p)
        if p.Character then
            local dot = Drawing.new("Circle")
            dot.Radius = 4
            dot.Color = Color3.fromRGB(255, 100, 100)
            dot.Filled = true
            RadarDots[p] = dot
        end
    end
end

-- 角色重生時刷新
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    if getgenv().ESPConfig.Enabled then
        for player, _ in pairs(ESPObjects) do
            CreateESP(player)
        end
    end
end)

UniversalTab:Divider()


-- MusicTab

MusicTab:Section({ Title = "🎶音樂播放", TextSize = 20 })

MusicTab:Divider()

local currentSound = nil

local currentVolume = 0.5

local currentSpeed = 1.0

MusicTab:Input({

    Title = "輸入音樂 ID",

    Desc = "貼上id",

    Placeholder = "請輸入文本",

    Callback = function(value)

        local soundId = tonumber(value)

        if not soundId then

            _G.WindUI:Notify({

                Title = "錯誤",

                Content = "請輸入有效的數字 ID",

                Duration = 4,

                Icon = "alert-triangle"

            })

            return

        end

        if currentSound then

            currentSound:Stop()

            currentSound:Destroy()

            currentSound = nil

        end

        local sound = Instance.new("Sound")

        sound.SoundId = "rbxassetid://" .. soundId

        sound.Volume = currentVolume

        sound.PlaybackSpeed = currentSpeed

        sound.Looped = true

        sound.Parent = workspace

        sound:Play()

        currentSound = sound

        _G.WindUI:Notify({

            Title = "正在播放",

            Content = "音樂 ID: " .. soundId .. "\n音量: " .. math.floor(currentVolume*100) .. "%\n速度: x" .. currentSpeed,

            Duration = 5,

            Icon = "music"

        })

    end

})

MusicTab:Slider({

    Title = "音量",

    Desc = "調整音樂大小",

    Value = {Min = 0, Max = 500, Default = 50, Step = 1},

    Callback = function(value)

        currentVolume = value / 100

        if currentSound then

            currentSound.Volume = currentVolume

        end

        _G.WindUI:Notify({

            Title = "音量調整",

            Content = "現在音量: " .. value .. "%",

            Duration = 3,

            Icon = "volume-2"

        })

    end

})

MusicTab:Slider({

    Title = "播放速度",

    Desc = "調整音樂快慢 ",

    Value = {Min = 0.1, Max = 10.0, Default = 1.0, Step = 0.1},

    Callback = function(value)

        currentSpeed = value

        if currentSound then

            currentSound.PlaybackSpeed = currentSpeed

        end

        _G.WindUI:Notify({

            Title = "速度調整",

            Content = "現在速度: x" .. value,

            Duration = 3,

            Icon = "fast-forward"

        })

    end

})

MusicTab:Divider()

MusicTab:Section({Title = "推薦音樂", TextSize = 18})

MusicTab:Button({

    Title = "Rick Roll",

    Desc = "依舊詐騙",

    Icon = "music-2",

    Callback = function()

        setclipboard("1842612729")

    end

})

MusicTab:Button({

    Title = "沈める街",

    Desc = "btw不是沈陽大街",

    Icon = "music-3",

    Callback = function()

        setclipboard("76668137537045")

    end

})

MusicTab:Button({

    Title = "jumpstyle",

    Desc = "backdoor skid",

    Icon = "star",

    Callback = function()

        setclipboard("1839246711")

    end

})

-- 可選：停止音樂按鈕

MusicTab:Button({

    Title = "停止播放",

    Desc = "關閉目前音樂",

    Icon = "stop-circle",

    Callback = function()

        if currentSound then

            currentSound:Stop()

            currentSound:Destroy()

            currentSound = nil

            _G.WindUI:Notify({Title = "停止", Content = "音樂已關閉", Duration = 4})

        end

    end

})

-- 紅色大戰藍色
RedvsBlueTab:Section({ Title = "功能列表", TextSize = 20 })
createScriptButton(RedvsBlueTab, "自動換彈", "自動換彈+Ui顯示", "https://pastebin.com/raw/7Dp7L3s4", "僅限此遊戲", "✈️")
RedvsBlueTab:Button({

    Title = "傳送至旗幟點 (搶奪模式)",

    Callback = function()

        local char = game.Players.LocalPlayer.Character

        if not char or not char:FindFirstChild("HumanoidRootPart") then 

            _G.WindUI:Notify("錯誤", "角色未載入", 3)

            return 

        end

        

        local hrp = char.HumanoidRootPart

        local original = hrp.CFrame

        

        hrp.CFrame = CFrame.new(261.9, 1.9, -665.6)

        task.wait(1)

        

        if hrp and hrp.Parent then 

            hrp.CFrame = original 

        end

        

        _G.WindUI:Notify("傳送完成", "已傳送到旗幟點並返回", 4)

    end

})
RedvsBlueTab:Button({
    Title = "傳送至國王身後",
    Callback = function()

        local rs = game:GetService("ReplicatedStorage")
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")

        -- 找符合條件的目標
        local target = nil

        for _, p in ipairs(Players:GetPlayers()) do
            if p == localplayer then continue end
            if not p.Character then continue end

            -- 隊伍過濾
            if p.Team and localplayer.Team and p.Team == localplayer.Team then
                continue
            end

            local char = p.Character
            local found = false

            -- 掃描 BillboardGui
            for _, obj in ipairs(char:GetDescendants()) do
                if obj:IsA("BillboardGui") and obj.Enabled == true then
                    target = char
                    found = true
                    break
                end
            end

            if found then break end
        end

        -- 沒找到目標
        if not target or not target:FindFirstChild("HumanoidRootPart") then
            _G.WindUI:Notify("模式錯誤")
            return
        end

        -- 自己的位置
        local myHRP = localplayer.Character
            and localplayer.Character:FindFirstChild("HumanoidRootPart")
        if not myHRP then return end

        local originalCFrame = myHRP.CFrame

        -- 目標後方
        local targetHRP = target.HumanoidRootPart
        local behindCFrame = targetHRP.CFrame * CFrame.new(0, 0, 4)
        local lookAtCFrame = CFrame.lookAt(
            behindCFrame.Position,
            targetHRP.Position
        )

        -- 傳送
        myHRP.CFrame = lookAtCFrame

        -- 3 秒後回來
        task.delay(3, function()
            if localplayer.Character
                and localplayer.Character:FindFirstChild("HumanoidRootPart") then
                localplayer.Character.HumanoidRootPart.CFrame = originalCFrame
            end
        end)

        _G.WindUI:Notify("執行完成")
    end
})

-- 可選：這裡可以加通知、音效、或 UI 反饋
-- print("已鎖定背後 3 秒")
-- 藍隊





-- 藍隊
RedvsBlueTab:Button({
    Title = "藍隊",
    Callback = function()
        local char = localplayer.Character
        if not char then return end
        local hrp = char:WaitForChild("HumanoidRootPart")
        local humanoid = char:WaitForChild("Humanoid")
        humanoid:MoveTo(Vector3.new(186.11, 6, -2868.74))
        humanoid.MoveToFinished:Wait()
        _G.WindUI:Notify("已傳送到 藍隊", "", 3)
    end
})

-- 中島
local function tweenTo(cf, time)
    local char = game.Players.LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local tween = TweenService:Create(
        hrp,
        TweenInfo.new(time or 0.3, Enum.EasingStyle.Linear),
        { CFrame = cf }
    )
    tween:Play()
    tween.Completed:Wait()
end
RedvsBlueTab:Button({
    Title = "藍隊",
    Callback = function()
        tweenTo(CFrame.new(186.11, 3.64, -2868.74))
        _G.WindUI:Notify("已傳送到 藍隊")
    end
})

            
RedvsBlueTab:Button({
    Title = "中島",
    Callback = function()
        tweenTo(CFrame.new(305.10, 3.75, -1806.30))
        _G.WindUI:Notify("已傳送到 中島")
    end
})

RedvsBlueTab:Button({
    Title = "左1島",
    Callback = function()
        tweenTo(CFrame.new(-954.76, 3.75, -1756.31))
        _G.WindUI:Notify("已傳送到 左1島")
    end
})

RedvsBlueTab:Button({
    Title = "左2島",
    Callback = function()
        tweenTo(CFrame.new(-2210.20, 0.50, -1729.77))
        _G.WindUI:Notify("已傳送到 左2島")
    end
})

RedvsBlueTab:Button({
    Title = "右2島",
    Callback = function()
        tweenTo(CFrame.new(2621.80, 3.75, -1732.79))
        _G.WindUI:Notify("已傳送到 右2島")
    end
})

RedvsBlueTab:Button({
    Title = "右1島",
    Callback = function()
        tweenTo(CFrame.new(1592.96, 3.75, -1732.18))
        _G.WindUI:Notify("已傳送到 右1島")
    end
})

RedvsBlueTab:Button({
    Title = "紅隊",
    Callback = function()
        tweenTo(CFrame.new(261.37, 1.92, -662.47))
        _G.WindUI:Notify("已傳送到 紅隊")
    end
})

RedvsBlueTab:Button({
    Title = "一鍵佔領全部（高速）",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then
            _G.WindUI:Notify("錯誤", "角色未載入", 3)
            return
        end

        local TweenService = game:GetService("TweenService")

        local points = {
            CFrame.new(186.11, 3.64, -2868.74), -- 藍
            CFrame.new(305.10, 3.75, -1806.30), -- 中
            CFrame.new(-954.76, 3.75, -1756.31), -- 左1
            CFrame.new(-2210.20, 0.50, -1729.77), -- 左2
            CFrame.new(1592.96, 3.75, -1732.18), -- 右1
            CFrame.new(2621.80, 3.75, -1732.79), -- 右2
            CFrame.new(261.37, 1.92, -662.47), -- 紅
            CFrame.new(853.81, 146.47, -1725.44),
            CFrame.new(-158.09, 42.40, -1740.25),
        }

        for _, cf in ipairs(points) do
            local tween = TweenService:Create(
                hrp,
                TweenInfo.new(
                    0.15, -- ⚡ 移動速度（越小越快）
                    Enum.EasingStyle.Linear
                ),
                { CFrame = cf }
            )

            tween:Play()
            tween.Completed:Wait()
            task.wait(0.3) -- ⏱ 停留時間
        end

        _G.WindUI:Notify("完成", "高速佔領完成", 4)
    end
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local swordName = "ClassicSword"
getgenv().KillAllEnabled = false

-- 找敵隊目標（活著 + 無無敵盾）
local function getNextTarget()
    for _, plr in pairs(Players:GetPlayers()) do
        
        if plr ~= LocalPlayer then
            
            if plr.Team ~= LocalPlayer.Team then
                
                local char = plr.Character
                if char then
                    
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    
                    if hum and hrp and hum.Health > 0 then
                        
                        if not char:FindFirstChildOfClass("ForceField") then
                            return char
                        end
                    end
                end
            end
        end
    end
    
    return nil
end

-- Toggle
RedvsBlueTab:Toggle({
    Title = "Kill All (敵隊自動擊殺)",
    Desc = "自動裝備劍 + 瞬移敵人身後 + 自動切換目標",
    Default = false,
    Callback = function(value)
        getgenv().KillAllEnabled = value
    end
})

-- 核心循環
spawn(function()
    while true do
        task.wait(0.1)

        if getgenv().KillAllEnabled then
            
            local character = LocalPlayer.Character
            if not character then continue end
            
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local hrp = character:FindFirstChild("HumanoidRootPart")
            
            if not humanoid or not hrp then continue end
            if humanoid.Health <= 0 then continue end

            -- 自動裝備劍
            local tool = character:FindFirstChildOfClass("Tool")
            if not tool or tool.Name ~= swordName then
                
                local sword = LocalPlayer.Backpack:FindFirstChild(swordName)
                
                if sword then
                    humanoid:EquipTool(sword)
                end
            end

            -- 找目標
            local target = getNextTarget()
            if target then
                
                local targetHRP = target:FindFirstChild("HumanoidRootPart")
                local targetHum = target:FindFirstChildOfClass("Humanoid")
                
                if targetHRP and targetHum and targetHum.Health > 0 then
                    
                    -- 計算身後位置
                    local behindPos =
                        targetHRP.Position -
                        targetHRP.CFrame.LookVector * 3
                    
                    -- 強制物理刷新
                    humanoid:ChangeState(Enum.HumanoidStateType.Physics)
                    
                    -- 穩定瞬移
                    character:PivotTo(
                        CFrame.new(behindPos, targetHRP.Position)
                    )
                    
                    -- 攻擊
                    local currentTool = character:FindFirstChildOfClass("Tool")
                    if currentTool then
                        currentTool:Activate()
                    end
                end
            end
        end
    end
end)


-- NTab (Wind UI 風格 - 只給三個控制項)


NTab:Section({ Title = "自然災害炸服💥", TextSize = 20})

-- 第一個：攻擊倍率滑桿 (AttackRate)
NTab:Slider({
    Title = "⚡ 攻擊倍率",
    Desc = "每次 Heartbeat 發送次數 (建議 10\~30)",
    Value = { Min = 1, Max = 100, Default = 50, Step = 1 },
    Callback = function(value)
        getgenv().AttackRate = value
    end
})

NTab:Slider({
    Title = "⏱️ 發送間隔",
    Desc = "每多少秒發一次 (防踢，建議 0.03\~0.1)",
    Value = { Min = 0.01, Max = 0.5, Default = 0.03, Step = 0.01 },
    Callback = function(value)
        getgenv().SpamDelay = value
    end
})

NTab:Toggle({
    Title = "🔥 是否攻擊",
    Desc = "開啟後自動 spam ClickedApple / ClickedBalloon",
    Default = false,
    Callback = function(value)
        if value then
            if connection then connection:Disconnect() end
            
            connection = RunService.Heartbeat:Connect(function()
                task.wait(getgenv().SpamDelay)
                for i = 1, getgenv().AttackRate do
                    pcall(function()
                        event:FireServer("ClickedApple")
                        event:FireServer("ClickedBalloon")
                    end)
                end
            end)
        else
            if connection then
                connection:Disconnect()
                connection = nil
            end
        end
    end
})



SettingsTab:Section({ Title = "🎨 介面自訂", TextSize = 20 })

SettingsTab:Divider()

-- 主題表格（用 Key 對應 WindUI 已有主題）
local themes = {
    ["Dark 🌙"]   = "Dark",
    ["Light ☀️"] = "Light",
    ["Red ❤️"]    = "Red"
}

-- 下拉選單
SettingsTab:Dropdown({
    Title = "🎭 介面主題",
    Desc = "更改介面主題與配色",
    Values = { "Dark 🌙", "Light ☀️", "Red ❤️" },
    Value = "Dark 🌙",
    Callback = function(value)
        local themeKey = themes[value]  -- 對應 WindUI 的主題 Key
        if themeKey and _G.WindUI then
            _G.WindUI:SetTheme(themeKey)
            -- 顯示通知
            _G.WindUI:Notify({
                Title = "🎭 主題",
                Content = "介面主題已設為：" .. value,
                Duration = 3,
                Icon = "palette"
            })
        end
    end
})

-- 介面透明度滑桿
SettingsTab:Slider({
    Title = "🔍 介面透明度",
    Desc = "調整視窗透明程度",
    Value = { Min = 0, Max = 1, Default = 0.1, Step = 0.05 },
    Callback = function(value)
        if _G.WindUI then
            _G.WindUI.TransparencyValue = value
        end
    end
})

SettingsTab:Keybind({

    Title = "⌨️ 介面開關快捷鍵",

    Desc = "設定顯示/隱藏介面的按鍵",

    Value = "RightControl",

    Callback = function(key)

        showNotification("⌨️ 快捷鍵", "介面開關鍵已設為：" .. key, 3, "keyboard")

    end

})

SettingsTab:Section({ Title = "💾 配置管理", TextSize = 18 })

SettingsTab:Divider()

local configName = "nova_center"

SettingsTab:Input({

    Title = "📝 配置名稱",

    Desc = "用於儲存/載入設定的名稱",

    Value = configName,

    Callback = function(value)

        configName = value or "nova_center"

    end

})

SettingsTab:Button({

    Title = "💾 儲存配置",

    Desc = "儲存目前所有設定與偏好",

    Icon = "save",

    Callback = function()

        local configData = {

            WalkSpeed = walkSpeedValue,

            JumpPower = jumpPowerValue,

            FlySpeed = flySpeed,

            Theme = "Dark",

            Transparency = 0.1

        }

        

        if writefile then

            writefile(configName .. "_config.json", game:GetService("HttpService"):JSONEncode(configData))

            showNotification("💾 已儲存", "配置儲存成功！", 3, "save")

        else

            showNotification("❌ 錯誤", "你的執行器不支援檔案寫入", 4, "alert-triangle")

        end

    end

})

SettingsTab:Button({

    Title = "📂 載入配置",

    Desc = "載入已儲存的設定與偏好",

    Icon = "folder",

    Callback = function()

        if readfile and isfile(configName .. "_config.json") then

            local configData = game:GetService("HttpService"):JSONDecode(readfile(configName .. "_config.json"))

            

            if configData.WalkSpeed then

                walkSpeedValue = configData.WalkSpeed

                local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

                if humanoid then humanoid.WalkSpeed = walkSpeedValue end

            end

            

            showNotification("📂 已載入", "配置載入成功！", 3, "folder")

        else

            showNotification("❌ 錯誤", "未找到已儲存的配置", 4, "alert-triangle")

        end

    end

})

SettingsTab:Button({

    Title = "🔄 重置全部",

    Desc = "將所有設定恢復預設值",

    Icon = "refresh-cw",

    Callback = function()

        _G.WindUI:SetTheme("Dark")

        _G.WindUI.TransparencyValue = 0.1

        walkSpeedValue = 16

        jumpPowerValue = 50

        flySpeed = 50

        

        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

        if humanoid then

            humanoid.WalkSpeed = 16

            humanoid.JumpPower = 50

        end

        

        showNotification("🔄 已重置", "所有設定已恢復預設值！", 3, "refresh-cw")

    end

})

-- 選擇首頁 Tab

Window:SelectTab(HomeTab)

-- 結尾部分

wait(1)



setclipboard("https://discord.gg/4WSmx666DP")

print("🎉 Nova中心 - 頂級通用腳本中心載入成功！")

-- print("[NovaHub Debug] 腳本執行完畢，UI 應該已建好，按 Insert 開啟")

   
