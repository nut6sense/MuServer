-- Table to store debug window information
ImGuiDebug = ImGuiDebug or {}

ImGuiDebug.windows = ImGuiDebug.windows or {}
ImGuiDebug.selectedWindow = ImGuiDebug.selectedWindow or nil
ImGuiDebug.isFollowing = false
ImGuiDebug.logFile = "Log/debug_layout.log"
ImGuiDebug.updateFuncs = ImGuiDebug.updateFuncs or {}
ImGuiDebug.hasWindowUpdate = ImGuiDebug.hasWindowUpdate or 0
ImGuiDebug.hasUpdate = ImGuiDebug.hasUpdate or 0
ImGuiDebug.useWASD  = false
ImGuiDebug.isReloaded = ImGuiDebug.isReloaded or false

local winMgr = CEGUI.WindowManager:getSingleton()

local function GetAbsolutePosition(window)

    local function recursiveGetPosition(win, accX,accY)
        if not win then
            return accX, accY
        end

        local pos = win:getPosition()
        
        local relativeX = pos.x:asAbsolute(1.0)
        local relativeY = pos.y:asAbsolute(1.0)

        accX = accX + relativeX
        accY = accY + relativeY

        local parent = win:getParent()
        if parent then
            return recursiveGetPosition(parent, accX, accY)
        else
            return accX, accY
        end

    end

    return recursiveGetPosition(window, 0, 0)
end

local function AddWindowByName(windowName)

    -- check if this name already exist, if so remove the old one and insert this one instead
    for i, window in ipairs(ImGuiDebug.windows) do
        if window.name == windowName then
            table.remove(ImGuiDebug.windows, i)
            break
        end
    end

    if winMgr:getWindow(windowName) == nil then
        LOG("Window not found: " .. windowName)
        return
    end

    table.insert(ImGuiDebug.windows, {name = windowName, ref = winMgr:getWindow(windowName)})

    if ImGuiDebug.hasWindowUpdate == 0 then

        if ImGuiUpdate then
            ImGuiDebug.hasWindowUpdate = ImGuiUpdate.AddEvent(ImGuiDebug.WindowUpdate)
        end

    end
    
end


function ImGuiDebug.AddWindow(window)

    if window ~= nil then
        AddWindowByName(window:getName())
    end

end

function ImGuiDebug.Update()

    for i, func in ipairs(ImGuiDebug.updateFuncs) do
        if func.isRemoved == true then
            table.remove(ImGuiDebug.updateFuncs, i)
        end
    end

    for _, item in ipairs(ImGuiDebug.updateFuncs) do
        item.func()
    end
    
end

function ImGuiDebug.AddEvent(updateEvent)
    
    for _, item in ipairs(ImGuiDebug.updateFuncs) do
        if item.func == updateEvent then
            return
        end
    end

    table.insert(ImGuiDebug.updateFuncs, {func = updateEvent, isRemoved = false})

    if ImGuiDebug.hasUpdate == 0 then
        if ImGuiUpdate then
            ImGuiDebug.hasUpdate = ImGuiUpdate.AddEvent(ImGuiDebug.Update)
            -- LOG("ImGuiUpdate return from add event " .. ImGuiDebug.hasUpdate)
        end
    end

end

function ImGuiDebug.RemoveEvent(updateEvent)

    for _, item in ipairs(ImGuiDebug.updateFuncs) do
        if item.func == updateEvent then
            item.isRemoved = true
            LOG("Update Event " .. tostring(item.func) .. " removed")
            break
        end
    end
    

end

-- Function to save the current layout to a log file
function ImGuiDebug.SaveLayout()
    local file = io.open(ImGuiDebug.logFile, "w")
    if not file then
        LOG("Could not open log file for writing.")
        return
    end

    LOG("Save layout")

    for _, window in ipairs(ImGuiDebug.windows) do

        local window = winMgr:getWindow(window.name)

        if window then

            local relative = window:getPosition()
            local base = 1.0
            local absPosX,absPosY = GetAbsolutePosition(window)

            file:write(string.format("Window names: %s\n", window.name))
            file:write(string.format("Absolute Position: (%d, %d)\n", absPosX, absPosY))
            file:write(string.format("Relative Position: (%d, %d)\n", relative.x:asAbsolute(base), relative.y:asAbsolute(base)))
            file:write("\n")

        end

    end

    file:close()
end



