local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- Variables globales de estado
local SelectedLanguage = "ES" 
local selectedRockName = "Tiny Rock"
local selectedUniqueItem = "Apex Overlord"
local autoRep, fastRep, autoReb, autoRockGlitch, autoBuyPet = false, false, false, false, false
local espEnabled = false

-- Diccionario maestro para traducción masiva por UI de Roblox
local lang = {
    ES = {
        title = "Muscle legends | Equinox hub", notify = "¡Idioma cambiado a Español!",
        f_strength = "Farming de Fuerza", f_durability = "script de Durabilidad", f_rebirth = "Renacimientos",
        btn_normal = "Auto Rep (Normal)", btn_fast = "Auto Fast Rep", btn_rock = "Auto Fast Rock Hit (Glitch)",
        btn_reb = "Auto Rebirth", drop_rock = "Seleccionar Roca", drop_pet = "Seleccionar Mascota o Aura",
        btn_buy = "Auto Comprar Mascota/Aura", sec_est = "Estabilidad", sec_tienda = "Mascotas y Auras (Glitch Países Bajos)",
        sec_vis = "Visuales", btn_lag = "Activar Anti-Lag 100%", btn_crash = "Activar Anti-Crash", btn_esp = "Jugadores ESP (Wallhack)",
        lang_select = "Seleccionar Idioma / Select Language", t_farm = "Farming", t_pets = "Crystals (Pets)"
    },
    EN = {
        title = "Muscle legends | Equinox hub", notify = "Language changed to English!",
        f_strength = "Strength Farming", f_durability = "Durability Script", f_rebirth = "Rebirths",
        btn_normal = "Auto Rep (Normal)", btn_fast = "Auto Fast Rep", btn_rock = "Auto Fast Rock Hit (Glitch)",
        btn_reb = "Auto Rebirth", drop_rock = "Select Rock", drop_pet = "Select Pet or Aura",
        btn_buy = "Auto Buy Pet/Aura", sec_est = "Stability", sec_tienda = "Pets & Auras (Netherlands Glitch)",
        sec_vis = "Visuals", btn_lag = "Enable Anti-Lag 100%", btn_crash = "Enable Anti-Crash", btn_esp = "Player ESP (Wallhack)",
        lang_select = "Select Language / Seleccionar Idioma", t_farm = "Farming", t_pets = "Crystals (Pets)"
    }
}

