loadstring([[
local Players, UserInputService = game:GetService("Players"), game:GetService("UserInputService")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)
local timeLabel = Instance.new("TextLabel", screenGui)
local toggleButton = Instance.new("TextButton", screenGui)
timeLabel.Size, timeLabel.Position, timeLabel.TextColor3, timeLabel.BackgroundTransparency, timeLabel.BackgroundColor3, timeLabel.TextScaled, timeLabel.TextStrokeTransparency = UDim2.new(0, 300, 0, 50), UDim2.new(0.5, -150, 0, 0), Color3.new(1, 1, 1), 0.5, Color3.new(0, 0, 0), true, 0.5
toggleButton.Size, toggleButton.Position, toggleButton.TextColor3, toggleButton.BackgroundColor3, toggleButton.Text = UDim2.new(0, 200, 0, 50), UDim2.new(0.5, -100, 0.1, 0), Color3.new(0, 0, 0), Color3.new(1, 1, 1), "Скрыть"
local countdownTime, isTimeVisible = 60 * 85, true

local function updateTime()
    while true do
        local serverTime, remainingTime = os.date("%H:%M:%S", tick()), countdownTime - (tick() % countdownTime)
        local hours, minutes, seconds = math.floor(remainingTime / 3600), math.floor((remainingTime % 3600) / 60), remainingTime % 60
        if isTimeVisible then timeLabel.Text = "Время сервера: " .. serverTime .. "\nRaid Pirat через: " .. string.format("%02d:%02d:%02d", hours, minutes, seconds) end
        wait(1)
    end
end

toggleButton.MouseButton1Click:Connect(function()
    isTimeVisible = not isTimeVisible
    timeLabel.Visible, toggleButton.Text = isTimeVisible, isTimeVisible and "Скрыть" or "Показать"
end)

local function makeDraggable(element)
    local dragging, startPos, startMousePos = false
    element.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging, startPos, startMousePos = true, element.Position, input.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    element.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            local delta = input.Position - startMousePos
            element.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(toggleButton)
makeDraggable(timeLabel)
updateTime()
]])()
