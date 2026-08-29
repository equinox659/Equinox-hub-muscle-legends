-- ====================================================================
-- SISTEMA DE VERIFICACIÓN CUSTOM (BYPASS BACKEND ROTO DE ORIONLIB)
-- ====================================================================
local Player = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local Validated = false

-- Crear una interfaz nativa limpia para pedir la llave
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleLabel = Instance.new("TextLabel")
local KeyInput = Instance.new("TextBox")
local VerifyBtn = Instance.new("TextButton")

ScreenGui.Name = "AFXKeySystem"
ScreenGui.Parent = CoreGui or Player.PlayerGui
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 180)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.Text = "AFX|ALPHA FOR X SCRIPT"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 18
TitleLabel.Parent = MainFrame

KeyInput.Size = UDim2.new(0, 260, 0, 40)
KeyInput.Position = UDim2.new(0.5, -130, 0.4, 0)
KeyInput.PlaceholderText = "Enter Key"
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.SourceSans
KeyInput.TextSize = 16
KeyInput.Parent = MainFrame

VerifyBtn.Size = UDim2.new(0, 140, 0, 35)
VerifyBtn.Position = UDim2.new(0.5, -70, 0.75, 0)
VerifyBtn.Text = "VERIFY / VERIFICAR"
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.Font = Enum.Font.SourceSansBold
VerifyBtn.TextSize = 16
VerifyBtn.Parent = MainFrame

-- Lógica de validación estricta
VerifyBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == "AFXONTOP" then -- TU LLAVE EXACTA SOLICITADA
        Validated = true
        ScreenGui:Destroy()
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "WRONG KEY! / LLAVE INCORRECTA!"
        KeyInput.PlaceholderColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- Si el jugador intenta cerrar el script de fondo o eliminar la GUI sin verificar, se le expulsa
task.spawn(function()
    task.wait(60) -- 1 minuto máximo para poner la llave o da kick
    if not Validated then
        Player:text("Equinox Hub: Verification Timeout / Tiempo de espera agotado.")
    end
end)

while not Validated do task.wait(0.1) end -- Pausa la ejecución de Lua hasta que ponga la llave real


local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- Variables globales de estado (Inglés por defecto como querías)
local SelectedLanguage = "EN" 
local selectedRockName = "Tiny Rock"
local selectedUniqueItem = "Apex Overlord"
local selectedDestination = "Spawn"
local autoRep, fastRep, autoLift, autoReb, autoRockGlitch, autoBuyPet, lockPositionEnabled = false, false, false, false, false, false, false
local espEnabled = false

