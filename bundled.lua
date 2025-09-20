-- ++++++++ WAX BUNDLED DATA BELOW ++++++++ --

-- Will be used later for getting flattened globals
local ImportGlobals

-- Holds direct closure data (defining this before the DOM tree for line debugging etc)
local ClosureBindings = {
    function()local wax,script,require=ImportGlobals(1)local ImportGlobals return (function(...)local ProjectMadara = {}
local Components = {}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")

local TWEEN_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local COLORS = {
    Background = Color3.fromRGB(32, 37, 44),
    DarkBackground = Color3.fromRGB(28, 32, 38),
    LightText = Color3.fromRGB(255, 255, 255),
    DarkText = Color3.fromRGB(170, 175, 185),
    Accent = Color3.fromRGB(88, 166, 255),
    Toggle = Color3.fromRGB(88, 166, 255),
    Hover = Color3.fromRGB(38, 43, 50),
    Border = Color3.fromRGB(45, 50, 57),
    Red = Color3.fromRGB(255, 85, 85),
}

for _, componentName in ipairs({"Window", "Tab", "Toggle", "Button", "TextBox", "Slider", "Dropdown", "Label", "Paragraph", "Loading", "FloatingControls", "MobileFloatingIcon", "DraggableKeybind"}) do
    Components[componentName] = require(script:WaitForChild(componentName))
end

Components.Notifications = require(script:WaitForChild("Notifications"))
Components.OptionsManager = require(script:WaitForChild("OptionsManager"))

function ProjectMadara:Window(options)
    options = options or {}
    options.Title = options.Title or "ProjectMadara UI"
    
    return Components.Window.new(options, self)
end

function ProjectMadara:CreateOptionsManager()
    return Components.OptionsManager.new()
end

function ProjectMadara:Loading(options)
    options = options or {}
    
    return Components.Loading.new(options, self)
end

function ProjectMadara:FloatingControls(options)
    options = options or {}
    
    return Components.FloatingControls.new(options, self)
end

ProjectMadara.Notifications = Components.Notifications.new()

function ProjectMadara:ShowNotification(options)
    return self.Notifications:Show(options)
end

function ProjectMadara:Success(title, content, duration)
    return self.Notifications:Success(title, content, duration)
end

function ProjectMadara:Error(title, content, duration)
    return self.Notifications:Error(title, content, duration)
end

function ProjectMadara:Warning(title, content, duration)
    return self.Notifications:Warning(title, content, duration)
end

function ProjectMadara:Info(title, content, duration)
    return self.Notifications:Info(title, content, duration)
end

ProjectMadara.Components = Components
ProjectMadara.Colors = COLORS
ProjectMadara.TweenInfo = TWEEN_INFO

return ProjectMadara
end)() end,
    function()local wax,script,require=ImportGlobals(2)local ImportGlobals return (function(...)local TweenService = game:GetService("TweenService")
local Button = {}
Button.__index = Button
function Button.new(options, tab)
    local self = setmetatable({}, Button)
    self.Tab = tab
    self.Library = tab.Library
    self.Name = options.Name or "Button"
    self.Description = options.Description or "" 
    self.HasKeybind = options.Keybind or false 
    self.Keybind = nil 
    self.IsListeningForKeybind = false
    self.Callback = options.Callback or function() end
    self:Create()
    if self.HasKeybind then
        self:SetupKeybindSystem()
    end
    return self
end
function Button:Create()
    self.Container = Instance.new("Frame")
    self.Container.Name = self.Name .. "Button"
    self.Container.Size = UDim2.new(1, 0, 0, self.Description ~= "" and 58 or 44)
    self.Container.BackgroundColor3 = Color3.fromRGB(32, 37, 44)
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.Tab.Container
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(55, 60, 67)
    border.Thickness = 1
    border.Parent = self.Container
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = self.Container
    local success, Lucide = pcall(function()
        return require(script.Parent.lucide)
    end)
    self.ButtonLeftIcon = Instance.new("ImageLabel")
    self.ButtonLeftIcon.Name = "LeftIcon"
    self.ButtonLeftIcon.Size = UDim2.new(0, 20, 0, 20)
    self.ButtonLeftIcon.Position = UDim2.new(0, 12, 0, self.Description ~= "" and 8 or 12)
    self.ButtonLeftIcon.BackgroundTransparency = 1
    self.ButtonLeftIcon.Image = (success and Lucide and Lucide["mouse-pointer-click"]) or "rbxassetid://10723434711"
    self.ButtonLeftIcon.ImageColor3 = Color3.fromRGB(120, 140, 160)
    self.ButtonLeftIcon.Parent = self.Container
    self.ButtonText = Instance.new("TextLabel")
    self.ButtonText.Name = "Text"
    self.ButtonText.Size = UDim2.new(0, 200, 0, 20)
    self.ButtonText.Position = UDim2.new(0, 38, 0, self.Description ~= "" and 6 or 12)
    self.ButtonText.BackgroundTransparency = 1
    self.ButtonText.Text = self.Name
    self.ButtonText.TextColor3 = Color3.fromRGB(240, 245, 250)
    self.ButtonText.TextSize = 14
    self.ButtonText.Font = Enum.Font.GothamSemibold
    self.ButtonText.TextXAlignment = Enum.TextXAlignment.Left
    self.ButtonText.Parent = self.Container
    if self.Description ~= "" then
        self.ButtonDescription = Instance.new("TextLabel")
        self.ButtonDescription.Name = "Description"
        self.ButtonDescription.Size = UDim2.new(0, 250, 0, 14)
        self.ButtonDescription.Position = UDim2.new(0, 38, 0, 28)
        self.ButtonDescription.BackgroundTransparency = 1
        self.ButtonDescription.Text = self.Description
        self.ButtonDescription.TextColor3 = Color3.fromRGB(160, 170, 180)
        self.ButtonDescription.TextSize = 11
        self.ButtonDescription.Font = Enum.Font.Gotham
        self.ButtonDescription.TextXAlignment = Enum.TextXAlignment.Left
        self.ButtonDescription.Parent = self.Container
    end
    if self.HasKeybind then
        self.KeybindButton = Instance.new("TextButton")
        self.KeybindButton.Name = "KeybindButton"
        self.KeybindButton.Size = UDim2.new(0, 32, 0, 24)
        self.KeybindButton.Position = UDim2.new(1, -42, 0.5, 0)
        self.KeybindButton.AnchorPoint = Vector2.new(0, 0.5)
        self.KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 55, 62)
        self.KeybindButton.Text = "⌨"
        self.KeybindButton.TextColor3 = Color3.fromRGB(200, 205, 210)
        self.KeybindButton.TextSize = 12
        self.KeybindButton.Font = Enum.Font.GothamBold
        self.KeybindButton.BorderSizePixel = 0
        self.KeybindButton.Parent = self.Container
        local keybindCorner = Instance.new("UICorner")
        keybindCorner.CornerRadius = UDim.new(0, 6)
        keybindCorner.Parent = self.KeybindButton
        self.KeybindButton.MouseButton1Down:Connect(function()
        end)
        local UserInputService = game:GetService("UserInputService")
        local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
        local isDragging = false
        local dragStart = nil
        local pressTime = 0
        local hasMovedEnough = false
        local dragConnection = nil
        local releaseConnection = nil
        self.KeybindButton.MouseButton1Down:Connect(function()
            isDragging = true
            dragStart = UserInputService:GetMouseLocation()
            pressTime = tick()
            hasMovedEnough = false
            print("Button keybind drag started") 
            if dragConnection then
                dragConnection:Disconnect()
            end
            if releaseConnection then
                releaseConnection:Disconnect()
            end
            dragConnection = UserInputService.InputChanged:Connect(function(input)
                if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local currentPos = Vector2.new(input.Position.X, input.Position.Y)
                    local distance = (currentPos - dragStart).Magnitude
                    if distance > 15 then 
                        hasMovedEnough = true
                        print("Button keybind moved enough:", distance) 
                    end
                end
            end)
            releaseConnection = UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and isDragging then
                    print("Button keybind mouse released") 
                    if releaseConnection then
                        releaseConnection:Disconnect()
                        releaseConnection = nil
                    end
                    if dragConnection then
                        dragConnection:Disconnect()
                        dragConnection = nil
                    end
                    local holdTime = tick() - pressTime
                    print("Button keybind released - holdTime:", holdTime, "moved:", hasMovedEnough) 
                    if hasMovedEnough or holdTime > 0.5 then
                        print("Creating draggable button keybind") 
                        self:CreateDraggableKeybind()
                    elseif holdTime < 0.3 then
                        print("Starting keybind listening") 
                        self:StartKeybindListening()
                    end
                    isDragging = false
                    dragStart = nil
                    hasMovedEnough = false
                end
            end)
        end)
        self.KeybindButton.MouseButton2Click:Connect(function()
            print("Right click - creating draggable button keybind") 
            self:CreateDraggableKeybind()
        end)
        self.KeybindButton.MouseEnter:Connect(function()
            if not self.IsListeningForKeybind then
                self.KeybindButton.BackgroundColor3 = Color3.fromRGB(65, 70, 77)
            end
        end)
        self.KeybindButton.MouseLeave:Connect(function()
            if not self.IsListeningForKeybind then
                self.KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 55, 62)
            end
        end)
    end
    self.ButtonIcon = Instance.new("ImageLabel")
    self.ButtonIcon.Name = "Icon"
    self.ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
    self.ButtonIcon.Position = UDim2.new(1, self.HasKeybind and -72 or -30, 0.5, 0) 
    self.ButtonIcon.AnchorPoint = Vector2.new(0, 0.5)
    self.ButtonIcon.BackgroundTransparency = 1
    self.ButtonIcon.Image = (success and Lucide and Lucide["fingerprint"]) or "rbxassetid://10723375250" 
    self.ButtonIcon.ImageColor3 = self.Library.Colors.LightText
    self.ButtonIcon.Parent = self.Container
    self.ButtonInteraction = Instance.new("TextButton")
    self.ButtonInteraction.Name = "Interaction"
    self.ButtonInteraction.Size = UDim2.new(1, self.HasKeybind and -42 or 0, 1, 0) 
    self.ButtonInteraction.BackgroundTransparency = 1
    self.ButtonInteraction.Text = ""
    self.ButtonInteraction.Parent = self.Container
    local clickEffect = function()
        local ripple = Instance.new("Frame")
        ripple.Name = "Ripple"
        ripple.AnchorPoint = Vector2.new(0.5, 0.5)
        ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
        ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ripple.BackgroundTransparency = 0.8
        ripple.BorderSizePixel = 0
        ripple.Size = UDim2.new(0, 0, 0, 0)
        ripple.Parent = self.Container
        local rippleCorner = Instance.new("UICorner")
        rippleCorner.CornerRadius = UDim.new(1, 0)
        rippleCorner.Parent = ripple
        local expandTween = TweenService:Create(
            ripple,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(1.5, 0, 1.5, 0), BackgroundTransparency = 1}
        )
        expandTween:Play()
        expandTween.Completed:Connect(function()
            ripple:Destroy()
        end)
    end
    self.ButtonInteraction.MouseButton1Click:Connect(function()
        clickEffect()
        self.Callback()
    end)
    self.ButtonInteraction.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(38, 43, 50)}
        )
        hoverTween:Play()
        local borderTween = TweenService:Create(
            border,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(70, 80, 90)}
        )
        borderTween:Play()
    end)
    self.ButtonInteraction.MouseLeave:Connect(function()
        local leaveTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(32, 37, 44)}
        )
        leaveTween:Play()
        local borderTween = TweenService:Create(
            border,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(55, 60, 67)}
        )
        borderTween:Play()
    end)
    return self
end
function Button:SetupKeybindSystem()
    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if self.IsListeningForKeybind then
            self.Keybind = input.KeyCode
            self.IsListeningForKeybind = false
            self:UpdateKeybindDisplay()
            self.KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 55, 62)
            return
        end
        if self.Keybind and input.KeyCode == self.Keybind then
            self.Callback()
        end
    end)
end
function Button:StartKeybindListening()
    self.IsListeningForKeybind = true
    self.KeybindButton.Text = "..."
    self.KeybindButton.BackgroundColor3 = self.Library.Colors.Accent 
end
function Button:UpdateKeybindDisplay()
    if self.Keybind then
        local keyName = tostring(self.Keybind):gsub("Enum.KeyCode.", "")
        self.KeybindButton.Text = keyName:upper()
        self.KeybindButton.TextSize = #keyName > 2 and 12 or 14 
    else
        self.KeybindButton.Text = "⌨"
    end
end
function Button:CreateDraggableKeybind()
    print("Button:CreateDraggableKeybind called for:", self.Name) 
    local DraggableKeybind = require(script.Parent.DraggableKeybind)
    local draggable = DraggableKeybind.CreateFromButton(
        self.KeybindButton,
        "Button",
        self.Name,
        self.Callback,
        nil,
        nil
    )
    print("Draggable button created:", draggable) 
end
return Button
end)() end,
    function()local wax,script,require=ImportGlobals(3)local ImportGlobals return (function(...)local HttpService = game:GetService("HttpService")
local Config = {}
Config.__index = Config

function Config.new(window)
    local self = setmetatable({}, Config)
    self.Window = window
    self.PlaceId = tostring(game.PlaceId)
    self.ConfigFolder = "ProjectMadara_" .. self.PlaceId
    self.ConfigFile = self.ConfigFolder .. "/config.json"
    self.Data = {}
    
    self:CreateConfigFolder()
    
    return self
end

function Config:CreateConfigFolder()
    if makefolder then
        makefolder(self.ConfigFolder)
    end
end

function Config:SaveConfig()
    if not writefile then
        warn("Config System: writefile function not available")
        return false
    end
    
    local configData = {
        version = "2.0.0",
        placeId = self.PlaceId,
        timestamp = os.time(),
        data = self.Data
    }
    
    local success, result = pcall(function()
        local jsonData = HttpService:JSONEncode(configData)
        writefile(self.ConfigFile, jsonData)
    end)
    
    if success then
        print("Config saved successfully to:", self.ConfigFile)
        return true
    else
        warn("Config System: Failed to save config:", result)
        return false
    end
end

function Config:LoadConfig()
    if not readfile or not isfile then
        warn("Config System: readfile or isfile function not available")
        return false
    end
    
    if not isfile(self.ConfigFile) then
        print("Config System: No existing config found, creating new one")
        return false
    end
    
    local success, result = pcall(function()
        local jsonData = readfile(self.ConfigFile)
        local configData = HttpService:JSONDecode(jsonData)
        
        if configData.placeId == self.PlaceId then
            self.Data = configData.data or {}
            return true
        else
            warn("Config System: PlaceId mismatch, creating new config")
            return false
        end
    end)
    
    if success and result then
        print("Config loaded successfully from:", self.ConfigFile)
        self:ApplyConfig()
        return true
    else
        warn("Config System: Failed to load config:", result)
        return false
    end
end

function Config:ApplyConfig()
    -- Apply config to all tabs and their components
    for _, tab in ipairs(self.Window.Tabs) do
        self:ApplyTabConfig(tab)
    end
end

function Config:ApplyTabConfig(tab)
    local tabData = self.Data[tab.Name] or {}
    
    -- Apply config to all components in the tab
    for _, component in ipairs(tab.Components) do
        local componentKey = component.Name
        local savedValue = tabData[componentKey]
        
        if savedValue ~= nil then
            self:ApplyComponentConfig(component, savedValue)
        end
    end
end

function Config:ApplyComponentConfig(component, value)
    if component.Type == "Toggle" then
        component:SetValue(value)
    elseif component.Type == "Slider" then
        component:SetValue(value)
    elseif component.Type == "Dropdown" then
        if component.Multiselect then
            -- For multiselect dropdowns, value should be a table
            if type(value) == "table" then
                component.Selected = {}
                for _, item in ipairs(value) do
                    component.Selected[item] = true
                end
                component:UpdateSelectedText()
                component:UpdateSelectAllButtonText()
            end
        else
            -- For single select dropdowns
            component:SetValue(value)
        end
    elseif component.Type == "TextBox" then
        component:SetValue(value)
    end
end

function Config:SaveComponentValue(tabName, componentName, value)
    if not self.Data[tabName] then
        self.Data[tabName] = {}
    end
    
    self.Data[tabName][componentName] = value
    
    -- Auto-save after each change
    self:SaveConfig()
end

function Config:GetComponentValue(tabName, componentName, defaultValue)
    if self.Data[tabName] and self.Data[tabName][componentName] ~= nil then
        return self.Data[tabName][componentName]
    end
    return defaultValue
end

function Config:ClearConfig()
    self.Data = {}
    self:SaveConfig()
    print("Config System: Configuration cleared")
end

function Config:DeleteConfig()
    if delfile and isfile and isfile(self.ConfigFile) then
        delfile(self.ConfigFile)
        print("Config System: Configuration file deleted")
    end
    if delfolder and isfolder and isfolder(self.ConfigFolder) then
        delfolder(self.ConfigFolder)
        print("Config System: Configuration folder deleted")
    end
end

return Config
end)() end,
    function()local wax,script,require=ImportGlobals(4)local ImportGlobals return (function(...)local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Credits = {}
Credits.__index = Credits

function Credits.new(options, tab)
    local self = setmetatable({}, Credits)
    self.Tab = tab
    self.Library = tab.Library
    self.Title = options.Title or "Credits"
    self.Subtitle = options.Subtitle or "Meet the amazing team behind this project"
    self.Developers = options.Developers or {}
    self.DiscordInvite = options.DiscordInvite or ""
    self.ProjectInfo = options.ProjectInfo or {}
    self:Create()
    return self
end

function Credits:Create()
    -- Main Credits Container
    self.Container = Instance.new("Frame")
    self.Container.Name = "CreditsContainer"
    self.Container.Size = UDim2.new(1, 0, 0, 0)
    self.Container.BackgroundTransparency = 1
    self.Container.BorderSizePixel = 0
    self.Container.AutomaticSize = Enum.AutomaticSize.Y
    self.Container.Parent = self.Tab.Container

    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 12)
    layout.Parent = self.Container

    -- Header Section
    self:CreateHeader()
    
    -- Project Info Section
    if next(self.ProjectInfo) then
        self:CreateProjectInfo()
    end
    
    -- Developers Section
    if #self.Developers > 0 then
        self:CreateDevelopersSection()
    end
    
    -- Discord Section
    if self.DiscordInvite ~= "" then
        self:CreateDiscordSection()
    end
    
    -- Footer
    self:CreateFooter()
    
    return self
end

function Credits:CreateHeader()
    local headerFrame = Instance.new("Frame")
    headerFrame.Name = "Header"
    headerFrame.Size = UDim2.new(1, 0, 0, 80)
    headerFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 30)
    headerFrame.BorderSizePixel = 0
    headerFrame.LayoutOrder = 1
    headerFrame.Parent = self.Container

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = headerFrame

    local headerBorder = Instance.new("UIStroke")
    headerBorder.Color = Color3.fromRGB(0, 120, 215)
    headerBorder.Thickness = 1
    headerBorder.Transparency = 0.7
    headerBorder.Parent = headerFrame

    -- Animated gradient background
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 215)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 50, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 120, 215))
    }
    gradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.9),
        NumberSequenceKeypoint.new(0.5, 0.95),
        NumberSequenceKeypoint.new(1, 0.9)
    }
    gradient.Rotation = 45
    gradient.Parent = headerFrame

    -- Animate gradient
    local gradientTween = TweenService:Create(
        gradient,
        TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
        {Rotation = 225}
    )
    gradientTween:Play()

    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -24, 0, 32)
    titleLabel.Position = UDim2.new(0, 12, 0, 12)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = self.Title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 24
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.Parent = headerFrame

    -- Subtitle
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Name = "Subtitle"
    subtitleLabel.Size = UDim2.new(1, -24, 0, 20)
    subtitleLabel.Position = UDim2.new(0, 12, 0, 48)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = self.Subtitle
    subtitleLabel.TextColor3 = Color3.fromRGB(180, 200, 220)
    subtitleLabel.TextSize = 14
    subtitleLabel.Font = Enum.Font.Gotham
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    subtitleLabel.Parent = headerFrame
end

function Credits:CreateProjectInfo()
    local infoFrame = Instance.new("Frame")
    infoFrame.Name = "ProjectInfo"
    infoFrame.Size = UDim2.new(1, 0, 0, 0)
    infoFrame.BackgroundTransparency = 1
    infoFrame.BorderSizePixel = 0
    infoFrame.AutomaticSize = Enum.AutomaticSize.Y
    infoFrame.LayoutOrder = 2
    infoFrame.Parent = self.Container

    local infoLayout = Instance.new("UIListLayout")
    infoLayout.FillDirection = Enum.FillDirection.Vertical
    infoLayout.SortOrder = Enum.SortOrder.LayoutOrder
    infoLayout.Padding = UDim.new(0, 8)
    infoLayout.Parent = infoFrame

    for key, value in pairs(self.ProjectInfo) do
        local infoItem = Instance.new("Frame")
        infoItem.Name = key
        infoItem.Size = UDim2.new(1, 0, 0, 36)
        infoItem.BackgroundColor3 = Color3.fromRGB(26, 30, 36)
        infoItem.BorderSizePixel = 0
        infoItem.Parent = infoFrame

        local itemCorner = Instance.new("UICorner")
        itemCorner.CornerRadius = UDim.new(0, 8)
        itemCorner.Parent = infoItem

        local keyLabel = Instance.new("TextLabel")
        keyLabel.Name = "Key"
        keyLabel.Size = UDim2.new(0.4, -12, 1, 0)
        keyLabel.Position = UDim2.new(0, 12, 0, 0)
        keyLabel.BackgroundTransparency = 1
        keyLabel.Text = key .. ":"
        keyLabel.TextColor3 = Color3.fromRGB(160, 180, 200)
        keyLabel.TextSize = 13
        keyLabel.Font = Enum.Font.GothamSemibold
        keyLabel.TextXAlignment = Enum.TextXAlignment.Left
        keyLabel.Parent = infoItem

        local valueLabel = Instance.new("TextLabel")
        valueLabel.Name = "Value"
        valueLabel.Size = UDim2.new(0.6, -12, 1, 0)
        valueLabel.Position = UDim2.new(0.4, 0, 0, 0)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Text = tostring(value)
        valueLabel.TextColor3 = Color3.fromRGB(240, 245, 250)
        valueLabel.TextSize = 13
        valueLabel.Font = Enum.Font.Gotham
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.Parent = infoItem
    end
end

function Credits:CreateDevelopersSection()
    -- Section Title
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Name = "DevelopersTitle"
    sectionTitle.Size = UDim2.new(1, 0, 0, 24)
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Text = "👨‍💻 Development Team"
    sectionTitle.TextColor3 = Color3.fromRGB(240, 245, 250)
    sectionTitle.TextSize = 16
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.LayoutOrder = 3
    sectionTitle.Parent = self.Container

    -- Developers Grid
    local devsFrame = Instance.new("Frame")
    devsFrame.Name = "Developers"
    devsFrame.Size = UDim2.new(1, 0, 0, 0)
    devsFrame.BackgroundTransparency = 1
    devsFrame.BorderSizePixel = 0
    devsFrame.AutomaticSize = Enum.AutomaticSize.Y
    devsFrame.LayoutOrder = 4
    devsFrame.Parent = self.Container

    local devsLayout = Instance.new("UIListLayout")
    devsLayout.FillDirection = Enum.FillDirection.Vertical
    devsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    devsLayout.Padding = UDim.new(0, 8)
    devsLayout.Parent = devsFrame

    for i, dev in ipairs(self.Developers) do
        self:CreateDeveloperCard(dev, devsFrame, i)
    end
end

function Credits:CreateDeveloperCard(dev, parent, order)
    local devCard = Instance.new("Frame")
    devCard.Name = "DevCard" .. order
    devCard.Size = UDim2.new(1, 0, 0, 72)
    devCard.BackgroundColor3 = Color3.fromRGB(28, 32, 38)
    devCard.BorderSizePixel = 0
    devCard.LayoutOrder = order
    devCard.Parent = parent

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 12)
    cardCorner.Parent = devCard

    local cardBorder = Instance.new("UIStroke")
    cardBorder.Color = Color3.fromRGB(45, 50, 58)
    cardBorder.Thickness = 1
    cardBorder.Parent = devCard

    -- Avatar/Icon
    local avatarFrame = Instance.new("Frame")
    avatarFrame.Name = "Avatar"
    avatarFrame.Size = UDim2.new(0, 48, 0, 48)
    avatarFrame.Position = UDim2.new(0, 12, 0.5, 0)
    avatarFrame.AnchorPoint = Vector2.new(0, 0.5)
    avatarFrame.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    avatarFrame.BorderSizePixel = 0
    avatarFrame.Parent = devCard

    local avatarCorner = Instance.new("UICorner")
    avatarCorner.CornerRadius = UDim.new(1, 0)
    avatarCorner.Parent = avatarFrame

    -- Avatar gradient
    local avatarGradient = Instance.new("UIGradient")
    avatarGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, dev.Color or Color3.fromRGB(0, 120, 215)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 50, 200))
    }
    avatarGradient.Rotation = 45
    avatarGradient.Parent = avatarFrame

    -- Avatar Text/Initial
    local avatarText = Instance.new("TextLabel")
    avatarText.Name = "AvatarText"
    avatarText.Size = UDim2.new(1, 0, 1, 0)
    avatarText.BackgroundTransparency = 1
    avatarText.Text = dev.Initial or string.sub(dev.Name or "?", 1, 1):upper()
    avatarText.TextColor3 = Color3.fromRGB(255, 255, 255)
    avatarText.TextSize = 20
    avatarText.Font = Enum.Font.GothamBold
    avatarText.TextXAlignment = Enum.TextXAlignment.Center
    avatarText.TextYAlignment = Enum.TextYAlignment.Center
    avatarText.Parent = avatarFrame

    -- Developer Info
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "Name"
    nameLabel.Size = UDim2.new(0, 200, 0, 20)
    nameLabel.Position = UDim2.new(0, 72, 0, 16)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = dev.Name or "Unknown Developer"
    nameLabel.TextColor3 = Color3.fromRGB(240, 245, 250)
    nameLabel.TextSize = 15
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = devCard

    local roleLabel = Instance.new("TextLabel")
    roleLabel.Name = "Role"
    roleLabel.Size = UDim2.new(0, 200, 0, 16)
    roleLabel.Position = UDim2.new(0, 72, 0, 38)
    roleLabel.BackgroundTransparency = 1
    roleLabel.Text = dev.Role or "Developer"
    roleLabel.TextColor3 = Color3.fromRGB(160, 180, 200)
    roleLabel.TextSize = 12
    roleLabel.Font = Enum.Font.Gotham
    roleLabel.TextXAlignment = Enum.TextXAlignment.Left
    roleLabel.Parent = devCard

    -- Status Badge
    if dev.Status then
        local statusBadge = Instance.new("Frame")
        statusBadge.Name = "StatusBadge"
        statusBadge.Size = UDim2.new(0, 8, 0, 8)
        statusBadge.Position = UDim2.new(1, -16, 0, 16)
        statusBadge.BackgroundColor3 = dev.Status == "Online" and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(120, 120, 120)
        statusBadge.BorderSizePixel = 0
        statusBadge.Parent = devCard

        local statusCorner = Instance.new("UICorner")
        statusCorner.CornerRadius = UDim.new(1, 0)
        statusCorner.Parent = statusBadge
    end

    -- Hover Effects
    local button = Instance.new("TextButton")
    button.Name = "HoverButton"
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = devCard

    button.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(
            devCard,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(35, 40, 48)}
        )
        hoverTween:Play()
        
        local borderTween = TweenService:Create(
            cardBorder,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(0, 120, 215)}
        )
        borderTween:Play()
    end)

    button.MouseLeave:Connect(function()
        local leaveTween = TweenService:Create(
            devCard,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(28, 32, 38)}
        )
        leaveTween:Play()
        
        local borderTween = TweenService:Create(
            cardBorder,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(45, 50, 58)}
        )
        borderTween:Play()
    end)
end

function Credits:CreateDiscordSection()
    -- Section Title
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Name = "CommunityTitle"
    sectionTitle.Size = UDim2.new(1, 0, 0, 24)
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Text = "💬 Join Our Community"
    sectionTitle.TextColor3 = Color3.fromRGB(240, 245, 250)
    sectionTitle.TextSize = 16
    sectionTitle.Font = Enum.Font.GothamBold
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.LayoutOrder = 5
    sectionTitle.Parent = self.Container

    -- Discord Button
    local discordButton = Instance.new("TextButton")
    discordButton.Name = "DiscordButton"
    discordButton.Size = UDim2.new(1, 0, 0, 56)
    discordButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    discordButton.BorderSizePixel = 0
    discordButton.Text = ""
    discordButton.LayoutOrder = 6
    discordButton.Parent = self.Container

    local discordCorner = Instance.new("UICorner")
    discordCorner.CornerRadius = UDim.new(0, 12)
    discordCorner.Parent = discordButton

    -- Discord gradient
    local discordGradient = Instance.new("UIGradient")
    discordGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 101, 242)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(114, 137, 218))
    }
    discordGradient.Rotation = 45
    discordGradient.Parent = discordButton

    -- Discord Icon
    local discordIcon = Instance.new("TextLabel")
    discordIcon.Name = "Icon"
    discordIcon.Size = UDim2.new(0, 32, 0, 32)
    discordIcon.Position = UDim2.new(0, 16, 0.5, 0)
    discordIcon.AnchorPoint = Vector2.new(0, 0.5)
    discordIcon.BackgroundTransparency = 1
    discordIcon.Text = "🎮"
    discordIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    discordIcon.TextSize = 24
    discordIcon.Font = Enum.Font.GothamBold
    discordIcon.TextXAlignment = Enum.TextXAlignment.Center
    discordIcon.TextYAlignment = Enum.TextYAlignment.Center
    discordIcon.Parent = discordButton

    -- Discord Text
    local discordText = Instance.new("TextLabel")
    discordText.Name = "Text"
    discordText.Size = UDim2.new(1, -64, 0, 20)
    discordText.Position = UDim2.new(0, 56, 0, 12)
    discordText.BackgroundTransparency = 1
    discordText.Text = "Join Discord Server"
    discordText.TextColor3 = Color3.fromRGB(255, 255, 255)
    discordText.TextSize = 16
    discordText.Font = Enum.Font.GothamBold
    discordText.TextXAlignment = Enum.TextXAlignment.Left
    discordText.Parent = discordButton

    local discordSubtext = Instance.new("TextLabel")
    discordSubtext.Name = "Subtext"
    discordSubtext.Size = UDim2.new(1, -64, 0, 16)
    discordSubtext.Position = UDim2.new(0, 56, 0, 32)
    discordSubtext.BackgroundTransparency = 1
    discordSubtext.Text = "Connect with the community and get support"
    discordSubtext.TextColor3 = Color3.fromRGB(220, 230, 240)
    discordSubtext.TextSize = 12
    discordSubtext.Font = Enum.Font.Gotham
    discordSubtext.TextXAlignment = Enum.TextXAlignment.Left
    discordSubtext.Parent = discordButton

    -- Click to copy invite
    discordButton.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(self.DiscordInvite)
            -- Show feedback
            discordText.Text = "✅ Invite Copied!"
            wait(2)
            discordText.Text = "Join Discord Server"
        end
    end)

    -- Hover effects
    discordButton.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(
            discordButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(1, 0, 0, 60)}
        )
        hoverTween:Play()
    end)

    discordButton.MouseLeave:Connect(function()
        local leaveTween = TweenService:Create(
            discordButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(1, 0, 0, 56)}
        )
        leaveTween:Play()
    end)
end

function Credits:CreateFooter()
    local footerFrame = Instance.new("Frame")
    footerFrame.Name = "Footer"
    footerFrame.Size = UDim2.new(1, 0, 0, 48)
    footerFrame.BackgroundColor3 = Color3.fromRGB(18, 22, 28)
    footerFrame.BorderSizePixel = 0
    footerFrame.LayoutOrder = 7
    footerFrame.Parent = self.Container

    local footerCorner = Instance.new("UICorner")
    footerCorner.CornerRadius = UDim.new(0, 8)
    footerCorner.Parent = footerFrame

    local footerText = Instance.new("TextLabel")
    footerText.Name = "FooterText"
    footerText.Size = UDim2.new(1, -24, 1, 0)
    footerText.Position = UDim2.new(0, 12, 0, 0)
    footerText.BackgroundTransparency = 1
    footerText.Text = "Made with ❤️ using ProjectMadara UI Library"
    footerText.TextColor3 = Color3.fromRGB(140, 160, 180)
    footerText.TextSize = 12
    footerText.Font = Enum.Font.GothamMedium
    footerText.TextXAlignment = Enum.TextXAlignment.Center
    footerText.TextYAlignment = Enum.TextYAlignment.Center
    footerText.Parent = footerFrame

    -- Sparkle animation
    spawn(function()
        while footerFrame.Parent do
            local sparkle = Instance.new("Frame")
            sparkle.Name = "Sparkle"
            sparkle.Size = UDim2.new(0, 2, 0, 2)
            sparkle.Position = UDim2.new(math.random(0, 100) / 100, 0, math.random(0, 100) / 100, 0)
            sparkle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sparkle.BorderSizePixel = 0
            sparkle.Parent = footerFrame

            local sparkleCorner = Instance.new("UICorner")
            sparkleCorner.CornerRadius = UDim.new(1, 0)
            sparkleCorner.Parent = sparkle

            local sparkleTween = TweenService:Create(
                sparkle,
                TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundTransparency = 1, Size = UDim2.new(0, 8, 0, 8)}
            )
            sparkleTween:Play()
            
            sparkleTween.Completed:Connect(function()
                sparkle:Destroy()
            end)
            
            wait(math.random(1, 3))
        end
    end)
end