-- Function to update the debug UI (called every frame)
function ImGuiDebug.WindowUpdate()

    if imgui == nil then
        return
    end

    for i = #ImGuiDebug.windows, 1, -1 do
        local window = ImGuiDebug.windows[i]
        
        -- Check if the window reference is nil or if the window doesn't exist anymore
        if window == nil or winMgr:getWindow(window.name) == nil then
            table.remove(ImGuiDebug.windows, i)
        end
    end

    -- if #ImGuiDebug.windows == 0 then
        
    --     if ImGuiUpdate then
    --         ImGuiUpdate.RemoveEvent(ImGuiDebug.hasWindowUpdate)
    --     end
        
    --     ImGuiDebug.hasWindowUpdate = 0
    --     return
    -- end

    if imgui.Begin("Debug UI") then

        for i, window in ipairs(ImGuiDebug.windows) do
            local debugWindow = winMgr:getWindow(window.name)
            
            if debugWindow ~= nil then
                if imgui.Button(window.name) then
                    ImGuiDebug.selectedWindow = {name = window.name, ref = debugWindow}
                    ImGuiDebug.isFollowing = true
                end
            end
        end

        -- Save layout button
        if imgui.Button("Save Layout") then
            ImGuiDebug.SaveLayout()
        end

        -- Input field for move increment
        if ImGuiDebug.moveIncrement == nil then
            ImGuiDebug.moveIncrement = 1 -- Default value
        end
        

        -- Display the position of the selected window
        if ImGuiDebug.selectedWindow ~= nil then
            
            local selectWindow = winMgr:getWindow(ImGuiDebug.selectedWindow.name)
            
            if selectWindow ~= nil then
                local base = 1.0
                local position = selectWindow:getPosition()
                local relativeX = position.x:asAbsolute(base)
                local relativeY = position.y:asAbsolute(base)
                local parentAbsoluteX, parentAbsoluteY = GetAbsolutePosition(selectWindow:getParent())
                local absPosX,absPosY = GetAbsolutePosition(ImGuiDebug.selectedWindow.ref)
    
                imgui.Text(string.format("Selected Window: %s", ImGuiDebug.selectedWindow.name))
                imgui.Text(string.format("Absolute X Position: %.2f", absPosX))
                imgui.Text(string.format("Absolute Y Position: %.2f", absPosY))
                imgui.Text(string.format("Relative X Position: %.2f", relativeX))
                imgui.Text(string.format("Relative Y Position: %.2f", relativeY))
                imgui.Text(string.format("Parent Absolute X Position: %.2f", parentAbsoluteX))
                imgui.Text(string.format("Parent Absolute Y Position: %.2f", parentAbsoluteY))
            else
                ImGuiDebug.selectedWindow = nil
            end
            

        
        end

        local changed, newValue = imgui.InputInt("Move Increment", ImGuiDebug.moveIncrement)
        if changed then
            ImGuiDebug.moveIncrement = newValue
        end

        -- Handle window movement
        if ImGuiDebug.selectedWindow ~= nil then
            local window = ImGuiDebug.selectedWindow.ref
            local parent = window:getParent()
            local parentAbsoluteX, parentAbsoluteY = GetAbsolutePosition(parent)
            local position = window:getPosition()
            local relativeX = position.x:asAbsolute(1.0)
            local relativeY = position.y:asAbsolute(1.0)

            -- Toggle between mouse follow and WASD movement when '[' is pressed
            if imgui.IsKeyPressed(0xDB) then -- 0xDB is the virtual key code for '['
                ImGuiDebug.useWASD = not ImGuiDebug.useWASD
            end

            if ImGuiDebug.useWASD  then
                local increment = ImGuiDebug.moveIncrement or 1
                if imgui.IsKeyPressed(0x41) then -- 'A' key
                    relativeX = relativeX - increment
                elseif imgui.IsKeyPressed(0x44) then -- 'D' key
                    relativeX = relativeX + increment
                elseif imgui.IsKeyPressed(0x57) then -- 'W' key
                    relativeY = relativeY - increment
                elseif imgui.IsKeyPressed(0x53) then -- 'S' key
                    relativeY = relativeY + increment
                end
            else -- Follow mouse
                local mousePos = imgui.GetMousePos()
                relativeX = mousePos.x - parentAbsoluteX
                relativeY = mousePos.y - parentAbsoluteY

                -- Stop following on right-click
                if imgui.IsMouseClicked(1) then -- 1 = right mouse button
                    ImGuiDebug.selectedWindow = nil
                end
            end

            window:setPosition(relativeX, relativeY)
        end

        imgui.End()

    end
end

if not ImGuiDebug.isReloaded then
    ImGuiDebug.isReloaded = true
    ImGuiUpdate.AddReload("lua/ImGuiDebug.lua")
end

return ImGuiDebug