local Window = OrionLib:MakeWindow({Name = lang[SelectedLanguage].title, HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

local RocksConfig = {
    ["Industrial Rock"] = 25000000, ["Jungle rock"] = 10000000, ["Muscle King Rock"] = 5000000,
    ["Legend Rock"] = 1000000, ["Eternal Rock"] = 750000, ["Mythical Rock"] = 400000,
    ["Frost Rock"] = 150000, ["Beach Rock"] = 5000, ["Starter Rock"] = 100, ["Tiny Rock"] = 0
}

local function findPhysicalRock(requiredDurability)
    local folder = workspace:FindFirstChild("machinesFolder")
    if not folder then return nil end
    for _, machine in ipairs(folder:GetDescendants()) do
        if machine.Name == "neededDurability" and machine:IsA("ValueBase") and tonumber(machine.Value) == requiredDurability then
            local rockMesh = machine.Parent and machine.Parent:FindFirstChild("Rock")
            if rockMesh and rockMesh:IsA("BasePart") then return rockMesh end
        end
    end
    return nil
end

local function autoEquipPunch()
    local player = game:GetService("Players").LocalPlayer
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    local punch = player.Character:FindFirstChild("Punch") or player.Backpack:FindFirstChild("Punch")
    if punch and humanoid and punch.Parent ~= player.Character then humanoid:EquipTool(punch) end
end

-- CREACIÓN DE LAS 2 PESTAÑAS (TABS) SOLICITADAS
local Tab1 = Window:MakeTab({Name = lang[SelectedLanguage].t_farm, Icon = "", PremiumOnly = false})
local Tab4 = Window:MakeTab({Name = lang[SelectedLanguage].t_pets, Icon = "", PremiumOnly = false})

local secStr = Tab1:AddSection({Name = lang[SelectedLanguage].f_strength})
local togNormal = Tab1:AddToggle({
    Name = lang[SelectedLanguage].btn_normal, Default = false,
    Callback = function(v)
        autoRep = v
        if autoRep then
            task.spawn(function()
                local ev = game:GetService("Players").LocalPlayer:FindFirstChild("muscleEvent")
                while autoRep and ev do ev:FireServer("rep") task.wait(0.3) end
            end)
        end
    end    
})

local togFast = Tab1:AddToggle({
    Name = lang[SelectedLanguage].btn_fast, Default = false,
    Callback = function(v)
        fastRep = v
        if fastRep then
            task.spawn(function()
                local pl = game:GetService("Players").LocalPlayer
                local ev = pl:FindFirstChild("muscleEvent")
                pl:SetAttribute("AutoLiftEnabled", true)
                while fastRep and ev do
                    for i = 1, 15 do task.spawn(function() ev:FireServer("rep") end) end
                    task.wait(0.001) 
                end
            end)
        end
    end    
})

local secDur = Tab1:AddSection({Name = lang[SelectedLanguage].f_durability})
local dropRock = Tab1:AddDropdown({
    Name = lang[SelectedLanguage].drop_rock, Default = "Tiny Rock",
    Options = {"Tiny Rock", "Starter Rock", "Beach Rock", "Frost Rock", "Mythical Rock", "Eternal Rock", "Legend Rock", "Muscle King Rock", "Ancient Rock", "Industrial Jungle Rock"},
    Callback = function(opt) selectedRockName = opt end
})

local togRock = Tab1:AddToggle({
    Name = lang[SelectedLanguage].btn_rock, Default = false,
    Callback = function(v)
        autoRockGlitch = v
        if autoRockGlitch then
            task.spawn(function()
                local player = game:GetService("Players").LocalPlayer
                local ev = player:FindFirstChild("muscleEvent")
                while autoRockGlitch and ev do
                    autoEquipPunch()
                    local targetDurability = RocksConfig[selectedRockName] or 0
                    local physicalRock = findPhysicalRock(targetDurability)
                    local char = player.Character
                    local leftHand = char and char:FindFirstChild("LeftHand")
                    local rightHand = char and char:FindFirstChild("RightHand")
                    
                    if physicalRock and leftHand and rightHand then
                        pcall(function()
                            physicalRock.Size = Vector3.new(2, 1, 1)
                            physicalRock.Transparency, physicalRock.CanCollide = 1, false
                            physicalRock.CFrame = rightHand.CFrame
                        end)
                        if type(firetouchinterest) == "function" then
                            pcall(firetouchinterest, physicalRock, rightHand, 0)
                            pcall(firetouchinterest, physicalRock, rightHand, 1)
                        end
                        pcall(function() ev:FireServer("punch", "leftHand") ev:FireServer("punch", "rightHand") end)
                    end
                    task.wait(0.001)
                end
            end)
        end
    end
})

local secReb = Tab1:AddSection({Name = lang[SelectedLanguage].f_rebirth})
local togReb = Tab1:AddToggle({
    Name = lang[SelectedLanguage].btn_reb, Default = false,
    Callback = function(v)
        autoReb = v
        if autoReb then
            task.spawn(function()
                local stats = game:GetService("Players").LocalPlayer:FindFirstChild("leaderstats")
                local rem = game:GetService("ReplicatedStorage"):FindFirstChild("rEvents") and game:GetService("ReplicatedStorage").rEvents:FindFirstChild("rebirthRemote")
                while autoReb and rem and stats do
                    local str = stats:FindFirstChild("Strength") and stats.Strength.Value or 0
                    local reb = stats:FindFirstChild("Rebirths") and stats.Rebirths.Value or 0
                    if str >= (10000 + 2500 * reb) then pcall(function() rem:InvokeServer("rebirthRequest") end) task.wait(1.5)
                    else task.wait(0.2) end
                end
            end)
        end
    end    
})

local secEst = Tab4:AddSection({Name = lang[SelectedLanguage].sec_est})
local btnLag = Tab4:AddButton({Name = lang[SelectedLanguage].btn_lag, Callback = function()
    pcall(function()
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("MeshPart") then obj.Material, obj.Reflectance = Enum.Material.SmoothPlastic, 0
            elseif obj:IsA("Decal") or obj:IsA("Texture") then obj:Destroy()
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then obj.Enabled = false end
        end
        game:GetService("Lighting").GlobalShadows = false
    end)
end})

local btnCrash = Tab4:AddButton({Name = lang[SelectedLanguage].btn_crash, Callback = function() pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 game:GetService("Debris"):SetMaxItems(5) end) end})

local secTienda = Tab4:AddSection({Name = lang[SelectedLanguage].sec_tienda})
local dropPet = Tab4:AddDropdown({
    Name = lang[SelectedLanguage].drop_pet, Default = "Apex Overlord",
    Options = {"Apex Overlord", "Core Pup", "Volt Talon", "Reactor Beast", "Plasma Ravager", "Titan Reactor", "Neon Guardian", "Cybernetic Showdown Dragon", "Darkstar Hunter", "Muscle Sensei", "Infernal Dragon", "Aether Spirit Bunny", "Magic Butterfly", "Ultra Birdie", "Muscle King", "Entropic Blast"},
    Callback = function(opt) selectedUniqueItem = opt end
})

local togBuy = Tab4:AddToggle({
    Name = lang[SelectedLanguage].btn_buy, Default = false,
    Callback = function(v)
        autoBuyPet = v
        if autoBuyPet then
            task.spawn(function()
                local rStorage = game:GetService("ReplicatedStorage")
                local sharedFolder = rStorage:FindFirstChild("shared")
                local runtimeFolder = sharedFolder and sharedFolder:FindFirstChild("runtime")
                local petShopFolder = runtimeFolder and runtimeFolder:FindFirstChild("cPetShopFolder") or rStorage:FindFirstChild("cPetShopFolder")
                local rEventsFolder = rStorage:FindFirstChild("rEvents")
                local petShopRemote = rEventsFolder and rEventsFolder:FindFirstChild("cPetShopRemote") or rStorage:FindFirstChild("cPetShopRemote")
                while autoBuyPet and petShopFolder and petShopRemote and petShopRemote:IsA("RemoteFunction") do
                    pcall(function()
                        local petInstance = petShopFolder:FindFirstChild(selectedUniqueItem)
                        if petInstance then petShopRemote:InvokeServer(petInstance) end
                    end)
                    task.wait(0.18)
                end
            end)
        end
    end
})

local secVis = Tab4:AddSection({Name = lang[SelectedLanguage].sec_vis})
local togEsp = Tab4:AddToggle({
    Name = lang[SelectedLanguage].btn_esp, Default = false,
    Callback = function(v)
        espEnabled = v
        task.spawn(function()
            while espEnabled do
                for _, p in pairs(game:GetService("Players"):GetPlayers()) do
                    if p ~= game:GetService("Players").LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        if not p.Character.HumanoidRootPart:FindFirstChild("PremiumESP") then
                            local box = Instance.new("BoxHandleAdornment")
                            box.Name, box.Size, box.Color3, box.AlwaysOnTop, box.ZIndex, box.Adornee, box.Parent = "PremiumESP", Vector3.new(4, 6, 4), Color3.fromRGB(0, 255, 255), true, 5, p.Character.HumanoidRootPart, p.Character.HumanoidRootPart
                        end
                    end
                end
                task.wait(2)
            end
            if not espEnabled then
                for _, p in pairs(game:GetService("Players"):GetPlayers()) do
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.HumanoidRootPart:FindFirstChild("PremiumESP") then p.Character.HumanoidRootPart.PremiumESP:Destroy() end
                end
            end
        end)
    end
})

-- SELECTOR DE IDIOMA MAESTRO POR JERARQUÍA DE UI DE ROBLOX (SIN CAMINADORAS NI TP)
Tab1:AddDropdown({
    Name = "Language / Idioma", Default = "Español", Options = {"Español", "English"},
    Callback = function(opt)
        SelectedLanguage = (opt == "Español") and "ES" or "EN"
        pcall(function()
            local orionGui = game:GetService("CoreGui"):FindFirstChild("Orion") or game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Orion")
            if orionGui then
                for _, btn in pairs(orionGui:GetDescendants()) do
                    if btn:IsA("TextButton") and btn.Name == "TabButton" then
                        if btn.Text == "Farming" then btn.Text = lang[SelectedLanguage].t_farm end
                        if btn.Text == "Crystals (Pets)" then btn.Text = lang[SelectedLanguage].t_pets end
                    end
                end
                for _, label in pairs(orionGui:GetDescendants()) do
                    if label:IsA("TextLabel") or label:IsA("TextBox") then
                        if label.Text == lang.ES.f_strength or label.Text == lang.EN.f_strength then label.Text = lang[SelectedLanguage].f_strength end
                        if label.Text == lang.ES.btn_normal or label.Text == lang.EN.btn_normal then label.Text = lang[SelectedLanguage].btn_normal end
                        if label.Text == lang.ES.btn_fast or label.Text == lang.EN.btn_fast then label.Text = lang[SelectedLanguage].btn_fast end
                        if label.Text == lang.ES.f_durability or label.Text == lang.EN.f_durability then label.Text = lang[SelectedLanguage].f_durability end
                        if label.Text == lang.ES.drop_rock or label.Text == lang.EN.drop_rock then label.Text = lang[SelectedLanguage].drop_rock end
                        if label.Text == lang.ES.btn_rock or label.Text == lang.EN.btn_rock then label.Text = lang[SelectedLanguage].btn_rock end
                        if label.Text == lang.ES.f_rebirth or label.Text == lang.EN.f_rebirth then label.Text = lang[SelectedLanguage].f_rebirth end
                        if label.Text == lang.ES.btn_reb or label.Text == lang.EN.btn_reb then label.Text = lang[SelectedLanguage].btn_reb end
                        if label.Text == lang.ES.sec_est or label.Text == lang.EN.sec_est then label.Text = lang[SelectedLanguage].sec_est end
                        if label.Text == lang.ES.btn_lag or label.Text == lang.EN.btn_lag then label.Text = lang[SelectedLanguage].btn_lag end
                        if label.Text == lang.ES.btn_crash or label.Text == lang.EN.btn_crash then label.Text = lang[SelectedLanguage].btn_crash end
                        if label.Text == lang.ES.sec_tienda or label.Text == lang.EN.sec_tienda then label.Text = lang[SelectedLanguage].sec_tienda end
                        if label.Text == lang.ES.drop_pet or label.Text == lang.EN.drop_pet then label.Text = lang[SelectedLanguage].drop_pet end
                        if label.Text == lang.ES.btn_buy or label.Text == lang.EN.btn_buy then label.Text = lang[SelectedLanguage].btn_buy end
                        if label.Text == lang.ES.sec_vis or label.Text == lang.EN.sec_vis then label.Text = lang[SelectedLanguage].sec_vis end
                        if label.Text == lang.ES.btn_esp or label.Text == lang.EN.btn_esp then label.Text = lang[SelectedLanguage].btn_esp end
                    end
                end
            end
        end)
        OrionLib:MakeNotification({Name = "Equinox", Content = lang[SelectedLanguage].notify, Time = 3})
    end
})

-- SISTEMA ANTI-AFK UNIVERSAL
pcall(function()
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new(0,0))
    end)
end)

OrionLib:Init()