return Credits
end)() end,
    function()local wax,script,require=ImportGlobals(5)local ImportGlobals return (function(...)local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local DraggableKeybind = {}
DraggableKeybind.__index = DraggableKeybind
local DraggedKeybinds = {}
local DraggedKeybindsGui = nil
function DraggableKeybind.new(options)
    local self = setmetatable({}, DraggableKeybind)
    self.Name = options.Name or "Keybind"
    self.Callback = options.Callback or function() end
    self.OriginalButton = options.OriginalButton 
    self.ComponentType = options.ComponentType or "Button" 
    self.ToggleValue = options.ToggleValue 
    self.SetToggleValue = options.SetToggleValue 
    self.IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    if not DraggedKeybindsGui then
        self:CreateDraggedKeybindsGui()
    end
    self:CreateFloatingKeybind()
    return self
end
function DraggableKeybind:CreateDraggedKeybindsGui()
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    DraggedKeybindsGui = Instance.new("ScreenGui")
    DraggedKeybindsGui.Name = "DraggedKeybinds"
    DraggedKeybindsGui.ResetOnSpawn = false
    DraggedKeybindsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    DraggedKeybindsGui.Parent = playerGui
end
function DraggableKeybind:CreateFloatingKeybind()
    self.Container = Instance.new("Frame")
    self.Container.Name = self.Name .. "FloatingKeybind"
    self.Container.Size = UDim2.new(0, self.IsMobile and 70 or 60, 0, self.IsMobile and 70 or 60)
    self.Container.Position = UDim2.new(0, math.random(100, 300), 0, math.random(150, 400))
    self.Container.BackgroundTransparency = 1
    self.Container.Parent = DraggedKeybindsGui
    self.FloatingButton = Instance.new("TextButton")
    self.FloatingButton.Name = "FloatingButton"
    self.FloatingButton.Size = UDim2.new(1, -6, 1, -6)
    self.FloatingButton.Position = UDim2.new(0, 3, 0, 3)
    self.FloatingButton.BackgroundColor3 = self.ComponentType == "Toggle" and Color3.fromRGB(88, 166, 255) or Color3.fromRGB(0, 120, 215)
    self.FloatingButton.Text = ""
    self.FloatingButton.BorderSizePixel = 0
    self.FloatingButton.Parent = self.Container
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = self.FloatingButton
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(255, 255, 255)
    border.Thickness = 2
    border.Transparency = 0.6
    border.Parent = self.FloatingButton
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 8, 1, 8)
    shadow.Position = UDim2.new(0, -4, 0, -4)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.7
    shadow.BorderSizePixel = 0
    shadow.ZIndex = self.FloatingButton.ZIndex - 1
    shadow.Parent = self.FloatingButton
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(1, 0)
    shadowCorner.Parent = shadow
    self.Icon = Instance.new("TextLabel")
    self.Icon.Size = UDim2.new(1, 0, 1, 0)
    self.Icon.BackgroundTransparency = 1
    self.Icon.Text = string.upper(string.sub(self.Name, 1, 1)) 
    self.Icon.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.Icon.TextSize = self.IsMobile and 28 or 24
    self.Icon.Font = Enum.Font.GothamBold
    self.Icon.TextXAlignment = Enum.TextXAlignment.Center
    self.Icon.TextYAlignment = Enum.TextYAlignment.Center
    self.Icon.Parent = self.FloatingButton
    self.NameLabel = Instance.new("TextLabel")
    self.NameLabel.Name = "NameLabel"
    self.NameLabel.Size = UDim2.new(0, 120, 0, 24)
    self.NameLabel.Position = UDim2.new(0.5, 0, 1, 8)
    self.NameLabel.AnchorPoint = Vector2.new(0.5, 0)
    self.NameLabel.BackgroundColor3 = Color3.fromRGB(20, 25, 32)
    self.NameLabel.Text = self.Name
    self.NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.NameLabel.TextSize = 12
    self.NameLabel.Font = Enum.Font.GothamSemibold
    self.NameLabel.TextXAlignment = Enum.TextXAlignment.Center
    self.NameLabel.TextYAlignment = Enum.TextYAlignment.Center
    self.NameLabel.BorderSizePixel = 0
    self.NameLabel.Visible = false
    self.NameLabel.Parent = self.Container
    local labelCorner = Instance.new("UICorner")
    labelCorner.CornerRadius = UDim.new(0, 6)
    labelCorner.Parent = self.NameLabel
    local labelBorder = Instance.new("UIStroke")
    labelBorder.Color = Color3.fromRGB(40, 45, 52)
    labelBorder.Thickness = 1
    labelBorder.Parent = self.NameLabel
    if self.ComponentType == "Toggle" then
        self.StateIndicator = Instance.new("Frame")
        self.StateIndicator.Size = UDim2.new(0, 12, 0, 12)
        self.StateIndicator.Position = UDim2.new(1, -8, 0, -4)
        self.StateIndicator.BackgroundColor3 = Color3.fromRGB(255, 60, 60) 
        self.StateIndicator.BorderSizePixel = 0
        self.StateIndicator.Parent = self.FloatingButton
        local stateCorner = Instance.new("UICorner")
        stateCorner.CornerRadius = UDim.new(1, 0)
        stateCorner.Parent = self.StateIndicator
        self:UpdateToggleState()
    end
    self.CloseButton = Instance.new("TextButton")
    self.CloseButton.Size = UDim2.new(0, 30, 0, 30) 
    self.CloseButton.Position = UDim2.new(1, -20, 0, -10) 
    self.CloseButton.AnchorPoint = Vector2.new(0.5, 0.5) 
    self.CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    self.CloseButton.Text = "×"
    self.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.CloseButton.TextSize = 18 
    self.CloseButton.Font = Enum.Font.GothamBold
    self.CloseButton.BorderSizePixel = 0
    self.CloseButton.Visible = true 
    self.CloseButton.ZIndex = 100 
    self.CloseButton.Parent = self.Container
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = self.CloseButton
    local closeBorder = Instance.new("UIStroke")
    closeBorder.Color = Color3.fromRGB(255, 255, 255)
    closeBorder.Thickness = 3 
    closeBorder.Parent = self.CloseButton
    self:MakeDraggable()
    self:SetupInteractions()
    table.insert(DraggedKeybinds, self)
    return self
end
function DraggableKeybind:MakeDraggable()
    local isDragging = false
    local dragStart = nil
    local startPos = nil
    local pressTime = 0
    local hasMovedEnough = false
    local dragConnection = nil
    local releaseConnection = nil
    self.FloatingButton.MouseButton1Down:Connect(function()
        isDragging = true
        dragStart = UserInputService:GetMouseLocation()
        startPos = self.Container.Position
        pressTime = tick()
        hasMovedEnough = false
        print("Floating button pressed:", self.Name) 
        if dragConnection then dragConnection:Disconnect() end
        if releaseConnection then releaseConnection:Disconnect() end
        dragConnection = UserInputService.InputChanged:Connect(function(input)
            if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local currentPos = Vector2.new(input.Position.X, input.Position.Y)
                local distance = (currentPos - dragStart).Magnitude
                if distance > 10 then 
                    hasMovedEnough = true
                    local delta = currentPos - dragStart
                    self.Container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end
        end)
        releaseConnection = UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and isDragging then
                local holdTime = tick() - pressTime
                print("Floating button released:", self.Name, "moved:", hasMovedEnough, "holdTime:", holdTime) 
                if dragConnection then
                    dragConnection:Disconnect()
                    dragConnection = nil
                end
                if releaseConnection then
                    releaseConnection:Disconnect()
                    releaseConnection = nil
                end
                if not hasMovedEnough and holdTime < 0.3 then
                    print("Activating floating button:", self.Name) 
                    self:OnActivated()
                end
                isDragging = false
                hasMovedEnough = false
            end
        end)
    end)
end
function DraggableKeybind:SetupInteractions()
    self.CloseButton.MouseButton1Click:Connect(function()
        print("Close button clicked for:", self.Name) 
        self:Remove()
    end)
    self.CloseButton.MouseEnter:Connect(function()
        print("Hovering over close button") 
        local scaleTween = TweenService:Create(
            self.CloseButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 35, 0, 35), BackgroundColor3 = Color3.fromRGB(255, 100, 100)}
        )
        scaleTween:Play()
    end)
    self.CloseButton.MouseLeave:Connect(function()
        local scaleTween = TweenService:Create(
            self.CloseButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 30, 0, 30), BackgroundColor3 = Color3.fromRGB(255, 60, 60)}
        )
        scaleTween:Play()
    end)
    if not self.IsMobile then
        self.FloatingButton.MouseEnter:Connect(function()
            self.NameLabel.Visible = true
            self.CloseButton.Visible = true
            local scaleTween = TweenService:Create(
                self.FloatingButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Size = UDim2.new(1, 4, 1, 4)}
            )
            scaleTween:Play()
        end)
        self.FloatingButton.MouseLeave:Connect(function()
            self.NameLabel.Visible = false
            self.CloseButton.Visible = false
            local scaleTween = TweenService:Create(
                self.FloatingButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Size = UDim2.new(1, -6, 1, -6)}
            )
            scaleTween:Play()
        end)
    else
        self.FloatingButton.MouseButton1Down:Connect(function()
            self.NameLabel.Visible = true
            local scaleTween = TweenService:Create(
                self.FloatingButton,
                TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Size = UDim2.new(1, -10, 1, -10)}
            )
            scaleTween:Play()
        end)
        self.FloatingButton.MouseButton1Up:Connect(function()
            wait(1)
            self.NameLabel.Visible = false
            local scaleTween = TweenService:Create(
                self.FloatingButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Size = UDim2.new(1, -6, 1, -6)}
            )
            scaleTween:Play()
        end)
    end
end
function DraggableKeybind:OnActivated()
    local pulseTween = TweenService:Create(
        self.FloatingButton,
        TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(1, 8, 1, 8)}
    )
    pulseTween:Play()
    pulseTween.Completed:Connect(function()
        local returnTween = TweenService:Create(
            self.FloatingButton,
            TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(1, -6, 1, -6)}
        )
        returnTween:Play()
    end)
    if self.ComponentType == "Toggle" then
        local newValue = not self.ToggleValue()
        self.SetToggleValue(newValue)
        self:UpdateToggleState()
    else
        self.Callback()
    end
end
function DraggableKeybind:UpdateToggleState()
    if self.ComponentType == "Toggle" and self.StateIndicator then
        local isOn = self.ToggleValue()
        local color = isOn and Color3.fromRGB(60, 255, 60) or Color3.fromRGB(255, 60, 60)
        local colorTween = TweenService:Create(
            self.StateIndicator,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = color}
        )
        colorTween:Play()
        local buttonColor = isOn and Color3.fromRGB(60, 200, 60) or Color3.fromRGB(88, 166, 255)
        local buttonTween = TweenService:Create(
            self.FloatingButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = buttonColor}
        )
        buttonTween:Play()
    end
end
function DraggableKeybind:Remove()
    for i, keybind in ipairs(DraggedKeybinds) do
        if keybind == self then
            table.remove(DraggedKeybinds, i)
            break
        end
    end
    local fadeTween = TweenService:Create(
        self.Container,
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}
    )
    fadeTween:Play()
    fadeTween.Completed:Connect(function()
        self.Container:Destroy()
    end)
    if self.OriginalButton then
        self.OriginalButton.Visible = true
    end
end
function DraggableKeybind.CreateFromButton(button, componentType, name, callback, toggleValue, setToggleValue)
    print("DraggableKeybind.CreateFromButton called:", name, componentType) 
    button.Visible = false
    print("Original button hidden") 
    local draggableKeybind = DraggableKeybind.new({
        Name = name,
        Callback = callback,
        OriginalButton = button,
        ComponentType = componentType,
        ToggleValue = toggleValue,
        SetToggleValue = setToggleValue
    })
    print("DraggableKeybind created successfully") 
    return draggableKeybind
end
function DraggableKeybind.GetAll()
    return DraggedKeybinds
end
function DraggableKeybind.RemoveAll()
    for _, keybind in ipairs(DraggedKeybinds) do
        keybind:Remove()
    end
    DraggedKeybinds = {}
end
return DraggableKeybind
end)() end,
    function()local wax,script,require=ImportGlobals(6)local ImportGlobals return (function(...)local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Dropdown = {}
Dropdown.__index = Dropdown
function Dropdown.new(options, tab)
    local self = setmetatable({}, Dropdown)
    self.Tab = tab
    self.Library = tab.Library
    self.Type = "Dropdown"
    self.Name = options.Name or "Dropdown"
    self.Description = options.Description or ""
    self.Items = options.Items or {}
    self.Multiselect = options.Multiselect or false
    self.Open = false
    self.FilteredItems = {}
    for _, item in ipairs(self.Items) do
        table.insert(self.FilteredItems, item)
    end
    if not self.Multiselect then
        self.Selected = options.Default or (self.Items[1] or "")
    else
        self.Selected = {}
        if options.Default then
            if type(options.Default) == "string" then
                self.Selected[options.Default] = true
            elseif type(options.Default) == "table" then
                for _, item in ipairs(options.Default) do
                    self.Selected[item] = true
                end
            end
        end
    end
    self.Callback = options.Callback or function() end
    self:Create()
    return self
end
function Dropdown:Create()
    self.Container = Instance.new("Frame")
    self.Container.Name = self.Name .. "Dropdown"
    self.Container.Size = UDim2.new(1, 0, 0, self.Description ~= "" and 68 or 52)
    self.Container.BackgroundColor3 = Color3.fromRGB(26, 30, 36) 
    self.Container.BorderSizePixel = 0
    self.Container.ClipsDescendants = true
    self.Container.Parent = self.Tab.Container
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(40, 45, 52)
    border.Thickness = 1
    border.Parent = self.Container
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12) 
    corner.Parent = self.Container
    self.Header = Instance.new("Frame")
    self.Header.Name = "Header"
    self.Header.Size = UDim2.new(1, 0, 0, self.Description ~= "" and 68 or 52)
    self.Header.BackgroundTransparency = 1
    self.Header.Parent = self.Container
    local success, Lucide = pcall(function()
        return require(script.Parent.lucide)
    end)
    self.DropdownIcon = Instance.new("ImageLabel")
    self.DropdownIcon.Name = "Icon"
    self.DropdownIcon.Size = UDim2.new(0, 22, 0, 22)
    self.DropdownIcon.Position = UDim2.new(0, 16, 0, self.Description ~= "" and 12 or 17)
    self.DropdownIcon.BackgroundTransparency = 1
    self.DropdownIcon.Image = (success and Lucide and Lucide["list"]) or "rbxassetid://10723433811"
    self.DropdownIcon.ImageColor3 = Color3.fromRGB(120, 140, 160)
    self.DropdownIcon.Parent = self.Header
    self.NameLabel = Instance.new("TextLabel")
    self.NameLabel.Name = "Name"
    self.NameLabel.Size = UDim2.new(0, 200, 0, 22)
    self.NameLabel.Position = UDim2.new(0, 44, 0, self.Description ~= "" and 8 or 15)
    self.NameLabel.BackgroundTransparency = 1
    self.NameLabel.Text = self.Name
    self.NameLabel.TextColor3 = Color3.fromRGB(240, 245, 250)
    self.NameLabel.TextSize = 15
    self.NameLabel.Font = Enum.Font.GothamSemibold
    self.NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.NameLabel.Parent = self.Header
    if self.Description ~= "" then
        self.DescriptionLabel = Instance.new("TextLabel")
        self.DescriptionLabel.Name = "Description"
        self.DescriptionLabel.Size = UDim2.new(0, 250, 0, 16)
        self.DescriptionLabel.Position = UDim2.new(0, 44, 0, 32)
        self.DescriptionLabel.BackgroundTransparency = 1
        self.DescriptionLabel.Text = self.Description
        self.DescriptionLabel.TextColor3 = Color3.fromRGB(160, 170, 180)
        self.DescriptionLabel.TextSize = 12
        self.DescriptionLabel.Font = Enum.Font.Gotham
        self.DescriptionLabel.TextXAlignment = Enum.TextXAlignment.Left
        self.DescriptionLabel.Parent = self.Header
    end
    if self.Multiselect then
        self.ClearButton = Instance.new("TextButton")
        self.ClearButton.Name = "ClearButton"
        self.ClearButton.Size = UDim2.new(0, 24, 0, 24)
        self.ClearButton.Position = UDim2.new(1, -60, 0.5, 0)
        self.ClearButton.AnchorPoint = Vector2.new(0, 0.5)
        self.ClearButton.BackgroundColor3 = Color3.fromRGB(70, 75, 82)
        self.ClearButton.Text = "✕"
        self.ClearButton.TextColor3 = Color3.fromRGB(200, 205, 210)
        self.ClearButton.TextSize = 12
        self.ClearButton.Font = Enum.Font.GothamBold
        self.ClearButton.BorderSizePixel = 0
        self.ClearButton.Parent = self.Header
        local clearCorner = Instance.new("UICorner")
        clearCorner.CornerRadius = UDim.new(0, 6)
        clearCorner.Parent = self.ClearButton
        self.ClearButton.MouseButton1Click:Connect(function()
            self:ClearAllSelections()
        end)
        self.ClearButton.MouseEnter:Connect(function()
            local hoverTween = TweenService:Create(
                self.ClearButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(220, 85, 85)}
            )
            hoverTween:Play()
        end)
        self.ClearButton.MouseLeave:Connect(function()
            local leaveTween = TweenService:Create(
                self.ClearButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(70, 75, 82)}
            )
            leaveTween:Play()
        end)
    end
    self.SelectedLabel = Instance.new("TextLabel")
    self.SelectedLabel.Name = "Selected"
    self.SelectedLabel.Size = UDim2.new(1, self.Multiselect and -120 or -90, 1, 0)
    self.SelectedLabel.Position = UDim2.new(1, -32, 0.5, 0)
    self.SelectedLabel.AnchorPoint = Vector2.new(1, 0.5)
    self.SelectedLabel.BackgroundTransparency = 1
    self.SelectedLabel.TextColor3 = Color3.fromRGB(180, 190, 200)
    self.SelectedLabel.TextSize = 13
    self.SelectedLabel.Font = Enum.Font.Gotham
    self.SelectedLabel.TextXAlignment = Enum.TextXAlignment.Right
    self.SelectedLabel.TextTruncate = Enum.TextTruncate.AtEnd
    self.SelectedLabel.Parent = self.Header
    self:UpdateSelectedText()
    self.ArrowIcon = Instance.new("ImageLabel")
    self.ArrowIcon.Name = "Arrow"
    self.ArrowIcon.Size = UDim2.new(0, 16, 0, 16)
    self.ArrowIcon.Position = UDim2.new(1, -20, 0.5, 0)
    self.ArrowIcon.AnchorPoint = Vector2.new(0, 0.5)
    self.ArrowIcon.BackgroundTransparency = 1
    self.ArrowIcon.Image = (success and Lucide and Lucide["chevron-down"]) or "rbxassetid://10709790948"
    self.ArrowIcon.ImageColor3 = Color3.fromRGB(140, 150, 160)
    self.ArrowIcon.Parent = self.Header
    self.DropdownButton = Instance.new("TextButton")
    self.DropdownButton.Name = "Button"
    self.DropdownButton.Size = UDim2.new(1, 0, 1, 0)
    self.DropdownButton.BackgroundTransparency = 1
    self.DropdownButton.Text = ""
    self.DropdownButton.Parent = self.Header
    self.SearchContainer = Instance.new("Frame")
    self.SearchContainer.Name = "SearchContainer"
    self.SearchContainer.Size = UDim2.new(1, -20, 0, 36)
    self.SearchContainer.Position = UDim2.new(0, 10, 0, (self.Description ~= "" and 68 or 52) + 8)
    self.SearchContainer.BackgroundColor3 = Color3.fromRGB(28, 33, 40)
    self.SearchContainer.BorderSizePixel = 0
    self.SearchContainer.Visible = false
    self.SearchContainer.Parent = self.Container
    local searchBorder = Instance.new("UIStroke")
    searchBorder.Color = Color3.fromRGB(50, 55, 62)
    searchBorder.Thickness = 1
    searchBorder.Parent = self.SearchContainer
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 6)
    searchCorner.Parent = self.SearchContainer
    self.SearchIcon = Instance.new("ImageLabel")
    self.SearchIcon.Name = "SearchIcon"
    self.SearchIcon.Size = UDim2.new(0, 16, 0, 16)
    self.SearchIcon.Position = UDim2.new(0, 12, 0.5, 0)
    self.SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
    self.SearchIcon.BackgroundTransparency = 1
    self.SearchIcon.Image = (success and Lucide and Lucide["search"]) or "rbxassetid://10709761530"
    self.SearchIcon.ImageColor3 = Color3.fromRGB(120, 130, 140)
    self.SearchIcon.Parent = self.SearchContainer
    if self.Multiselect then
        self.SelectAllButton = Instance.new("TextButton")
        self.SelectAllButton.Name = "SelectAllButton"
        self.SelectAllButton.Size = UDim2.new(0, 60, 0, 24)
        self.SelectAllButton.Position = UDim2.new(1, -66, 0.5, 0)
        self.SelectAllButton.AnchorPoint = Vector2.new(0, 0.5)
        self.SelectAllButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        self.SelectAllButton.Text = "All"
        self.SelectAllButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        self.SelectAllButton.TextSize = 11
        self.SelectAllButton.Font = Enum.Font.GothamBold
        self.SelectAllButton.BorderSizePixel = 0
        self.SelectAllButton.Parent = self.SearchContainer
        local selectAllCorner = Instance.new("UICorner")
        selectAllCorner.CornerRadius = UDim.new(0, 4)
        selectAllCorner.Parent = self.SelectAllButton
        self.SelectAllButton.MouseButton1Click:Connect(function()
            self:ToggleSelectAll()
        end)
        self.SelectAllButton.MouseEnter:Connect(function()
            local hoverTween = TweenService:Create(
                self.SelectAllButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(30, 140, 235)}
            )
            hoverTween:Play()
        end)
        self.SelectAllButton.MouseLeave:Connect(function()
            local leaveTween = TweenService:Create(
                self.SelectAllButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
            )
            leaveTween:Play()
        end)
        
        -- Initialize button text based on current selection state
        self:UpdateSelectAllButtonText()
    end
    self.SearchBox = Instance.new("TextBox")
    self.SearchBox.Name = "SearchBox"
    self.SearchBox.Size = UDim2.new(1, self.Multiselect and -110 or -40, 1, 0) 
    self.SearchBox.Position = UDim2.new(0, 36, 0, 0)
    self.SearchBox.BackgroundTransparency = 1
    self.SearchBox.Text = ""
    self.SearchBox.PlaceholderText = "Search options..."
    self.SearchBox.PlaceholderColor3 = Color3.fromRGB(120, 130, 140)
    self.SearchBox.TextColor3 = Color3.fromRGB(240, 245, 250)
    self.SearchBox.TextSize = 13
    self.SearchBox.Font = Enum.Font.Gotham
    self.SearchBox.TextXAlignment = Enum.TextXAlignment.Left
    self.SearchBox.Parent = self.SearchContainer
    self.SearchBox.Changed:Connect(function(property)
        if property == "Text" then
            self:FilterItems(self.SearchBox.Text)
        end
    end)
    self.Content = Instance.new("ScrollingFrame")
    self.Content.Name = "Content"
    self.Content.Size = UDim2.new(1, -20, 0, math.min(240, #self.Items * 44)) 
    self.Content.Position = UDim2.new(0, 10, 0, (self.Description ~= "" and 68 or 52) + 52)
    self.Content.BackgroundTransparency = 1
    self.Content.BorderSizePixel = 0
    self.Content.ScrollBarThickness = 4
    self.Content.ScrollBarImageColor3 = Color3.fromRGB(80, 90, 100)
    self.Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    self.Content.Visible = false
    self.Content.Parent = self.Container
    self.ContentLayout = Instance.new("UIListLayout")
    self.ContentLayout.FillDirection = Enum.FillDirection.Vertical
    self.ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.ContentLayout.Padding = UDim.new(0, 4) 
    self.ContentLayout.Parent = self.Content
    self:CreateItems()
    self.DropdownButton.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    self.DropdownButton.MouseEnter:Connect(function()
        if not self.Open then
            local hoverTween = TweenService:Create(
                self.Container,
                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(32, 37, 44)}
            )
            hoverTween:Play()
            local borderTween = TweenService:Create(
                border,
                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Color = Color3.fromRGB(0, 120, 215)}
            )
            borderTween:Play()
        end
    end)
    self.DropdownButton.MouseLeave:Connect(function()
        if not self.Open then
            local leaveTween = TweenService:Create(
                self.Container,
                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(26, 30, 36)}
            )
            leaveTween:Play()
            local borderTween = TweenService:Create(
                border,
                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Color = Color3.fromRGB(40, 45, 52)}
            )
            borderTween:Play()
        end
    end)
    UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and self.Open then
            local mouse = game.Players.LocalPlayer:GetMouse()
            local containerPos = self.Container.AbsolutePosition
            local containerSize = self.Container.AbsoluteSize
            if mouse.X < containerPos.X or mouse.X > containerPos.X + containerSize.X or
               mouse.Y < containerPos.Y or mouse.Y > containerPos.Y + containerSize.Y then
                self:Toggle(false)
            end
        end
    end)
    return self
end
function Dropdown:CreateItems()
    for _, child in ipairs(self.Content:GetChildren()) do
        if child:IsA("Frame") and child.Name:find("Item_") then
            child:Destroy()
        end
    end
    local itemsToShow = #self.FilteredItems > 0 and self.FilteredItems or self.Items
    for i, item in ipairs(itemsToShow) do
        local itemContainer = Instance.new("Frame")
        itemContainer.Name = "Item_" .. i
        itemContainer.Size = UDim2.new(1, 0, 0, 40) 
        itemContainer.BackgroundColor3 = Color3.fromRGB(28, 33, 40)
        itemContainer.BorderSizePixel = 0
        itemContainer.LayoutOrder = i
        itemContainer.Parent = self.Content
        local itemCorner = Instance.new("UICorner")
        itemCorner.CornerRadius = UDim.new(0, 6)
        itemCorner.Parent = itemContainer
        local itemButton = Instance.new("TextButton")
        itemButton.Name = "Button"
        itemButton.Size = UDim2.new(1, 0, 1, 0)
        itemButton.BackgroundTransparency = 1
        itemButton.Text = ""
        itemButton.Parent = itemContainer
        local itemText = Instance.new("TextLabel")
        itemText.Name = "Text"
        itemText.Size = UDim2.new(1, self.Multiselect and -50 or -40, 1, 0)
        itemText.Position = UDim2.new(0, 16, 0, 0)
        itemText.BackgroundTransparency = 1
        itemText.Text = item
        itemText.TextColor3 = Color3.fromRGB(220, 230, 240)
        itemText.TextSize = 13
        itemText.Font = Enum.Font.Gotham
        itemText.TextXAlignment = Enum.TextXAlignment.Left
        itemText.TextYAlignment = Enum.TextYAlignment.Center
        itemText.Parent = itemContainer
        if self.Multiselect then
            local checkboxContainer = Instance.new("Frame")
            checkboxContainer.Name = "CheckboxContainer"
            checkboxContainer.Size = UDim2.new(0, 20, 0, 20)
            checkboxContainer.Position = UDim2.new(1, -30, 0.5, 0)
            checkboxContainer.AnchorPoint = Vector2.new(0, 0.5)
            checkboxContainer.BackgroundColor3 = self.Selected[item] == true and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(60, 65, 72)
            checkboxContainer.BorderSizePixel = 0
            checkboxContainer.Parent = itemContainer
            local checkboxCorner = Instance.new("UICorner")
            checkboxCorner.CornerRadius = UDim.new(0, 4)
            checkboxCorner.Parent = checkboxContainer
            local checkboxBorder = Instance.new("UIStroke")
            checkboxBorder.Color = self.Selected[item] == true and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(100, 105, 112)
            checkboxBorder.Thickness = 1
            checkboxBorder.Parent = checkboxContainer
            local checkmark = Instance.new("TextLabel")
            checkmark.Name = "Checkmark"
            checkmark.Size = UDim2.new(1, 0, 1, 0)
            checkmark.BackgroundTransparency = 1
            checkmark.Text = "✓"
            checkmark.TextColor3 = Color3.fromRGB(255, 255, 255)
            checkmark.TextSize = 12
            checkmark.Font = Enum.Font.GothamBold
            checkmark.TextXAlignment = Enum.TextXAlignment.Center
            checkmark.TextYAlignment = Enum.TextYAlignment.Center
            checkmark.Visible = self.Selected[item] == true
            checkmark.Parent = checkboxContainer
        else
            local radioContainer = Instance.new("Frame")
            radioContainer.Name = "RadioContainer"
            radioContainer.Size = UDim2.new(0, 18, 0, 18)
            radioContainer.Position = UDim2.new(1, -28, 0.5, 0)
            radioContainer.AnchorPoint = Vector2.new(0, 0.5)
            radioContainer.BackgroundColor3 = Color3.fromRGB(60, 65, 72)
            radioContainer.BorderSizePixel = 0
            radioContainer.Parent = itemContainer
            local radioCorner = Instance.new("UICorner")
            radioCorner.CornerRadius = UDim.new(1, 0)
            radioCorner.Parent = radioContainer
            local radioBorder = Instance.new("UIStroke")
            radioBorder.Color = self.Selected == item and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(100, 105, 112)
            radioBorder.Thickness = 1
            radioBorder.Parent = radioContainer
            local radioDot = Instance.new("Frame")
            radioDot.Name = "RadioDot"
            radioDot.Size = UDim2.new(0, 8, 0, 8)
            radioDot.Position = UDim2.new(0.5, 0, 0.5, 0)
            radioDot.AnchorPoint = Vector2.new(0.5, 0.5)
            radioDot.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
            radioDot.BorderSizePixel = 0
            radioDot.Visible = self.Selected == item
            radioDot.Parent = radioContainer
            local dotCorner = Instance.new("UICorner")
            dotCorner.CornerRadius = UDim.new(1, 0)
            dotCorner.Parent = radioDot
        end
        itemButton.MouseButton1Click:Connect(function()
            self:SelectItem(item)
        end)
        itemButton.MouseEnter:Connect(function()
            local hoverTween = TweenService:Create(
                itemContainer,
                TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(40, 45, 52)}
            )
            hoverTween:Play()
            local textTween = TweenService:Create(
                itemText,
                TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {TextColor3 = Color3.fromRGB(255, 255, 255)}
            )
            textTween:Play()
        end)
        itemButton.MouseLeave:Connect(function()
            local leaveTween = TweenService:Create(
                itemContainer,
                TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(28, 33, 40)}
            )
            leaveTween:Play()
            local textTween = TweenService:Create(
                itemText,
                TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {TextColor3 = Color3.fromRGB(220, 230, 240)}
            )
            textTween:Play()
        end)
    end
end
function Dropdown:SelectItem(item)
    if self.Multiselect then
        if self.Selected[item] then
            self.Selected[item] = nil 
        else
            self.Selected[item] = true 
        end
        for _, child in ipairs(self.Content:GetChildren()) do
            if child:IsA("Frame") and child.Name:find("Item_") and child.Text.Text == item then
                local checkboxContainer = child:FindFirstChild("CheckboxContainer")
                if checkboxContainer then
                    local checkmark = checkboxContainer:FindFirstChild("Checkmark")
                    local border = checkboxContainer:FindFirstChild("UIStroke")
                    if checkmark then
                        checkmark.Visible = self.Selected[item] == true
                    end
                    local bgTween = TweenService:Create(
                        checkboxContainer,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {BackgroundColor3 = self.Selected[item] == true and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(60, 65, 72)}
                    )
                    bgTween:Play()
                    if border then
                        local borderTween = TweenService:Create(
                            border,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                            {Color = self.Selected[item] == true and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(100, 105, 112)}
                        )
                        borderTween:Play()
                    end
                end
                break
            end
        end
        self:UpdateSelectedText()
        self:UpdateSelectAllButtonText()
        local selectedItems = {}
        for selectedItem, selected in pairs(self.Selected) do
            if selected == true then 
                table.insert(selectedItems, selectedItem)
            end
        end
        -- Save to config if enabled
        if self.Tab.Window and self.Tab.Window.ConfigEnabled then
            self.Tab.Window:SaveComponentConfig(self.Tab.Name, self.Name, selectedItems)
        end
        self.Callback(selectedItems)
    else
        local oldSelected = self.Selected
        self.Selected = item
        for _, child in ipairs(self.Content:GetChildren()) do
            if child:IsA("Frame") and child.Name:find("Item_") then
                local radioContainer = child:FindFirstChild("RadioContainer")
                if radioContainer then
                    local radioDot = radioContainer:FindFirstChild("RadioDot")
                    local border = radioContainer:FindFirstChild("UIStroke")
                    local isSelected = child.Text.Text == item
                    if radioDot then
                        radioDot.Visible = isSelected
                    end
                    if border then
                        local borderTween = TweenService:Create(
                            border,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                            {Color = isSelected and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(100, 105, 112)}
                        )
                        borderTween:Play()
                    end
                end
            end
        end
        self:UpdateSelectedText()
        self:Toggle(false)
        -- Save to config if enabled
        if self.Tab.Window and self.Tab.Window.ConfigEnabled then
            self.Tab.Window:SaveComponentConfig(self.Tab.Name, self.Name, item)
        end
        self.Callback(item)
    end
end
function Dropdown:UpdateSelectedText()
    if self.Multiselect then
        local count = 0
        local selectedText = ""
        local selectedItems = {}
        for item, selected in pairs(self.Selected) do
            if selected == true then 
                count = count + 1
                table.insert(selectedItems, item)
            end
        end
        if count == 0 then
            selectedText = "Select options..."
            self.SelectedLabel.TextColor3 = Color3.fromRGB(120, 130, 140)
        elseif count == 1 then
            selectedText = selectedItems[1]
            self.SelectedLabel.TextColor3 = Color3.fromRGB(180, 190, 200)
        elseif count <= 3 then
            selectedText = table.concat(selectedItems, ", ")
            self.SelectedLabel.TextColor3 = Color3.fromRGB(180, 190, 200)
        else
            selectedText = selectedItems[1] .. ", " .. selectedItems[2] .. " (+" .. (count - 2) .. " more)"
            self.SelectedLabel.TextColor3 = Color3.fromRGB(180, 190, 200)
        end
        self.SelectedLabel.Text = selectedText
    else
        if self.Selected == "" then
            self.SelectedLabel.Text = "Select option..."
            self.SelectedLabel.TextColor3 = Color3.fromRGB(120, 130, 140)
        else
            self.SelectedLabel.Text = self.Selected
            self.SelectedLabel.TextColor3 = Color3.fromRGB(180, 190, 200)
        end
    end