-- TUS COORDENADAS EXACTAS EN CFRAME REAL
local TP_Locations = {
    ["Spawn"] = CFrame.new(0, 4, 0),
    ["Frost Island"] = CFrame.new(-2917.47314, 12.1008654, -178.445648, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    ["Mythical Island"] = CFrame.new(2250.77808, 28.6999931, 1073.22668, 0, 0, -1, 0, 1, 0, 1, 0, 0),
    ["Eternal Island"] = CFrame.new(-7173.3418, 40.8608437, -1092.33618, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    ["Legend Island"] = CFrame.new(4551.51514, 997.727234, -4018.90186, -0.642763734, 0, 0.766064942, 0, 1, 0, -0.766064942, 0, -0.642763734),
    ["Muscle King Gym"] = CFrame.new(-8772.97266, 24.4272194, -5638.37402, 1, 0, 0, 0, 1, 0, 0, 0, 1),
    ["Industrial Gym"] = CFrame.new(-5000, 129.197, 5000)
}

-- TU DICCIONARIO MAESTRO COMPLETO Y TRADUCIBLE (CON LOCK POSITION)
local lang = {
    EN = {
        title = "AFX|ALPHA FOR X SCRIPT", notify = "¡Idioma cambiado a Español!",
        f_strength = "Farming de Fuerza", f_durability = "Exploit de Durabilidad (Manual)", f_rebirth = "Renacimientos",
        btn_normal = "Auto Rep (Normal)", btn_fast = "Auto Fast Rep (AFX x15)", btn_rock = "Auto Fast Rock Hit (Glitch)",
        btn_reb = "Auto Rebirth", drop_rock = "Seleccionar Roca", drop_pet = "Seleccionar Mascota o Aura",
        btn_buy = "Auto Comprar Mascota/Aura", sec_est = "Estabilidad", sec_tienda = "Mascotas y Auras (Glitch Países Bajos)",
        btn_lift = "free Auto lift", sec_vis = "Visuales", btn_lag = "Activar Anti-Lag 100%", btn_crash = "Activar Anti-Crash", 
        btn_esp = "Jugadores ESP (Wallhack)", lang_select = "Seleccionar Idioma / Select Language", t_farm = "Farming", 
        t_pets = "Crystals (Pets)", t_tp = "Teleports", sec_tp = "Viaje Instantáneo a Islas", 
        drop_tp = "Seleccionar Destino", btn_tp = "Teletransportarse Ahora", btn_dc = "Copiar Discord",
        sec_lock = "Estabilidad de Posición", btn_lock = "Lock Position (Anclar Personaje)"
    },
    ES = {
        title = "AFX|ALPHA FOR X SCRIPT", notify = "Language changed to English!",
        f_strength = "Strength Farming", f_durability = "Durability Exploit (Manual)", f_rebirth = "Rebirths",
        btn_normal = "Auto Rep (Normal)", btn_fast = "Auto Fast Rep (AFX x15)", btn_rock = "Auto Fast Rock Hit (Glitch)",
        btn_reb = "Auto Rebirth", drop_rock = "Select Rock", drop_pet = "Select Pet or Aura",
        btn_buy = "Auto Buy Pet/Aura", sec_est = "Stability", sec_tienda = "Pets & Auras (Netherlands Glitch)",
        btn_lift = "free Auto lift", sec_vis = "Visuals", btn_lag = "Enable Anti-Lag 100%", btn_crash = "Enable Anti-Crash", 
        btn_esp = "Player ESP (Wallhack)", lang_select = "Select Language / Seleccionar Idioma", t_farm = "Farming", 
        t_pets = "Crystals (Pets)", t_tp = "Teleports", sec_tp = "Instant Island Travel", 
        drop_tp = "Select Destination", btn_tp = "Teleport Now", btn_dc = "Copy Discord Link",
        sec_lock = "Position Stability", btn_lock = "Lock Position (Anchor Character)"
    }
}

-- CONFIGURACIÓN DE TU COMPROBACIÓN NATIVA DE LLAVE
local Window = OrionLib:MakeWindow({
    Name = lang[SelectedLanguage].title, HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest", KeySystem = true,
    Title = "AFX|ALPHA FOR X SCRIPT Verification", Description = "",
    KeySettings = { Title = "Key System", Description = "Enter the Key to execute AFX|ALPHA FOR X SCRIPT", Key = "AFXONTOP", ResetKey = false }
})

local RocksConfig = {
    ["Industrial Rock"] = 25000000, ["Jungle Rock"] = 10000000, ["Muscle King Rock"] = 5000000,
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

-- CREACIÓN DE LAS 3 PESTAÑAS (TABS OFICIALES COMPACTAS)
local Tab1 = Window:MakeTab({Name = lang[SelectedLanguage].t_farm, Icon = "", PremiumOnly = false})
local Tab2 = Window:MakeTab({Name = lang[SelectedLanguage].t_tp, Icon = "", PremiumOnly = false})
local Tab3 = Window:MakeTab({Name = lang[SelectedLanguage].t_pets, Icon = "", PremiumOnly = false})

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

Tab1:AddToggle({
    Name = lang[SelectedLanguage].btn_lift, Default = false,
    Callback = function(v)
        autoLift = v
        game:GetService("Players").LocalPlayer:SetAttribute("AutoLiftEnabled", autoLift)
    end
})

local secDur = Tab1:AddSection({Name = lang[SelectedLanguage].f_durability})
Tab1:AddDropdown({
    Name = lang[SelectedLanguage].drop_rock, Default = "Tiny Rock",
    Options = {"Tiny Rock", "Starter Rock", "Beach Rock", "Frost Rock", "Mythical Rock", "Eternal Rock", "Legend Rock", "Muscle King Rock", "Jungle Rock", "Industrial Rock"},
    Callback = function(opt) selectedRockName = opt end
})

Tab1:AddToggle({
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
                        pcall(function() physicalRock.Size = Vector3.new(2, 1, 1) physicalRock.Transparency, physicalRock.CanCollide = 1, false physicalRock.CFrame = rightHand.CFrame end)
                        if type(firetouchinterest) == "function" then firetouchinterest(physicalRock, rightHand, 0) firetouchinterest(physicalRock, rightHand, 1) end
                        pcall(function() ev:FireServer("punch", "leftHand") ev:FireServer("punch", "rightHand") end)
                    end
                    task.wait(0.001)
                end
            end)
        end
    end
})

local secReb = Tab1:AddSection({Name = lang[SelectedLanguage].f_rebirth})
Tab1:AddToggle({
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
                    if str >= (10000 + 2500 * reb) then 
                        pcall(function()
                            if togFast then togFast:Set(false, true) end
                            if togNormal then togNormal:Set(false, true) end
                            rem:InvokeServer("rebirthRequest") 
                        end)
                        task.wait(1.5) 
                    else 
                        task.wait(0.2) 
                    end
                end
            end)
        end
    end    
})

-- NUEVA SECCIÓN DE COMODIDAD AFK: LOCK POSITION SOLICITADA
local secLock = Tab1:AddSection({Name = lang[SelectedLanguage].sec_lock})
Tab1:AddToggle({
    Name = lang[SelectedLanguage].btn_lock, Default = false,
    Callback = function(v)
        lockPositionEnabled = v
        pcall(function()
            local root = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                -- Ancla o desancla la pieza raíz del personaje de Roblox según el estado del switch
                root.Anchored = lockPositionEnabled
            end
        end)
    end
})

local secTp = Tab2:AddSection({Name = lang[SelectedLanguage].sec_tp})
Tab2:AddDropdown({Name = lang[SelectedLanguage].drop_tp, Default = "Spawn", Options = {"Spawn", "Muscle King Gym", "Industrial Gym", "Frost Island", "Mythical Island", "Eternal Island", "Legend Island"}, Callback = function(opt) selectedDestination = opt end})
Tab2:AddButton({Name = lang[SelectedLanguage].btn_tp, Callback = function() pcall(function() local targetCFrame = TP_Locations[selectedDestination] local root = game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") if targetCFrame and root then root.CFrame = targetCFrame end end) end})

local secEst = Tab3:AddSection({Name = lang[SelectedLanguage].sec_est})
Tab3:AddButton({Name = lang[SelectedLanguage].btn_lag, Callback = function() pcall(function() for _, obj in pairs(workspace:GetDescendants()) do if obj:IsA("BasePart") or obj:IsA("MeshPart") then obj.Material, obj.Reflectance = Enum.Material.SmoothPlastic, 0 elseif obj:IsA("Decal") or obj:IsA("Texture") then obj:Destroy() elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then obj.Enabled = false end end game:GetService("Lighting").GlobalShadows = false end) end})
Tab3:AddButton({Name = lang[SelectedLanguage].btn_crash, Callback = function() pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 game:GetService("Debris"):SetMaxItems(5) end) end})

local secTienda = Tab3:AddSection({Name = lang[SelectedLanguage].sec_tienda})
Tab3:AddDropdown({Name = lang[SelectedLanguage].drop_pet, Default = "Apex Overlord", Options = {"Apex Overlord", "Core Pup", "Volt Talon", "Reactor Beast", "Plasma Ravager", "Titan Reactor", "Neon Guardian", "Cybernetic Showdown Dragon", "Darkstar Hunter", "Muscle Sensei", "Infernal Dragon", "Aether Spirit Bunny", "Magic Butterfly", "Ultra Birdie", "Muscle King", "Entropic Blast"}, Callback = function(opt) selectedUniqueItem = opt end})

Tab3:AddToggle({
    Name = lang[SelectedLanguage].btn_buy, Default = false,
    Callback = function(v)
        autoBuyPet = v
        if autoBuyPet then
            task.spawn(function()
                local rStorage = game:GetService("ReplicatedStorage")
                local sharedFolder = rStorage:FindFirstChild("shared")
                local runtimeFolder = sharedFolder and sharedFolder:FindFirstChild("runtime")
                local petShopFolder = runtimeFolder and runtimeFolder:FindFirstChild("cPetShopFolder") or rStorage:FindFirstChild("cPetShopFolder")
                local petShopRemote = rStorage:FindFirstChild("rEvents") and rStorage.rEvents:FindFirstChild("cPetShopRemote") or rStorage:FindFirstChild("cPetShopRemote")
                while autoBuyPet and petShopFolder and petShopRemote do
                    pcall(function() local petInstance = petShopFolder:FindFirstChild(selectedUniqueItem) if petInstance then petShopRemote:InvokeServer(petInstance) end end)
                    task.wait(0.18)
                end
            end)
        end
    end
})

local secVis = Tab3:AddSection({Name = lang[SelectedLanguage].sec_vis})
Tab3:AddToggle({
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
            if not espEnabled then for _, p in pairs(game:GetService("Players"):GetPlayers()) do if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.HumanoidRootPart:FindFirstChild("PremiumESP") then p.Character.HumanoidRootPart.PremiumESP:Destroy() end end end
        end)
    end
})

Tab1:AddButton({Name = lang[SelectedLanguage].btn_dc, Callback = function() if setclipboard then setclipboard("https://discord.gg") end end})

-- SISTEMA DINÁMICO COMPLETAMENTE INTEGRADO (TRADUCCIÓN FLUIDA)
Tab1:AddDropdown({
    Name = "Language / Idioma", Default = "English", Options = {"English", "Español"},
    Callback = function(opt)
        SelectedLanguage = (opt == "Español") and "ES" or "EN"
        pcall(function()
            local orionGui = game:GetService("CoreGui"):FindFirstChild("Orion") or game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Orion")
            if orionGui then
                for _, b in pairs(orionGui:GetDescendants()) do
                    if b:IsA("TextButton") and b.Name == "TabButton" then
                        if b.Text == "Farming" or b.Text == "Farming" then b.Text = lang[SelectedLanguage].t_farm end
                        if b.Text == "Teleports" or b.Text == "Teleports" then b.Text = lang[SelectedLanguage].t_tp end
                        if b.Text == "Crystals (Pets)" or b.Text == "Crystals (Pets)" then b.Text = lang[SelectedLanguage].t_pets end
                    end
                end
                for _, l in pairs(orionGui:GetDescendants()) do
                    if l:IsA("TextLabel") or l:IsA("TextBox") then
                        if l.Text == lang.ES.f_strength or l.Text == lang.EN.f_strength then l.Text = lang[SelectedLanguage].f_strength end
                        if l.Text == lang.ES.btn_normal or l.Text == lang.EN.btn_normal then l.Text = lang[SelectedLanguage].btn_normal end
                        if l.Text == lang.ES.btn_fast or l.Text == lang.EN.btn_fast then l.Text = lang[SelectedLanguage].btn_fast end
                        if l.Text == lang.ES.btn_lift or l.Text == lang.EN.btn_lift then l.Text = lang[SelectedLanguage].btn_lift end
                        if l.Text == lang.ES.f_durability or l.Text == lang.EN.f_durability then l.Text = lang[SelectedLanguage].f_durability end
                        if l.Text == lang.ES.drop_rock or l.Text == lang.EN.drop_rock then l.Text = lang[SelectedLanguage].drop_rock end
                        if l.Text == lang.ES.btn_rock or l.Text == lang.EN.btn_rock then l.Text = lang[SelectedLanguage].btn_rock end
                        if l.Text == lang.ES.f_rebirth or l.Text == lang.EN.f_rebirth then l.Text = lang[SelectedLanguage].f_rebirth end
                        if l.Text == lang.ES.btn_reb or l.Text == lang.EN.btn_reb then l.Text = lang[SelectedLanguage].btn_reb end
                        if l.Text == lang.ES.sec_est or l.Text == lang.EN.sec_est then l.Text = lang[SelectedLanguage].sec_est end
                        if l.Text == lang.ES.btn_lag or l.Text == lang.EN.btn_lag then l.Text = lang[SelectedLanguage].btn_lag end
                        if l.Text == lang.ES.btn_crash or l.Text == lang.EN.btn_crash then l.Text = lang[SelectedLanguage].btn_crash end
                        if l.Text == lang.ES.sec_tienda or l.Text == lang.EN.sec_tienda then l.Text = lang[SelectedLanguage].sec_tienda end
                        if l.Text == lang.ES.drop_pet or l.Text == lang.EN.drop_pet then l.Text = lang[SelectedLanguage].drop_pet end
                        if l.Text == lang.ES.btn_buy or l.Text == lang.EN.btn_buy then l.Text = lang[SelectedLanguage].btn_buy end
                        if l.Text == lang.ES.sec_vis or l.Text == lang.EN.sec_vis then l.Text = lang[SelectedLanguage].sec_vis end
                        if l.Text == lang.ES.btn_esp or l.Text == lang.EN.btn_esp then l.Text = lang[SelectedLanguage].btn_esp end
                        if l.Text == lang.ES.sec_tp or l.Text == lang.EN.sec_tp then l.Text = lang[SelectedLanguage].sec_tp end
                        if l.Text == lang.ES.drop_tp or l.Text == lang.EN.drop_tp then l.Text = lang[SelectedLanguage].drop_tp end
                        if l.Text == lang.ES.btn_tp or l.Text == lang.EN.btn_tp then l.Text = lang[SelectedLanguage].btn_tp end
                        if l.Text == lang.ES.btn_dc or l.Text == lang.EN.btn_dc then l.Text = lang[SelectedLanguage].btn_dc end
                        if l.Text == lang.ES.sec_lock or l.Text == lang.EN.sec_lock then l.Text = lang[SelectedLanguage].sec_lock end
                        if l.Text == lang.ES.btn_lock or l.Text == lang.EN.btn_lock then l.Text = lang[SelectedLanguage].btn_lock end
                    end
                end
            end
        end)
        OrionLib:MakeNotification({Name = "Equinox", Content = lang[SelectedLanguage].notify, Time = 3})
    end
})

pcall(function() game:GetService("Players").LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):CaptureController() game:GetService("VirtualUser"):ClickButton2(Vector2.new(0,0)) end) end)
OrionLib:Init()
