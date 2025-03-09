local guiTools = guiTools or {}

local winMgr = CEGUI.WindowManager:getSingleton()

guiTools.isInit = guiTools.isInit or false

guiTools.TopLeft = "GuiTools_AnchorTopLeft"
guiTools.TopMiddle = "GuiTools_AnchorTopMiddle"
guiTools.TopRight = "GuiTools_AnchorTopRight"

guiTools.MiddleLeft = "GuiTools_AnchorMiddleLeft"
guiTools.Middle = "GuiTools_AnchorMiddle"
guiTools.MiddleRight = "GuiTools_AnchorMiddleRight"

guiTools.BottomLeft = "GuiTools_AnchorBottomLeft"
guiTools.BottomMiddle = "GuiTools_AnchorBottomMiddle"
guiTools.BottomRight = "GuiTools_AnchorBottomRight"

guiTools.anchors = guiTools.anchors or {}

guiTools.MainInputPassThrough = "MainInputPassThrough"

local function RemoveFromParent(window)
    local oldParent = window:getParent()
    if oldParent ~= nil then
        oldParent:removeChildWindow(window)
    end
end

local function CreateBaseAnchor(name)

    local root = winMgr:getWindow("DefaultWindow")
    local anchor = winMgr:createWindow("TaharezLook/StaticImage", name)

    anchor:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
    anchor:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
    anchor:setAlwaysOnTop(true)
    anchor:setMousePassThroughEnabled(true)
    anchor:setZOrderingEnabled(true)

    root:addChildWindow(anchor)

    return anchor
end

local function GetAnchor(anchorName)

    local anchor = winMgr:getWindow(anchorName)
    if anchor == nil then
        anchor = CreateBaseAnchor(anchorName)
    end

    return anchor

end

guiTools.anchors.TopLeft = function (window)
    
    if window ~= nil then
        local anchor = GetAnchor(guiTools.TopLeft)
        anchor:addChildWindow(window)
    end

end

guiTools.anchors.TopMiddle = function (window)
    
    if window ~= nil then

        local anchor = GetAnchor(guiTools.TopMiddle)
        
        local currWinX, currWinY = GetCurrentResolution()
        anchor:setPosition(currWinX/2, 0)

        anchor:subscribeEvent("Sized", function()
            local currWinX, currWinY = GetCurrentResolution()
            anchor:setPosition(currWinX/2, 0)
        end)

        anchor:addChildWindow(window)
    end

end

guiTools.anchors.TopRight = function (window)
    
    if window ~= nil then
        local anchor = GetAnchor(guiTools.TopRight)

        local currWinX, currWinY = GetCurrentResolution()
        anchor:setPosition(currWinX, 0)

        anchor:subscribeEvent("Sized", function()
            local currWinX, currWinY = GetCurrentResolution()
            anchor:setPosition(currWinX, 0)
        end)

        anchor:addChildWindow(window)
    end

end

guiTools.anchors.MiddleLeft = function (window)
    
    if window ~= nil then
        local anchor = GetAnchor(guiTools.MiddleLeft)

        local currWinX, currWinY = GetCurrentResolution()
        anchor:setPosition(0, currWinY/2)

        anchor:subscribeEvent("Sized", function()
            local currWinX, currWinY = GetCurrentResolution()
            anchor:setPosition(0, currWinY/2)
        end)
        anchor:addChildWindow(window)
    end

end

guiTools.anchors.Middle = function (window)
    
    if window ~= nil then
        local anchor = GetAnchor(guiTools.Middle)

        local currWinX, currWinY = GetCurrentResolution()
        anchor:setPosition(currWinX/2, currWinY/2)

        anchor:subscribeEvent("Sized", function()
            local currWinX, currWinY = GetCurrentResolution()
            anchor:setPosition(currWinX/2, currWinY/2)
        end)
        anchor:addChildWindow(window)
    end

end

guiTools.anchors.MiddleRight = function (window)
    
    if window ~= nil then
        local anchor = GetAnchor(guiTools.MiddleRight)
        local currWinX, currWinY = GetCurrentResolution()
        anchor:setPosition(currWinX, currWinY/2)

        anchor:subscribeEvent("Sized", function()
            local currWinX, currWinY = GetCurrentResolution()
            anchor:setPosition(currWinX, currWinY/2)
        end)
        anchor:addChildWindow(window)
    end

end

guiTools.anchors.BottomLeft = function (window)
    
    if window ~= nil then
        local anchor = GetAnchor(guiTools.BottomLeft)

        local currWinX, currWinY = GetCurrentResolution()
        anchor:setPosition(0, currWinY)

        anchor:subscribeEvent("Sized", function()
            local currWinX, currWinY = GetCurrentResolution()
            anchor:setPosition(0, currWinY)
        end)
        anchor:addChildWindow(window)
    end

end

guiTools.anchors.BottomMiddle = function (window)
    
    if window ~= nil then
        local anchor = GetAnchor(guiTools.BottomMiddle)

        local currWinX, currWinY = GetCurrentResolution()
        anchor:setPosition(currWinX/2, currWinY)

        anchor:subscribeEvent("Sized", function()    
            local currWinX, currWinY = GetCurrentResolution()
            anchor:setPosition(currWinX/2, currWinY)
        end)
        anchor:addChildWindow(window)
    end

end

guiTools.AnchorTopLeft = function(window)
    RemoveFromParent(window)
    guiTools.anchors.TopLeft(window)
end

guiTools.AnchorTopMiddle = function(window)
    RemoveFromParent(window)
    guiTools.anchors.TopMiddle(window)
end

guiTools.AnchorTopRight = function(window)
    RemoveFromParent(window)
    guiTools.anchors.TopRight(window)
end

guiTools.AnchorMiddleLeft = function(window)
    RemoveFromParent(window)
    guiTools.anchors.MiddleLeft(window)
end

guiTools.AnchorMiddle = function(window)
    RemoveFromParent(window)
    guiTools.anchors.Middle(window)
end

guiTools.AnchorMiddleRight = function(window)
    RemoveFromParent(window)
    guiTools.anchors.MiddleRight(window)
end

guiTools.AnchorBottomLeft = function(window)
    RemoveFromParent(window)
    guiTools.anchors.BottomLeft(window)
end

guiTools.AnchorBottomMiddle = function(window)
    RemoveFromParent(window)
    guiTools.anchors.BottomMiddle(window)
end

guiTools.AnchorBottomRight = function(window)
    RemoveFromParent(window)
    guiTools.anchors.BottomRight(window)
end

guiTools.GetAbsoluteWindowPosition = function(window)

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


return guiTools