end
function Dropdown:Toggle(state)
    if state ~= nil then
        self.Open = state
    else
        self.Open = not self.Open
    end
    local baseHeight = self.Description ~= "" and 68 or 52
    local searchHeight = 44
    local contentHeight = math.min(240, #self.Items * 44) 
    if self.Open then
        self.SearchContainer.Visible = true
        self.Content.Visible = true
        local expandTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(1, 0, 0, baseHeight + searchHeight + contentHeight + 16)}
        )
        expandTween:Play()
        local arrowTween = TweenService:Create(
            self.ArrowIcon,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Rotation = 180}
        )
        arrowTween:Play()
        local bgTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(38, 43, 50)}
        )
        bgTween:Play()
        wait(0.1)
        self.SearchBox:CaptureFocus()
    else
        local collapseTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(1, 0, 0, baseHeight)}
        )
        collapseTween:Play()
        local arrowTween = TweenService:Create(
            self.ArrowIcon,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Rotation = 0}
        )
        arrowTween:Play()
        local bgTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(32, 37, 44)}
        )
        bgTween:Play()
        wait(0.25)
        self.SearchContainer.Visible = false
        self.Content.Visible = false
        self.SearchBox.Text = ""
        self:FilterItems("")
    end
end
function Dropdown:SetItems(items)
    self.Items = items
    self:CreateItems()
    if not self.Multiselect then
        local found = false
        for _, item in ipairs(items) do
            if item == self.Selected then
                found = true
                break
            end
        end
        if not found and #items > 0 then
            self.Selected = items[1]
            self:UpdateSelectedText()
        elseif not found then
            self.Selected = ""
            self:UpdateSelectedText()
        end
    else
        local newSelected = {}
        for _, item in ipairs(items) do
            if self.Selected[item] then
                newSelected[item] = true
            end
        end
        self.Selected = newSelected
        self:UpdateSelectedText()
        self:UpdateSelectAllButtonText()
    end
    return self
end
function Dropdown:FilterItems(searchText)
    searchText = searchText:lower()
    self.FilteredItems = {}
    for _, item in ipairs(self.Items) do
        if searchText == "" or item:lower():find(searchText) then
            table.insert(self.FilteredItems, item)
        end
    end
    self:CreateItems()
    local contentHeight = math.min(240, #self.FilteredItems * 44) 
    local baseHeight = self.Description ~= "" and 68 or 52
    local searchHeight = 44
    if self.Open then
        local sizeTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(1, 0, 0, baseHeight + searchHeight + contentHeight + 16)}
        )
        sizeTween:Play()
        local contentSizeTween = TweenService:Create(
            self.Content,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(1, -20, 0, contentHeight)}
        )
        contentSizeTween:Play()
    end
end
function Dropdown:ClearAllSelections()
    if not self.Multiselect then return end
    self.Selected = {}
    for _, child in ipairs(self.Content:GetChildren()) do
        if child:IsA("Frame") and child.Name:find("Item_") then
            local checkboxContainer = child:FindFirstChild("CheckboxContainer")
            if checkboxContainer then
                local checkmark = checkboxContainer:FindFirstChild("Checkmark")
                local border = checkboxContainer:FindFirstChild("UIStroke")
                if checkmark then
                    checkmark.Visible = false
                end
                local bgTween = TweenService:Create(
                    checkboxContainer,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(60, 65, 72)}
                )
                bgTween:Play()
                if border then
                    local borderTween = TweenService:Create(
                        border,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {Color = Color3.fromRGB(100, 105, 112)}
                    )
                    borderTween:Play()
                end
            end
        end
    end
    self:UpdateSelectedText()
    self:UpdateSelectAllButtonText()
    -- Save to config if enabled
    if self.Tab.Window and self.Tab.Window.ConfigEnabled then
        self.Tab.Window:SaveComponentConfig(self.Tab.Name, self.Name, {})
    end
    self.Callback({})
end
function Dropdown:SelectAllItems()
    if not self.Multiselect then return end
    for _, item in ipairs(self.Items) do
        self.Selected[item] = true
    end
    for _, child in ipairs(self.Content:GetChildren()) do
        if child:IsA("Frame") and child.Name:find("Item_") then
            local itemText = child:FindFirstChild("Text")
            if itemText then
                local item = itemText.Text
                local checkboxContainer = child:FindFirstChild("CheckboxContainer")
                if checkboxContainer then
                    local checkmark = checkboxContainer:FindFirstChild("Checkmark")
                    local border = checkboxContainer:FindFirstChild("UIStroke")
                    if checkmark then
                        checkmark.Visible = true
                    end
                    local bgTween = TweenService:Create(
                        checkboxContainer,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
                    )
                    bgTween:Play()
                    if border then
                        local borderTween = TweenService:Create(
                            border,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                            {Color = Color3.fromRGB(0, 120, 215)}
                        )
                        borderTween:Play()
                    end
                end
            end
        end
    end
    self:UpdateSelectedText()
    self:UpdateSelectAllButtonText()
    local selectedItems = {}
    for item, selected in pairs(self.Selected) do
        if selected == true then 
            table.insert(selectedItems, item)
        end
    end
    -- Save to config if enabled
    if self.Tab.Window and self.Tab.Window.ConfigEnabled then
        self.Tab.Window:SaveComponentConfig(self.Tab.Name, self.Name, selectedItems)
    end
    self.Callback(selectedItems)
end
function Dropdown:ToggleSelectAll()
    if not self.Multiselect then return end
    
    -- Check if all items are currently selected
    local allSelected = true
    for _, item in ipairs(self.Items) do
        if not self.Selected[item] then
            allSelected = false
            break
        end
    end
    
    if allSelected then
        -- If all are selected, clear all selections
        self:ClearAllSelections()
    else
        -- If not all are selected, select all
        self:SelectAllItems()
    end
    
    -- Update the button text based on new state
    self:UpdateSelectAllButtonText()
end
function Dropdown:SetValue(value)
    if self.Multiselect then
        self.Selected = {}
        if type(value) == "table" then
            for _, item in ipairs(value) do
                self.Selected[item] = true
            end
        end
    else
        self.Selected = value
    end
    self:UpdateSelectedText()
    if self.Multiselect then
        self:UpdateSelectAllButtonText()
    end
    return self
end
function Dropdown:UpdateSelectAllButtonText()
    if not self.Multiselect or not self.SelectAllButton then return end
    
    -- Check if all items are currently selected
    local allSelected = true
    for _, item in ipairs(self.Items) do
        if not self.Selected[item] then
            allSelected = false
            break
        end
    end
    
    -- Update button text
    if allSelected then
        self.SelectAllButton.Text = "None"
    else
        self.SelectAllButton.Text = "All"
    end
end
return Dropdown
end)() end,
    function()local wax,script,require=ImportGlobals(7)local ImportGlobals return (function(...)local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local FloatingControls = {}
FloatingControls.__index = FloatingControls
function FloatingControls.new(options, library)
    local self = setmetatable({}, FloatingControls)
    self.Library = library
    self.Title = options.Title or "Quick Controls"
    self.Controls = {}
    self.IsVisible = true
    self.IsMinimized = false
    self.IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    self:CreateGui()
    if self.IsMobile then
        local MobileFloatingIcon = require(script.Parent.MobileFloatingIcon)
        self.MobileIcon = MobileFloatingIcon.new({
            IconText = options.IconText or "C",
            IconColor = options.IconColor or Color3.fromRGB(0, 120, 215),
            Size = options.IconSize or 60
        }, self)
        self:Hide()
    end
    return self
end
function FloatingControls:CreateGui()
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "FloatingControls"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ScreenGui.Parent = playerGui
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "FloatingPanel"
    self.MainFrame.Size = UDim2.new(0, 280, 0, 60) 
    self.MainFrame.Position = UDim2.new(0, 20, 0, 200) 
    self.MainFrame.BackgroundColor3 = Color3.fromRGB(20, 25, 32) 
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Parent = self.ScreenGui
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = self.MainFrame
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(0, 120, 215)
    border.Thickness = 2
    border.Transparency = 0.3
    border.Parent = self.MainFrame
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 8, 1, 8)
    shadow.Position = UDim2.new(0, -4, 0, -4)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.6
    shadow.BorderSizePixel = 0
    shadow.ZIndex = self.MainFrame.ZIndex - 1
    shadow.Parent = self.MainFrame
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 12)
    shadowCorner.Parent = shadow
    self.HeaderBar = Instance.new("Frame")
    self.HeaderBar.Name = "HeaderBar"
    self.HeaderBar.Size = UDim2.new(1, 0, 0, 40)
    self.HeaderBar.BackgroundColor3 = Color3.fromRGB(15, 20, 27)
    self.HeaderBar.BorderSizePixel = 0
    self.HeaderBar.Parent = self.MainFrame
    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = self.HeaderBar
    local headerMask = Instance.new("Frame")
    headerMask.Size = UDim2.new(1, 0, 0, 12)
    headerMask.Position = UDim2.new(0, 0, 1, -12)
    headerMask.BackgroundColor3 = Color3.fromRGB(15, 20, 27)
    headerMask.BorderSizePixel = 0
    headerMask.Parent = self.HeaderBar
    self.AppIcon = Instance.new("Frame")
    self.AppIcon.Size = UDim2.new(0, 30, 0, 30)
    self.AppIcon.Position = UDim2.new(0, 12, 0.5, 0)
    self.AppIcon.AnchorPoint = Vector2.new(0, 0.5)
    self.AppIcon.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    self.AppIcon.BorderSizePixel = 0
    self.AppIcon.Parent = self.HeaderBar
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 8)
    iconCorner.Parent = self.AppIcon
    local iconText = Instance.new("TextLabel")
    iconText.Size = UDim2.new(1, 0, 1, 0)
    iconText.BackgroundTransparency = 1
    iconText.Text = "C"
    iconText.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconText.TextSize = 18
    iconText.Font = Enum.Font.GothamBold
    iconText.TextXAlignment = Enum.TextXAlignment.Center
    iconText.TextYAlignment = Enum.TextYAlignment.Center
    iconText.Parent = self.AppIcon
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Size = UDim2.new(0, 120, 1, 0)
    self.TitleLabel.Position = UDim2.new(0, 44, 0, 0)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = self.Title
    self.TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.TitleLabel.TextSize = 14
    self.TitleLabel.Font = Enum.Font.GothamSemibold
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
    self.TitleLabel.Parent = self.HeaderBar
    self.ExpandButton = Instance.new("TextButton")
    self.ExpandButton.Size = UDim2.new(0, 28, 0, 28)
    self.ExpandButton.Position = UDim2.new(1, -70, 0.5, 0)
    self.ExpandButton.AnchorPoint = Vector2.new(0, 0.5)
    self.ExpandButton.BackgroundColor3 = Color3.fromRGB(45, 55, 65)
    self.ExpandButton.Text = "▼"
    self.ExpandButton.TextColor3 = Color3.fromRGB(200, 220, 240)
    self.ExpandButton.TextSize = 12
    self.ExpandButton.Font = Enum.Font.GothamBold
    self.ExpandButton.BorderSizePixel = 0
    self.ExpandButton.Parent = self.HeaderBar
    local expandCorner = Instance.new("UICorner")
    expandCorner.CornerRadius = UDim.new(0, 6)
    expandCorner.Parent = self.ExpandButton
    self.HideButton = Instance.new("TextButton")
    self.HideButton.Size = UDim2.new(0, 28, 0, 28)
    self.HideButton.Position = UDim2.new(1, -36, 0.5, 0)
    self.HideButton.AnchorPoint = Vector2.new(0, 0.5)
    self.HideButton.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
    self.HideButton.Text = "×"
    self.HideButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.HideButton.TextSize = 14
    self.HideButton.Font = Enum.Font.GothamBold
    self.HideButton.BorderSizePixel = 0
    self.HideButton.Parent = self.HeaderBar
    local hideCorner = Instance.new("UICorner")
    hideCorner.CornerRadius = UDim.new(0, 6)
    hideCorner.Parent = self.HideButton
    self.ContentContainer = Instance.new("ScrollingFrame")
    self.ContentContainer.Name = "ContentContainer"
    self.ContentContainer.Size = UDim2.new(1, 0, 1, -40)
    self.ContentContainer.Position = UDim2.new(0, 0, 0, 40)
    self.ContentContainer.BackgroundColor3 = Color3.fromRGB(20, 25, 32)
    self.ContentContainer.BorderSizePixel = 0
    self.ContentContainer.ScrollBarThickness = 4
    self.ContentContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 120, 215)
    self.ContentContainer.ScrollBarImageTransparency = 0.3
    self.ContentContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.ContentContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    self.ContentContainer.Visible = false
    self.ContentContainer.Parent = self.MainFrame
    self.ContentLayout = Instance.new("UIListLayout")
    self.ContentLayout.FillDirection = Enum.FillDirection.Vertical
    self.ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.ContentLayout.Padding = UDim.new(0, 8)
    self.ContentLayout.Parent = self.ContentContainer
    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingAll = UDim.new(0, 12)
    contentPadding.Parent = self.ContentContainer
    self:MakeDraggable()
    self.ExpandButton.MouseButton1Click:Connect(function()
        self:ToggleExpanded()
    end)
    self.HideButton.MouseButton1Click:Connect(function()
        self:Hide()
    end)
    self:SetupHoverEffects()
    return self
end
function FloatingControls:MakeDraggable()
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    local function updateInput(input)
        local delta = input.Position - dragStart
        self.MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    self.HeaderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    self.HeaderBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)
end
function FloatingControls:SetupHoverEffects()
    self.ExpandButton.MouseEnter:Connect(function()
        local tween = TweenService:Create(
            self.ExpandButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
        )
        tween:Play()
    end)
    self.ExpandButton.MouseLeave:Connect(function()
        local tween = TweenService:Create(
            self.ExpandButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(45, 55, 65)}
        )
        tween:Play()
    end)
    self.HideButton.MouseEnter:Connect(function()
        local tween = TweenService:Create(
            self.HideButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(255, 90, 90)}
        )
        tween:Play()
    end)
    self.HideButton.MouseLeave:Connect(function()
        local tween = TweenService:Create(
            self.HideButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(200, 70, 70)}
        )
        tween:Play()
    end)
end
function FloatingControls:ToggleExpanded()
    if self.IsMinimized then
        self.IsMinimized = false
        self.ExpandButton.Text = "▼"
        self.ContentContainer.Visible = true
        local contentHeight = math.max(200, math.min(400, self.ContentLayout.AbsoluteContentSize.Y + 64))
        local expandTween = TweenService:Create(
            self.MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 280, 0, contentHeight)}
        )
        expandTween:Play()
    else
        self.IsMinimized = true
        self.ExpandButton.Text = "▲"
        local minimizeTween = TweenService:Create(
            self.MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 280, 0, 40)}
        )
        minimizeTween:Play()
        minimizeTween.Completed:Connect(function()
            self.ContentContainer.Visible = false
        end)
    end
end
function FloatingControls:Show()
    self.IsVisible = true
    self.ScreenGui.Enabled = true
end
function FloatingControls:Hide()
    self.IsVisible = false
    self.ScreenGui.Enabled = false
end
function FloatingControls:Toggle()
    if self.IsVisible then
        self:Hide()
    else
        self:Show()
    end
end
function FloatingControls:AddToggle(options)
    options = options or {}
    local name = options.Name or "Toggle"
    local description = options.Description or ""
    local default = options.Default or false
    local keybind = options.Keybind
    local callback = options.Callback or function() end
    local container = Instance.new("Frame")
    container.Name = name .. "Toggle"
    container.Size = UDim2.new(1, 0, 0, description ~= "" and 60 or 44)
    container.BackgroundColor3 = Color3.fromRGB(26, 30, 36)
    container.BorderSizePixel = 0
    container.Parent = self.ContentContainer
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 8)
    containerCorner.Parent = container
    local containerBorder = Instance.new("UIStroke")
    containerBorder.Color = Color3.fromRGB(40, 45, 52)
    containerBorder.Thickness = 1
    containerBorder.Parent = container
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 32, 0, 32)
    icon.Position = UDim2.new(0, 12, 0, description ~= "" and 6 or 6)
    icon.BackgroundTransparency = 1
    icon.Text = "⚡"
    icon.TextColor3 = Color3.fromRGB(120, 140, 160)
    icon.TextSize = 24
    icon.Font = Enum.Font.GothamBold
    icon.TextXAlignment = Enum.TextXAlignment.Center
    icon.TextYAlignment = Enum.TextYAlignment.Center
    icon.Parent = container
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0, 120, 0, 18)
    nameLabel.Position = UDim2.new(0, 40, 0, description ~= "" and 6 or 13)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(240, 245, 250)
    nameLabel.TextSize = 13
    nameLabel.Font = Enum.Font.GothamSemibold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = container
    if description ~= "" then
        local descLabel = Instance.new("TextLabel")
        descLabel.Size = UDim2.new(0, 150, 0, 14)
        descLabel.Position = UDim2.new(0, 40, 0, 26)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = description
        descLabel.TextColor3 = Color3.fromRGB(160, 170, 180)
        descLabel.TextSize = 10
        descLabel.Font = Enum.Font.Gotham
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Parent = container
    end
    local keybindLabel
    if keybind then
        keybindLabel = Instance.new("TextLabel")
        keybindLabel.Size = UDim2.new(0, 44, 0, 26)
        keybindLabel.Position = UDim2.new(1, -92, 0.5, 0)
        keybindLabel.AnchorPoint = Vector2.new(0, 0.5)
        keybindLabel.BackgroundColor3 = Color3.fromRGB(50, 55, 62)
        keybindLabel.Text = tostring(keybind):gsub("Enum.KeyCode.", ""):upper()
        keybindLabel.TextColor3 = Color3.fromRGB(200, 205, 210)
        keybindLabel.TextSize = 14
        keybindLabel.Font = Enum.Font.GothamBold
        keybindLabel.TextXAlignment = Enum.TextXAlignment.Center
        keybindLabel.TextYAlignment = Enum.TextYAlignment.Center
        keybindLabel.BorderSizePixel = 0
        keybindLabel.Parent = container
        local keybindCorner = Instance.new("UICorner")
        keybindCorner.CornerRadius = UDim.new(0, 6)
        keybindCorner.Parent = keybindLabel
    end
    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, 36, 0, 20)
    toggleBg.Position = UDim2.new(1, keybind and -40 or -46, 0.5, 0)
    toggleBg.AnchorPoint = Vector2.new(0, 0.5)
    toggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = container
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleBg
    local toggleIndicator = Instance.new("Frame")
    toggleIndicator.Size = UDim2.new(0, 16, 0, 16)
    toggleIndicator.Position = UDim2.new(0, 2, 0.5, 0)
    toggleIndicator.AnchorPoint = Vector2.new(0, 0.5)
    toggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleIndicator.BorderSizePixel = 0
    toggleIndicator.Parent = toggleBg
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(1, 0)
    indicatorCorner.Parent = toggleIndicator
    local isToggled = default
    local function updateToggle(value, animate)
        if animate == nil then animate = true end
        isToggled = value
        if animate then
            local bgTween = TweenService:Create(
                toggleBg,
                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {BackgroundColor3 = isToggled and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(60, 60, 65)}
            )
            bgTween:Play()
            local indicatorTween = TweenService:Create(
                toggleIndicator,
                TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Position = UDim2.new(0, isToggled and 18 or 2, 0.5, 0)}
            )
            indicatorTween:Play()
        else
            toggleBg.BackgroundColor3 = isToggled and Color3.fromRGB(0, 120, 215) or Color3.fromRGB(60, 60, 65)
            toggleIndicator.Position = UDim2.new(0, isToggled and 18 or 2, 0.5, 0)
        end
        callback(isToggled)
    end
    updateToggle(default, false)
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(1, keybind and -40 or 0, 1, 0)
    toggleButton.BackgroundTransparency = 1
    toggleButton.Text = ""
    toggleButton.Parent = container
    toggleButton.MouseButton1Click:Connect(function()
        updateToggle(not isToggled)
    end)
    if keybind then
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == keybind then
                updateToggle(not isToggled)
            end
        end)
    end
    toggleButton.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(
            container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(32, 37, 44)}
        )
        hoverTween:Play()
    end)
    toggleButton.MouseLeave:Connect(function()
        local leaveTween = TweenService:Create(
            container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(26, 30, 36)}
        )
        leaveTween:Play()
    end)
    local control = {
        Type = "Toggle",
        Name = name,
        Container = container,
        GetValue = function() return isToggled end,
        SetValue = updateToggle
    }
    table.insert(self.Controls, control)
    if self.MobileIcon then
        spawn(function()
            wait(0.1) 
            self.MobileIcon:UpdateBadge()
        end)
    end
    return control
end
function FloatingControls:AddButton(options)
    options = options or {}
    local name = options.Name or "Button"
    local description = options.Description or ""
    local keybind = options.Keybind
    local callback = options.Callback or function() end
    local container = Instance.new("Frame")
    container.Name = name .. "Button"
    container.Size = UDim2.new(1, 0, 0, description ~= "" and 60 or 44)
    container.BackgroundColor3 = Color3.fromRGB(32, 37, 44)
    container.BorderSizePixel = 0
    container.Parent = self.ContentContainer
    local containerCorner = Instance.new("UICorner")
    containerCorner.CornerRadius = UDim.new(0, 8)
    containerCorner.Parent = container
    local containerBorder = Instance.new("UIStroke")
    containerBorder.Color = Color3.fromRGB(55, 60, 67)
    containerBorder.Thickness = 1
    containerBorder.Parent = container
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 32, 0, 32)
    icon.Position = UDim2.new(0, 12, 0, description ~= "" and 6 or 6)
    icon.BackgroundTransparency = 1
    icon.Text = "🎯"
    icon.TextColor3 = Color3.fromRGB(120, 140, 160)
    icon.TextSize = 24
    icon.Font = Enum.Font.GothamBold
    icon.TextXAlignment = Enum.TextXAlignment.Center
    icon.TextYAlignment = Enum.TextYAlignment.Center
    icon.Parent = container
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0, 120, 0, 18)
    nameLabel.Position = UDim2.new(0, 40, 0, description ~= "" and 6 or 13)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(240, 245, 250)
    nameLabel.TextSize = 13
    nameLabel.Font = Enum.Font.GothamSemibold
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = container
    if description ~= "" then
        local descLabel = Instance.new("TextLabel")
        descLabel.Size = UDim2.new(0, 150, 0, 14)
        descLabel.Position = UDim2.new(0, 40, 0, 26)
        descLabel.BackgroundTransparency = 1
        descLabel.Text = description
        descLabel.TextColor3 = Color3.fromRGB(160, 170, 180)
        descLabel.TextSize = 10
        descLabel.Font = Enum.Font.Gotham
        descLabel.TextXAlignment = Enum.TextXAlignment.Left
        descLabel.Parent = container
    end
    if keybind then
        local keybindLabel = Instance.new("TextLabel")
        keybindLabel.Size = UDim2.new(0, 44, 0, 26)
        keybindLabel.Position = UDim2.new(1, -52, 0.5, 0)
        keybindLabel.AnchorPoint = Vector2.new(0, 0.5)
        keybindLabel.BackgroundColor3 = Color3.fromRGB(50, 55, 62)
        keybindLabel.Text = tostring(keybind):gsub("Enum.KeyCode.", ""):upper()
        keybindLabel.TextColor3 = Color3.fromRGB(200, 205, 210)
        keybindLabel.TextSize = 14
        keybindLabel.Font = Enum.Font.GothamBold
        keybindLabel.TextXAlignment = Enum.TextXAlignment.Center
        keybindLabel.TextYAlignment = Enum.TextYAlignment.Center
        keybindLabel.BorderSizePixel = 0
        keybindLabel.Parent = container
        local keybindCorner = Instance.new("UICorner")
        keybindCorner.CornerRadius = UDim.new(0, 6)
        keybindCorner.Parent = keybindLabel
    end
    local actionIcon = Instance.new("TextLabel")
    actionIcon.Size = UDim2.new(0, 20, 0, 20)
    actionIcon.Position = UDim2.new(1, keybind and -22 or -28, 0.5, 0)
    actionIcon.AnchorPoint = Vector2.new(0, 0.5)
    actionIcon.BackgroundTransparency = 1
    actionIcon.Text = "▶"
    actionIcon.TextColor3 = Color3.fromRGB(240, 245, 250)
    actionIcon.TextSize = 14
    actionIcon.Font = Enum.Font.GothamBold
    actionIcon.TextXAlignment = Enum.TextXAlignment.Center
    actionIcon.TextYAlignment = Enum.TextYAlignment.Center
    actionIcon.Parent = container
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = container
    button.MouseButton1Click:Connect(function()
        local ripple = Instance.new("Frame")
        ripple.AnchorPoint = Vector2.new(0.5, 0.5)
        ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
        ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ripple.BackgroundTransparency = 0.8
        ripple.BorderSizePixel = 0
        ripple.Size = UDim2.new(0, 0, 0, 0)
        ripple.Parent = container
        local rippleCorner = Instance.new("UICorner")
        rippleCorner.CornerRadius = UDim.new(1, 0)
        rippleCorner.Parent = ripple
        local expandTween = TweenService:Create(
            ripple,
            TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(1.5, 0, 1.5, 0), BackgroundTransparency = 1}
        )
        expandTween:Play()
        expandTween.Completed:Connect(function()
            ripple:Destroy()
        end)
        callback()
    end)
    if keybind then
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == keybind then
                callback()
            end
        end)
    end
    button.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(
            container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(38, 43, 50)}
        )
        hoverTween:Play()
    end)
    button.MouseLeave:Connect(function()
        local leaveTween = TweenService:Create(
            container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(32, 37, 44)}
        )
        leaveTween:Play()
    end)
    local control = {
        Type = "Button",
        Name = name,
        Container = container,
        Trigger = callback
    }
    table.insert(self.Controls, control)
    return control
end
return FloatingControls
end)() end,
    function()local wax,script,require=ImportGlobals(8)local ImportGlobals return (function(...)local Label = {}
Label.__index = Label
function Label.new(options, tab)
    local self = setmetatable({}, Label)
    self.Tab = tab
    self.Library = tab.Library
    self.Text = options.Text or ""
    self:Create()
    return self
end
function Label:Create()
    self.Container = Instance.new("Frame")
    self.Container.Name = "Label"
    self.Container.Size = UDim2.new(1, 0, 0, 52)
    self.Container.BackgroundColor3 = Color3.fromRGB(28, 33, 40)
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.Tab.Container
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = self.Container
    local success, Lucide = pcall(function()
        return require(script.Parent.lucide)
    end)
    self.LabelIcon = Instance.new("ImageLabel")
    self.LabelIcon.Name = "Icon"
    self.LabelIcon.Size = UDim2.new(0, 18, 0, 18)
    self.LabelIcon.Position = UDim2.new(0, 16, 0.5, 0)
    self.LabelIcon.AnchorPoint = Vector2.new(0, 0.5)
    self.LabelIcon.BackgroundTransparency = 1
    self.LabelIcon.Image = (success and Lucide and Lucide["tag"]) or "rbxassetid://10723416057"
    self.LabelIcon.ImageColor3 = Color3.fromRGB(120, 140, 160)
    self.LabelIcon.Parent = self.Container
    self.TextLabel = Instance.new("TextLabel")
    self.TextLabel.Name = "Text"
    self.TextLabel.Size = UDim2.new(1, -50, 1, 0)
    self.TextLabel.Position = UDim2.new(0, 44, 0, 0)
    self.TextLabel.BackgroundTransparency = 1
    self.TextLabel.Text = self.Text
    self.TextLabel.TextColor3 = Color3.fromRGB(220, 230, 240)
    self.TextLabel.TextSize = self.Text:find("📝") or self.Text:find("🎛️") or self.Text:find("⚙️") or self.Text:find("ℹ️") and 16 or 14
    self.TextLabel.Font = self.Text:find("📝") or self.Text:find("🎛️") or self.Text:find("⚙️") or self.Text:find("ℹ️") and Enum.Font.GothamBold or Enum.Font.Gotham
    self.TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.TextLabel.TextYAlignment = Enum.TextYAlignment.Center
    self.TextLabel.TextWrapped = true
    self.TextLabel.Parent = self.Container
    return self
end
function Label:SetText(text)
    self.Text = text
    self.TextLabel.Text = text
    return self
end
return Label
end)() end,
    function()local wax,script,require=ImportGlobals(9)local ImportGlobals return (function(...)local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Loading = {}
Loading.__index = Loading
function Loading.new(options, library)
    local self = setmetatable({}, Loading)
    self.Library = library
    self.Title = options.Title or "Loading"
    self.Subtitle = options.Subtitle or "Please wait..."
    self.Duration = options.Duration or 3
    self.ShowProgress = options.ShowProgress ~= false 
    self.ShowPercentage = options.ShowPercentage ~= false 
    self.OnComplete = options.OnComplete or function() end
    self.Progress = 0
    self.IsComplete = false
    self.StartTime = tick()
    self:Create()
    self:StartLoading()
    return self
end
function Loading:Create()
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "ProjectMadaraLoading"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ScreenGui.DisplayOrder = 999 
    self.ScreenGui.Parent = playerGui
    self.Background = Instance.new("Frame")
    self.Background.Name = "Background"
    self.Background.Size = UDim2.new(1, 0, 1, 0)
    self.Background.Position = UDim2.new(0, 0, 0, 0)
    self.Background.BackgroundColor3 = Color3.fromRGB(8, 12, 18) 
    self.Background.BackgroundTransparency = 0.3 
    self.Background.BorderSizePixel = 0
    self.Background.Parent = self.ScreenGui
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 12, 18)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(15, 20, 28)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 12, 18))
    }
    gradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.3), 
        NumberSequenceKeypoint.new(0.5, 0.2), 
        NumberSequenceKeypoint.new(1, 0.3) 
    }
    gradient.Rotation = 45
    gradient.Parent = self.Background
    local gradientTween = TweenService:Create(
        gradient,
        TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
        {Rotation = 405}
    )
    gradientTween:Play()
    self:CreateParticles()
    self.LoadingContainer = Instance.new("Frame")
    self.LoadingContainer.Name = "LoadingContainer"
    self.LoadingContainer.Size = UDim2.new(0, 500, 0, 300)
    self.LoadingContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
    self.LoadingContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    self.LoadingContainer.BackgroundTransparency = 1
    self.LoadingContainer.Parent = self.Background
    self.LogoContainer = Instance.new("Frame")
    self.LogoContainer.Name = "LogoContainer"
    self.LogoContainer.Size = UDim2.new(0, 120, 0, 120)
    self.LogoContainer.Position = UDim2.new(0.5, 0, 0, 0)
    self.LogoContainer.AnchorPoint = Vector2.new(0.5, 0)
    self.LogoContainer.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    self.LogoContainer.BorderSizePixel = 0
    self.LogoContainer.Parent = self.LoadingContainer
    local logoCorner = Instance.new("UICorner")
    logoCorner.CornerRadius = UDim.new(0, 25)
    logoCorner.Parent = self.LogoContainer
    local logoBorder = Instance.new("UIStroke")
    logoBorder.Color = Color3.fromRGB(100, 180, 255)
    logoBorder.Thickness = 3
    logoBorder.Transparency = 0.3
    logoBorder.Parent = self.LogoContainer
    self.LogoText = Instance.new("TextLabel")
    self.LogoText.Name = "LogoText"
    self.LogoText.Size = UDim2.new(1, 0, 1, 0)
    self.LogoText.BackgroundTransparency = 1
    self.LogoText.Text = "M" 
    self.LogoText.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.LogoText.TextSize = 48
    self.LogoText.Font = Enum.Font.GothamBold
    self.LogoText.TextXAlignment = Enum.TextXAlignment.Center
    self.LogoText.TextYAlignment = Enum.TextYAlignment.Center
    self.LogoText.Parent = self.LogoContainer
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "TitleLabel"
    self.TitleLabel.Size = UDim2.new(1, 0, 0, 40)
    self.TitleLabel.Position = UDim2.new(0, 0, 0, 140)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = self.Title
    self.TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.TitleLabel.TextSize = 32
    self.TitleLabel.Font = Enum.Font.GothamBold
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    self.TitleLabel.Parent = self.LoadingContainer
    local titleGlow = Instance.new("UIStroke")
    titleGlow.Color = Color3.fromRGB(100, 180, 255)
    titleGlow.Thickness = 1
    titleGlow.Transparency = 0.7
    titleGlow.Parent = self.TitleLabel
    self.SubtitleLabel = Instance.new("TextLabel")
    self.SubtitleLabel.Name = "SubtitleLabel"
    self.SubtitleLabel.Size = UDim2.new(1, 0, 0, 24)
    self.SubtitleLabel.Position = UDim2.new(0, 0, 0, 185)
    self.SubtitleLabel.BackgroundTransparency = 1
    self.SubtitleLabel.Text = self.Subtitle
    self.SubtitleLabel.TextColor3 = Color3.fromRGB(160, 180, 200)
    self.SubtitleLabel.TextSize = 16
    self.SubtitleLabel.Font = Enum.Font.Gotham
    self.SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
    self.SubtitleLabel.Parent = self.LoadingContainer
    if self.ShowProgress then
        self.ProgressContainer = Instance.new("Frame")
        self.ProgressContainer.Name = "ProgressContainer"
        self.ProgressContainer.Size = UDim2.new(0, 400, 0, 8)
        self.ProgressContainer.Position = UDim2.new(0.5, 0, 0, 230)
        self.ProgressContainer.AnchorPoint = Vector2.new(0.5, 0)
        self.ProgressContainer.BackgroundColor3 = Color3.fromRGB(25, 30, 38)
        self.ProgressContainer.BorderSizePixel = 0
        self.ProgressContainer.Parent = self.LoadingContainer
        local progressCorner = Instance.new("UICorner")
        progressCorner.CornerRadius = UDim.new(1, 0)
        progressCorner.Parent = self.ProgressContainer
        local progressBorder = Instance.new("UIStroke")
        progressBorder.Color = Color3.fromRGB(45, 55, 65)
        progressBorder.Thickness = 1
        progressBorder.Parent = self.ProgressContainer
        self.ProgressFill = Instance.new("Frame")
        self.ProgressFill.Name = "ProgressFill"
        self.ProgressFill.Size = UDim2.new(0, 0, 1, 0)
        self.ProgressFill.Position = UDim2.new(0, 0, 0, 0)
        self.ProgressFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        self.ProgressFill.BorderSizePixel = 0
        self.ProgressFill.Parent = self.ProgressContainer
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(1, 0)
        fillCorner.Parent = self.ProgressFill
        local progressGradient = Instance.new("UIGradient")
        progressGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 215)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 180, 255)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 150, 255))
        }
        progressGradient.Parent = self.ProgressFill
        local progressGradientTween = TweenService:Create(
            progressGradient,
            TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1),
            {Offset = Vector2.new(1, 0)}
        )
        progressGradientTween:Play()
        self.ProgressGlow = Instance.new("Frame")
        self.ProgressGlow.Name = "ProgressGlow"
        self.ProgressGlow.Size = UDim2.new(1, 20, 1, 20)
        self.ProgressGlow.Position = UDim2.new(0, -10, 0, -10)
        self.ProgressGlow.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        self.ProgressGlow.BackgroundTransparency = 0.8
        self.ProgressGlow.BorderSizePixel = 0
        self.ProgressGlow.ZIndex = self.ProgressContainer.ZIndex - 1
        self.ProgressGlow.Parent = self.ProgressContainer
        local glowCorner = Instance.new("UICorner")
        glowCorner.CornerRadius = UDim.new(1, 0)
        glowCorner.Parent = self.ProgressGlow
    end
    if self.ShowPercentage then
        self.PercentageLabel = Instance.new("TextLabel")
        self.PercentageLabel.Name = "PercentageLabel"
        self.PercentageLabel.Size = UDim2.new(0, 100, 0, 30)
        self.PercentageLabel.Position = UDim2.new(0.5, 0, 0, 250)
        self.PercentageLabel.AnchorPoint = Vector2.new(0.5, 0)
        self.PercentageLabel.BackgroundTransparency = 1
        self.PercentageLabel.Text = "0%"
        self.PercentageLabel.TextColor3 = Color3.fromRGB(100, 180, 255)
        self.PercentageLabel.TextSize = 18
        self.PercentageLabel.Font = Enum.Font.GothamBold
        self.PercentageLabel.TextXAlignment = Enum.TextXAlignment.Center
        self.PercentageLabel.Parent = self.LoadingContainer
    end
    self:PlayEntranceAnimations()
