local canvas = {}
canvas.__index = canvas

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

local function CreateMainCanvas(width,height,name)

    local root = winMgr:getWindow("DefaultWindow")
    local window = winMgr:getWindow("Canvas_" .. name)
    if window == nil then

        window = winMgr:createWindow("TaharezLook/StaticImage", "Canvas_" .. name)
        window:setTexture("Enabled", "UIData/invisible2.png", 0, 0)
        window:setTexture("Disabled", "UIData/invisible2.png", 0, 0)
        window:setSize(width, height)
        window:setAlpha(0)
        window:setRiseOnClickEnabled(false)

        root:addChildWindow(window)

    end

    return window
end

function canvas:new(width,height,name)
    
    local self = setmetatable({}, canvas)
    self.canvas = CreateMainCanvas(width,height,name)
    self.childWindows = {}
    self.debugWindow = nil
    return self

end

function canvas:addElement(window,layer)

    if window ~= nil then

        if self.childWindows[layer] == nil then
            self.childWindows[layer] = {}
        end

        window:setLayer(layer)
        self.canvas:addChildWindow(window)

        local layerWindows = self.childWindows[layer]
        table.insert(layerWindows, {ref = window, name = window:getName()})

    end

end

function canvas:getPixelRect()
    return self.canvas:getPixelRect()
end

function canvas:addChild(canvas)
    self.canvas:addChildWindow(canvas)
end

function canvas:setDebugVisible(value)

    if self.debugWindow == nil then

        self.canvas:setAlpha(100)

        local debugButton = winMgr:createWindow("TaharezLook/StaticImage", "Canvas_DebugWindow")
        debugButton:setTexture("Enabled", "UIData/DefaultTexture.png", 0, 0)
        debugButton:setTexture("Disabled", "UIData/DefaultTexture.png", 0, 0)
        debugButton:setSize(100, 100)
        debugButton:setVisible(value)
        debugButton:setVerticalAlignment(1)
        debugButton:setHorizontalAlignment(1)
        self:addElement(self.debugWindow, 0)

        self.debugWindow = debugButton

    else
        self.debugWindow:setVisible(value)
    end
end

function canvas:setLocalPosition(x,y)
    self.canvas:setPosition(x,y)
end

function canvas:getLocalPosition()
    return self.canvas:getPosition()
end

function canvas:GetAbsolutePosition()
    return GetAbsolutePosition(self.canvas)
end

return canvas