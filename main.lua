local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- Создание GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local KeyInput = Instance.new("TextBox")
local CheckButton = Instance.new("TextButton")

-- Настройка GUI
ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.5, -75)
Frame.BackgroundColor3 = Color3.new(1, 1, 1)
Frame.Parent = ScreenGui

KeyInput.Size = UDim2.new(1, 0, 0, 50)
KeyInput.Position = UDim2.new(0, 0, 0, 20)
KeyInput.PlaceholderText = "Введите ключ"
KeyInput.Parent = Frame

CheckButton.Size = UDim2.new(1, 0, 0, 50)
CheckButton.Position = UDim2.new(0, 0, 0, 80)
CheckButton.Text = "Проверить ключ"
CheckButton.Parent = Frame

-- Функция для проверки ключа
local function checkKey()
    local key = KeyInput.Text
    local url = "https://f77dfd7b-039c-4efc-a9ef-a6638f9757db-00-fjavopd5ysfq.pike.replit.dev/check_key"
    local data = HttpService:JSONEncode({ key = key })

    local response = HttpService:PostAsync(url, data, Enum.HttpContentType.ApplicationJson)
    local result = HttpService:JSONDecode(response)

    if result.status == "success" then
        print("Ключ действителен! Загружаем скрипт...")
        
        -- Загружаем скрипт после успешной проверки ключа
        local scriptUrl = 'https://raw.githubusercontent.com/KOT16122/generalscript/refs/heads/main/script.lua'
        local scriptContent = HttpService:GetAsync(scriptUrl)
        loadstring(scriptContent)()
    else
        print("Неверный ключ!")
    end
end

-- Подключение функции проверки к кнопке
CheckButton.MouseButton1Click:Connect(checkKey)