end
function Loading:CreateParticles()
    for i = 1, 15 do
        local particle = Instance.new("Frame")
        particle.Name = "Particle" .. i
        particle.Size = UDim2.new(0, math.random(2, 6), 0, math.random(2, 6))
        particle.Position = UDim2.new(math.random(), 0, math.random(), 0)
        particle.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
        particle.BackgroundTransparency = math.random(30, 80) / 100
        particle.BorderSizePixel = 0
        particle.Parent = self.Background
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(1, 0)
        corner.Parent = particle
        local floatTween = TweenService:Create(
            particle,
            TweenInfo.new(math.random(8, 15), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true),
            {
                Position = UDim2.new(math.random(), 0, math.random(), 0),
                BackgroundTransparency = math.random(20, 90) / 100
            }
        )
        floatTween:Play()
    end
end
function Loading:PlayEntranceAnimations()
    self.LoadingContainer.Size = UDim2.new(0, 0, 0, 0)
    self.LogoContainer.Rotation = -180
    self.TitleLabel.TextTransparency = 1
    self.SubtitleLabel.TextTransparency = 1
    if self.ProgressContainer then
        self.ProgressContainer.Size = UDim2.new(0, 0, 0, 8)
    end
    local containerTween = TweenService:Create(
        self.LoadingContainer,
        TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 500, 0, 300)}
    )
    containerTween:Play()
    wait(0.2)
    local logoTween = TweenService:Create(
        self.LogoContainer,
        TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
        {Rotation = 0}
    )
    logoTween:Play()
    wait(0.3)
    local titleTween = TweenService:Create(
        self.TitleLabel,
        TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {TextTransparency = 0}
    )
    titleTween:Play()
    wait(0.2)
    local subtitleTween = TweenService:Create(
        self.SubtitleLabel,
        TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {TextTransparency = 0}
    )
    subtitleTween:Play()
    if self.ProgressContainer then
        wait(0.3)
        local progressTween = TweenService:Create(
            self.ProgressContainer,
            TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 400, 0, 8)}
        )
        progressTween:Play()
    end
end
function Loading:StartLoading()
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if self.IsComplete then
            connection:Disconnect()
            return
        end
        local elapsed = tick() - self.StartTime
        self.Progress = math.min(elapsed / self.Duration, 1)
        if self.ProgressFill then
            local targetSize = UDim2.new(self.Progress, 0, 1, 0)
            local progressTween = TweenService:Create(
                self.ProgressFill,
                TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Size = targetSize}
            )
            progressTween:Play()
        end
        if self.PercentageLabel then
            local percentage = math.floor(self.Progress * 100)
            self.PercentageLabel.Text = percentage .. "%"
            local color = Color3.fromRGB(
                math.floor(100 + (155 * self.Progress)),
                math.floor(180 + (75 * self.Progress)),
                255
            )
            self.PercentageLabel.TextColor3 = color
        end
        local pulseScale = 1 + (math.sin(elapsed * 8) * 0.05)
        self.LogoContainer.Size = UDim2.new(0, 120 * pulseScale, 0, 120 * pulseScale)
        if self.Progress >= 1 and not self.IsComplete then
            self.IsComplete = true
            self:CompleteLoading()
        end
    end)
end
function Loading:CompleteLoading()
    local flash = Instance.new("Frame")
    flash.Size = UDim2.new(1, 0, 1, 0)
    flash.BackgroundColor3 = Color3.fromRGB(100, 180, 255)
    flash.BackgroundTransparency = 1
    flash.BorderSizePixel = 0
    flash.Parent = self.Background
    local flashTween = TweenService:Create(
        flash,
        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
        {BackgroundTransparency = 0.7}
    )
    flashTween:Play()
    flashTween.Completed:Connect(function()
        local flashOut = TweenService:Create(
            flash,
            TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundTransparency = 1}
        )
        flashOut:Play()
        flashOut.Completed:Connect(function()
            flash:Destroy()
        end)
    end)
    if self.SubtitleLabel then
        self.SubtitleLabel.Text = "Loading Complete! ✨"
        self.SubtitleLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
    end
    wait(0.8)
    local exitTween = TweenService:Create(
        self.LoadingContainer,
        TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        {
            Size = UDim2.new(0, 0, 0, 0),
            Rotation = 180
        }
    )
    exitTween:Play()
    local bgTween = TweenService:Create(
        self.Background,
        TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {BackgroundTransparency = 1}
    )
    bgTween:Play()
    bgTween.Completed:Connect(function()
        self.OnComplete()
        wait(0.2)
        self.ScreenGui:Destroy()
    end)
end
return Loading
end)() end,
    function()local wax,script,require=ImportGlobals(10)local ImportGlobals return (function(...)local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local MobileFloatingIcon = {}
MobileFloatingIcon.__index = MobileFloatingIcon
function MobileFloatingIcon.new(options, floatingControls)
    local self = setmetatable({}, MobileFloatingIcon)
    self.FloatingControls = floatingControls
    self.IconText = options.IconText or "C"
    self.IconColor = options.IconColor or Color3.fromRGB(0, 120, 215)
    self.Size = options.Size or 60
    if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
        self:CreateGui()
    end
    return self
end
function MobileFloatingIcon:CreateGui()
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "MobileFloatingIcon"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ScreenGui.Parent = playerGui
    self.Container = Instance.new("Frame")
    self.Container.Name = "IconContainer"
    self.Container.Size = UDim2.new(0, self.Size + 10, 0, self.Size + 10)
    self.Container.Position = UDim2.new(0, 20, 0, 150) 
    self.Container.BackgroundTransparency = 1
    self.Container.Parent = self.ScreenGui
    self.IconButton = Instance.new("TextButton")
    self.IconButton.Name = "IconButton"
    self.IconButton.Size = UDim2.new(0, self.Size, 0, self.Size)
    self.IconButton.Position = UDim2.new(0, 5, 0, 5)
    self.IconButton.BackgroundColor3 = self.IconColor
    self.IconButton.Text = self.IconText
    self.IconButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.IconButton.TextSize = self.Size * 0.4
    self.IconButton.Font = Enum.Font.GothamBold
    self.IconButton.BorderSizePixel = 0
    self.IconButton.Parent = self.Container
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = self.IconButton
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(255, 255, 255)
    border.Thickness = 3
    border.Transparency = 0.7
    border.Parent = self.IconButton
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 8, 1, 8)
    shadow.Position = UDim2.new(0, -4, 0, -4)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.6
    shadow.BorderSizePixel = 0
    shadow.ZIndex = self.IconButton.ZIndex - 1
    shadow.Parent = self.IconButton
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(1, 0)
    shadowCorner.Parent = shadow
    self.Badge = Instance.new("Frame")
    self.Badge.Name = "Badge"
    self.Badge.Size = UDim2.new(0, 20, 0, 20)
    self.Badge.Position = UDim2.new(1, -10, 0, -5)
    self.Badge.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    self.Badge.BorderSizePixel = 0
    self.Badge.Visible = false
    self.Badge.Parent = self.IconButton
    local badgeCorner = Instance.new("UICorner")
    badgeCorner.CornerRadius = UDim.new(1, 0)
    badgeCorner.Parent = self.Badge
    self.BadgeText = Instance.new("TextLabel")
    self.BadgeText.Size = UDim2.new(1, 0, 1, 0)
    self.BadgeText.BackgroundTransparency = 1
    self.BadgeText.Text = "0"
    self.BadgeText.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.BadgeText.TextSize = 12
    self.BadgeText.Font = Enum.Font.GothamBold
    self.BadgeText.TextXAlignment = Enum.TextXAlignment.Center
    self.BadgeText.TextYAlignment = Enum.TextYAlignment.Center
    self.BadgeText.Parent = self.Badge
    self.CloseButton = Instance.new("TextButton")
    self.CloseButton.Name = "CloseButton"
    self.CloseButton.Size = UDim2.new(0, 25, 0, 25)
    self.CloseButton.Position = UDim2.new(0, -8, 0, -8) 
    self.CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    self.CloseButton.Text = "×"
    self.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.CloseButton.TextSize = 16
    self.CloseButton.Font = Enum.Font.GothamBold
    self.CloseButton.BorderSizePixel = 0
    self.CloseButton.ZIndex = 100
    self.CloseButton.Parent = self.IconButton
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = self.CloseButton
    local closeBorder = Instance.new("UIStroke")
    closeBorder.Color = Color3.fromRGB(255, 255, 255)
    closeBorder.Thickness = 2
    closeBorder.Parent = self.CloseButton
    self:MakeDraggable()
    self.IconButton.MouseButton1Click:Connect(function()
        self:OnIconTapped()
    end)
    self.CloseButton.MouseButton1Click:Connect(function()
        print("Mobile icon close button clicked") 
        self:Hide()
    end)
    self.CloseButton.MouseEnter:Connect(function()
        local scaleTween = TweenService:Create(
            self.CloseButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 30, 0, 30), BackgroundColor3 = Color3.fromRGB(255, 100, 100)}
        )
        scaleTween:Play()
    end)
    self.CloseButton.MouseLeave:Connect(function()
        local scaleTween = TweenService:Create(
            self.CloseButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 25, 0, 25), BackgroundColor3 = Color3.fromRGB(255, 60, 60)}
        )
        scaleTween:Play()
    end)
    self:SetupTouchEffects()
    self:UpdateBadge()
    return self
end
function MobileFloatingIcon:MakeDraggable()
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    local function updateInput(input)
        local delta = input.Position - dragStart
        self.Container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    self.Container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.Container.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    self.Container.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)
end
function MobileFloatingIcon:SetupTouchEffects()
    self.IconButton.MouseButton1Down:Connect(function()
        local scaleTween = TweenService:Create(
            self.IconButton,
            TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, self.Size * 0.9, 0, self.Size * 0.9)}
        )
        scaleTween:Play()
        local colorTween = TweenService:Create(
            self.IconButton,
            TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(
                math.min(255, self.IconColor.R * 255 + 30),
                math.min(255, self.IconColor.G * 255 + 30),
                math.min(255, self.IconColor.B * 255 + 30)
            )}
        )
        colorTween:Play()
    end)
    self.IconButton.MouseButton1Up:Connect(function()
        local scaleTween = TweenService:Create(
            self.IconButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, self.Size, 0, self.Size)}
        )
        scaleTween:Play()
        local colorTween = TweenService:Create(
            self.IconButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = self.IconColor}
        )
        colorTween:Play()
    end)
end
function MobileFloatingIcon:OnIconTapped()
    if self.FloatingControls then
        self.FloatingControls:Toggle()
        local pulseTween = TweenService:Create(
            self.IconButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, self.Size * 1.2, 0, self.Size * 1.2)}
        )
        pulseTween:Play()
        pulseTween.Completed:Connect(function()
            local returnTween = TweenService:Create(
                self.IconButton,
                TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, self.Size, 0, self.Size)}
            )
            returnTween:Play()
        end)
    end
end
function MobileFloatingIcon:UpdateBadge()
    if not self.FloatingControls then return end
    local activeCount = 0
    for _, control in ipairs(self.FloatingControls.Controls) do
        if control.Type == "Toggle" and control.GetValue() then
            activeCount = activeCount + 1
        end
    end
    if activeCount > 0 then
        self.Badge.Visible = true
        self.BadgeText.Text = tostring(activeCount)
        local badgeTween = TweenService:Create(
            self.Badge,
            TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 20, 0, 20)}
        )
        badgeTween:Play()
    else
        self.Badge.Visible = false
    end
end
function MobileFloatingIcon:Show()
    if self.ScreenGui then
        self.ScreenGui.Enabled = true
    end
end
function MobileFloatingIcon:Hide()
    if self.ScreenGui then
        self.ScreenGui.Enabled = false
    end
end
return MobileFloatingIcon
end)() end,
    function()local wax,script,require=ImportGlobals(11)local ImportGlobals return (function(...)local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Notifications = {}
Notifications.__index = Notifications
local NotificationTypes = {
    Success = {
        Color = Color3.fromRGB(34, 197, 94), 
        Icon = "check-circle",
        Sound = "rbxassetid://131961136" 
    },
    Error = {
        Color = Color3.fromRGB(239, 68, 68), 
        Icon = "x-circle",
        Sound = "rbxassetid://131961136" 
    },
    Warning = {
        Color = Color3.fromRGB(245, 158, 11), 
        Icon = "alert-triangle",
        Sound = "rbxassetid://131961136" 
    },
    Info = {
        Color = Color3.fromRGB(59, 130, 246), 
        Icon = "info",
        Sound = "rbxassetid://131961136" 
    }
}
function Notifications.new()
    local self = setmetatable({}, Notifications)
    self.ActiveNotifications = {}
    self.NotificationQueue = {}
    self.MaxNotifications = 5 
    self:CreateContainer()
    return self
end
function Notifications:CreateContainer()
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "ProjectMadaraNotifications"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ScreenGui.DisplayOrder = 999 
    self.ScreenGui.Parent = playerGui
    self.Container = Instance.new("Frame")
    self.Container.Name = "NotificationContainer"
    self.Container.Size = UDim2.new(0, 350, 1, 0) 
    self.Container.Position = UDim2.new(1, -370, 0, 20) 
    self.Container.BackgroundTransparency = 1
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.ScreenGui
    self.Layout = Instance.new("UIListLayout")
    self.Layout.FillDirection = Enum.FillDirection.Vertical
    self.Layout.SortOrder = Enum.SortOrder.LayoutOrder
    self.Layout.Padding = UDim.new(0, 12) 
    self.Layout.Parent = self.Container
end
function Notifications:Show(options)
    options = options or {}
    local title = options.Title or "Notification"
    local content = options.Content or "This is a notification message."
    local type = options.Type or "Info" 
    local duration = options.Duration or 3 
    local style = NotificationTypes[type] or NotificationTypes.Info
    if #self.ActiveNotifications >= self.MaxNotifications then
        table.insert(self.NotificationQueue, options)
        return
    end
    local notification = self:CreateNotification(title, content, style, duration)
    table.insert(self.ActiveNotifications, notification)
    self:AnimateIn(notification)
    if duration > 0 then
        task.wait(duration)
        self:Dismiss(notification)
    end
end
function Notifications:CreateNotification(title, content, style, duration)
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(1, 0, 0, 80) 
    notification.BackgroundColor3 = Color3.fromRGB(20, 25, 32) 
    notification.BorderSizePixel = 0
    notification.AutomaticSize = Enum.AutomaticSize.Y
    notification.LayoutOrder = #self.ActiveNotifications + 1
    notification.Parent = self.Container
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12) 
    corner.Parent = notification
    local border = Instance.new("UIStroke")
    border.Color = style.Color
    border.Thickness = 2
    border.Transparency = 0.3 
    border.Parent = notification
    local glow = Instance.new("Frame")
    glow.Name = "Glow"
    glow.Size = UDim2.new(1, -4, 1, -4)
    glow.Position = UDim2.new(0, 2, 0, 2)
    glow.BackgroundColor3 = style.Color
    glow.BackgroundTransparency = 0.95 
    glow.BorderSizePixel = 0
    glow.Parent = notification
    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(0, 10)
    glowCorner.Parent = glow
    local accentBar = Instance.new("Frame")
    accentBar.Name = "AccentBar"
    accentBar.Size = UDim2.new(0, 4, 1, -16)
    accentBar.Position = UDim2.new(0, 8, 0, 8)
    accentBar.BackgroundColor3 = style.Color
    accentBar.BorderSizePixel = 0
    accentBar.Parent = notification
    local accentCorner = Instance.new("UICorner")
    accentCorner.CornerRadius = UDim.new(0, 2)
    accentCorner.Parent = accentBar
    local iconContainer = Instance.new("Frame")
    iconContainer.Name = "IconContainer"
    iconContainer.Size = UDim2.new(0, 36, 0, 36)
    iconContainer.Position = UDim2.new(0, 20, 0, 16)
    iconContainer.BackgroundColor3 = style.Color
    iconContainer.BackgroundTransparency = 0.9
    iconContainer.BorderSizePixel = 0
    iconContainer.Parent = notification
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 8)
    iconCorner.Parent = iconContainer
    local success, Lucide = pcall(function()
        return require(script.Parent.lucide)
    end)
    local icon = Instance.new("ImageLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 20, 0, 20)
    icon.Position = UDim2.new(0.5, 0, 0.5, 0)
    icon.AnchorPoint = Vector2.new(0.5, 0.5)
    icon.BackgroundTransparency = 1
    icon.Image = (success and Lucide and Lucide[style.Icon]) or "rbxassetid://10723416057"
    icon.ImageColor3 = style.Color
    icon.Parent = iconContainer
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 24, 0, 24)
    closeButton.Position = UDim2.new(1, -32, 0, 16)
    closeButton.BackgroundColor3 = Color3.fromRGB(60, 65, 72)
    closeButton.BackgroundTransparency = 0.8
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.fromRGB(200, 205, 210)
    closeButton.TextSize = 14
    closeButton.Font = Enum.Font.GothamBold
    closeButton.BorderSizePixel = 0
    closeButton.Parent = notification
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(1, 0)
    closeCorner.Parent = closeButton
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, -120, 0, 20)
    titleLabel.Position = UDim2.new(0, 68, 0, 16)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 15
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center
    titleLabel.Parent = notification
    local contentLabel = Instance.new("TextLabel")
    contentLabel.Name = "Content"
    contentLabel.Size = UDim2.new(1, -80, 0, 0)
    contentLabel.Position = UDim2.new(0, 68, 0, 42)
    contentLabel.BackgroundTransparency = 1
    contentLabel.Text = content
    contentLabel.TextColor3 = Color3.fromRGB(180, 190, 200)
    contentLabel.TextSize = 13
    contentLabel.Font = Enum.Font.Gotham
    contentLabel.TextXAlignment = Enum.TextXAlignment.Left
    contentLabel.TextYAlignment = Enum.TextYAlignment.Top
    contentLabel.TextWrapped = true
    contentLabel.AutomaticSize = Enum.AutomaticSize.Y
    contentLabel.Parent = notification
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 0)
    padding.PaddingRight = UDim.new(0, 16)
    padding.PaddingTop = UDim.new(0, 0)
    padding.PaddingBottom = UDim.new(0, 24) 
    padding.Parent = notification
    if duration > 0 then
        local progressBar = Instance.new("Frame")
        progressBar.Name = "ProgressBar"
        progressBar.Size = UDim2.new(1, -16, 0, 2)
        progressBar.Position = UDim2.new(0, 8, 1, -10) 
        progressBar.BackgroundColor3 = style.Color
        progressBar.BorderSizePixel = 0
        progressBar.Parent = notification
        local progressCorner = Instance.new("UICorner")
        progressCorner.CornerRadius = UDim.new(0, 1)
        progressCorner.Parent = progressBar
        local progressTween = TweenService:Create(
            progressBar,
            TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 0, 0, 2)}
        )
        progressTween:Play()
    end
    closeButton.MouseButton1Click:Connect(function()
        self:Dismiss(notification)
    end)
    closeButton.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(
            closeButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(220, 85, 85), BackgroundTransparency = 0}
        )
        hoverTween:Play()
    end)
    closeButton.MouseLeave:Connect(function()
        local leaveTween = TweenService:Create(
            closeButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(60, 65, 72), BackgroundTransparency = 0.8}
        )
        leaveTween:Play()
    end)
    return notification
end
function Notifications:AnimateIn(notification)
    notification.Position = UDim2.new(1, 50, 0, 0)
    notification.BackgroundTransparency = 1
    local slideTween = TweenService:Create(
        notification,
        TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Position = UDim2.new(0, 0, 0, 0)}
    )
    slideTween:Play()
    local fadeTween = TweenService:Create(
        notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0}
    )
    fadeTween:Play()
    local iconContainer = notification:FindFirstChild("IconContainer")
    if iconContainer then
        iconContainer.Size = UDim2.new(0, 0, 0, 0)
        local iconTween = TweenService:Create(
            iconContainer,
            TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 36, 0, 36)}
        )
        iconTween:Play()
    end
end
function Notifications:Dismiss(notification)
    for i, activeNotif in ipairs(self.ActiveNotifications) do
        if activeNotif == notification then
            table.remove(self.ActiveNotifications, i)
            break
        end
    end
    local slideOutTween = TweenService:Create(
        notification,
        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
        {Position = UDim2.new(1, 50, 0, 0), BackgroundTransparency = 1}
    )
    slideOutTween:Play()
    slideOutTween.Completed:Connect(function()
        notification:Destroy()
        if #self.NotificationQueue > 0 then
            local nextNotification = table.remove(self.NotificationQueue, 1)
            self:Show(nextNotification)
        end
    end)
end
function Notifications:Success(title, content, duration)
    self:Show({
        Title = title,
        Content = content,
        Type = "Success",
        Duration = duration or 4
    })
end
function Notifications:Error(title, content, duration)
    self:Show({
        Title = title,
        Content = content,
        Type = "Error",
        Duration = duration or 6
    })
end
function Notifications:Warning(title, content, duration)
    self:Show({
        Title = title,
        Content = content,
        Type = "Warning",
        Duration = duration or 5
    })
end
function Notifications:Info(title, content, duration)
    self:Show({
        Title = title,
        Content = content,
        Type = "Info",
        Duration = duration or 4
    })
end
return Notifications
end)() end,
    function()local wax,script,require=ImportGlobals(12)local ImportGlobals return (function(...)local OptionsManager = {}
OptionsManager.__index = OptionsManager

function OptionsManager.new()
    local self = setmetatable({}, OptionsManager)
    
    self.Toggles = {}
    self.Options = {}
    
    setmetatable(self.Toggles, {
        __index = function(t, key)
            local component = rawget(t, key)
            if component then
                return component
            end
            return {Value = false}
        end
    })
    
    setmetatable(self.Options, {
        __index = function(t, key)
            local component = rawget(t, key)
            if component then
                return component
            end
            return {Value = ""}
        end
    })
    
    return self.Toggles, self.Options, self
end

function OptionsManager:RegisterToggle(name, component)
    self.Toggles[name] = component
    return component
end

function OptionsManager:RegisterOption(name, component)
    self.Options[name] = component
    return component
end

function OptionsManager:GetToggles()
    local values = {}
    for name, component in pairs(self.Toggles) do
        values[name] = component.Value
    end
    return values
end

function OptionsManager:GetOptions()
    local values = {}
    for name, component in pairs(self.Options) do
        values[name] = component.Value
    end
    return values
end

function OptionsManager:GetAllValues()
    return {
        Toggles = self:GetToggles(),
        Options = self:GetOptions()
    }
end

function OptionsManager:SetToggle(name, value)
    if self.Toggles[name] and self.Toggles[name].SetValue then
        self.Toggles[name]:SetValue(value)
    end
end

function OptionsManager:SetOption(name, value)
    if self.Options[name] and self.Options[name].SetValue then
        self.Options[name]:SetValue(value)
    end
end

function OptionsManager:LoadValues(data)
    if data.Toggles then
        for name, value in pairs(data.Toggles) do
            self:SetToggle(name, value)
        end
    end
    
    if data.Options then
        for name, value in pairs(data.Options) do
            self:SetOption(name, value)
        end
    end
end

function OptionsManager:SaveValues()
    return self:GetAllValues()
end

return OptionsManager
end)() end,
    function()local wax,script,require=ImportGlobals(13)local ImportGlobals return (function(...)local TweenService = game:GetService("TweenService")
local Paragraph = {}
Paragraph.__index = Paragraph
function Paragraph.new(options, tab)
    local self = setmetatable({}, Paragraph)
    self.Tab = tab
    self.Library = tab.Library
    self.Name = options.Name or "Paragraph"
    self.Subtitle = options.Subtitle or "Add your paragraph content here..."
    self:Create()
    return self
end
function Paragraph:Create()
    self.Container = Instance.new("Frame")
    self.Container.Name = self.Name .. "Paragraph"
    self.Container.Size = UDim2.new(1, 0, 0, 0) 
    self.Container.BackgroundColor3 = Color3.fromRGB(28, 33, 40) 
    self.Container.BorderSizePixel = 0
    self.Container.AutomaticSize = Enum.AutomaticSize.Y 
    self.Container.Parent = self.Tab.Container
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(45, 55, 65) 
    border.Thickness = 1
    border.Parent = self.Container
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = self.Container
    self.AccentLine = Instance.new("Frame")
    self.AccentLine.Name = "AccentLine"
    self.AccentLine.Size = UDim2.new(0, 3, 1, -24) 
    self.AccentLine.Position = UDim2.new(0, 12, 0, 12)
    self.AccentLine.BackgroundColor3 = Color3.fromRGB(0, 120, 215) 
    self.AccentLine.BorderSizePixel = 0
    self.AccentLine.Parent = self.Container
    local accentCorner = Instance.new("UICorner")
    accentCorner.CornerRadius = UDim.new(0, 2)
    accentCorner.Parent = self.AccentLine
    local success, Lucide = pcall(function()
        return require(script.Parent.lucide)
    end)
    self.ParagraphIcon = Instance.new("ImageLabel")
    self.ParagraphIcon.Name = "Icon"
    self.ParagraphIcon.Size = UDim2.new(0, 20, 0, 20)
    self.ParagraphIcon.Position = UDim2.new(0, 24, 0, 16)
    self.ParagraphIcon.BackgroundTransparency = 1
    self.ParagraphIcon.Image = (success and Lucide and Lucide["file-text"]) or "rbxassetid://10723416057"
    self.ParagraphIcon.ImageColor3 = Color3.fromRGB(100, 140, 180) 
    self.ParagraphIcon.Parent = self.Container
    self.TitleLabel = Instance.new("TextLabel")
    self.TitleLabel.Name = "Title"
    self.TitleLabel.Size = UDim2.new(1, -60, 0, 24)
    self.TitleLabel.Position = UDim2.new(0, 52, 0, 12)
    self.TitleLabel.BackgroundTransparency = 1
    self.TitleLabel.Text = self.Name
    self.TitleLabel.TextColor3 = Color3.fromRGB(240, 245, 250)
    self.TitleLabel.TextSize = 16
    self.TitleLabel.Font = Enum.Font.GothamBold
    self.TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
    self.TitleLabel.Parent = self.Container
    self.ContentLabel = Instance.new("TextLabel")
    self.ContentLabel.Name = "Content"
    self.ContentLabel.Size = UDim2.new(1, -60, 0, 0) 
    self.ContentLabel.Position = UDim2.new(0, 52, 0, 44)
    self.ContentLabel.BackgroundTransparency = 1
    self.ContentLabel.Text = self.Subtitle
    self.ContentLabel.TextColor3 = Color3.fromRGB(180, 195, 210) 
    self.ContentLabel.TextSize = 13
    self.ContentLabel.Font = Enum.Font.Gotham
    self.ContentLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.ContentLabel.TextYAlignment = Enum.TextYAlignment.Top
    self.ContentLabel.TextWrapped = true 
    self.ContentLabel.AutomaticSize = Enum.AutomaticSize.Y 
    self.ContentLabel.Parent = self.Container
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 0)
    padding.PaddingRight = UDim.new(0, 16)
    padding.PaddingTop = UDim.new(0, 0)
    padding.PaddingBottom = UDim.new(0, 16)
    padding.Parent = self.Container
    self.ContentLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        self.Container.Size = UDim2.new(1, 0, 0, self.ContentLabel.AbsoluteSize.Y + 60) 
        self.AccentLine.Size = UDim2.new(0, 3, 1, -24)
    end)
    self.Container.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(32, 37, 44)}
        )
        hoverTween:Play()
        local borderTween = TweenService:Create(
            border,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(60, 70, 80)}
        )
        borderTween:Play()
        local accentTween = TweenService:Create(
            self.AccentLine,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 140, 235)}
        )
        accentTween:Play()
    end)
    self.Container.MouseLeave:Connect(function()
        local leaveTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(28, 33, 40)}
        )
        leaveTween:Play()
        local borderTween = TweenService:Create(
            border,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(45, 55, 65)}
        )
        borderTween:Play()
        local accentTween = TweenService:Create(
            self.AccentLine,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
        )
        accentTween:Play()
    end)
    return self
end
function Paragraph:SetTitle(title)
    self.Name = title
    self.TitleLabel.Text = title
    return self
end
function Paragraph:SetContent(content)
    self.Subtitle = content
    self.ContentLabel.Text = content
    return self
end
return Paragraph
end)() end,
    function()local wax,script,require=ImportGlobals(14)local ImportGlobals return (function(...)local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Slider = {}
Slider.__index = Slider
function Slider:FormatValue(value)
    if value == math.floor(value) then
        return tostring(math.floor(value))
    else
        local formatted = string.format("%.2f", value)
        formatted = formatted:gsub("%.?0+$", "") 
        return formatted
    end
end
function Slider.new(options, tab)
    local self = setmetatable({}, Slider)
    self.Tab = tab
    self.Library = tab.Library
    self.Type = "Slider"
    self.Name = options.Name or "Slider"
    self.Description = options.Description or "" 
    self.Min = options.Min or 0
    self.Max = options.Max or 100
    self.Step = options.Step or 1
    self.Value = options.InitialValue or self.Min
    self.Callback = options.Callback or function() end
    self.Value = math.clamp(self.Value, self.Min, self.Max)
    self.Value = self.Min + (math.floor((self.Value - self.Min) / self.Step + 0.5) * self.Step)
    self:Create()
    return self
end
function Slider:Create()
    self.Container = Instance.new("Frame")
    self.Container.Name = self.Name .. "Slider"
    self.Container.Size = UDim2.new(1, 0, 0, self.Description ~= "" and 68 or 52)
    self.Container.BackgroundColor3 = Color3.fromRGB(32, 37, 44)
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.Tab.Container
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(55, 60, 67)
    border.Thickness = 1
    border.Parent = self.Container
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = self.Container
    local success, Lucide = pcall(function()
        return require(script.Parent.lucide)
    end)
    self.SliderIcon = Instance.new("ImageLabel")
    self.SliderIcon.Name = "Icon"
    self.SliderIcon.Size = UDim2.new(0, 18, 0, 18)
    self.SliderIcon.Position = UDim2.new(0, 16, 0, self.Description ~= "" and 12 or 17)
    self.SliderIcon.BackgroundTransparency = 1
    self.SliderIcon.Image = (success and Lucide and Lucide["sliders"]) or "rbxassetid://10734942565"
    self.SliderIcon.ImageColor3 = Color3.fromRGB(120, 140, 160)
    self.SliderIcon.Parent = self.Container
    self.NameLabel = Instance.new("TextLabel")
    self.NameLabel.Name = "Name"
    self.NameLabel.Size = UDim2.new(0, 150, 0, 22)
    self.NameLabel.Position = UDim2.new(0, 44, 0, self.Description ~= "" and 8 or 15)
    self.NameLabel.BackgroundTransparency = 1
    self.NameLabel.Text = self.Name
    self.NameLabel.TextColor3 = Color3.fromRGB(240, 245, 250)
    self.NameLabel.TextSize = 15
    self.NameLabel.Font = Enum.Font.GothamSemibold
    self.NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.NameLabel.Parent = self.Container
    if self.Description ~= "" then
        self.SliderDescription = Instance.new("TextLabel")
        self.SliderDescription.Name = "Description"
        self.SliderDescription.Size = UDim2.new(0, 250, 0, 16)
        self.SliderDescription.Position = UDim2.new(0, 44, 0, 32)
        self.SliderDescription.BackgroundTransparency = 1
        self.SliderDescription.Text = self.Description
        self.SliderDescription.TextColor3 = Color3.fromRGB(160, 170, 180)
        self.SliderDescription.TextSize = 12
        self.SliderDescription.Font = Enum.Font.Gotham
        self.SliderDescription.TextXAlignment = Enum.TextXAlignment.Left
        self.SliderDescription.Parent = self.Container
    end
    self.ValueLabel = Instance.new("TextLabel")
    self.ValueLabel.Name = "Value"
    self.ValueLabel.Size = UDim2.new(0, 40, 1, 0) 
    self.ValueLabel.Position = UDim2.new(1, -16, 0.5, 0) 
    self.ValueLabel.AnchorPoint = Vector2.new(1, 0.5) 
    self.ValueLabel.BackgroundTransparency = 1
    self.ValueLabel.Text = self:FormatValue(self.Value)
    self.ValueLabel.TextColor3 = self.Library.Colors.LightText
    self.ValueLabel.TextSize = 14
    self.ValueLabel.Font = Enum.Font.GothamMedium
    self.ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    self.ValueLabel.Parent = self.Container
    self.SliderTrack = Instance.new("Frame")
    self.SliderTrack.Name = "Track"
    self.SliderTrack.Size = UDim2.new(1, -220, 0, 4) 
    self.SliderTrack.Position = UDim2.new(0, 170, 0.5, 0) 
    self.SliderTrack.AnchorPoint = Vector2.new(0, 0.5) 
    self.SliderTrack.BackgroundColor3 = self.Library.Colors.Background
    self.SliderTrack.BorderSizePixel = 0
    self.SliderTrack.Parent = self.Container
    local trackCorner = Instance.new("UICorner")
    trackCorner.CornerRadius = UDim.new(1, 0)
    trackCorner.Parent = self.SliderTrack
    self.SliderFill = Instance.new("Frame")
    self.SliderFill.Name = "Fill"
    self.SliderFill.Size = UDim2.new(0, 0, 1, 0) 
    self.SliderFill.BackgroundColor3 = self.Library.Colors.Accent
    self.SliderFill.BorderSizePixel = 0
    self.SliderFill.Parent = self.SliderTrack
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = self.SliderFill
    self.SliderIndicator = Instance.new("Frame")
    self.SliderIndicator.Name = "Indicator"
    self.SliderIndicator.Size = UDim2.new(0, 12, 0, 12) 
    self.SliderIndicator.Position = UDim2.new(0, 0, 0.5, 0) 
    self.SliderIndicator.AnchorPoint = Vector2.new(0.5, 0.5)
    self.SliderIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    self.SliderIndicator.BorderSizePixel = 0
    self.SliderIndicator.Parent = self.SliderTrack
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(1, 0)
    indicatorCorner.Parent = self.SliderIndicator
    self.SliderButton = Instance.new("TextButton")
    self.SliderButton.Name = "Button"
    self.SliderButton.Size = UDim2.new(1, 0, 1, 0)
    self.SliderButton.BackgroundTransparency = 1
    self.SliderButton.Text = ""
    self.SliderButton.Parent = self.SliderTrack
    self:UpdateValue(self.Value)
    local isDragging = false
    self.SliderButton.MouseButton1Down:Connect(function()
        isDragging = true
        self:UpdateFromMouse()
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
            self:UpdateFromMouse()
        end
    end)
    self.Container.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(38, 43, 50)}
        )
        hoverTween:Play()
        local borderTween = TweenService:Create(
            border,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(70, 80, 90)}
        )
        borderTween:Play()
    end)
    self.Container.MouseLeave:Connect(function()
        local leaveTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(32, 37, 44)}
        )
        leaveTween:Play()
        local borderTween = TweenService:Create(
            border,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(55, 60, 67)}
        )
        borderTween:Play()
    end)
    return self
end
function Slider:UpdateFromMouse()
    local mouse = game:GetService("Players").LocalPlayer:GetMouse()
    local trackPosition = self.SliderTrack.AbsolutePosition
    local trackSize = self.SliderTrack.AbsoluteSize
    local relativeX = math.clamp(mouse.X - trackPosition.X, 0, trackSize.X)
    local percent = relativeX / trackSize.X
    local value = self.Min + ((self.Max - self.Min) * percent)
    value = self.Min + (math.floor((value - self.Min) / self.Step + 0.5) * self.Step)
    self:UpdateValue(value)
end
function Slider:UpdateValue(value)
    value = math.clamp(value, self.Min, self.Max)
    value = self.Min + (math.floor((value - self.Min) / self.Step + 0.5) * self.Step)
    self.Value = value
    self.ValueLabel.Text = self:FormatValue(value)
    local percent = (value - self.Min) / (self.Max - self.Min)
    self.SliderFill.Size = UDim2.new(percent, 0, 1, 0)
    self.SliderIndicator.Position = UDim2.new(percent, 0, 0.5, 0)
    -- Save to config if enabled
    if self.Tab.Window and self.Tab.Window.ConfigEnabled then
        self.Tab.Window:SaveComponentConfig(self.Tab.Name, self.Name, value)
    end
    self.Callback(value)
    return self
end
function Slider:SetValue(value)
    value = math.clamp(value, self.Min, self.Max)
    value = self.Min + (math.floor((value - self.Min) / self.Step + 0.5) * self.Step)
    self.Value = value
    self.ValueLabel.Text = self:FormatValue(value)
    local percent = (value - self.Min) / (self.Max - self.Min)
    self.SliderFill.Size = UDim2.new(percent, 0, 1, 0)
    self.SliderIndicator.Position = UDim2.new(percent, 0, 0.5, 0)
    return self
end
return Slider
end)() end,
    function()local wax,script,require=ImportGlobals(15)local ImportGlobals return (function(...)local TweenService = game:GetService("TweenService")
local Tab = {}
Tab.__index = Tab
function Tab.new(options, window)
    local self = setmetatable({}, Tab)
    self.Window = window
    self.Library = window.Library
    self.Name = options.Name or "Tab"
    self.Color = options.tabColor or self.Library.Colors.Accent
    self.Icon = options.Icon or ""
    self.Elements = {}
    self.Components = {} -- Track components for config system
    self.OptionsManager = options.OptionsManager
    self:Create()
    return self
end
function Tab:Create()
    local success, Lucide = pcall(function()
        return require(script.Parent.lucide)
    end)
    self.TabButton = Instance.new("TextButton")
    self.TabButton.Name = self.Name .. "Tab"
    self.TabButton.Size = UDim2.new(1, 0, 0, 42) 
    self.TabButton.BackgroundColor3 = Color3.fromRGB(22, 26, 32) 
    self.TabButton.BackgroundTransparency = 1 
    self.TabButton.BorderSizePixel = 0
    self.TabButton.Text = ""
    self.TabButton.AutoButtonColor = false
    self.TabButton.Parent = self.Window.TabListContainer
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 14) 
    tabCorner.Parent = self.TabButton
    self.TabBorder = Instance.new("UIStroke")
    self.TabBorder.Color = Color3.fromRGB(0, 120, 215) 
    self.TabBorder.Thickness = 1
    self.TabBorder.Transparency = 1 
    self.TabBorder.Parent = self.TabButton
    self.TabGlow = Instance.new("Frame")
    self.TabGlow.Name = "GlowEffect"
    self.TabGlow.Size = UDim2.new(1, 4, 1, 4)
    self.TabGlow.Position = UDim2.new(0, -2, 0, -2)
    self.TabGlow.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    self.TabGlow.BackgroundTransparency = 1 
    self.TabGlow.BorderSizePixel = 0
    self.TabGlow.ZIndex = self.TabButton.ZIndex - 1
    self.TabGlow.Parent = self.TabButton
    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(0, 16)
    glowCorner.Parent = self.TabGlow
    if self.Icon and self.Icon ~= "" and success and Lucide and Lucide[self.Icon] then
        self.IconContainer = Instance.new("Frame")
        self.IconContainer.Name = "IconContainer"
        self.IconContainer.Size = UDim2.new(0, 32, 0, 32)
        self.IconContainer.Position = UDim2.new(0, 12, 0.5, 0)
        self.IconContainer.AnchorPoint = Vector2.new(0, 0.5)
        self.IconContainer.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        self.IconContainer.BackgroundTransparency = 0.9 
        self.IconContainer.BorderSizePixel = 0
        self.IconContainer.Parent = self.TabButton
        local iconCorner = Instance.new("UICorner")
        iconCorner.CornerRadius = UDim.new(0, 8)
        iconCorner.Parent = self.IconContainer
        self.TabIcon = Instance.new("ImageLabel")
        self.TabIcon.Name = "Icon"
        self.TabIcon.Size = UDim2.new(0, 18, 0, 18)
        self.TabIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
        self.TabIcon.AnchorPoint = Vector2.new(0.5, 0.5)
        self.TabIcon.BackgroundTransparency = 1
        self.TabIcon.Image = Lucide[self.Icon]
        self.TabIcon.ImageColor3 = Color3.fromRGB(140, 160, 180)
        self.TabIcon.Parent = self.IconContainer
        self.TabText = Instance.new("TextLabel")
        self.TabText.Name = "Text"
        self.TabText.Size = UDim2.new(1, -60, 1, 0)
        self.TabText.Position = UDim2.new(0, 52, 0.5, 0)
        self.TabText.AnchorPoint = Vector2.new(0, 0.5)
        self.TabText.BackgroundTransparency = 1
        self.TabText.Text = self.Name
        self.TabText.TextColor3 = Color3.fromRGB(160, 180, 200)
        self.TabText.TextSize = 15
        self.TabText.Font = Enum.Font.GothamMedium
        self.TabText.TextXAlignment = Enum.TextXAlignment.Left
        self.TabText.Parent = self.TabButton
    else
        self.TabText = Instance.new("TextLabel")
        self.TabText.Name = "Text"
        self.TabText.Size = UDim2.new(1, -32, 1, 0)
        self.TabText.Position = UDim2.new(0, 20, 0.5, 0)
        self.TabText.AnchorPoint = Vector2.new(0, 0.5)
        self.TabText.BackgroundTransparency = 1
        self.TabText.Text = self.Name
        self.TabText.TextColor3 = Color3.fromRGB(160, 180, 200)
        self.TabText.TextSize = 15
        self.TabText.Font = Enum.Font.GothamMedium
        self.TabText.TextXAlignment = Enum.TextXAlignment.Left
        self.TabText.Parent = self.TabButton
    end
    self.TabIndicator = Instance.new("Frame")
    self.TabIndicator.Name = "Indicator"
    self.TabIndicator.Size = UDim2.new(0, 4, 0, 30)
    self.TabIndicator.Position = UDim2.new(0, 0, 0.5, 0)
    self.TabIndicator.AnchorPoint = Vector2.new(0, 0.5)
    self.TabIndicator.BackgroundColor3 = Color3.fromRGB(0, 150, 255) 
    self.TabIndicator.BorderSizePixel = 0
    self.TabIndicator.Visible = false
    self.TabIndicator.Parent = self.TabButton
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0, 2)
    indicatorCorner.Parent = self.TabIndicator
    self.Container = Instance.new("ScrollingFrame")
    self.Container.Name = self.Name .. "Container"
    self.Container.Size = UDim2.new(1, -4, 1, -4) 
    self.Container.Position = UDim2.new(0, 2, 0, 2) 
    self.Container.BackgroundTransparency = 1
    self.Container.BorderSizePixel = 0
    self.Container.ScrollBarThickness = 3 
    self.Container.ScrollBarImageColor3 = self.Library.Colors.Accent
    self.Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
    self.Container.Visible = false 
    self.Container.Parent = self.Window.ContentContainer
    self.ContainerLayout = Instance.new("UIListLayout")
    self.ContainerLayout.FillDirection = Enum.FillDirection.Vertical
    self.ContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.ContainerLayout.Padding = UDim.new(0, 8) 
    self.ContainerLayout.Parent = self.Container
    local containerPadding = Instance.new("UIPadding")
    containerPadding.PaddingLeft = UDim.new(0, 8) 
    containerPadding.PaddingRight = UDim.new(0, 8)
    containerPadding.PaddingTop = UDim.new(0, 8)
    containerPadding.PaddingBottom = UDim.new(0, 8)
    containerPadding.Parent = self.Container
    self.TabButton.MouseButton1Click:Connect(function()
        self.Window:SelectTab(self)
    end)
    self.TabButton.MouseEnter:Connect(function()
        if self.Window.ActiveTab ~= self then
            local bgTween = TweenService:Create(
                self.TabButton,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(28, 35, 42), BackgroundTransparency = 0}
            )
            bgTween:Play()
            local glowTween = TweenService:Create(
                self.TabGlow,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {BackgroundTransparency = 0.95}
            )
            glowTween:Play()
            local borderTween = TweenService:Create(
                self.TabBorder,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Transparency = 0.7}
            )
            borderTween:Play()
            local textTween = TweenService:Create(
                self.TabText,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {TextColor3 = Color3.fromRGB(220, 240, 255)}
            )
            textTween:Play()
            if self.IconContainer then
                local iconBgTween = TweenService:Create(
                    self.IconContainer,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 0.8}
                )
                iconBgTween:Play()
                local iconTween = TweenService:Create(
                    self.TabIcon,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {ImageColor3 = Color3.fromRGB(100, 180, 255)}
                )
                iconTween:Play()
            end
        end
    end)
    self.TabButton.MouseLeave:Connect(function()
        if self.Window.ActiveTab ~= self then
            local bgTween = TweenService:Create(
                self.TabButton,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {BackgroundTransparency = 1}
            )
            bgTween:Play()
            local glowTween = TweenService:Create(
                self.TabGlow,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {BackgroundTransparency = 1}
            )
            glowTween:Play()
            local borderTween = TweenService:Create(
                self.TabBorder,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Transparency = 1}
            )
            borderTween:Play()
            local textTween = TweenService:Create(
                self.TabText,
                TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {TextColor3 = Color3.fromRGB(160, 180, 200)}
            )
            textTween:Play()
            if self.IconContainer then
                local iconBgTween = TweenService:Create(
                    self.IconContainer,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 0.9}
                )
                iconBgTween:Play()
                local iconTween = TweenService:Create(
                    self.TabIcon,
                    TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {ImageColor3 = Color3.fromRGB(140, 160, 180)}
                )
                iconTween:Play()
            end
        end
    end)
    return self
end
function Tab:Show()
    self.Container.Visible = true
    self.TabIndicator.Visible = true
    local bgTween = TweenService:Create(
        self.TabButton,
        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(0, 120, 215), BackgroundTransparency = 0}
    )
    bgTween:Play()
    local glowTween = TweenService:Create(
        self.TabGlow,
        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {BackgroundTransparency = 0.8}
    )
    glowTween:Play()
    local borderTween = TweenService:Create(
        self.TabBorder,
        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Color = Color3.fromRGB(100, 180, 255), Transparency = 0}
    )
    borderTween:Play()
    local textTween = TweenService:Create(
        self.TabText,
        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {TextColor3 = Color3.fromRGB(255, 255, 255)}
    )
    textTween:Play()
    self.TabText.Font = Enum.Font.GothamBold 
    if self.IconContainer then
        local iconBgTween = TweenService:Create(
            self.IconContainer,
            TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.1}
        )
        iconBgTween:Play()
        local iconTween = TweenService:Create(
            self.TabIcon,
            TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {ImageColor3 = Color3.fromRGB(0, 120, 215)}
        )
        iconTween:Play()
    end
end
function Tab:Hide()
    self.Container.Visible = false
    self.TabIndicator.Visible = false
    local bgTween = TweenService:Create(
        self.TabButton,
        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {BackgroundTransparency = 1}
    )
    bgTween:Play()
    local glowTween = TweenService:Create(
        self.TabGlow,
        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {BackgroundTransparency = 1}
    )
    glowTween:Play()
    local borderTween = TweenService:Create(
        self.TabBorder,
        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Color = Color3.fromRGB(0, 120, 215), Transparency = 1}
    )
    borderTween:Play()
    local textTween = TweenService:Create(
        self.TabText,
        TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {TextColor3 = Color3.fromRGB(160, 180, 200)}
    )
    textTween:Play()
    self.TabText.Font = Enum.Font.GothamMedium 
    if self.IconContainer then
        local iconBgTween = TweenService:Create(
            self.IconContainer,
            TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 120, 215), BackgroundTransparency = 0.9}
        )
        iconBgTween:Play()
        local iconTween = TweenService:Create(
            self.TabIcon,
            TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {ImageColor3 = Color3.fromRGB(140, 160, 180)}
        )
        iconTween:Play()
    end
end
function Tab:Section(name)
    local section = Instance.new("Frame")
    section.Name = name .. "Section"
    section.Size = UDim2.new(1, 0, 0, 0) 
    section.BackgroundTransparency = 1
    section.BorderSizePixel = 0
    section.AutomaticSize = Enum.AutomaticSize.Y
    section.Parent = self.Container
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 18) 
    title.BackgroundTransparency = 1
    title.Text = name
    title.TextColor3 = self.Library.Colors.LightText
    title.TextSize = 14 
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = section
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, 0, 0, 0) 
    content.Position = UDim2.new(0, 0, 0, 22) 
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.AutomaticSize = Enum.AutomaticSize.Y
    content.Parent = section
    local layout = Instance.new("UIListLayout")
    layout.FillDirection = Enum.FillDirection.Vertical
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 4) 
    layout.Parent = content
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        content.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y)
        section.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y + 30)
    end)
    return content
end
function Tab:Toggle(options)
    options = options or {}
    options.Name = options.Name or "Toggle"
    options.Default = options.Default or false
    options.Callback = options.Callback or function() end
    local toggle = require(script.Parent.Toggle).new(options, self)
    table.insert(self.Elements, toggle)
    table.insert(self.Components, toggle) -- Track for config system
    if self.OptionsManager then
        self.OptionsManager:RegisterToggle(options.Name, toggle)
    end
    return toggle
end
function Tab:Button(options)
    options = options or {}
    options.Name = options.Name or "Button"
    options.Callback = options.Callback or function() end
    local button = require(script.Parent.Button).new(options, self)
    table.insert(self.Elements, button)
    return button
end
function Tab:TextBox(options)
    options = options or {}
    options.Name = options.Name or "TextBox"
    options.Placeholder = options.Placeholder or "Type here..."
    options.Callback = options.Callback or function() end
    local textbox = require(script.Parent.TextBox).new(options, self)
    table.insert(self.Elements, textbox)
    table.insert(self.Components, textbox) -- Track for config system
    if self.OptionsManager then
        self.OptionsManager:RegisterOption(options.Name, textbox)
    end
    return textbox
end
function Tab:Slider(options)
    options = options or {}
    options.Name = options.Name or "Slider"
    options.Min = options.Min or 0
    options.Max = options.Max or 100
    options.Step = options.Step or 1
    options.InitialValue = options.InitialValue or options.Min
    options.Callback = options.Callback or function() end
    local slider = require(script.Parent.Slider).new(options, self)
    table.insert(self.Elements, slider)
    table.insert(self.Components, slider) -- Track for config system
    if self.OptionsManager then
        self.OptionsManager:RegisterOption(options.Name, slider)
    end
    return slider
end
function Tab:Dropdown(options)
    options = options or {}
    options.Name = options.Name or "Dropdown"
    options.Default = options.Default or ""
    options.Items = options.Items or {}
    options.Multiselect = options.Multiselect or false
    options.Callback = options.Callback or function() end
    local dropdown = require(script.Parent.Dropdown).new(options, self)
    table.insert(self.Elements, dropdown)
    table.insert(self.Components, dropdown) -- Track for config system
    if self.OptionsManager then
        self.OptionsManager:RegisterOption(options.Name, dropdown)
    end
    return dropdown
end
function Tab:Label(text)
    local label = require(script.Parent.Label).new({Text = text}, self)
    table.insert(self.Elements, label)
    return label
end
function Tab:Paragraph(options)
    options = options or {}
    options.Name = options.Name or "Paragraph"
    options.Subtitle = options.Subtitle or "Add your paragraph content here..."
    local paragraph = require(script.Parent.Paragraph).new(options, self)
    table.insert(self.Elements, paragraph)
    return paragraph
end
function Tab:Credits(options)
    options = options or {}
    options.Title = options.Title or "Credits"
    options.Subtitle = options.Subtitle or "Meet the amazing team behind this project"
    options.Developers = options.Developers or {}
    options.DiscordInvite = options.DiscordInvite or ""
    options.ProjectInfo = options.ProjectInfo or {}
    local credits = require(script.Parent.Credits).new(options, self)
    table.insert(self.Elements, credits)
    return credits
end
return Tab
end)() end,
    function()local wax,script,require=ImportGlobals(16)local ImportGlobals return (function(...)local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextBox = {}
TextBox.__index = TextBox
function TextBox.new(options, tab)
    local self = setmetatable({}, TextBox)
    self.Tab = tab
    self.Library = tab.Library
    self.Type = "TextBox"
    self.Name = options.Name or "TextBox"
    self.Placeholder = options.Placeholder or "Type here..."
    self.Value = ""
    self.Callback = options.Callback or function() end
    self:Create()
    return self
end
function TextBox:Create()
    self.Container = Instance.new("Frame")
    self.Container.Name = self.Name .. "TextBox"
    self.Container.Size = UDim2.new(1, 0, 0, 52)
    self.Container.BackgroundColor3 = Color3.fromRGB(32, 37, 44)
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.Tab.Container
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(55, 60, 67)
    border.Thickness = 1
    border.Parent = self.Container
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = self.Container
    local success, Lucide = pcall(function()
        return require(script.Parent.lucide)
    end)
    self.TextBoxIcon = Instance.new("ImageLabel")
    self.TextBoxIcon.Name = "Icon"
    self.TextBoxIcon.Size = UDim2.new(0, 18, 0, 18)
    self.TextBoxIcon.Position = UDim2.new(0, 16, 0.5, 0)
    self.TextBoxIcon.AnchorPoint = Vector2.new(0, 0.5)
    self.TextBoxIcon.BackgroundTransparency = 1
    self.TextBoxIcon.Image = (success and Lucide and Lucide["type"]) or "rbxassetid://10723367606"
    self.TextBoxIcon.ImageColor3 = Color3.fromRGB(120, 140, 160)
    self.TextBoxIcon.Parent = self.Container
    self.NameLabel = Instance.new("TextLabel")
    self.NameLabel.Name = "Name"
    self.NameLabel.Size = UDim2.new(0, 150, 0, 22)
    self.NameLabel.Position = UDim2.new(0, 44, 0, 15)
    self.NameLabel.BackgroundTransparency = 1
    self.NameLabel.Text = self.Name
    self.NameLabel.TextColor3 = Color3.fromRGB(240, 245, 250)
    self.NameLabel.TextSize = 15
    self.NameLabel.Font = Enum.Font.GothamSemibold
    self.NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.NameLabel.Parent = self.Container
    self.InputBackground = Instance.new("Frame")
    self.InputBackground.Name = "InputBackground"
    self.InputBackground.Size = UDim2.new(0, 220, 0, 32)
    self.InputBackground.Position = UDim2.new(1, -16, 0.5, 0)
    self.InputBackground.AnchorPoint = Vector2.new(1, 0.5)
    self.InputBackground.BackgroundColor3 = Color3.fromRGB(28, 33, 40)
    self.InputBackground.BorderSizePixel = 0
    self.InputBackground.Parent = self.Container
    self.InputBorder = Instance.new("UIStroke")
    self.InputBorder.Color = Color3.fromRGB(50, 55, 62)
    self.InputBorder.Thickness = 1
    self.InputBorder.Parent = self.InputBackground
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 6)
    inputCorner.Parent = self.InputBackground
    self.Input = Instance.new("TextBox")
    self.Input.Name = "Input"
    self.Input.Size = UDim2.new(1, -16, 1, 0)
    self.Input.Position = UDim2.new(0, 8, 0, 0)
    self.Input.BackgroundTransparency = 1
    self.Input.Text = ""
    self.Input.PlaceholderText = self.Placeholder
    self.Input.PlaceholderColor3 = Color3.fromRGB(120, 130, 140)
    self.Input.TextColor3 = Color3.fromRGB(240, 245, 250)
    self.Input.TextSize = 13
    self.Input.Font = Enum.Font.Gotham
    self.Input.TextXAlignment = Enum.TextXAlignment.Left
    self.Input.ClearTextOnFocus = false
    self.Input.Parent = self.InputBackground
    self.Input.Focused:Connect(function()
        local bgTween = TweenService:Create(
            self.InputBackground,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(35, 40, 47)}
        )
        bgTween:Play()
        local borderTween = TweenService:Create(
            self.InputBorder,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(0, 120, 215)}
        )
        borderTween:Play()
    end)
    self.Input.FocusLost:Connect(function(enterPressed)
        local bgTween = TweenService:Create(
            self.InputBackground,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(28, 33, 40)}
        )
        bgTween:Play()
        local borderTween = TweenService:Create(
            self.InputBorder,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(50, 55, 62)}
        )
        borderTween:Play()
        self.Value = self.Input.Text
        -- Save to config if enabled
        if self.Tab.Window and self.Tab.Window.ConfigEnabled then
            self.Tab.Window:SaveComponentConfig(self.Tab.Name, self.Name, self.Value)
        end
        self.Callback(self.Value)
    end)
    self.Container.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(38, 43, 50)}
        )
        hoverTween:Play()
        local borderTween = TweenService:Create(
            border,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(70, 80, 90)}
        )
        borderTween:Play()
    end)
    self.Container.MouseLeave:Connect(function()
        local leaveTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(32, 37, 44)}
        )
        leaveTween:Play()
        local borderTween = TweenService:Create(
            border,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(55, 60, 67)}
        )
        borderTween:Play()
    end)
    return self
end
function TextBox:SetValue(value)
    self.Value = value
    self.Input.Text = value
    -- Save to config if enabled
    if self.Tab.Window and self.Tab.Window.ConfigEnabled then
        self.Tab.Window:SaveComponentConfig(self.Tab.Name, self.Name, value)
    end
    self.Callback(value)
    return self
end
return TextBox
end)() end,
    function()local wax,script,require=ImportGlobals(17)local ImportGlobals return (function(...)local TweenService = game:GetService("TweenService")
local Toggle = {}
Toggle.__index = Toggle
function Toggle.new(options, tab)
    local self = setmetatable({}, Toggle)
    self.Tab = tab
    self.Library = tab.Library
    self.Type = "Toggle"
    self.Name = options.Name or "Toggle"
    self.Description = options.Description or "" 
    self.HasKeybind = options.Keybind or false 
    self.Keybind = nil 
    self.IsListeningForKeybind = false
    self.Value = options.Default or false
    self.Callback = options.Callback or function() end
    self:Create()
    if self.HasKeybind then
        self:SetupKeybindSystem()
    end
    return self
end
function Toggle:Create()
    self.Container = Instance.new("Frame")
    self.Container.Name = self.Name .. "Toggle"
    self.Container.Size = UDim2.new(1, 0, 0, self.Description ~= "" and 58 or 44)
    self.Container.BackgroundColor3 = Color3.fromRGB(26, 30, 36) 
    self.Container.BorderSizePixel = 0
    self.Container.Parent = self.Tab.Container
    local border = Instance.new("UIStroke")
    border.Color = Color3.fromRGB(40, 45, 52)
    border.Thickness = 1
    border.Parent = self.Container
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12) 
    corner.Parent = self.Container
    local success, Lucide = pcall(function()
        return require(script.Parent.lucide)
    end)
    self.ToggleIcon = Instance.new("ImageLabel")
    self.ToggleIcon.Name = "Icon"
    self.ToggleIcon.Size = UDim2.new(0, 20, 0, 20)
    self.ToggleIcon.Position = UDim2.new(0, 12, 0, self.Description ~= "" and 8 or 12)
    self.ToggleIcon.BackgroundTransparency = 1
    self.ToggleIcon.Image = (success and Lucide and Lucide["power"]) or "rbxassetid://10734930466"
    self.ToggleIcon.ImageColor3 = Color3.fromRGB(120, 140, 160)
    self.ToggleIcon.Parent = self.Container
    self.NameLabel = Instance.new("TextLabel")
    self.NameLabel.Name = "Name"
    self.NameLabel.Size = UDim2.new(0, 200, 0, 20)
    self.NameLabel.Position = UDim2.new(0, 38, 0, self.Description ~= "" and 6 or 12)
    self.NameLabel.BackgroundTransparency = 1
    self.NameLabel.Text = self.Name
    self.NameLabel.TextColor3 = Color3.fromRGB(240, 245, 250)
    self.NameLabel.TextSize = 14
    self.NameLabel.Font = Enum.Font.GothamSemibold
    self.NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    self.NameLabel.Parent = self.Container
    if self.Description ~= "" then
        self.ToggleDescription = Instance.new("TextLabel")
        self.ToggleDescription.Name = "Description"
        self.ToggleDescription.Size = UDim2.new(0, 250, 0, 14)
        self.ToggleDescription.Position = UDim2.new(0, 38, 0, 28)
        self.ToggleDescription.BackgroundTransparency = 1
        self.ToggleDescription.Text = self.Description
        self.ToggleDescription.TextColor3 = Color3.fromRGB(160, 170, 180)
        self.ToggleDescription.TextSize = 11
        self.ToggleDescription.Font = Enum.Font.Gotham
        self.ToggleDescription.TextXAlignment = Enum.TextXAlignment.Left
        self.ToggleDescription.Parent = self.Container
    end
    self.ToggleBackground = Instance.new("Frame")
    self.ToggleBackground.Name = "Background"
    self.ToggleBackground.Size = UDim2.new(0, 38, 0, 20) 
    self.ToggleBackground.Position = UDim2.new(1, self.HasKeybind and -82 or -46, 0.5, 0) 
    self.ToggleBackground.AnchorPoint = Vector2.new(0, 0.5) 
    self.ToggleBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 65) 
    self.ToggleBackground.BorderSizePixel = 0
    self.ToggleBackground.Parent = self.Container
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(1, 0) 
    bgCorner.Parent = self.ToggleBackground
    self.ToggleIndicator = Instance.new("Frame")
    self.ToggleIndicator.Name = "Indicator"
    self.ToggleIndicator.Size = UDim2.new(0, 16, 0, 16) 
    self.ToggleIndicator.Position = UDim2.new(0, 2, 0.5, 0) 
    self.ToggleIndicator.AnchorPoint = Vector2.new(0, 0.5) 
    self.ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255) 
    self.ToggleIndicator.BorderSizePixel = 0
    self.ToggleIndicator.Parent = self.ToggleBackground
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(1, 0) 
    indicatorCorner.Parent = self.ToggleIndicator
    if self.HasKeybind then
        self.KeybindButton = Instance.new("TextButton")
        self.KeybindButton.Name = "KeybindButton"
        self.KeybindButton.Size = UDim2.new(0, 32, 0, 24)
        self.KeybindButton.Position = UDim2.new(1, -38, 0.5, 0) 
        self.KeybindButton.AnchorPoint = Vector2.new(0, 0.5)
        self.KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 55, 62)
        self.KeybindButton.Text = "⌨"
        self.KeybindButton.TextColor3 = Color3.fromRGB(200, 205, 210)
        self.KeybindButton.TextSize = 12
        self.KeybindButton.Font = Enum.Font.GothamBold
        self.KeybindButton.BorderSizePixel = 0
        self.KeybindButton.ZIndex = 10 
        self.KeybindButton.Parent = self.Container
        local keybindCorner = Instance.new("UICorner")
        keybindCorner.CornerRadius = UDim.new(0, 6)
        keybindCorner.Parent = self.KeybindButton
        local UserInputService = game:GetService("UserInputService")
        local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
        local isDragging = false
        local dragStart = nil
        local pressTime = 0
        local hasMovedEnough = false
        local dragConnection = nil
        local releaseConnection = nil
        self.KeybindButton.MouseButton1Down:Connect(function()
            isDragging = true
            dragStart = UserInputService:GetMouseLocation()
            pressTime = tick()
            hasMovedEnough = false
            print("Toggle keybind drag started") 
            if dragConnection then
                dragConnection:Disconnect()
            end
            if releaseConnection then
                releaseConnection:Disconnect()
            end
            dragConnection = UserInputService.InputChanged:Connect(function(input)
                if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local currentPos = Vector2.new(input.Position.X, input.Position.Y)
                    local distance = (currentPos - dragStart).Magnitude
                    if distance > 15 then 
                        hasMovedEnough = true
                        print("Toggle keybind moved enough:", distance) 
                    end
                end
            end)
            releaseConnection = UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and isDragging then
                    print("Toggle keybind mouse released") 
                    if releaseConnection then
                        releaseConnection:Disconnect()
                        releaseConnection = nil
                    end
                    if dragConnection then
                        dragConnection:Disconnect()
                        dragConnection = nil
                    end
                    local holdTime = tick() - pressTime
                    print("Toggle keybind released - holdTime:", holdTime, "moved:", hasMovedEnough) 
                    if hasMovedEnough or holdTime > 0.5 then
                        print("Creating draggable toggle keybind") 
                        self:CreateDraggableKeybind()
                    elseif holdTime < 0.3 then
                        print("Starting keybind listening") 
                        self:StartKeybindListening()
                    end
                    isDragging = false
                    dragStart = nil
                    hasMovedEnough = false
                end
            end)
        end)
        self.KeybindButton.MouseButton2Click:Connect(function()
            print("Right click - creating draggable toggle keybind") 
            self:CreateDraggableKeybind()
        end)
        self.KeybindButton.MouseEnter:Connect(function()
            if not self.IsListeningForKeybind then
                local hoverTween = TweenService:Create(
                    self.KeybindButton,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
                )
                hoverTween:Play()
            end
        end)
        self.KeybindButton.MouseLeave:Connect(function()
            if not self.IsListeningForKeybind then
                local leaveTween = TweenService:Create(
                    self.KeybindButton,
                    TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(50, 55, 62)}
                )
                leaveTween:Play()
            end
        end)
    end
    self.ToggleButton = Instance.new("TextButton")
    self.ToggleButton.Name = "Button"
    self.ToggleButton.Size = UDim2.new(1, self.HasKeybind and -44 or 0, 1, 0) 
    self.ToggleButton.BackgroundTransparency = 1
    self.ToggleButton.Text = ""
    self.ToggleButton.Parent = self.Container
    if self.Value then
        self:SetValue(true, false) 
    end
    self.ToggleButton.MouseButton1Click:Connect(function()
        self:SetValue(not self.Value)
    end)
    self.ToggleButton.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(32, 37, 44)}
        )
        hoverTween:Play()
        local borderTween = TweenService:Create(
            border,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(0, 120, 215)}
        )
        borderTween:Play()
    end)
    self.ToggleButton.MouseLeave:Connect(function()
        local leaveTween = TweenService:Create(
            self.Container,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(26, 30, 36)}
        )
        leaveTween:Play()
        local borderTween = TweenService:Create(
            border,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(40, 45, 52)}
        )
        borderTween:Play()
    end)
    return self
end
function Toggle:SetValue(value, callCallback)
    if callCallback == nil then callCallback = true end
    self.Value = value
    if value then
        local indicatorTween = TweenService:Create(
            self.ToggleIndicator,
            self.Library.TweenInfo,
            {Position = UDim2.new(0, 20, 0.5, 0)} 
        )
        indicatorTween:Play()
        local bgTween = TweenService:Create(
            self.ToggleBackground,
            self.Library.TweenInfo,
            {BackgroundColor3 = self.Library.Colors.Toggle}
        )
        bgTween:Play()
    else
        local indicatorTween = TweenService:Create(
            self.ToggleIndicator,
            self.Library.TweenInfo,
            {Position = UDim2.new(0, 2, 0.5, 0)} 
        )
        indicatorTween:Play()
        local bgTween = TweenService:Create(
            self.ToggleBackground,
            self.Library.TweenInfo,
            {BackgroundColor3 = Color3.fromRGB(60, 60, 65)}
        )
        bgTween:Play()
    end
    
    -- Save to config if enabled
    if self.Tab.Window and self.Tab.Window.ConfigEnabled then
        self.Tab.Window:SaveComponentConfig(self.Tab.Name, self.Name, self.Value)
    end
    
    if callCallback then
        self.Callback(self.Value)
    end
    return self
end
function Toggle:SetupKeybindSystem()
    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if self.IsListeningForKeybind then
            self.Keybind = input.KeyCode
            self.IsListeningForKeybind = false
            self:UpdateKeybindDisplay()
            self.KeybindButton.BackgroundColor3 = Color3.fromRGB(50, 55, 62)
            return
        end
        if self.Keybind and input.KeyCode == self.Keybind then
            self:SetValue(not self.Value)
        end
    end)
end
function Toggle:StartKeybindListening()
    self.IsListeningForKeybind = true
    self.KeybindButton.Text = "..."
    self.KeybindButton.BackgroundColor3 = self.Library.Colors.Accent 
end
function Toggle:UpdateKeybindDisplay()
    if self.Keybind then
        local keyName = tostring(self.Keybind):gsub("Enum.KeyCode.", "")
        self.KeybindButton.Text = keyName:upper()
        self.KeybindButton.TextSize = #keyName > 2 and 12 or 14 
    else
        self.KeybindButton.Text = "⌨"
    end
end
function Toggle:CreateDraggableKeybind()
    print("Toggle:CreateDraggableKeybind called for:", self.Name) 
    local DraggableKeybind = require(script.Parent.DraggableKeybind)
    local draggable = DraggableKeybind.CreateFromButton(
        self.KeybindButton,
        "Toggle",
        self.Name,
        function() self:SetValue(not self.Value) end,
        function() return self.Value end,
        function(value) self:SetValue(value) end
    )
    print("Draggable toggle created:", draggable) 
end
return Toggle
end)() end,
    function()local wax,script,require=ImportGlobals(18)local ImportGlobals return (function(...)local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Window = {}
Window.__index = Window
function Window.new(options, library)
    local self = setmetatable({}, Window)
    self.Library = library
    self.Title = options.Title or "ProjectMadara UI"
    self.Subtitle = options.Subtitle or "Please Set this up when you get a chance"
    self.Tabs = {}
    self.ActiveTab = nil
    self.OptionsManager = options.OptionsManager
    self.ConfigEnabled = options.Config or false
    
    -- Initialize config system if enabled
    if self.ConfigEnabled then
        local Config = require(script.Parent.Config)
        self.Config = Config.new(self)
    end
    
    self:CreateGui()
    
    -- Load config after GUI is created
    if self.ConfigEnabled and self.Config then
        self.Config:LoadConfig()
    end
    
    return self
end
function Window:CreateGui()
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    local UserInputService = game:GetService("UserInputService")
    local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "ProjectMadaraUI"
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ScreenGui.Parent = playerGui
    local baseWidth = isMobile and 320 or 675  
    local baseHeight = isMobile and 400 or 550
    local scaleFactor = isMobile and 0.9 or 1.0
    self.MainFrame = Instance.new("Frame")
    self.MainFrame.Name = "MainFrame"
    self.MainFrame.Size = UDim2.new(0, baseWidth, 0, baseHeight)
    self.MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    self.MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    self.MainFrame.BackgroundColor3 = self.Library.Colors.Background
    self.MainFrame.BorderSizePixel = 0
    self.MainFrame.Parent = self.ScreenGui
    self.IsMobile = isMobile
    self.ScaleFactor = scaleFactor
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = self.MainFrame
    self.TitleBar = Instance.new("Frame")
    self.TitleBar.Name = "TitleBar"
    self.TitleBar.Size = UDim2.new(1, 0, 0, 70) 
    self.TitleBar.Position = UDim2.new(0, 0, 0, 0) 
    self.TitleBar.BackgroundColor3 = Color3.fromRGB(15, 18, 24) 
    self.TitleBar.BorderSizePixel = 0
    self.TitleBar.Parent = self.MainFrame
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12) 
    titleCorner.Parent = self.TitleBar
    local titleMask = Instance.new("Frame")
    titleMask.Name = "TitleMask"
    titleMask.Size = UDim2.new(1, 0, 0, 12)
    titleMask.Position = UDim2.new(0, 0, 1, -12)
    titleMask.BackgroundColor3 = Color3.fromRGB(15, 18, 24)
    titleMask.BorderSizePixel = 0
    titleMask.Parent = self.TitleBar
    local titleBorder = Instance.new("UIStroke")
    titleBorder.Color = Color3.fromRGB(0, 120, 215) 
    titleBorder.Thickness = 1
    titleBorder.Transparency = 0.6 
    titleBorder.Parent = self.TitleBar
    self.TitleGlow = Instance.new("Frame")
    self.TitleGlow.Name = "TitleGlow"
    self.TitleGlow.Size = UDim2.new(1, -4, 1, -4)
    self.TitleGlow.Position = UDim2.new(0, 2, 0, 2)
    self.TitleGlow.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    self.TitleGlow.BackgroundTransparency = 0.95 
    self.TitleGlow.BorderSizePixel = 0
    self.TitleGlow.Parent = self.TitleBar
    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(0, 10)
    glowCorner.Parent = self.TitleGlow
    self.AppIcon = Instance.new("Frame")
    self.AppIcon.Name = "AppIcon"
    self.AppIcon.Size = UDim2.new(0, 40, 0, 40)
    self.AppIcon.Position = UDim2.new(0, 20, 0.5, 0)
    self.AppIcon.AnchorPoint = Vector2.new(0, 0.5)
    self.AppIcon.BackgroundColor3 = Color3.fromRGB(0, 120, 215) 
    self.AppIcon.BorderSizePixel = 0
    self.AppIcon.Parent = self.TitleBar
    local iconCorner = Instance.new("UICorner")
    iconCorner.CornerRadius = UDim.new(0, 10)
    iconCorner.Parent = self.AppIcon
    self.AppIconText = Instance.new("TextLabel")
    self.AppIconText.Name = "IconText"
    self.AppIconText.Size = UDim2.new(1, 0, 1, 0)
    self.AppIconText.BackgroundTransparency = 1
    self.AppIconText.Text = "M" 
    self.AppIconText.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.AppIconText.TextSize = 20
    self.AppIconText.Font = Enum.Font.GothamBold
    self.AppIconText.TextXAlignment = Enum.TextXAlignment.Center
    self.AppIconText.TextYAlignment = Enum.TextYAlignment.Center
    self.AppIconText.Parent = self.AppIcon
    self.TitleText = Instance.new("TextLabel")
    self.TitleText.Name = "TitleText"
    self.TitleText.Size = UDim2.new(0, 250, 0, 24)
    self.TitleText.Position = UDim2.new(0, 75, 0, 12)
    self.TitleText.BackgroundTransparency = 1
    self.TitleText.Text = self.Title
    self.TitleText.TextColor3 = Color3.fromRGB(255, 255, 255) 
    self.TitleText.TextSize = 18
    self.TitleText.Font = Enum.Font.GothamBold
    self.TitleText.TextXAlignment = Enum.TextXAlignment.Left
    self.TitleText.Parent = self.TitleBar
    self.SubtitleText = Instance.new("TextLabel")
    self.SubtitleText.Name = "SubtitleText"
    self.SubtitleText.Size = UDim2.new(0, 350, 0, 16)
    self.SubtitleText.Position = UDim2.new(0, 75, 0, 38)
    self.SubtitleText.BackgroundTransparency = 1
    self.SubtitleText.Text = self.Subtitle
    self.SubtitleText.TextColor3 = Color3.fromRGB(160, 180, 200) 
    self.SubtitleText.TextSize = 12
    self.SubtitleText.Font = Enum.Font.Gotham
    self.SubtitleText.TextXAlignment = Enum.TextXAlignment.Left
    self.SubtitleText.Parent = self.TitleBar
    self.SearchBackground = Instance.new("Frame")
    self.SearchBackground.Name = "SearchBackground"
    self.SearchBackground.Size = UDim2.new(0, 220, 0, 32) 
    self.SearchBackground.Position = UDim2.new(1, -390, 0.5, 0) 
    self.SearchBackground.AnchorPoint = Vector2.new(0, 0.5)
    self.SearchBackground.BackgroundColor3 = Color3.fromRGB(22, 26, 32) 
    self.SearchBackground.BorderSizePixel = 0
    self.SearchBackground.Parent = self.TitleBar
    local searchBorder = Instance.new("UIStroke")
    searchBorder.Color = Color3.fromRGB(40, 50, 60) 
    searchBorder.Thickness = 1
    searchBorder.Parent = self.SearchBackground
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 12) 
    searchCorner.Parent = self.SearchBackground
    local success, Lucide = pcall(function()
        return require(script.Parent.lucide)
    end)
    self.SearchIcon = Instance.new("ImageLabel")
    self.SearchIcon.Name = "SearchIcon"
    self.SearchIcon.Size = UDim2.new(0, 18, 0, 18)
    self.SearchIcon.Position = UDim2.new(0, 12, 0.5, 0)
    self.SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
    self.SearchIcon.BackgroundTransparency = 1
    self.SearchIcon.Image = (success and Lucide and Lucide["search"]) or "rbxassetid://10723416057"
    self.SearchIcon.ImageColor3 = Color3.fromRGB(120, 140, 160) 
    self.SearchIcon.Parent = self.SearchBackground
    self.SearchBox = Instance.new("TextBox")
    self.SearchBox.Name = "SearchBox"
    self.SearchBox.Size = UDim2.new(1, -45, 1, 0)
    self.SearchBox.Position = UDim2.new(0, 40, 0, 0)
    self.SearchBox.BackgroundTransparency = 1
    self.SearchBox.Text = ""
    self.SearchBox.PlaceholderText = "Search components..."
    self.SearchBox.TextColor3 = Color3.fromRGB(240, 245, 250) 
    self.SearchBox.PlaceholderColor3 = Color3.fromRGB(120, 140, 160) 
    self.SearchBox.TextSize = 14
    self.SearchBox.Font = Enum.Font.Gotham
    self.SearchBox.TextXAlignment = Enum.TextXAlignment.Left
    self.SearchBox.Parent = self.SearchBackground
    self.SearchBox.Changed:Connect(function(property)
        if property == "Text" then
            self:FilterComponents(self.SearchBox.Text)
        end
    end)
    self.SearchBox.Focused:Connect(function()
        local bgTween = TweenService:Create(
            self.SearchBackground,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(28, 35, 42)}
        )
        bgTween:Play()
        local borderTween = TweenService:Create(
            searchBorder,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(0, 120, 215)}
        )
        borderTween:Play()
        local iconTween = TweenService:Create(
            self.SearchIcon,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {ImageColor3 = Color3.fromRGB(0, 150, 255)}
        )
        iconTween:Play()
    end)
    self.SearchBox.FocusLost:Connect(function()
        local bgTween = TweenService:Create(
            self.SearchBackground,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(22, 26, 32)}
        )
        bgTween:Play()
        local borderTween = TweenService:Create(
            searchBorder,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(40, 50, 60)}
        )
        borderTween:Play()
        local iconTween = TweenService:Create(
            self.SearchIcon,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {ImageColor3 = Color3.fromRGB(120, 140, 160)}
        )
        iconTween:Play()
    end)
    self.KeybindButton = Instance.new("TextButton")
    self.KeybindButton.Name = "KeybindButton"
    self.KeybindButton.Size = UDim2.new(0, 36, 0, 36)
    self.KeybindButton.Position = UDim2.new(1, -140, 0.5, 0) 
    self.KeybindButton.AnchorPoint = Vector2.new(0, 0.5)
    self.KeybindButton.BackgroundColor3 = Color3.fromRGB(45, 55, 65) 
    self.KeybindButton.Text = "⌨"
    self.KeybindButton.TextColor3 = Color3.fromRGB(200, 220, 240)
    self.KeybindButton.TextSize = 16
    self.KeybindButton.Font = Enum.Font.GothamBold
    self.KeybindButton.BorderSizePixel = 0
    self.KeybindButton.Parent = self.TitleBar
    local keybindBorder = Instance.new("UIStroke")
    keybindBorder.Color = Color3.fromRGB(70, 80, 90)
    keybindBorder.Thickness = 1
    keybindBorder.Parent = self.KeybindButton
    local keybindCorner = Instance.new("UICorner")
    keybindCorner.CornerRadius = UDim.new(0, 10)
    keybindCorner.Parent = self.KeybindButton
    self.MinimizeButton = Instance.new("TextButton")
    self.MinimizeButton.Name = "MinimizeButton"
    self.MinimizeButton.Size = UDim2.new(0, 36, 0, 36)
    self.MinimizeButton.Position = UDim2.new(1, -92, 0.5, 0) 
    self.MinimizeButton.AnchorPoint = Vector2.new(0, 0.5)
    self.MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 70, 80) 
    self.MinimizeButton.Text = "−"
    self.MinimizeButton.TextColor3 = Color3.fromRGB(220, 230, 240)
    self.MinimizeButton.TextSize = 18
    self.MinimizeButton.Font = Enum.Font.GothamBold
    self.MinimizeButton.BorderSizePixel = 0
    self.MinimizeButton.Parent = self.TitleBar
    local minimizeBorder = Instance.new("UIStroke")
    minimizeBorder.Color = Color3.fromRGB(80, 90, 100)
    minimizeBorder.Thickness = 1
    minimizeBorder.Parent = self.MinimizeButton
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 10)
    minimizeCorner.Parent = self.MinimizeButton
    self.CloseButton = Instance.new("TextButton")
    self.CloseButton.Name = "CloseButton"
    self.CloseButton.Size = UDim2.new(0, 36, 0, 36)
    self.CloseButton.Position = UDim2.new(1, -44, 0.5, 0) 
    self.CloseButton.AnchorPoint = Vector2.new(0, 0.5)
    self.CloseButton.BackgroundColor3 = Color3.fromRGB(200, 70, 70) 
    self.CloseButton.Text = "×"
    self.CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.CloseButton.TextSize = 18
    self.CloseButton.Font = Enum.Font.GothamBold
    self.CloseButton.BorderSizePixel = 0
    self.CloseButton.Parent = self.TitleBar
    local closeBorder = Instance.new("UIStroke")
    closeBorder.Color = Color3.fromRGB(220, 90, 90)
    closeBorder.Thickness = 1
    closeBorder.Parent = self.CloseButton
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 10)
    closeCorner.Parent = self.CloseButton
    self.Sidebar = Instance.new("Frame")
    self.Sidebar.Name = "Sidebar"
    self.Sidebar.Size = UDim2.new(0, 200, 1, -70) 
    self.Sidebar.Position = UDim2.new(0, 0, 0, 70)
    self.Sidebar.BackgroundColor3 = Color3.fromRGB(18, 22, 28) 
    self.Sidebar.BorderSizePixel = 0
    self.Sidebar.Parent = self.MainFrame
    local sidebarBorder = Instance.new("UIStroke")
    sidebarBorder.Color = Color3.fromRGB(0, 120, 215) 
    sidebarBorder.Thickness = 1
    sidebarBorder.Transparency = 0.7 
    sidebarBorder.Parent = self.Sidebar
    self.SidebarShadow = Instance.new("Frame")
    self.SidebarShadow.Name = "InnerShadow"
    self.SidebarShadow.Size = UDim2.new(1, -4, 1, -4)
    self.SidebarShadow.Position = UDim2.new(0, 2, 0, 2)
    self.SidebarShadow.BackgroundColor3 = Color3.fromRGB(15, 18, 24) 
    self.SidebarShadow.BackgroundTransparency = 0.5
    self.SidebarShadow.BorderSizePixel = 0
    self.SidebarShadow.Parent = self.Sidebar
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 10)
    shadowCorner.Parent = self.SidebarShadow
    self.TabListContainer = Instance.new("ScrollingFrame")
    self.TabListContainer.Name = "TabListContainer"
    self.TabListContainer.Size = UDim2.new(1, -16, 1, -16)
    self.TabListContainer.Position = UDim2.new(0, 8, 0, 8)
    self.TabListContainer.BackgroundTransparency = 1
    self.TabListContainer.BorderSizePixel = 0
    self.TabListContainer.ScrollBarThickness = 2
    self.TabListContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 120, 215)
    self.TabListContainer.ScrollBarImageTransparency = 0.2
    self.TabListContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    self.TabListContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    self.TabListContainer.Parent = self.Sidebar
    self.TabListLayout = Instance.new("UIListLayout")
    self.TabListLayout.FillDirection = Enum.FillDirection.Vertical
    self.TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.TabListLayout.Padding = UDim.new(0, 2) 
    self.TabListLayout.Parent = self.TabListContainer
    local tabPadding = Instance.new("UIPadding")
    tabPadding.PaddingLeft = UDim.new(0, 8)
    tabPadding.PaddingRight = UDim.new(0, 8)
    tabPadding.PaddingTop = UDim.new(0, 8)
    tabPadding.PaddingBottom = UDim.new(0, 8)
    tabPadding.Parent = self.TabListContainer
    self.ContentContainer = Instance.new("Frame")
    self.ContentContainer.Name = "ContentContainer"
    self.ContentContainer.Size = UDim2.new(1, -200, 1, -70) 
    self.ContentContainer.Position = UDim2.new(0, 200, 0, 70) 
    self.ContentContainer.BackgroundColor3 = Color3.fromRGB(26, 30, 36) 
    self.ContentContainer.BorderSizePixel = 0
    self.ContentContainer.Parent = self.MainFrame
    local contentBorder = Instance.new("UIStroke")
    contentBorder.Color = Color3.fromRGB(0, 120, 215)
    contentBorder.Thickness = 1
    contentBorder.Transparency = 0.8 
    contentBorder.Parent = self.ContentContainer
    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingLeft = UDim.new(0, 8)
    contentPadding.PaddingRight = UDim.new(0, 8)
    contentPadding.PaddingTop = UDim.new(0, 8)
    contentPadding.PaddingBottom = UDim.new(0, 8)
    contentPadding.Parent = self.ContentContainer
    self:MakeDraggable()
    self:SetupKeybindSystem()
    self:UpdateKeybindDisplay() 
    self.IsMinimized = false
    self.OriginalSize = self.MainFrame.Size
    self.ToggleKeybind = Enum.KeyCode.Insert 
    self.IsListeningForKeybind = false
    self.KeybindButton.MouseButton1Click:Connect(function()
        self:StartKeybindListening()
    end)
    self.MinimizeButton.MouseButton1Click:Connect(function()
        self:ToggleMinimize()
    end)
    self.KeybindButton.MouseEnter:Connect(function()
        local bgTween = TweenService:Create(
            self.KeybindButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
        )
        bgTween:Play()
        local borderTween = TweenService:Create(
            keybindBorder,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(100, 180, 255)}
        )
        borderTween:Play()
        local textTween = TweenService:Create(
            self.KeybindButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {TextColor3 = Color3.fromRGB(255, 255, 255)}
        )
        textTween:Play()
    end)
    self.KeybindButton.MouseLeave:Connect(function()
        local bgTween = TweenService:Create(
            self.KeybindButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(45, 55, 65)}
        )
        bgTween:Play()
        local borderTween = TweenService:Create(
            keybindBorder,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(70, 80, 90)}
        )
        borderTween:Play()
        local textTween = TweenService:Create(
            self.KeybindButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {TextColor3 = Color3.fromRGB(200, 220, 240)}
        )
        textTween:Play()
    end)
    self.MinimizeButton.MouseEnter:Connect(function()
        local bgTween = TweenService:Create(
            self.MinimizeButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(80, 90, 100)}
        )
        bgTween:Play()
        local borderTween = TweenService:Create(
            minimizeBorder,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(120, 130, 140)}
        )
        borderTween:Play()
        local textTween = TweenService:Create(
            self.MinimizeButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {TextColor3 = Color3.fromRGB(255, 255, 255)}
        )
        textTween:Play()
    end)
    self.MinimizeButton.MouseLeave:Connect(function()
        local bgTween = TweenService:Create(
            self.MinimizeButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(60, 70, 80)}
        )
        bgTween:Play()
        local borderTween = TweenService:Create(
            minimizeBorder,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(80, 90, 100)}
        )
        borderTween:Play()
        local textTween = TweenService:Create(
            self.MinimizeButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {TextColor3 = Color3.fromRGB(220, 230, 240)}
        )
        textTween:Play()
    end)
    self.CloseButton.MouseButton1Click:Connect(function()
        self.ScreenGui:Destroy()
    end)
    self.CloseButton.MouseEnter:Connect(function()
        local bgTween = TweenService:Create(
            self.CloseButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(255, 90, 90)}
        )
        bgTween:Play()
        local borderTween = TweenService:Create(
            closeBorder,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(255, 120, 120)}
        )
        borderTween:Play()
        local scaleTween = TweenService:Create(
            self.CloseButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 38, 0, 38)}
        )
        scaleTween:Play()
    end)
    self.CloseButton.MouseLeave:Connect(function()
        local bgTween = TweenService:Create(
            self.CloseButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(200, 70, 70)}
        )
        bgTween:Play()
        local borderTween = TweenService:Create(
            closeBorder,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Color = Color3.fromRGB(220, 90, 90)}
        )
        borderTween:Play()
        local scaleTween = TweenService:Create(
            self.CloseButton,
            TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 36, 0, 36)}
        )
        scaleTween:Play()
    end)
    return self
end
function Window:MakeDraggable()
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    local function updateInput(input)
        local delta = input.Position - dragStart
        self.MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    self.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    self.TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)
end
function Window:Tab(options)
    options = options or {}
    options.Name = options.Name or "Tab"
    options.tabColor = options.tabColor or self.Library.Colors.Accent
    options.Icon = options.Icon or ""
    options.OptionsManager = self.OptionsManager
    local tab = require(script.Parent.Tab).new(options, self)
    table.insert(self.Tabs, tab)
    if #self.Tabs == 1 then
        self:SelectTab(tab)
    end
    return tab
end
function Window:SelectTab(tab)
    for _, t in ipairs(self.Tabs) do
        t:Hide()
    end
    tab:Show()
    self.ActiveTab = tab
end
function Window:ToggleMinimize()
    local TweenService = game:GetService("TweenService")
    if not self.IsMinimized then
        self.IsMinimized = true
        self.MinimizeButton.Text = "+"
        self.ContentContainer.Visible = false
        self.Sidebar.Visible = false
        local minimizeTween = TweenService:Create(
            self.MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 400, 0, 60)}
        )
        minimizeTween:Play()
    else
        self.IsMinimized = false
        self.MinimizeButton.Text = "−"
        local restoreTween = TweenService:Create(
            self.MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = self.OriginalSize}
        )
        restoreTween:Play()
        restoreTween.Completed:Connect(function()
            self.ContentContainer.Visible = true
            self.Sidebar.Visible = true
        end)
    end
end
function Window:CreateMobileIcon()
    self.MobileIcon = Instance.new("ScreenGui")
    self.MobileIcon.Name = "ProjectMadaraMobile"
    self.MobileIcon.ResetOnSpawn = false
    self.MobileIcon.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.MobileIcon.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    self.MobileContainer = Instance.new("Frame")
    self.MobileContainer.Name = "MobileContainer"
    self.MobileContainer.Size = UDim2.new(0, 60, 0, 60)
    self.MobileContainer.Position = UDim2.new(0, 20, 0, 100) 
    self.MobileContainer.BackgroundTransparency = 1
    self.MobileContainer.Parent = self.MobileIcon
    self.MobileButton = Instance.new("TextButton")
    self.MobileButton.Name = "MobileButton"
    self.MobileButton.Size = UDim2.new(0, 50, 0, 50)
    self.MobileButton.Position = UDim2.new(0, 5, 0, 5)
    self.MobileButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215) 
    self.MobileButton.Text = "M"
    self.MobileButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.MobileButton.TextSize = 22
    self.MobileButton.Font = Enum.Font.GothamBold
    self.MobileButton.BorderSizePixel = 0
    self.MobileButton.Parent = self.MobileContainer
    local mobileCorner = Instance.new("UICorner")
    mobileCorner.CornerRadius = UDim.new(0, 25) 
    mobileCorner.Parent = self.MobileButton
    local mobileBorder = Instance.new("UIStroke")
    mobileBorder.Color = Color3.fromRGB(100, 180, 255)
    mobileBorder.Thickness = 2
    mobileBorder.Transparency = 0.3
    mobileBorder.Parent = self.MobileButton
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 6, 1, 6)
    shadow.Position = UDim2.new(0, -3, 0, -3)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.7
    shadow.BorderSizePixel = 0
    shadow.ZIndex = self.MobileButton.ZIndex - 1
    shadow.Parent = self.MobileButton
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 25)
    shadowCorner.Parent = shadow
    self:MakeMobileDraggable()
    local tapStartTime = 0
    local isDragging = false
    self.MobileButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            tapStartTime = tick()
            isDragging = false
        end
    end)
    self.MobileButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            local tapDuration = tick() - tapStartTime
            if tapDuration < 0.3 and not isDragging then
                self:ToggleVisibility()
                self:MobileButtonFeedback()
            end
        end
    end)
    self.MobileButton.MouseEnter:Connect(function()
        local hoverTween = TweenService:Create(
            self.MobileButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(30, 140, 235)}
        )
        hoverTween:Play()
        local borderTween = TweenService:Create(
            mobileBorder,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Transparency = 0.1}
        )
        borderTween:Play()
    end)
    self.MobileButton.MouseLeave:Connect(function()
        local leaveTween = TweenService:Create(
            self.MobileButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
        )
        leaveTween:Play()
        local borderTween = TweenService:Create(
            mobileBorder,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Transparency = 0.3}
        )
        borderTween:Play()
    end)
    self.MobileContainer.Visible = not self.ScreenGui.Enabled
end
function Window:MakeMobileDraggable()
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    local function updateInput(input)
        local delta = input.Position - dragStart
        local newPos = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
        local screenSize = workspace.CurrentCamera.ViewportSize
        local buttonSize = self.MobileContainer.AbsoluteSize
        local clampedX = math.clamp(newPos.X.Offset, 0, screenSize.X - buttonSize.X)
        local clampedY = math.clamp(newPos.Y.Offset, 0, screenSize.Y - buttonSize.Y)
        self.MobileContainer.Position = UDim2.new(0, clampedX, 0, clampedY)
    end
    self.MobileContainer.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.MobileContainer.Position
            local scaleTween = TweenService:Create(
                self.MobileButton,
                TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 45, 0, 45)}
            )
            scaleTween:Play()
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    local scaleTween = TweenService:Create(
                        self.MobileButton,
                        TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 50, 0, 50)}
                    )
                    scaleTween:Play()
                end
            end)
        end
    end)
    self.MobileContainer.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
            if dragging then
                isDragging = true 
            end
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)
end
function Window:MobileButtonFeedback()
    local scaleTween = TweenService:Create(
        self.MobileButton,
        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 45, 0, 45)}
    )
    scaleTween:Play()
    scaleTween.Completed:Connect(function()
        local returnTween = TweenService:Create(
            self.MobileButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 50, 0, 50)}
        )
        returnTween:Play()
    end)
    local colorTween = TweenService:Create(
        self.MobileButton,
        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {BackgroundColor3 = Color3.fromRGB(100, 200, 255)}
    )
    colorTween:Play()
    colorTween.Completed:Connect(function()
        local returnColorTween = TweenService:Create(
            self.MobileButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(0, 120, 215)}
        )
        returnColorTween:Play()
    end)
end
function Window:SetupKeybindSystem()
    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if self.IsListeningForKeybind then
            self.ToggleKeybind = input.KeyCode
            self.IsListeningForKeybind = false
            self:UpdateKeybindDisplay()
            self.KeybindButton.BackgroundColor3 = Color3.fromRGB(45, 55, 65)
            return
        end
        if input.KeyCode == self.ToggleKeybind then
            self:ToggleVisibility()
        end
    end)
end
function Window:StartKeybindListening()
    self.IsListeningForKeybind = true
    self.KeybindButton.Text = "..."
    self.KeybindButton.BackgroundColor3 = Color3.fromRGB(88, 166, 255) 
end
function Window:UpdateKeybindDisplay()
    local keyName = tostring(self.ToggleKeybind):gsub("Enum.KeyCode.", "")
    self.KeybindButton.Text = keyName:upper()
    self.KeybindButton.TextSize = #keyName > 3 and 10 or 12 
end
function Window:ToggleVisibility()
    self.ScreenGui.Enabled = not self.ScreenGui.Enabled
end
function Window:FilterComponents(searchText)
    if not self.ActiveTab then return end
    searchText = searchText:lower()
    for _, child in ipairs(self.ActiveTab.Container:GetChildren()) do
        if child:IsA("Frame") and child.Name:find("Button") or child.Name:find("Toggle") or child.Name:find("TextBox") or child.Name:find("Dropdown") or child.Name:find("Slider") then
            local nameLabel = child:FindFirstChild("Name") or child:FindFirstChild("Text")
            if nameLabel and nameLabel:IsA("TextLabel") then
                local componentName = nameLabel.Text:lower()
                if searchText == "" or componentName:find(searchText) then
                    child.Visible = true
                else
                    child.Visible = false
                end
            end
        end
    end
end
function Window:Show()
    self.ScreenGui.Enabled = true
    self.MainFrame.Size = UDim2.new(0, 0, 0, 0)
    local showTween = TweenService:Create(
        self.MainFrame,
        TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        {Size = self.OriginalSize}
    )
    showTween:Play()
end
function Window:Hide()
    self.ScreenGui.Enabled = false
end
function Window:ToggleVisibility()
    if self.ScreenGui.Enabled then
        self.ScreenGui.Enabled = false
        if self.MobileContainer then
            self.MobileContainer.Visible = true
        end
        if self.ToggleContainer then
            self.ToggleContainer.Visible = true
        end
        if self.MobileButton then
            self.MobileButton.Size = UDim2.new(0, 30, 0, 30)
            local appearTween = TweenService:Create(
                self.MobileButton,
                TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 50, 0, 50)}
            )
            appearTween:Play()
        end
        if self.ToggleButton then
            self.ToggleButton.Size = UDim2.new(0, 40, 0, 40)
            local toggleAppearTween = TweenService:Create(
                self.ToggleButton,
                TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 60, 0, 60)}
            )
            toggleAppearTween:Play()
        end
    else
        self.ScreenGui.Enabled = true
        if self.MobileContainer then
            self.MobileContainer.Visible = false
        end
        if self.ToggleContainer then
            self.ToggleContainer.Visible = false
        end
        self.MainFrame.Size = UDim2.new(0, 600, 0, 500)
        local showTween = TweenService:Create(
            self.MainFrame,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 675, 0, 550)}
        )
        showTween:Play()
    end
end
function Window:CreateMobileToggleButton()
    self.MobileToggleGui = Instance.new("ScreenGui")
    self.MobileToggleGui.Name = "ProjectMadaraToggleControls"
    self.MobileToggleGui.ResetOnSpawn = false
    self.MobileToggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.MobileToggleGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    self.ToggleContainer = Instance.new("Frame")
    self.ToggleContainer.Name = "ToggleContainer"
    self.ToggleContainer.Size = UDim2.new(0, 70, 0, 70)
    self.ToggleContainer.Position = UDim2.new(1, -90, 0, 150) 
    self.ToggleContainer.BackgroundTransparency = 1
    self.ToggleContainer.Parent = self.MobileToggleGui
    self.ToggleButton = Instance.new("TextButton")
    self.ToggleButton.Name = "ToggleButton"
    self.ToggleButton.Size = UDim2.new(0, 60, 0, 60)
    self.ToggleButton.Position = UDim2.new(0, 5, 0, 5)
    self.ToggleButton.BackgroundColor3 = Color3.fromRGB(45, 55, 65) 
    self.ToggleButton.Text = "⚡" 
    self.ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    self.ToggleButton.TextSize = 24
    self.ToggleButton.Font = Enum.Font.GothamBold
    self.ToggleButton.BorderSizePixel = 0
    self.ToggleButton.Parent = self.ToggleContainer
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 30) 
    toggleCorner.Parent = self.ToggleButton
    local toggleBorder = Instance.new("UIStroke")
    toggleBorder.Color = Color3.fromRGB(255, 165, 0) 
    toggleBorder.Thickness = 2
    toggleBorder.Transparency = 0.3
    toggleBorder.Parent = self.ToggleButton
    local toggleShadow = Instance.new("Frame")
    toggleShadow.Name = "Shadow"
    toggleShadow.Size = UDim2.new(1, 6, 1, 6)
    toggleShadow.Position = UDim2.new(0, -3, 0, -3)
    toggleShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleShadow.BackgroundTransparency = 0.7
    toggleShadow.BorderSizePixel = 0
    toggleShadow.ZIndex = self.ToggleButton.ZIndex - 1
    toggleShadow.Parent = self.ToggleButton
    local toggleShadowCorner = Instance.new("UICorner")
    toggleShadowCorner.CornerRadius = UDim.new(0, 30)
    toggleShadowCorner.Parent = toggleShadow
    self.ToggleButtonState = "off" 
    self.ToggleStates = {"off", "on", "auto"}
    self.ToggleIcons = {"⚡", "🔥", "🤖"} 
    self.ToggleColors = {
        Color3.fromRGB(45, 55, 65),   
        Color3.fromRGB(0, 200, 100),  
        Color3.fromRGB(255, 165, 0)   
    }
    self.ToggleBorderColors = {
        Color3.fromRGB(100, 110, 120), 
        Color3.fromRGB(100, 255, 150), 
        Color3.fromRGB(255, 200, 100)  
    }
    self:MakeToggleDraggable()
    local tapStartTime = 0
    local isToggleDragging = false
    self.ToggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            tapStartTime = tick()
            isToggleDragging = false
        end
    end)
    self.ToggleButton.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            local tapDuration = tick() - tapStartTime
            if tapDuration < 0.3 and not isToggleDragging then
                self:CycleToggleState()
                self:ToggleButtonFeedback()
            end
        end
    end)
    self.ToggleButton.MouseEnter:Connect(function()
        local currentStateIndex = self:GetToggleStateIndex()
        local hoverColor = self.ToggleColors[currentStateIndex]
        local r = math.min(255, hoverColor.R * 255 + 30)
        local g = math.min(255, hoverColor.G * 255 + 30)
        local b = math.min(255, hoverColor.B * 255 + 30)
        local hoverTween = TweenService:Create(
            self.ToggleButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(r, g, b)}
        )
        hoverTween:Play()
        local borderTween = TweenService:Create(
            toggleBorder,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Transparency = 0.1}
        )
        borderTween:Play()
    end)
    self.ToggleButton.MouseLeave:Connect(function()
        local currentStateIndex = self:GetToggleStateIndex()
        local leaveTween = TweenService:Create(
            self.ToggleButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {BackgroundColor3 = self.ToggleColors[currentStateIndex]}
        )
        leaveTween:Play()
        local borderTween = TweenService:Create(
            toggleBorder,
            TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
            {Transparency = 0.3}
        )
        borderTween:Play()
    end)
    self.ToggleContainer.Visible = not self.ScreenGui.Enabled
end
function Window:MakeToggleDraggable()
    local dragging = false
    local dragInput
    local dragStart
    local startPos
    local function updateInput(input)
        local delta = input.Position - dragStart
        local newPos = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
        local screenSize = workspace.CurrentCamera.ViewportSize
        local buttonSize = self.ToggleContainer.AbsoluteSize
        local clampedX = math.clamp(newPos.X.Offset, 0, screenSize.X - buttonSize.X)
        local clampedY = math.clamp(newPos.Y.Offset, 0, screenSize.Y - buttonSize.Y)
        self.ToggleContainer.Position = UDim2.new(0, clampedX, 0, clampedY)
    end
    self.ToggleContainer.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.ToggleContainer.Position
            local scaleTween = TweenService:Create(
                self.ToggleButton,
                TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 55, 0, 55)}
            )
            scaleTween:Play()
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    local scaleTween = TweenService:Create(
                        self.ToggleButton,
                        TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 60, 0, 60)}
                    )
                    scaleTween:Play()
                end
            end)
        end
    end)
    self.ToggleContainer.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
            if dragging then
                isToggleDragging = true 
            end
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)
end
function Window:CycleToggleState()
    local currentIndex = self:GetToggleStateIndex()
    local nextIndex = (currentIndex % #self.ToggleStates) + 1
    self.ToggleButtonState = self.ToggleStates[nextIndex]
    self.ToggleButton.Text = self.ToggleIcons[nextIndex]
    local colorTween = TweenService:Create(
        self.ToggleButton,
        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {BackgroundColor3 = self.ToggleColors[nextIndex]}
    )
    colorTween:Play()
    local borderTween = TweenService:Create(
        self.ToggleButton.UIStroke,
        TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Color = self.ToggleBorderColors[nextIndex]}
    )
    borderTween:Play()
    self:HandleToggleStateChange(self.ToggleButtonState)
end
function Window:GetToggleStateIndex()
    for i, state in ipairs(self.ToggleStates) do
        if state == self.ToggleButtonState then
            return i
        end
    end
    return 1 
end
function Window:HandleToggleStateChange(newState)
    if newState == "off" then
        print("All toggles OFF")
    elseif newState == "on" then
        print("All toggles ON")
    elseif newState == "auto" then
        print("Toggles set to AUTO")
    end
end
function Window:ToggleButtonFeedback()
    local scaleTween = TweenService:Create(
        self.ToggleButton,
        TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Size = UDim2.new(0, 55, 0, 55)}
    )
    scaleTween:Play()
    scaleTween.Completed:Connect(function()
        local returnTween = TweenService:Create(
            self.ToggleButton,
            TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {Size = UDim2.new(0, 60, 0, 60)}
        )
        returnTween:Play()
    end)
end
function Window:FilterComponents(searchText)
    if self.ActiveTab and self.ActiveTab.FilterComponents then
        self.ActiveTab:FilterComponents(searchText)
    end
end

function Window:SaveComponentConfig(tabName, componentName, value)
    if self.ConfigEnabled and self.Config then
        self.Config:SaveComponentValue(tabName, componentName, value)
    end
end

function Window:GetComponentConfig(tabName, componentName, defaultValue)
    if self.ConfigEnabled and self.Config then
        return self.Config:GetComponentValue(tabName, componentName, defaultValue)
    end
    return defaultValue
end

return Window
end)() end,
    function()local wax,script,require=ImportGlobals(19)local ImportGlobals return (function(...)local assets = {
	["accessibility"] = "rbxassetid://10709751939",
	["activity"] = "rbxassetid://10709752035",
	["air-vent"] = "rbxassetid://10709752131",
	["airplay"] = "rbxassetid://10709752254",
	["alarm-check"] = "rbxassetid://10709752405",
	["alarm-clock"] = "rbxassetid://10709752630",
	["alarm-clock-off"] = "rbxassetid://10709752508",
	["alarm-minus"] = "rbxassetid://10709752732",
	["alarm-plus"] = "rbxassetid://10709752825",
	["album"] = "rbxassetid://10709752906",
	["alert-circle"] = "rbxassetid://10709752996",
	["alert-octagon"] = "rbxassetid://10709753064",
	["alert-triangle"] = "rbxassetid://10709753149",
	["align-center"] = "rbxassetid://10709753570",
	["align-center-horizontal"] = "rbxassetid://10709753272",
	["align-center-vertical"] = "rbxassetid://10709753421",
	["align-end-horizontal"] = "rbxassetid://10709753692",
	["align-end-vertical"] = "rbxassetid://10709753808",
	["align-horizontal-distribute-center"] = "rbxassetid://10747779791",
	["align-horizontal-distribute-end"] = "rbxassetid://10747784534",
	["align-horizontal-distribute-start"] = "rbxassetid://10709754118",
	["align-horizontal-justify-center"] = "rbxassetid://10709754204",
	["align-horizontal-justify-end"] = "rbxassetid://10709754317",
	["align-horizontal-justify-start"] = "rbxassetid://10709754436",
	["align-horizontal-space-around"] = "rbxassetid://10709754590",
	["align-horizontal-space-between"] = "rbxassetid://10709754749",
	["align-justify"] = "rbxassetid://10709759610",
	["align-left"] = "rbxassetid://10709759764",
	["align-right"] = "rbxassetid://10709759895",
	["align-start-horizontal"] = "rbxassetid://10709760051",
	["align-start-vertical"] = "rbxassetid://10709760244",
	["align-vertical-distribute-center"] = "rbxassetid://10709760351",
	["align-vertical-distribute-end"] = "rbxassetid://10709760434",
	["align-vertical-distribute-start"] = "rbxassetid://10709760612",
	["align-vertical-justify-center"] = "rbxassetid://10709760814",
	["align-vertical-justify-end"] = "rbxassetid://10709761003",
	["align-vertical-justify-start"] = "rbxassetid://10709761176",
	["align-vertical-space-around"] = "rbxassetid://10709761324",
	["align-vertical-space-between"] = "rbxassetid://10709761434",
	["anchor"] = "rbxassetid://10709761530",
	["angry"] = "rbxassetid://10709761629",
	["annoyed"] = "rbxassetid://10709761722",
	["aperture"] = "rbxassetid://10709761813",
	["apple"] = "rbxassetid://10709761889",
	["archive"] = "rbxassetid://10709762233",
	["archive-restore"] = "rbxassetid://10709762058",
	["armchair"] = "rbxassetid://10709762327",
	["arrow-big-down"] = "rbxassetid://10747796644",
	["arrow-big-left"] = "rbxassetid://10709762574",
	["arrow-big-right"] = "rbxassetid://10709762727",
	["arrow-big-up"] = "rbxassetid://10709762879",
	["arrow-down"] = "rbxassetid://10709767827",
	["arrow-down-circle"] = "rbxassetid://10709763034",
	["arrow-down-left"] = "rbxassetid://10709767656",
	["arrow-down-right"] = "rbxassetid://10709767750",
	["arrow-left"] = "rbxassetid://10709768114",
	["arrow-left-circle"] = "rbxassetid://10709767936",
	["arrow-left-right"] = "rbxassetid://10709768019",
	["arrow-right"] = "rbxassetid://10709768347",
	["arrow-right-circle"] = "rbxassetid://10709768226",
	["arrow-up"] = "rbxassetid://10709768939",
	["arrow-up-circle"] = "rbxassetid://10709768432",
	["arrow-up-down"] = "rbxassetid://10709768538",
	["arrow-up-left"] = "rbxassetid://10709768661",
	["arrow-up-right"] = "rbxassetid://10709768787",
	["asterisk"] = "rbxassetid://10709769095",
	["at-sign"] = "rbxassetid://10709769286",
	["award"] = "rbxassetid://10709769406",
	["axe"] = "rbxassetid://10709769508",
	["axis-3d"] = "rbxassetid://10709769598",
	["baby"] = "rbxassetid://10709769732",
	["backpack"] = "rbxassetid://10709769841",
	["baggage-claim"] = "rbxassetid://10709769935",
	["banana"] = "rbxassetid://10709770005",
	["banknote"] = "rbxassetid://10709770178",
	["bar-chart"] = "rbxassetid://10709773755",
	["bar-chart-2"] = "rbxassetid://10709770317",
	["bar-chart-3"] = "rbxassetid://10709770431",
	["bar-chart-4"] = "rbxassetid://10709770560",
	["bar-chart-horizontal"] = "rbxassetid://10709773669",
	["barcode"] = "rbxassetid://10747360675",
	["baseline"] = "rbxassetid://10709773863",
	["bath"] = "rbxassetid://10709773963",
	["battery"] = "rbxassetid://10709774640",
	["battery-charging"] = "rbxassetid://10709774068",
	["battery-full"] = "rbxassetid://10709774206",
	["battery-low"] = "rbxassetid://10709774370",
	["battery-medium"] = "rbxassetid://10709774513",
	["beaker"] = "rbxassetid://10709774756",
	["bed"] = "rbxassetid://10709775036",
	["bed-double"] = "rbxassetid://10709774864",
	["bed-single"] = "rbxassetid://10709774968",
	["beer"] = "rbxassetid://10709775167",
	["bell"] = "rbxassetid://10709775704",
	["bell-minus"] = "rbxassetid://10709775241",
	["bell-off"] = "rbxassetid://10709775320",
	["bell-plus"] = "rbxassetid://10709775448",
	["bell-ring"] = "rbxassetid://10709775560",
	["bike"] = "rbxassetid://10709775894",
	["binary"] = "rbxassetid://10709776050",
	["bitcoin"] = "rbxassetid://10709776126",
	["bluetooth"] = "rbxassetid://10709776655",
	["bluetooth-connected"] = "rbxassetid://10709776240",
	["bluetooth-off"] = "rbxassetid://10709776344",
	["bluetooth-searching"] = "rbxassetid://10709776501",
	["bold"] = "rbxassetid://10747813908",
	["bomb"] = "rbxassetid://10709781460",
	["bone"] = "rbxassetid://10709781605",
	["book"] = "rbxassetid://10709781824",
	["book-open"] = "rbxassetid://10709781717",
	["bookmark"] = "rbxassetid://10709782154",
	["bookmark-minus"] = "rbxassetid://10709781919",
	["bookmark-plus"] = "rbxassetid://10709782044",
	["bot"] = "rbxassetid://10709782230",
	["box"] = "rbxassetid://10709782497",
	["box-select"] = "rbxassetid://10709782342",
	["boxes"] = "rbxassetid://10709782582",
	["briefcase"] = "rbxassetid://10709782662",
	["brush"] = "rbxassetid://10709782758",
	["bug"] = "rbxassetid://10709782845",
	["building"] = "rbxassetid://10709783051",
	["building-2"] = "rbxassetid://10709782939",
	["bus"] = "rbxassetid://10709783137",
	["cake"] = "rbxassetid://10709783217",
	["calculator"] = "rbxassetid://10709783311",
	["calendar"] = "rbxassetid://10709789505",
	["calendar-check"] = "rbxassetid://10709783474",
	["calendar-check-2"] = "rbxassetid://10709783392",
	["calendar-clock"] = "rbxassetid://10709783577",
	["calendar-days"] = "rbxassetid://10709783673",
	["calendar-heart"] = "rbxassetid://10709783835",
	["calendar-minus"] = "rbxassetid://10709783959",
	["calendar-off"] = "rbxassetid://10709788784",
	["calendar-plus"] = "rbxassetid://10709788937",
	["calendar-range"] = "rbxassetid://10709789053",
	["calendar-search"] = "rbxassetid://10709789200",
	["calendar-x"] = "rbxassetid://10709789407",
	["calendar-x-2"] = "rbxassetid://10709789329",
	["camera"] = "rbxassetid://10709789686",
	["camera-off"] = "rbxassetid://10747822677",
	["car"] = "rbxassetid://10709789810",
	["carrot"] = "rbxassetid://10709789960",
	["cast"] = "rbxassetid://10709790097",
	["charge"] = "rbxassetid://10709790202",
	["check"] = "rbxassetid://10709790644",
	["check-circle"] = "rbxassetid://10709790387",
	["check-circle-2"] = "rbxassetid://10709790298",
	["check-square"] = "rbxassetid://10709790537",
	["chef-hat"] = "rbxassetid://10709790757",
	["cherry"] = "rbxassetid://10709790875",
	["chevron-down"] = "rbxassetid://10709790948",
	["chevron-first"] = "rbxassetid://10709791015",
	["chevron-last"] = "rbxassetid://10709791130",
	["chevron-left"] = "rbxassetid://10709791281",
	["chevron-right"] = "rbxassetid://10709791437",
	["chevron-up"] = "rbxassetid://10709791523",
	["chevrons-down"] = "rbxassetid://10709796864",
	["chevrons-down-up"] = "rbxassetid://10709791632",
	["chevrons-left"] = "rbxassetid://10709797151",
	["chevrons-left-right"] = "rbxassetid://10709797006",
	["chevrons-right"] = "rbxassetid://10709797382",
	["chevrons-right-left"] = "rbxassetid://10709797274",
	["chevrons-up"] = "rbxassetid://10709797622",
	["chevrons-up-down"] = "rbxassetid://10709797508",
	["chrome"] = "rbxassetid://10709797725",
	["circle"] = "rbxassetid://10709798174",
	["circle-dot"] = "rbxassetid://10709797837",
	["circle-ellipsis"] = "rbxassetid://10709797985",
	["circle-slashed"] = "rbxassetid://10709798100",
	["citrus"] = "rbxassetid://10709798276",
	["clapperboard"] = "rbxassetid://10709798350",
	["clipboard"] = "rbxassetid://10709799288",
	["clipboard-check"] = "rbxassetid://10709798443",
	["clipboard-copy"] = "rbxassetid://10709798574",
	["clipboard-edit"] = "rbxassetid://10709798682",
	["clipboard-list"] = "rbxassetid://10709798792",
	["clipboard-signature"] = "rbxassetid://10709798890",
	["clipboard-type"] = "rbxassetid://10709798999",
	["clipboard-x"] = "rbxassetid://10709799124",
	["clock"] = "rbxassetid://10709805144",
	["clock-1"] = "rbxassetid://10709799535",
	["clock-10"] = "rbxassetid://10709799718",
	["clock-11"] = "rbxassetid://10709799818",
	["clock-12"] = "rbxassetid://10709799962",
	["clock-2"] = "rbxassetid://10709803876",
	["clock-3"] = "rbxassetid://10709803989",
	["clock-4"] = "rbxassetid://10709804164",
	["clock-5"] = "rbxassetid://10709804291",
	["clock-6"] = "rbxassetid://10709804435",
	["clock-7"] = "rbxassetid://10709804599",
	["clock-8"] = "rbxassetid://10709804784",
	["clock-9"] = "rbxassetid://10709804996",
	["cloud"] = "rbxassetid://10709806740",
	["cloud-cog"] = "rbxassetid://10709805262",
	["cloud-drizzle"] = "rbxassetid://10709805371",
	["cloud-fog"] = "rbxassetid://10709805477",
	["cloud-hail"] = "rbxassetid://10709805596",
	["cloud-lightning"] = "rbxassetid://10709805727",
	["cloud-moon"] = "rbxassetid://10709805942",
	["cloud-moon-rain"] = "rbxassetid://10709805838",
	["cloud-off"] = "rbxassetid://10709806060",
	["cloud-rain"] = "rbxassetid://10709806277",
	["cloud-rain-wind"] = "rbxassetid://10709806166",
	["cloud-snow"] = "rbxassetid://10709806374",
	["cloud-sun"] = "rbxassetid://10709806631",
	["cloud-sun-rain"] = "rbxassetid://10709806475",
	["cloudy"] = "rbxassetid://10709806859",
	["clover"] = "rbxassetid://10709806995",
	["code"] = "rbxassetid://10709810463",
	["code-2"] = "rbxassetid://10709807111",
	["codepen"] = "rbxassetid://10709810534",
	["codesandbox"] = "rbxassetid://10709810676",
	["coffee"] = "rbxassetid://10709810814",
	["cog"] = "rbxassetid://10709810948",
	["coins"] = "rbxassetid://10709811110",
	["columns"] = "rbxassetid://10709811261",
	["command"] = "rbxassetid://10709811365",
	["compass"] = "rbxassetid://10709811445",
	["component"] = "rbxassetid://10709811595",
	["concierge-bell"] = "rbxassetid://10709811706",
	["connection"] = "rbxassetid://10747361219",
	["contact"] = "rbxassetid://10709811834",
	["contrast"] = "rbxassetid://10709811939",
	["cookie"] = "rbxassetid://10709812067",
	["copy"] = "rbxassetid://10709812159",
	["copyleft"] = "rbxassetid://10709812251",
	["copyright"] = "rbxassetid://10709812311",
	["corner-down-left"] = "rbxassetid://10709812396",
	["corner-down-right"] = "rbxassetid://10709812485",
	["corner-left-down"] = "rbxassetid://10709812632",
	["corner-left-up"] = "rbxassetid://10709812784",
	["corner-right-down"] = "rbxassetid://10709812939",
	["corner-right-up"] = "rbxassetid://10709813094",
	["corner-up-left"] = "rbxassetid://10709813185",
	["corner-up-right"] = "rbxassetid://10709813281",
	["cpu"] = "rbxassetid://10709813383",
	["croissant"] = "rbxassetid://10709818125",
	["crop"] = "rbxassetid://10709818245",
	["cross"] = "rbxassetid://10709818399",
	["crosshair"] = "rbxassetid://10709818534",
	["crown"] = "rbxassetid://10709818626",
	["cup-soda"] = "rbxassetid://10709818763",
	["curly-braces"] = "rbxassetid://10709818847",
	["currency"] = "rbxassetid://10709818931",
	["database"] = "rbxassetid://10709818996",
	["delete"] = "rbxassetid://10709819059",
	["diamond"] = "rbxassetid://10709819149",
	["dice-1"] = "rbxassetid://10709819266",
	["dice-2"] = "rbxassetid://10709819361",
	["dice-3"] = "rbxassetid://10709819508",
	["dice-4"] = "rbxassetid://10709819670",
	["dice-5"] = "rbxassetid://10709819801",
	["dice-6"] = "rbxassetid://10709819896",
	["dices"] = "rbxassetid://10723343321",
	["diff"] = "rbxassetid://10723343416",
	["disc"] = "rbxassetid://10723343537",
	["divide"] = "rbxassetid://10723343805",
	["divide-circle"] = "rbxassetid://10723343636",
	["divide-square"] = "rbxassetid://10723343737",
	["dollar-sign"] = "rbxassetid://10723343958",
	["download"] = "rbxassetid://10723344270",
	["download-cloud"] = "rbxassetid://10723344088",
	["droplet"] = "rbxassetid://10723344432",
	["droplets"] = "rbxassetid://10734883356",
	["drumstick"] = "rbxassetid://10723344737",
	["edit"] = "rbxassetid://10734883598",
	["edit-2"] = "rbxassetid://10723344885",
	["edit-3"] = "rbxassetid://10723345088",
	["egg"] = "rbxassetid://10723345518",
	["egg-fried"] = "rbxassetid://10723345347",
	["electricity"] = "rbxassetid://10723345749",
	["electricity-off"] = "rbxassetid://10723345643",
	["equal"] = "rbxassetid://10723345990",
	["equal-not"] = "rbxassetid://10723345866",
	["eraser"] = "rbxassetid://10723346158",
	["euro"] = "rbxassetid://10723346372",
	["expand"] = "rbxassetid://10723346553",
	["external-link"] = "rbxassetid://10723346684",
	["eye"] = "rbxassetid://10723346959",
	["eye-off"] = "rbxassetid://10723346871",
	["factory"] = "rbxassetid://10723347051",
	["fan"] = "rbxassetid://10723354359",
	["fast-forward"] = "rbxassetid://10723354521",
	["feather"] = "rbxassetid://10723354671",
	["figma"] = "rbxassetid://10723354801",
	["file"] = "rbxassetid://10723374641",
	["file-archive"] = "rbxassetid://10723354921",
	["file-audio"] = "rbxassetid://10723355148",
	["file-audio-2"] = "rbxassetid://10723355026",
	["file-axis-3d"] = "rbxassetid://10723355272",
	["file-badge"] = "rbxassetid://10723355622",
	["file-badge-2"] = "rbxassetid://10723355451",
	["file-bar-chart"] = "rbxassetid://10723355887",
	["file-bar-chart-2"] = "rbxassetid://10723355746",
	["file-box"] = "rbxassetid://10723355989",
	["file-check"] = "rbxassetid://10723356210",
	["file-check-2"] = "rbxassetid://10723356100",
	["file-clock"] = "rbxassetid://10723356329",
	["file-code"] = "rbxassetid://10723356507",
	["file-cog"] = "rbxassetid://10723356830",
	["file-cog-2"] = "rbxassetid://10723356676",
	["file-diff"] = "rbxassetid://10723357039",
	["file-digit"] = "rbxassetid://10723357151",
	["file-down"] = "rbxassetid://10723357322",
	["file-edit"] = "rbxassetid://10723357495",
	["file-heart"] = "rbxassetid://10723357637",
	["file-image"] = "rbxassetid://10723357790",
	["file-input"] = "rbxassetid://10723357933",
	["file-json"] = "rbxassetid://10723364435",
	["file-json-2"] = "rbxassetid://10723364361",
	["file-key"] = "rbxassetid://10723364605",
	["file-key-2"] = "rbxassetid://10723364515",
	["file-line-chart"] = "rbxassetid://10723364725",
	["file-lock"] = "rbxassetid://10723364957",
	["file-lock-2"] = "rbxassetid://10723364861",
	["file-minus"] = "rbxassetid://10723365254",
	["file-minus-2"] = "rbxassetid://10723365086",
	["file-output"] = "rbxassetid://10723365457",
	["file-pie-chart"] = "rbxassetid://10723365598",
	["file-plus"] = "rbxassetid://10723365877",
	["file-plus-2"] = "rbxassetid://10723365766",
	["file-question"] = "rbxassetid://10723365987",
	["file-scan"] = "rbxassetid://10723366167",
	["file-search"] = "rbxassetid://10723366550",
	["file-search-2"] = "rbxassetid://10723366340",
	["file-signature"] = "rbxassetid://10723366741",
	["file-spreadsheet"] = "rbxassetid://10723366962",
	["file-symlink"] = "rbxassetid://10723367098",
	["file-terminal"] = "rbxassetid://10723367244",
	["file-text"] = "rbxassetid://10723367380",
	["file-type"] = "rbxassetid://10723367606",
	["file-type-2"] = "rbxassetid://10723367509",
	["file-up"] = "rbxassetid://10723367734",
	["file-video"] = "rbxassetid://10723373884",
	["file-video-2"] = "rbxassetid://10723367834",
	["file-volume"] = "rbxassetid://10723374172",
	["file-volume-2"] = "rbxassetid://10723374030",
	["file-warning"] = "rbxassetid://10723374276",
	["file-x"] = "rbxassetid://10723374544",
	["file-x-2"] = "rbxassetid://10723374378",
	["files"] = "rbxassetid://10723374759",
	["film"] = "rbxassetid://10723374981",
	["filter"] = "rbxassetid://10723375128",
	["fingerprint"] = "rbxassetid://10723375250",
	["flag"] = "rbxassetid://10723375890",
	["flag-off"] = "rbxassetid://10723375443",
	["flag-triangle-left"] = "rbxassetid://10723375608",
	["flag-triangle-right"] = "rbxassetid://10723375727",
	["flame"] = "rbxassetid://10723376114",
	["flashlight"] = "rbxassetid://10723376471",
	["flashlight-off"] = "rbxassetid://10723376365",
	["flask-conical"] = "rbxassetid://10734883986",
	["flask-round"] = "rbxassetid://10723376614",
	["flip-horizontal"] = "rbxassetid://10723376884",
	["flip-horizontal-2"] = "rbxassetid://10723376745",
	["flip-vertical"] = "rbxassetid://10723377138",
	["flip-vertical-2"] = "rbxassetid://10723377026",
	["flower"] = "rbxassetid://10747830374",
	["flower-2"] = "rbxassetid://10723377305",
	["focus"] = "rbxassetid://10723377537",
	["folder"] = "rbxassetid://10723387563",
	["folder-archive"] = "rbxassetid://10723384478",
	["folder-check"] = "rbxassetid://10723384605",
	["folder-clock"] = "rbxassetid://10723384731",
	["folder-closed"] = "rbxassetid://10723384893",
	["folder-cog"] = "rbxassetid://10723385213",
	["folder-cog-2"] = "rbxassetid://10723385036",
	["folder-down"] = "rbxassetid://10723385338",
	["folder-edit"] = "rbxassetid://10723385445",
	["folder-heart"] = "rbxassetid://10723385545",
	["folder-input"] = "rbxassetid://10723385721",
	["folder-key"] = "rbxassetid://10723385848",
	["folder-lock"] = "rbxassetid://10723386005",
	["folder-minus"] = "rbxassetid://10723386127",
	["folder-open"] = "rbxassetid://10723386277",
	["folder-output"] = "rbxassetid://10723386386",
	["folder-plus"] = "rbxassetid://10723386531",
	["folder-search"] = "rbxassetid://10723386787",
	["folder-search-2"] = "rbxassetid://10723386674",
	["folder-symlink"] = "rbxassetid://10723386930",
	["folder-tree"] = "rbxassetid://10723387085",
	["folder-up"] = "rbxassetid://10723387265",
	["folder-x"] = "rbxassetid://10723387448",
	["folders"] = "rbxassetid://10723387721",
	["form-input"] = "rbxassetid://10723387841",
	["forward"] = "rbxassetid://10723388016",
	["frame"] = "rbxassetid://10723394389",
	["framer"] = "rbxassetid://10723394565",
	["frown"] = "rbxassetid://10723394681",
	["fuel"] = "rbxassetid://10723394846",
	["function-square"] = "rbxassetid://10723395041",
	["gamepad"] = "rbxassetid://10723395457",
	["gamepad-2"] = "rbxassetid://10723395215",
	["gauge"] = "rbxassetid://10723395708",
	["gavel"] = "rbxassetid://10723395896",
	["gem"] = "rbxassetid://10723396000",
	["ghost"] = "rbxassetid://10723396107",
	["gift"] = "rbxassetid://10723396402",
	["gift-card"] = "rbxassetid://10723396225",
	["git-branch"] = "rbxassetid://10723396676",
	["git-branch-plus"] = "rbxassetid://10723396542",
	["git-commit"] = "rbxassetid://10723396812",
	["git-compare"] = "rbxassetid://10723396954",
	["git-fork"] = "rbxassetid://10723397049",
	["git-merge"] = "rbxassetid://10723397165",
	["git-pull-request"] = "rbxassetid://10723397431",
	["git-pull-request-closed"] = "rbxassetid://10723397268",
	["git-pull-request-draft"] = "rbxassetid://10734884302",
	["glass"] = "rbxassetid://10723397788",
	["glass-2"] = "rbxassetid://10723397529",
	["glass-water"] = "rbxassetid://10723397678",
	["glasses"] = "rbxassetid://10723397895",
	["globe"] = "rbxassetid://10723404337",
	["globe-2"] = "rbxassetid://10723398002",
	["grab"] = "rbxassetid://10723404472",
	["graduation-cap"] = "rbxassetid://10723404691",
	["grape"] = "rbxassetid://10723404822",
	["grid"] = "rbxassetid://10723404936",
	["grip-horizontal"] = "rbxassetid://10723405089",
	["grip-vertical"] = "rbxassetid://10723405236",
	["hammer"] = "rbxassetid://10723405360",
	["hand"] = "rbxassetid://10723405649",
	["hand-metal"] = "rbxassetid://10723405508",
	["hard-drive"] = "rbxassetid://10723405749",
	["hard-hat"] = "rbxassetid://10723405859",
	["hash"] = "rbxassetid://10723405975",
	["haze"] = "rbxassetid://10723406078",
	["headphones"] = "rbxassetid://10723406165",
	["heart"] = "rbxassetid://10723406885",
	["heart-crack"] = "rbxassetid://10723406299",
	["heart-handshake"] = "rbxassetid://10723406480",
	["heart-off"] = "rbxassetid://10723406662",
	["heart-pulse"] = "rbxassetid://10723406795",
	["help-circle"] = "rbxassetid://10723406988",
	["hexagon"] = "rbxassetid://10723407092",
	["highlighter"] = "rbxassetid://10723407192",
	["history"] = "rbxassetid://10723407335",
	["home"] = "rbxassetid://10723407389",
	["hourglass"] = "rbxassetid://10723407498",
	["ice-cream"] = "rbxassetid://10723414308",
	["image"] = "rbxassetid://10723415040",
	["image-minus"] = "rbxassetid://10723414487",
	["image-off"] = "rbxassetid://10723414677",
	["image-plus"] = "rbxassetid://10723414827",
	["import"] = "rbxassetid://10723415205",
	["inbox"] = "rbxassetid://10723415335",
	["indent"] = "rbxassetid://10723415494",
	["indian-rupee"] = "rbxassetid://10723415642",
	["infinity"] = "rbxassetid://10723415766",
	["info"] = "rbxassetid://10723415903",
	["inspect"] = "rbxassetid://10723416057",
	["italic"] = "rbxassetid://10723416195",
	["japanese-yen"] = "rbxassetid://10723416363",
	["joystick"] = "rbxassetid://10723416527",
	["key"] = "rbxassetid://10723416652",
	["keyboard"] = "rbxassetid://10723416765",
	["lamp"] = "rbxassetid://10723417513",
	["lamp-ceiling"] = "rbxassetid://10723416922",
	["lamp-desk"] = "rbxassetid://10723417016",
	["lamp-floor"] = "rbxassetid://10723417131",
	["lamp-wall-down"] = "rbxassetid://10723417240",
	["lamp-wall-up"] = "rbxassetid://10723417356",
	["landmark"] = "rbxassetid://10723417608",
	["languages"] = "rbxassetid://10723417703",
	["laptop"] = "rbxassetid://10723423881",
	["laptop-2"] = "rbxassetid://10723417797",
	["lasso"] = "rbxassetid://10723424235",
	["lasso-select"] = "rbxassetid://10723424058",
	["laugh"] = "rbxassetid://10723424372",
	["layers"] = "rbxassetid://10723424505",
	["layout"] = "rbxassetid://10723425376",
	["layout-dashboard"] = "rbxassetid://10723424646",
	["layout-grid"] = "rbxassetid://10723424838",
	["layout-list"] = "rbxassetid://10723424963",
	["layout-template"] = "rbxassetid://10723425187",
	["leaf"] = "rbxassetid://10723425539",
	["library"] = "rbxassetid://10723425615",
	["life-buoy"] = "rbxassetid://10723425685",
	["lightbulb"] = "rbxassetid://10723425852",
	["lightbulb-off"] = "rbxassetid://10723425762",
	["line-chart"] = "rbxassetid://10723426393",
	["link"] = "rbxassetid://10723426722",
	["link-2"] = "rbxassetid://10723426595",
	["link-2-off"] = "rbxassetid://10723426513",
	["list"] = "rbxassetid://10723433811",
	["list-checks"] = "rbxassetid://10734884548",
	["list-end"] = "rbxassetid://10723426886",
	["list-minus"] = "rbxassetid://10723426986",
	["list-music"] = "rbxassetid://10723427081",
	["list-ordered"] = "rbxassetid://10723427199",
	["list-plus"] = "rbxassetid://10723427334",
	["list-start"] = "rbxassetid://10723427494",
	["list-video"] = "rbxassetid://10723427619",
	["list-x"] = "rbxassetid://10723433655",
	["loader"] = "rbxassetid://10723434070",
	["loader-2"] = "rbxassetid://10723433935",
	["locate"] = "rbxassetid://10723434557",
	["locate-fixed"] = "rbxassetid://10723434236",
	["locate-off"] = "rbxassetid://10723434379",
	["lock"] = "rbxassetid://10723434711",
	["log-in"] = "rbxassetid://10723434830",
	["log-out"] = "rbxassetid://10723434906",
	["luggage"] = "rbxassetid://10723434993",
	["magnet"] = "rbxassetid://10723435069",
	["mail"] = "rbxassetid://10734885430",
	["mail-check"] = "rbxassetid://10723435182",
	["mail-minus"] = "rbxassetid://10723435261",
	["mail-open"] = "rbxassetid://10723435342",
	["mail-plus"] = "rbxassetid://10723435443",
	["mail-question"] = "rbxassetid://10723435515",
	["mail-search"] = "rbxassetid://10734884739",
	["mail-warning"] = "rbxassetid://10734885015",
	["mail-x"] = "rbxassetid://10734885247",
	["mails"] = "rbxassetid://10734885614",
	["map"] = "rbxassetid://10734886202",
	["map-pin"] = "rbxassetid://10734886004",
	["map-pin-off"] = "rbxassetid://10734885803",
	["maximize"] = "rbxassetid://10734886735",
	["maximize-2"] = "rbxassetid://10734886496",
	["medal"] = "rbxassetid://10734887072",
	["megaphone"] = "rbxassetid://10734887454",
	["megaphone-off"] = "rbxassetid://10734887311",
	["meh"] = "rbxassetid://10734887603",
	["menu"] = "rbxassetid://10734887784",
	["message-circle"] = "rbxassetid://10734888000",
	["message-square"] = "rbxassetid://10734888228",
	["mic"] = "rbxassetid://10734888864",
	["mic-2"] = "rbxassetid://10734888430",
	["mic-off"] = "rbxassetid://10734888646",
	["microscope"] = "rbxassetid://10734889106",
	["microwave"] = "rbxassetid://10734895076",
	["milestone"] = "rbxassetid://10734895310",
	["minimize"] = "rbxassetid://10734895698",
	["minimize-2"] = "rbxassetid://10734895530",
	["minus"] = "rbxassetid://10734896206",
	["minus-circle"] = "rbxassetid://10734895856",
	["minus-square"] = "rbxassetid://10734896029",
	["monitor"] = "rbxassetid://10734896881",
	["monitor-off"] = "rbxassetid://10734896360",
	["monitor-speaker"] = "rbxassetid://10734896512",
	["moon"] = "rbxassetid://10734897102",
	["more-horizontal"] = "rbxassetid://10734897250",
	["more-vertical"] = "rbxassetid://10734897387",
	["mountain"] = "rbxassetid://10734897956",
	["mountain-snow"] = "rbxassetid://10734897665",
	["mouse"] = "rbxassetid://10734898592",
	["mouse-pointer"] = "rbxassetid://10734898476",
	["mouse-pointer-2"] = "rbxassetid://10734898194",
	["mouse-pointer-click"] = "rbxassetid://10734898355",
	["move"] = "rbxassetid://10734900011",
	["move-3d"] = "rbxassetid://10734898756",
	["move-diagonal"] = "rbxassetid://10734899164",
	["move-diagonal-2"] = "rbxassetid://10734898934",
	["move-horizontal"] = "rbxassetid://10734899414",
	["move-vertical"] = "rbxassetid://10734899821",
	["music"] = "rbxassetid://10734905958",
	["music-2"] = "rbxassetid://10734900215",
	["music-3"] = "rbxassetid://10734905665",
	["music-4"] = "rbxassetid://10734905823",
	["navigation"] = "rbxassetid://10734906744",
	["navigation-2"] = "rbxassetid://10734906332",
	["navigation-2-off"] = "rbxassetid://10734906144",
	["navigation-off"] = "rbxassetid://10734906580",
	["network"] = "rbxassetid://10734906975",
	["newspaper"] = "rbxassetid://10734907168",
	["octagon"] = "rbxassetid://10734907361",
	["option"] = "rbxassetid://10734907649",
	["outdent"] = "rbxassetid://10734907933",
	["package"] = "rbxassetid://10734909540",
	["package-2"] = "rbxassetid://10734908151",
	["package-check"] = "rbxassetid://10734908384",
	["package-minus"] = "rbxassetid://10734908626",
	["package-open"] = "rbxassetid://10734908793",
	["package-plus"] = "rbxassetid://10734909016",
	["package-search"] = "rbxassetid://10734909196",
	["package-x"] = "rbxassetid://10734909375",
	["paint-bucket"] = "rbxassetid://10734909847",
	["paintbrush"] = "rbxassetid://10734910187",
	["paintbrush-2"] = "rbxassetid://10734910030",
	["palette"] = "rbxassetid://10734910430",
	["palmtree"] = "rbxassetid://10734910680",
	["paperclip"] = "rbxassetid://10734910927",
	["party-popper"] = "rbxassetid://10734918735",
	["pause"] = "rbxassetid://10734919336",
	["pause-circle"] = "rbxassetid://10735024209",
	["pause-octagon"] = "rbxassetid://10734919143",
	["pen-tool"] = "rbxassetid://10734919503",
	["pencil"] = "rbxassetid://10734919691",
	["percent"] = "rbxassetid://10734919919",
	["person-standing"] = "rbxassetid://10734920149",
	["phone"] = "rbxassetid://10734921524",
	["phone-call"] = "rbxassetid://10734920305",
	["phone-forwarded"] = "rbxassetid://10734920508",
	["phone-incoming"] = "rbxassetid://10734920694",
	["phone-missed"] = "rbxassetid://10734920845",
	["phone-off"] = "rbxassetid://10734921077",
	["phone-outgoing"] = "rbxassetid://10734921288",
	["pie-chart"] = "rbxassetid://10734921727",
	["piggy-bank"] = "rbxassetid://10734921935",
	["pin"] = "rbxassetid://10734922324",
	["pin-off"] = "rbxassetid://10734922180",
	["pipette"] = "rbxassetid://10734922497",
	["pizza"] = "rbxassetid://10734922774",
	["plane"] = "rbxassetid://10734922971",
	["play"] = "rbxassetid://10734923549",
	["play-circle"] = "rbxassetid://10734923214",
	["plus"] = "rbxassetid://10734924532",
	["plus-circle"] = "rbxassetid://10734923868",
	["plus-square"] = "rbxassetid://10734924219",
	["podcast"] = "rbxassetid://10734929553",
	["pointer"] = "rbxassetid://10734929723",
	["pound-sterling"] = "rbxassetid://10734929981",
	["power"] = "rbxassetid://10734930466",
	["power-off"] = "rbxassetid://10734930257",
	["printer"] = "rbxassetid://10734930632",
	["puzzle"] = "rbxassetid://10734930886",
	["quote"] = "rbxassetid://10734931234",
	["radio"] = "rbxassetid://10734931596",
	["radio-receiver"] = "rbxassetid://10734931402",
	["rectangle-horizontal"] = "rbxassetid://10734931777",
	["rectangle-vertical"] = "rbxassetid://10734932081",
	["recycle"] = "rbxassetid://10734932295",
	["redo"] = "rbxassetid://10734932822",
	["redo-2"] = "rbxassetid://10734932586",
	["refresh-ccw"] = "rbxassetid://10734933056",
	["refresh-cw"] = "rbxassetid://10734933222",
	["refrigerator"] = "rbxassetid://10734933465",
	["regex"] = "rbxassetid://10734933655",
	["repeat"] = "rbxassetid://10734933966",
	["repeat-1"] = "rbxassetid://10734933826",
	["reply"] = "rbxassetid://10734934252",
	["reply-all"] = "rbxassetid://10734934132",
	["rewind"] = "rbxassetid://10734934347",
	["rocket"] = "rbxassetid://10734934585",
	["rocking-chair"] = "rbxassetid://10734939942",
	["rotate-3d"] = "rbxassetid://10734940107",
	["rotate-ccw"] = "rbxassetid://10734940376",
	["rotate-cw"] = "rbxassetid://10734940654",
	["rss"] = "rbxassetid://10734940825",
	["ruler"] = "rbxassetid://10734941018",
	["russian-ruble"] = "rbxassetid://10734941199",
	["sailboat"] = "rbxassetid://10734941354",
	["save"] = "rbxassetid://10734941499",
	["scale"] = "rbxassetid://10734941912",
	["scale-3d"] = "rbxassetid://10734941739",
	["scaling"] = "rbxassetid://10734942072",
	["scan"] = "rbxassetid://10734942565",
	["scan-face"] = "rbxassetid://10734942198",
	["scan-line"] = "rbxassetid://10734942351",
	["scissors"] = "rbxassetid://10734942778",
	["screen-share"] = "rbxassetid://10734943193",
	["screen-share-off"] = "rbxassetid://10734942967",
	["scroll"] = "rbxassetid://10734943448",
	["search"] = "rbxassetid://10734943674",
	["send"] = "rbxassetid://10734943902",
	["separator-horizontal"] = "rbxassetid://10734944115",
	["separator-vertical"] = "rbxassetid://10734944326",
	["server"] = "rbxassetid://10734949856",
	["server-cog"] = "rbxassetid://10734944444",
	["server-crash"] = "rbxassetid://10734944554",
	["server-off"] = "rbxassetid://10734944668",
	["settings"] = "rbxassetid://10734950309",
	["settings-2"] = "rbxassetid://10734950020",
	["share"] = "rbxassetid://10734950813",
	["share-2"] = "rbxassetid://10734950553",
	["sheet"] = "rbxassetid://10734951038",
	["shield"] = "rbxassetid://10734951847",
	["shield-alert"] = "rbxassetid://10734951173",
	["shield-check"] = "rbxassetid://10734951367",
	["shield-close"] = "rbxassetid://10734951535",
	["shield-off"] = "rbxassetid://10734951684",
	["shirt"] = "rbxassetid://10734952036",
	["shopping-bag"] = "rbxassetid://10734952273",
	["shopping-cart"] = "rbxassetid://10734952479",
	["shovel"] = "rbxassetid://10734952773",
	["shower-head"] = "rbxassetid://10734952942",
	["shrink"] = "rbxassetid://10734953073",
	["shrub"] = "rbxassetid://10734953241",
	["shuffle"] = "rbxassetid://10734953451",
	["sidebar"] = "rbxassetid://10734954301",
	["sidebar-close"] = "rbxassetid://10734953715",
	["sidebar-open"] = "rbxassetid://10734954000",
	["sigma"] = "rbxassetid://10734954538",
	["signal"] = "rbxassetid://10734961133",
	["signal-high"] = "rbxassetid://10734954807",
	["signal-low"] = "rbxassetid://10734955080",
	["signal-medium"] = "rbxassetid://10734955336",
	["signal-zero"] = "rbxassetid://10734960878",
	["siren"] = "rbxassetid://10734961284",
	["skip-back"] = "rbxassetid://10734961526",
	["skip-forward"] = "rbxassetid://10734961809",
	["skull"] = "rbxassetid://10734962068",
	["slack"] = "rbxassetid://10734962339",
	["slash"] = "rbxassetid://10734962600",
	["slice"] = "rbxassetid://10734963024",
	["sliders"] = "rbxassetid://10734963400",
	["sliders-horizontal"] = "rbxassetid://10734963191",
	["smartphone"] = "rbxassetid://10734963940",
	["smartphone-charging"] = "rbxassetid://10734963671",
	["smile"] = "rbxassetid://10734964441",
	["smile-plus"] = "rbxassetid://10734964188",
	["snowflake"] = "rbxassetid://10734964600",
	["sofa"] = "rbxassetid://10734964852",
	["sort-asc"] = "rbxassetid://10734965115",
	["sort-desc"] = "rbxassetid://10734965287",
	["speaker"] = "rbxassetid://10734965419",
	["sprout"] = "rbxassetid://10734965572",
	["square"] = "rbxassetid://10734965702",
	["star"] = "rbxassetid://10734966248",
	["star-half"] = "rbxassetid://10734965897",
	["star-off"] = "rbxassetid://10734966097",
	["stethoscope"] = "rbxassetid://10734966384",
	["sticker"] = "rbxassetid://10734972234",
	["sticky-note"] = "rbxassetid://10734972463",
	["stop-circle"] = "rbxassetid://10734972621",
	["stretch-horizontal"] = "rbxassetid://10734972862",
	["stretch-vertical"] = "rbxassetid://10734973130",
	["strikethrough"] = "rbxassetid://10734973290",
	["subscript"] = "rbxassetid://10734973457",
	["sun"] = "rbxassetid://10734974297",
	["sun-dim"] = "rbxassetid://10734973645",
	["sun-medium"] = "rbxassetid://10734973778",
	["sun-moon"] = "rbxassetid://10734973999",
	["sun-snow"] = "rbxassetid://10734974130",
	["sunrise"] = "rbxassetid://10734974522",
	["sunset"] = "rbxassetid://10734974689",
	["superscript"] = "rbxassetid://10734974850",
	["swiss-franc"] = "rbxassetid://10734975024",
	["switch-camera"] = "rbxassetid://10734975214",
	["sword"] = "rbxassetid://10734975486",
	["swords"] = "rbxassetid://10734975692",
	["syringe"] = "rbxassetid://10734975932",
	["table"] = "rbxassetid://10734976230",
	["table-2"] = "rbxassetid://10734976097",
	["tablet"] = "rbxassetid://10734976394",
	["tag"] = "rbxassetid://10734976528",
	["tags"] = "rbxassetid://10734976739",
	["target"] = "rbxassetid://10734977012",
	["tent"] = "rbxassetid://10734981750",
	["terminal"] = "rbxassetid://10734982144",
	["terminal-square"] = "rbxassetid://10734981995",
	["text-cursor"] = "rbxassetid://10734982395",
	["text-cursor-input"] = "rbxassetid://10734982297",
	["thermometer"] = "rbxassetid://10734983134",
	["thermometer-snowflake"] = "rbxassetid://10734982571",
	["thermometer-sun"] = "rbxassetid://10734982771",
	["thumbs-down"] = "rbxassetid://10734983359",
	["thumbs-up"] = "rbxassetid://10734983629",
	["ticket"] = "rbxassetid://10734983868",
	["timer"] = "rbxassetid://10734984606",
	["timer-off"] = "rbxassetid://10734984138",
	["timer-reset"] = "rbxassetid://10734984355",
	["toggle-left"] = "rbxassetid://10734984834",
	["toggle-right"] = "rbxassetid://10734985040",
	["tornado"] = "rbxassetid://10734985247",
	["toy-brick"] = "rbxassetid://10747361919",
	["train"] = "rbxassetid://10747362105",
	["trash"] = "rbxassetid://10747362393",
	["trash-2"] = "rbxassetid://10747362241",
	["tree-deciduous"] = "rbxassetid://10747362534",
	["tree-pine"] = "rbxassetid://10747362748",
	["trees"] = "rbxassetid://10747363016",
	["trending-down"] = "rbxassetid://10747363205",
	["trending-up"] = "rbxassetid://10747363465",
	["triangle"] = "rbxassetid://10747363621",
	["trophy"] = "rbxassetid://10747363809",
	["truck"] = "rbxassetid://10747364031",
	["tv"] = "rbxassetid://10747364593",
	["tv-2"] = "rbxassetid://10747364302",
	["type"] = "rbxassetid://10747364761",
	["umbrella"] = "rbxassetid://10747364971",
	["underline"] = "rbxassetid://10747365191",
	["undo"] = "rbxassetid://10747365484",
	["undo-2"] = "rbxassetid://10747365359",
	["unlink"] = "rbxassetid://10747365771",
	["unlink-2"] = "rbxassetid://10747397871",
	["unlock"] = "rbxassetid://10747366027",
	["upload"] = "rbxassetid://10747366434",
	["upload-cloud"] = "rbxassetid://10747366266",
	["usb"] = "rbxassetid://10747366606",
	["user"] = "rbxassetid://10747373176",
	["user-check"] = "rbxassetid://10747371901",
	["user-cog"] = "rbxassetid://10747372167",
	["user-minus"] = "rbxassetid://10747372346",
	["user-plus"] = "rbxassetid://10747372702",
	["user-x"] = "rbxassetid://10747372992",
	["users"] = "rbxassetid://10747373426",
	["utensils"] = "rbxassetid://10747373821",
	["utensils-crossed"] = "rbxassetid://10747373629",
	["venetian-mask"] = "rbxassetid://10747374003",
	["verified"] = "rbxassetid://10747374131",
	["vibrate"] = "rbxassetid://10747374489",
	["vibrate-off"] = "rbxassetid://10747374269",
	["video"] = "rbxassetid://10747374938",
	["video-off"] = "rbxassetid://10747374721",
	["view"] = "rbxassetid://10747375132",
	["voicemail"] = "rbxassetid://10747375281",
	["volume"] = "rbxassetid://10747376008",
	["volume-1"] = "rbxassetid://10747375450",
	["volume-2"] = "rbxassetid://10747375679",
	["volume-x"] = "rbxassetid://10747375880",
	["wallet"] = "rbxassetid://10747376205",
	["wand"] = "rbxassetid://10747376565",
	["wand-2"] = "rbxassetid://10747376349",
	["watch"] = "rbxassetid://10747376722",
	["waves"] = "rbxassetid://10747376931",
	["webcam"] = "rbxassetid://10747381992",
	["wifi"] = "rbxassetid://10747382504",
	["wifi-off"] = "rbxassetid://10747382268",
	["wind"] = "rbxassetid://10747382750",
	["wrap-text"] = "rbxassetid://10747383065",
	["wrench"] = "rbxassetid://10747383470",
	["x"] = "rbxassetid://10747384394",
	["x-circle"] = "rbxassetid://10747383819",
	["x-octagon"] = "rbxassetid://10747384037",
	["x-square"] = "rbxassetid://10747384217",
	["zoom-in"] = "rbxassetid://10747384552",
	["zoom-out"] = "rbxassetid://10747384679",
}

return assets
end)() end
} -- [RefId] = Closure

-- Holds the actual DOM data
local ObjectTree = {
    {
        1,
        2,
        {
            "ProjectMadara"
        },
        {
            {
                3,
                2,
                {
                    "Config"
                }
            },
            {
                15,
                2,
                {
                    "Tab"
                }
            },
            {
                14,
                2,
                {
                    "Slider"
                }
            },
            {
                2,
                2,
                {
                    "Button"
                }
            },
            {
                8,
                2,
                {
                    "Label"
                }
            },
            {
                17,
                2,
                {
                    "Toggle"
                }
            },
            {
                9,
                2,
                {
                    "Loading"
                }
            },
            {
                12,
                2,
                {
                    "OptionsManager"
                }
            },
            {
                13,
                2,
                {
                    "Paragraph"
                }
            },
            {
                10,
                2,
                {
                    "MobileFloatingIcon"
                }
            },
            {
                16,
                2,
                {
                    "TextBox"
                }
            },
            {
                18,
                2,
                {
                    "Window"
                }
            },
            {
                19,
                2,
                {
                    "lucide"
                }
            },
            {
                6,
                2,
                {
                    "Dropdown"
                }
            },
            {
                4,
                2,
                {
                    "Credits"
                }
            },
            {
                5,
                2,
                {
                    "DraggableKeybind"
                }
            },
            {
                11,
                2,
                {
                    "Notifications"
                }
            },
            {
                7,
                2,
                {
                    "FloatingControls"
                }
            }
        }
    }
}

-- Line offsets for debugging (only included when minifyTables is false)
local LineOffsets = {
    8,
    88,
    362,
    530,
    1048,
    1386,
    2192,
    2774,
    2828,
    3172,
    3419,
    3722,
    3819,
    3957,
    4168,
    4603,
    4761,
    5079,
    6157
}

-- Misc AOT variable imports
local WaxVersion = "0.4.1"
local EnvName = "WaxRuntime"

-- ++++++++ RUNTIME IMPL BELOW ++++++++ --

-- Localizing certain libraries and built-ins for runtime efficiency
local string, task, setmetatable, error, next, table, unpack, coroutine, script, type, require, pcall, tostring, tonumber, _VERSION =
      string, task, setmetatable, error, next, table, unpack, coroutine, script, type, require, pcall, tostring, tonumber, _VERSION

local table_insert = table.insert
local table_remove = table.remove
local table_freeze = table.freeze or function(t) return t end -- lol

local coroutine_wrap = coroutine.wrap

local string_sub = string.sub
local string_match = string.match
local string_gmatch = string.gmatch

-- The Lune runtime has its own `task` impl, but it must be imported by its builtin
-- module path, "@lune/task"
if _VERSION and string_sub(_VERSION, 1, 4) == "Lune" then
    local RequireSuccess, LuneTaskLib = pcall(require, "@lune/task")
    if RequireSuccess and LuneTaskLib then
        task = LuneTaskLib
    end
end

local task_defer = task and task.defer

-- If we're not running on the Roblox engine, we won't have a `task` global
local Defer = task_defer or function(f, ...)
    coroutine_wrap(f)(...)
end

-- ClassName "IDs"
local ClassNameIdBindings = {
    [1] = "Folder",
    [2] = "ModuleScript",
    [3] = "Script",
    [4] = "LocalScript",
    [5] = "StringValue",
}

local RefBindings = {} -- [RefId] = RealObject

local ScriptClosures = {}
local ScriptClosureRefIds = {} -- [ScriptClosure] = RefId
local StoredModuleValues = {}
local ScriptsToRun = {}

-- wax.shared __index/__newindex
local SharedEnvironment = {}

-- We're creating 'fake' instance refs soley for traversal of the DOM for require() compatibility
-- It's meant to be as lazy as possible
local RefChildren = {} -- [Ref] = {ChildrenRef, ...}

-- Implemented instance methods
local InstanceMethods = {
    GetFullName = { {}, function(self)
        local Path = self.Name
        local ObjectPointer = self.Parent

        while ObjectPointer do
            Path = ObjectPointer.Name .. "." .. Path

            -- Move up the DOM (parent will be nil at the end, and this while loop will stop)
            ObjectPointer = ObjectPointer.Parent
        end

        return Path
    end},

    GetChildren = { {}, function(self)
        local ReturnArray = {}

        for Child in next, RefChildren[self] do
            table_insert(ReturnArray, Child)
        end

        return ReturnArray
    end},

    GetDescendants = { {}, function(self)
        local ReturnArray = {}

        for Child in next, RefChildren[self] do
            table_insert(ReturnArray, Child)

            for _, Descendant in next, Child:GetDescendants() do
                table_insert(ReturnArray, Descendant)
            end
        end

        return ReturnArray
    end},

    FindFirstChild = { {"string", "boolean?"}, function(self, name, recursive)
        local Children = RefChildren[self]

        for Child in next, Children do
            if Child.Name == name then
                return Child
            end
        end

        if recursive then
            for Child in next, Children do
                -- Yeah, Roblox follows this behavior- instead of searching the entire base of a
                -- ref first, the engine uses a direct recursive call
                return Child:FindFirstChild(name, true)
            end
        end
    end},

    FindFirstAncestor = { {"string"}, function(self, name)
        local RefPointer = self.Parent
        while RefPointer do
            if RefPointer.Name == name then
                return RefPointer
            end

            RefPointer = RefPointer.Parent
        end
    end},

    -- Just to implement for traversal usage
    WaitForChild = { {"string", "number?"}, function(self, name)
        return self:FindFirstChild(name)
    end},
}

-- "Proxies" to instance methods, with err checks etc
local InstanceMethodProxies = {}
for MethodName, MethodObject in next, InstanceMethods do
    local Types = MethodObject[1]
    local Method = MethodObject[2]

    local EvaluatedTypeInfo = {}
    for ArgIndex, TypeInfo in next, Types do
        local ExpectedType, IsOptional = string_match(TypeInfo, "^([^%?]+)(%??)")
        EvaluatedTypeInfo[ArgIndex] = {ExpectedType, IsOptional}
    end

    InstanceMethodProxies[MethodName] = function(self, ...)
        if not RefChildren[self] then
            error("Expected ':' not '.' calling member function " .. MethodName, 2)
        end

        local Args = {...}
        for ArgIndex, TypeInfo in next, EvaluatedTypeInfo do
            local RealArg = Args[ArgIndex]
            local RealArgType = type(RealArg)
            local ExpectedType, IsOptional = TypeInfo[1], TypeInfo[2]

            if RealArg == nil and not IsOptional then
                error("Argument " .. RealArg .. " missing or nil", 3)
            end

            if ExpectedType ~= "any" and RealArgType ~= ExpectedType and not (RealArgType == "nil" and IsOptional) then
                error("Argument " .. ArgIndex .. " expects type \"" .. ExpectedType .. "\", got \"" .. RealArgType .. "\"", 2)
            end
        end

        return Method(self, ...)
    end
end

local function CreateRef(className, name, parent)
    -- `name` and `parent` can also be set later by the init script if they're absent

    -- Extras
    local StringValue_Value

    -- Will be set to RefChildren later aswell
    local Children = setmetatable({}, {__mode = "k"})

    -- Err funcs
    local function InvalidMember(member)
        error(member .. " is not a valid (virtual) member of " .. className .. " \"" .. name .. "\"", 3)
    end
    local function ReadOnlyProperty(property)
        error("Unable to assign (virtual) property " .. property .. ". Property is read only", 3)
    end

    local Ref = {}
    local RefMetatable = {}

    RefMetatable.__metatable = false

    RefMetatable.__index = function(_, index)
        if index == "ClassName" then -- First check "properties"
            return className
        elseif index == "Name" then
            return name
        elseif index == "Parent" then
            return parent
        elseif className == "StringValue" and index == "Value" then
            -- Supporting StringValue.Value for Rojo .txt file conv
            return StringValue_Value
        else -- Lastly, check "methods"
            local InstanceMethod = InstanceMethodProxies[index]

            if InstanceMethod then
                return InstanceMethod
            end
        end

        -- Next we'll look thru child refs
        for Child in next, Children do
            if Child.Name == index then
                return Child
            end
        end

        -- At this point, no member was found; this is the same err format as Roblox
        InvalidMember(index)
    end

    RefMetatable.__newindex = function(_, index, value)
        -- __newindex is only for props fyi
        if index == "ClassName" then
            ReadOnlyProperty(index)
        elseif index == "Name" then
            name = value
        elseif index == "Parent" then
            -- We'll just ignore the process if it's trying to set itself
            if value == Ref then
                return
            end

            if parent ~= nil then
                -- Remove this ref from the CURRENT parent
                RefChildren[parent][Ref] = nil
            end

            parent = value

            if value ~= nil then
                -- And NOW we're setting the new parent
                RefChildren[value][Ref] = true
            end
        elseif className == "StringValue" and index == "Value" then
            -- Supporting StringValue.Value for Rojo .txt file conv
            StringValue_Value = value
        else
            -- Same err as __index when no member is found
            InvalidMember(index)
        end
    end

    RefMetatable.__tostring = function()
        return name
    end

    setmetatable(Ref, RefMetatable)

    RefChildren[Ref] = Children

    if parent ~= nil then
        RefChildren[parent][Ref] = true
    end

    return Ref
end

-- Create real ref DOM from object tree
local function CreateRefFromObject(object, parent)
    local RefId = object[1]
    local ClassNameId = object[2]
    local Properties = object[3] -- Optional
    local Children = object[4] -- Optional

    local ClassName = ClassNameIdBindings[ClassNameId]

    local Name = Properties and table_remove(Properties, 1) or ClassName

    local Ref = CreateRef(ClassName, Name, parent) -- 3rd arg may be nil if this is from root
    RefBindings[RefId] = Ref

    if Properties then
        for PropertyName, PropertyValue in next, Properties do
            Ref[PropertyName] = PropertyValue
        end
    end

    if Children then
        for _, ChildObject in next, Children do
            CreateRefFromObject(ChildObject, Ref)
        end
    end

    return Ref
end

local RealObjectRoot = CreateRef("Folder", "[" .. EnvName .. "]")
for _, Object in next, ObjectTree do
    CreateRefFromObject(Object, RealObjectRoot)
end

-- Now we'll set script closure refs and check if they should be ran as a BaseScript
for RefId, Closure in next, ClosureBindings do
    local Ref = RefBindings[RefId]

    ScriptClosures[Ref] = Closure
    ScriptClosureRefIds[Ref] = RefId

    local ClassName = Ref.ClassName
    if ClassName == "LocalScript" or ClassName == "Script" then
        table_insert(ScriptsToRun, Ref)
    end
end

local function LoadScript(scriptRef)
    local ScriptClassName = scriptRef.ClassName

    -- First we'll check for a cached module value (packed into a tbl)
    local StoredModuleValue = StoredModuleValues[scriptRef]
    if StoredModuleValue and ScriptClassName == "ModuleScript" then
        return unpack(StoredModuleValue)
    end

    local Closure = ScriptClosures[scriptRef]

    local function FormatError(originalErrorMessage)
        originalErrorMessage = tostring(originalErrorMessage)

        local VirtualFullName = scriptRef:GetFullName()

        -- Check for vanilla/Roblox format
        local OriginalErrorLine, BaseErrorMessage = string_match(originalErrorMessage, "[^:]+:(%d+): (.+)")

        if not OriginalErrorLine or not LineOffsets then
            return VirtualFullName .. ":*: " .. (BaseErrorMessage or originalErrorMessage)
        end

        OriginalErrorLine = tonumber(OriginalErrorLine)

        local RefId = ScriptClosureRefIds[scriptRef]
        local LineOffset = LineOffsets[RefId]

        local RealErrorLine = OriginalErrorLine - LineOffset + 1
        if RealErrorLine < 0 then
            RealErrorLine = "?"
        end

        return VirtualFullName .. ":" .. RealErrorLine .. ": " .. BaseErrorMessage
    end

    -- If it's a BaseScript, we'll just run it directly!
    if ScriptClassName == "LocalScript" or ScriptClassName == "Script" then
        local RunSuccess, ErrorMessage = pcall(Closure)
        if not RunSuccess then
            error(FormatError(ErrorMessage), 0)
        end
    else
        local PCallReturn = {pcall(Closure)}

        local RunSuccess = table_remove(PCallReturn, 1)
        if not RunSuccess then
            local ErrorMessage = table_remove(PCallReturn, 1)
            error(FormatError(ErrorMessage), 0)
        end

        StoredModuleValues[scriptRef] = PCallReturn
        return unpack(PCallReturn)
    end
end

-- We'll assign the actual func from the top of this output for flattening user globals at runtime
-- Returns (in a tuple order): wax, script, require
function ImportGlobals(refId)
    local ScriptRef = RefBindings[refId]

    local function RealCall(f, ...)
        local PCallReturn = {pcall(f, ...)}

        local CallSuccess = table_remove(PCallReturn, 1)
        if not CallSuccess then
            error(PCallReturn[1], 3)
        end

        return unpack(PCallReturn)
    end

    -- `wax.shared` index
    local WaxShared = table_freeze(setmetatable({}, {
        __index = SharedEnvironment,
        __newindex = function(_, index, value)
            SharedEnvironment[index] = value
        end,
        __len = function()
            return #SharedEnvironment
        end,
        __iter = function()
            return next, SharedEnvironment
        end,
    }))

    local Global_wax = table_freeze({
        -- From AOT variable imports
        version = WaxVersion,
        envname = EnvName,

        shared = WaxShared,

        -- "Real" globals instead of the env set ones
        script = script,
        require = require,
    })

    local Global_script = ScriptRef

    local function Global_require(module, ...)
        local ModuleArgType = type(module)

        local ErrorNonModuleScript = "Attempted to call require with a non-ModuleScript"
        local ErrorSelfRequire = "Attempted to call require with self"

        if ModuleArgType == "table" and RefChildren[module]  then
            if module.ClassName ~= "ModuleScript" then
                error(ErrorNonModuleScript, 2)
            elseif module == ScriptRef then
                error(ErrorSelfRequire, 2)
            end

            return LoadScript(module)
        elseif ModuleArgType == "string" and string_sub(module, 1, 1) ~= "@" then
            -- The control flow on this SUCKS

            if #module == 0 then
                error("Attempted to call require with empty string", 2)
            end

            local CurrentRefPointer = ScriptRef

            if string_sub(module, 1, 1) == "/" then
                CurrentRefPointer = RealObjectRoot
            elseif string_sub(module, 1, 2) == "./" then
                module = string_sub(module, 3)
            end

            local PreviousPathMatch
            for PathMatch in string_gmatch(module, "([^/]*)/?") do
                local RealIndex = PathMatch
                if PathMatch == ".." then
                    RealIndex = "Parent"
                end

                -- Don't advance dir if it's just another "/" either
                if RealIndex ~= "" then
                    local ResultRef = CurrentRefPointer:FindFirstChild(RealIndex)
                    if not ResultRef then
                        local CurrentRefParent = CurrentRefPointer.Parent
                        if CurrentRefParent then
                            ResultRef = CurrentRefParent:FindFirstChild(RealIndex)
                        end
                    end

                    if ResultRef then
                        CurrentRefPointer = ResultRef
                    elseif PathMatch ~= PreviousPathMatch and PathMatch ~= "init" and PathMatch ~= "init.server" and PathMatch ~= "init.client" then
                        error("Virtual script path \"" .. module .. "\" not found", 2)
                    end
                end

                -- For possible checks next cycle
                PreviousPathMatch = PathMatch
            end

            if CurrentRefPointer.ClassName ~= "ModuleScript" then
                error(ErrorNonModuleScript, 2)
            elseif CurrentRefPointer == ScriptRef then
                error(ErrorSelfRequire, 2)
            end

            return LoadScript(CurrentRefPointer)
        end

        return RealCall(require, module, ...)
    end

    -- Now, return flattened globals ready for direct runtime exec
    return Global_wax, Global_script, Global_require
end

for _, ScriptRef in next, ScriptsToRun do
    Defer(LoadScript, ScriptRef)
end

-- AoT adjustment: Load init module (MainModule behavior)
return LoadScript(RealObjectRoot:GetChildren()[1])
