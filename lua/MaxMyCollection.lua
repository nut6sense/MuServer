local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
local isHideMatchMakingButton = false

guiSystem:setGUISheet(root)
root:activate()
function WndMyCollectionClose()
	-- LOG("WndMyCollectionClose")
	background = winMgr:getWindow("Collection_BackImage")
	
	background:setVisible(false)

end
function RenderClossBtn()
	background = winMgr:getWindow("Collection_BackImage")
	CloseBTN = winMgr:createWindow("TaharezLook/Button", "Collection_CloseBTN")
	CloseBTN:setTexture("Normal", "UIData/Collection/Collection_UI.png", 624, 724)
	CloseBTN:setTexture("Hover", "UIData/Collection/Collection_UI.png", 624, 724+16)
	CloseBTN:setPosition(870, 10)
	CloseBTN:setSize(16, 16)
	CloseBTN:setVisible(true)
	CloseBTN:setAlwaysOnTop(true)
	CloseBTN:setZOrderingEnabled(true)
	CloseBTN:subscribeEvent("Clicked", function()
		-- LOG("CloseBTN Clicked")
		WndMyCollectionClose()
	end)
	background:addChildWindow(CloseBTN)

	function HideMatchMakingButton()
		isHideMatchMakingButton = true
		mywindow = winMgr:getWindow("OpenCollection")
		mywindow:setVisible(false)
		mywindow:setEnabled(false)
	end
 
 end
 
 function ShowMatchMakingButton()
	isHideMatchMakingButton = false
	mywindow = winMgr:getWindow("OpenCollection")
	mywindow:setVisible(true)
	mywindow:setEnabled(true)
 end
function BTNOpenWndMyCollection()
	-- LOG("BTNOpenWndMyCollection")
	-- xpcall(OpenCollection, errorHandler, "character")
	local myRoot = winMgr:getWindow("DefaultWindow")
	mywindow = winMgr:createWindow("TaharezLook/Button", "OpenCollection")
	mywindow:setTexture("Normal", "UIData/Collection/Collection_Register_UI.png", 263, 568)
	mywindow:setTexture("Hover", "UIData/Collection/Collection_Register_UI.png", 263, 606)
	mywindow:setTexture("Pushed", "UIData/Collection/Collection_Register_UI.png", 263, 568)
	mywindow:setTexture("PushedOff", "UIData/Collection/Collection_Register_UI.png", 263, 606)
	mywindow:setTexture("Disabled", "UIData/Collection/Collection_Register_UI.png", 263, 645)
	-- mywindow:setAlign(3)
	-- mywindow:setWideType(7)
	-- mywindow:setPosition(800.5, 173)
	mywindow:setSize(221, 35)
	mywindow:setVisible(true)
	-- mywindow:setAlwaysOnTop(true)
	-- mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", function()
		-- LOG("OpenCollection Clicked")
		xpcall(WndMyCollection, errorHandler)
		winMgr:getWindow("Collection_RegisterSetCollectionBackround"):setVisible(false)
		winMgr:getWindow("Collection_ItemCollectionBackround"):setVisible(false)

	end)

	mywindow:setHorizontalAlignment(2)
	mywindow:setPosition(-2,175)

	if myRoot ~= nil then
		myRoot:addChildWindow(mywindow)
	end
end
function OpenCollection()
	-- LOG("OpenCollection")
	xpcall(WndMyCollectionToggle, errorHandler)
end

function WndMyCollection()
	-- LOG("Start WndMyCollection")
	-- local guiSystem = CEGUI.System:getSingleton()
	-- local winMgr	= CEGUI.WindowManager:getSingleton()
	-- local root		= winMgr:getWindow("DefaultWindow")
	-- local drawer	= root:getDrawer()
	-- guiSystem:setGUISheet(root)
	-- root:activate()
	-- body
	-- background
	background = winMgr:createWindow("TaharezLook/StaticImage", "Collection_BackImage")
	
	RenderClossBtn()


	-- LOG("created windows")
	background:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 0, 0)

	-- LOG("created setTexture")
	-- position center screen
	background:setPosition((g_MAIN_WIN_SIZEX-900)/2, (g_MAIN_WIN_SIZEY-500)/2)
	-- LOG("created setPosition")
	background:setSize(900, 500)
	-- LOG("created setSize")
	background:setVisible(true)
	-- LOG("created setVisible")
	background:setAlwaysOnTop(true)
	-- LOG("created setAlwaysOnTop")
	background:setZOrderingEnabled(true)
	-- LOG("created setZOrderingEnabled")
	background:subscribeEvent("Clicked", function()

		winMgr:getWindow('Collection_RegisterSetCollectionBackround'):setVisible(false)
			
	end)
	root:addChildWindow(background)

	RegistEscEventInfo("Collection_BackImage","WndMyCollectionClose")
	-- LOG("End WndMyCollection")
	-- render button menu
	RenderButtonMenu()
	-- -- render table
	RenderTable()
	-- -- render radio filter collection
	RenderRedioFilterCollection()
	-- -- render search bar
	CollectionSeachbar()
	-- -- render collection info
	-- เธฅเธณเธ”เธฑ๏ฟฝ๏ฟฝเธ—เธต๏ฟฝ๏ฟฝ1
	MyCollectionInfo() 


	-- RenderItemReward()
	-- RegisterSet()
	-- -- debug text
	-- debugText = Text("Collection_DebugText")
	-- debugText:setPosition(10, 10)
	-- root:addChildWindow(debugText)
	-- MyCollectionModeOpen()
	

end

local number_current_page = 1
local number_all_page = 2
local max_1Page = 6
-- -- ////////////////////////////////////////////////////////////////////////////////
function Text(name)
	mywindow = winMgr:createWindow("TaharezLook/StaticText", name)
	mywindow:setTextColor(255, 255, 255, 255)
	mywindow:setFont("tahoma", 16)
	-- mywindow:setFont(g_STRING_FONT_GULIMCHE, 12);
	mywindow:setText("")
	mywindow:setPosition(10, 0)
	mywindow:setSize(250, 36)
	mywindow:setAlwaysOnTop(true)
	root:addChildWindow(mywindow)
	return mywindow
end



function RenderButtonMenu()
    background = winMgr:getWindow("Collection_BackImage")
    btnWidth = 100
    btnHigh = 30
    btnLen =5
    margin =5
    menuName ={"Charater","Costume" ,"PVE" ,"PVP","Event","Secret"}
    buttons = {} 

    for i = 0, #menuName - 1 do
        local menu = winMgr:createWindow("TaharezLook/Button", "collection_button"..i)
        
        menu:setTexture("Normal", "UIData/Collection/Collection_UI.png", ((btnWidth * i)), 520)
        menu:setTexture("Hover", "UIData/Collection/Collection_UI.png", ((btnWidth * i)), 520 + 35)
        menu:setPosition(((btnWidth + margin) * i) + 15, 50)
        menu:setSize(btnWidth, btnHigh)
        menu:setVisible(true)
        menu:setAlwaysOnTop(true)
        menu:setZOrderingEnabled(true)
        buttons[i + 1] = menu 
        menu:subscribeEvent("Clicked", function()
            for j = 1, #menuName do
                if buttons[j] then
                    if j == i + 1 then
                        buttons[j]:setTexture("Normal", "UIData/Collection/Collection_UI.png", ((btnWidth * (j - 1))), 520 + 35) 
                    else
                        buttons[j]:setTexture("Normal", "UIData/Collection/Collection_UI.png", ((btnWidth * (j - 1))), 520) 
                    end
                end
            end

			if id_selectedMenu ~= menuName[i + 1] then 
				ManuTabBar(menuName[i + 1])
			end
        end)
        
        background:addChildWindow(menu)
		menu:subscribeEvent("MouseClick", function()
			RegisterSetCollectionBackround:setVisible(false)  
		end)
    end
end



local id_collection_Character = {}
local id_collection_Costume = {}
local id_collection_PVE = {}
local id_collection_PVP = {}
local id_collection_Event = {}
local id_collection_Secret = {}

local collectionData_path = {}
local collectionData_collectionName = {}
local collectionData_itemName = {}
local collectionData_itemId = {}
local collectionData_counts = {}
local collectionData_upgrades = {}
local collectionData_reward = {}

local collectionData_History = {}

-- local posX = {['err']=0, [0]= 15,50,85,120,155,15,50,85,120,155}
local posX = {['err']=0, [0]= 15,50,85,120,155,35,70,105,140,175}
local posY = {['err']=0, [0]= 20,20,20,20,20,55,55,55,55,55}
local sizeX = {['err']=0, [0]= 30,30,30,30,30,30,30,30,30,30}
local sizeY = {['err']=0, [0]= 30,30,30,30,30,30,30,30,30,30}
local cropX = {['err']=0, [0]= 0,35,70,105,140,175,210,245,280,315}
local cropY = {['err']=0, [0]= 815,815,815,815,815,815,815,815,815,815}
-- local cropX = {['err']=0, [0]= 342,342,342,342,342,342,342,342,342}
-- local cropY = {['err']=0, [0]= 433,433,433,433,433,433,433,433,433}


-- ฟังก์ชันช่วยตรวจสอบว่าค่า collection_id มีอยู่ในตารางแล้วหรือไม่
local function isValueInTable(tbl, value)
    for _, v in ipairs(tbl) do
        if v == value then
            return true -- พบค่าในตาราง
        end
    end
    return false -- ไม่พบค่าในตาราง
end

-- ฟังก์ชันสำหรับเพิ่มข้อมูลใน collectionData_path
function addPathCollectionHashData(category_id, collection_id, index, path_file_CollectionHashData)
    -- ตรวจสอบว่ามี category_id อยู่หรือยัง
    if not collectionData_path[category_id] then
        collectionData_path[category_id] = {} -- ถ้ายังไม่มี category_id ให้สร้างตารางเปล่า
    end

    -- ตรวจสอบว่ามี collection_id นี้หรือยัง
    if not collectionData_path[category_id][collection_id] then
        collectionData_path[category_id][collection_id] = {} -- ถ้ายังไม่มี ให้สร้างตารางเปล่าสำหรับ collection_id นี้
    end

	-- เพิ่ม collection_id ลงใน id_collection ที่เหมาะสมโดยไม่เพิ่มซ้ำ
    if category_id == 1 and not isValueInTable(id_collection_Character, collection_id) then
        table.insert(id_collection_Character, collection_id)
    elseif category_id == 2 and not isValueInTable(id_collection_Costume, collection_id) then
        table.insert(id_collection_Costume, collection_id)
    elseif category_id == 3 and not isValueInTable(id_collection_PVE, collection_id) then
        table.insert(id_collection_PVE, collection_id)
    elseif category_id == 4 and not isValueInTable(id_collection_PVP, collection_id) then
        table.insert(id_collection_PVP, collection_id)
    elseif category_id == 5 and not isValueInTable(id_collection_Event, collection_id) then
        table.insert(id_collection_Event, collection_id)
    elseif category_id == 6 and not isValueInTable(id_collection_Secret, collection_id) then
        table.insert(id_collection_Secret, collection_id)
    end
    -- เพิ่มข้อมูล path_file_CollectionHashData โดยใช้ index เป็น key
    collectionData_path[category_id][collection_id][index] = path_file_CollectionHashData
	-- LOG("collectionData_path["..category_id.."]["..collection_id.."]["..index.."] = "..path_file_CollectionHashData)
end

function getPathCollectionHashData(category_id, index, collection_id, path_file_CollectionHashData)
	addPathCollectionHashData(category_id, collection_id, index, path_file_CollectionHashData)
end

local currentIndex_in_row_onClick = 0


function addItemCollectionHashData(category_id, collection_id, index, collectionName, itemName, itemId, counts, upgrades)
    -- ตรวจสอบว่ามี category_id อยู่หรือยัง
    if not collectionData_collectionName[category_id] then
        collectionData_collectionName[category_id] = {} -- ถ้ายังไม่มี category_id ให้สร้างตารางเปล่า
        collectionData_itemName[category_id] = {}
        collectionData_itemId[category_id] = {}
        collectionData_counts[category_id] = {}
        collectionData_upgrades[category_id] = {} 
		collectionData_History[category_id] = {} 

    end

    -- ตรวจสอบว่ามี collection_id นี้หรือยัง
    if not collectionData_collectionName[category_id][collection_id] then
        collectionData_collectionName[category_id][collection_id] = {} -- ถ้ายังไม่มี ให้สร้างตารางเปล่าสำหรับ collection_id นี้
        collectionData_itemName[category_id][collection_id] = {}
        collectionData_itemId[category_id][collection_id] = {}
        collectionData_counts[category_id][collection_id] = {}
        collectionData_upgrades[category_id][collection_id] = {}
        collectionData_History[category_id][collection_id] = {}

    end

    -- เพิ่มข้อมูล
    collectionData_collectionName[category_id][collection_id][index] = collectionName
    collectionData_itemName[category_id][collection_id][index] = itemName
    collectionData_itemId[category_id][collection_id][index] = itemId
    collectionData_counts[category_id][collection_id][index] = counts
    collectionData_upgrades[category_id][collection_id][index] = upgrades
	table.insert(collectionData_History[category_id][collection_id][itemId], 0)
end

function getCollectionReward(category_id,collection_id,reward_item)

	if not collectionData_reward[category_id] then
        collectionData_reward[category_id] = {} -- ถ้ายังไม่มี category_id ให้สร้างตารางเปล่า
    end

	if not collectionData_reward[category_id][collection_id] then
        collectionData_reward[category_id][collection_id] = {} -- ถ้ายังไม่มี ให้สร้างตารางเปล่าสำหรับ collection_id นี้
    end

	--เพิ่มข้อมูล 
	collectionData_reward[category_id][collection_id] = reward_item


end

function getCollectionHashData(category_id, index, collection_id, collection_name, item_name, item_id, count, upgrade)
	-- LOG("============ getCollectionHashData ====================");
	-- LOG("getCollectionHashData("..category_id..", "..index..", "..collection_id..", "..collection_name..", "..item_name..", "..item_id..", "..count..", "..upgrade..")")
	addItemCollectionHashData(category_id, collection_id, index, collection_name, item_name, item_id, count, upgrade)
end

function getHistoryCollection(category_id, collection_id, id_item, count, upgrade, status)
	-- ตรวจสอบว่ามี category_id อยู่หรือยัง
    if not collectionData_History[category_id] then
        collectionData_History[category_id] = {} 
    end

    -- ตรวจสอบว่ามี collection_id นี้หรือยัง
    if not collectionData_History[category_id][collection_id] then
        collectionData_History[category_id][collection_id] = {}
    end
    -- เพิ่มข้อมูล
	table.insert(collectionData_History[category_id][collection_id], id_item)
	
	winMgr:getWindow("Collection_Item_Check"..collection_id.."_"..id_item):setVisible(true)
	winMgr:getWindow("img_Collection_Check_ItemFrame_"..currentIndex_in_row_onClick):setVisible(true)
	winMgr:getWindow('Collection_RegisterSetCollectionBackround'):setVisible(false)

	if status == 'receive' then
		-- LOG("Collection_Claim"..category_id.."-"..collection_id)
		winMgr:getWindow("Collection_Claim"..category_id.."-"..collection_id):setEnabled(false)
		-- 457, 437 old
		winMgr:getWindow("Collection_Claim"..category_id.."-"..collection_id):setTexture("Normal", "UIData/Collection/Collection_Register_UI.png", 455, 437)
		winMgr:getWindow("Collection_Claim"..category_id.."-"..collection_id):setSize(105, 33)
	
	elseif status == 'success' then 
		winMgr:getWindow("Collection_Claim"..category_id.."-"..collection_id):setTexture("Normal", "UIData/Collection/Collection_Register_UI.png", 2, 479)
		winMgr:getWindow("Collection_Claim"..category_id.."-"..collection_id):setEnabled(true)
		winMgrwinMgr:setSize(100, 33)

	end

end


local id_selectedMenu = 1
local old_id_selectedMenu = 0
local id_Rowtable = 0
-- สร้างตารางสำหรับเก็บ arrays
local arrays_collection_item = {}
function ManuTabBar(selectedMenu)
    local dataList = {}
    local favFlagList = {}

	if selectedMenu == "Charater" then
		id_selectedMenu = 1
		favFlagList = {0, 0, 0, 0, 0, 0}
		number_all_page = ((tonumber(#id_collection_Character)/max_1Page)+1)
		all_item_list = tonumber(#id_collection_Character)
		-- GetCollectionHistory(1)

	elseif selectedMenu == "Costume" then
		id_selectedMenu = 2
		favFlagList = {0, 0, 0, 0, 0, 0}
		number_all_page = ((tonumber(#id_collection_Costume)/max_1Page)+1)
		all_item_list = tonumber(#id_collection_Costume)
		-- GetCollectionHistory(2)

	elseif selectedMenu == "PVE" then
		id_selectedMenu = 3
		favFlagList = {0, 0, 0, 0, 0, 0}
		number_all_page = ((tonumber(#id_collection_PVE)/max_1Page)+1)
		all_item_list = tonumber(#id_collection_PVE)
		-- GetCollectionHistory(3)

	elseif selectedMenu == "PVP" then
		id_selectedMenu = 4
		favFlagList = {0, 0, 0, 0, 0, 0}
		number_all_page = ((tonumber(#id_collection_PVP)/max_1Page) + 1)
		all_item_list = tonumber(#id_collection_PVP)
		-- GetCollectionHistory(4)

	elseif selectedMenu == "Event" then
		id_selectedMenu = 5
		favFlagList = {0, 0, 0, 0, 0, 0}
		number_all_page = ((tonumber(#id_collection_Event)/max_1Page) + 1)
		all_item_list = tonumber(#id_collection_Event)
		-- GetCollectionHistory(5)

	elseif selectedMenu == "Secret" then
		id_selectedMenu = 6
		favFlagList = {0, 0, 0, 0, 0, 0}
		number_all_page = ((tonumber(#id_collection_Secret)/max_1Page) + 1)
		all_item_list = tonumber(#id_collection_Secret)
		-- GetCollectionHistory(6)

	end
	number_current_page = 1
	local startPage = ((number_current_page-1)*max_1Page) 
	local endPage = (startPage + max_1Page)
	if endPage > all_item_list then
        endPage = all_item_list
    end
	
	-- Check คลิกซ้ำตัวเดิมหลายครั้ง
	if old_id_selectedMenu ~= id_selectedMenu then 

		old_id_selectedMenu = id_selectedMenu
		clearAllRows() 

		-- -- render pagination
		RenderPagination()
	
		bg = winMgr:getWindow("Collection_OverAllFrame")
		bg:setVisible(true)
		-- countLoop = (6*number_current_page)
	
	
		GetCollectionHistory(id_selectedMenu)
	
		for i = startPage, endPage - 1  do
			DrawerRowTable(i, number_current_page, favFlagList[i + 1])
		end
	end
end

function RenderTable()
	background = winMgr:getWindow("Collection_BackImage")
	headTable = winMgr:createWindow("TaharezLook/Button", "Collection_TableHead")
	headTable:setTexture("Normal", "UIData/Collection/Collection_UI.png", 0, 590)

	headTable:setPosition(15, 85)
	headTable:setSize(625, 30)
	headTable:setVisible(true)
	headTable:setAlwaysOnTop(true)
	headTable:setZOrderingEnabled(true)
	headTable:subscribeEvent("Clicked", function()
		-- onRowClick(index, data)
		winMgr:getWindow('Collection_RegisterSetCollectionBackround'):setVisible(false)
	end)
	background:addChildWindow(headTable)
	
	-- for each collections_data 
	-- data , pages = paginationCollectionData(#collections_data, 1)

end


function DrawerRowTable(index, data, favFlag)
    -- กำหนด testnumber เริ่มต้น
    local row_list = 0
    -- ถ้า index เกินกว่า 5
	if index > 5 then
        row_list = (index - 6) % 6  -- ทำให้ค่าเวียนตั้งแต่ 0-5
    else
        row_list = index  -- ใช้ index ตรงๆ ถ้ายังไม่เกิน 6
    end

	background = winMgr:getWindow("Collection_BackImage")
	rowWidth = 625
	rowHigh = 50
	Rowtable = winMgr:createWindow("TaharezLook/Button", "Collection_Table"..row_list)
	Rowtable:setTexture("Normal", "UIData/Collection/Collection_UI.png", 0, 620)
		
	Rowtable:setPosition(15, 120+(row_list*50))
	Rowtable:setSize(rowWidth, rowHigh)
	Rowtable:setVisible(true)
	Rowtable:setAlwaysOnTop(true)
	Rowtable:setZOrderingEnabled(true)
	Rowtable:setProperty('Selected', 'false')
	Rowtable:subscribeEvent("SelectStateChanged", function()
		onRowClick(index, data)
	end)


	background:addChildWindow(Rowtable)
	text = winMgr:createWindow("TaharezLook/Button", "Collection_Text"..row_list)
	local collection_Name = ""
	local idCollection = 0
	if id_selectedMenu == 1 then
		collection_Name = collectionData_collectionName[id_selectedMenu][id_collection_Character[index+1]][index+1]
		idCollection =  id_collection_Character[index+1]
		
	elseif id_selectedMenu == 2 then
		collection_Name = collectionData_collectionName[id_selectedMenu][id_collection_Costume[index+1]][index+1]
		idCollection =  id_collection_Costume[index+1]

	elseif id_selectedMenu == 3 then
		collection_Name = collectionData_collectionName[id_selectedMenu][id_collection_PVE[index+1]][index+1]
		idCollection =  id_collection_PVE[index+1]

	elseif id_selectedMenu == 4 then
		collection_Name = collectionData_collectionName[id_selectedMenu][id_collection_PVP[index+1]][index+1]
		idCollection =  id_collection_PVP[index+1]

	elseif id_selectedMenu == 5 then
		collection_Name = collectionData_collectionName[id_selectedMenu][id_collection_Event[index+1]][index+1]
		idCollection =  id_collection_Event[index+1]

	elseif id_selectedMenu == 6 then
		collection_Name = collectionData_collectionName[id_selectedMenu][id_collection_Secret[index+1]][index+1]
		idCollection =  id_collection_Secret[index+1]
	end

	

	text:setText(collection_Name)
	text:setPosition(50, (rowHigh-10)/2)
	text:setSize(200, 50)
	text:setFont("tahoma", 10)
	text:setTextColor(255, 255, 255, 255)
	-- onclick event
	text:subscribeEvent("Clicked", function()
		onRowClick(index, data)
	end)
	-- hover event
	
	Rowtable:addChildWindow(text)
	-- fav btn icon
	fav = winMgr:createWindow("TaharezLook/Button", "Collection_Fav"..row_list)
	if (favFlag == 1) then
		fav:setTexture("Normal", "UIData/Collection/Collection_UI.png",625, 872)
	else
		fav:setTexture("Normal", "UIData/Collection/Collection_UI.png",625, 852)
	end
	fav:setPosition(30, (rowHigh-20)/2)
	fav:setSize(20, 20)
	fav:setVisible(true)
	fav:setAlwaysOnTop(true)
	fav:setZOrderingEnabled(true)
	-- fav:subscribeEvent("Clicked", function()
			
	-- end)
	Rowtable:addChildWindow(fav)
	-- render items 9 slot after text item data
	marginIcon = 5
	-- LOG("collectionData_itemName[id_selectedMenu][idCollection] : "..#collectionData_itemName[id_selectedMenu][idCollection])
	for i = 0, 8 do
		local IdInCollectionList = collectionData_itemId[id_selectedMenu][idCollection][i+1]
		local name = collectionData_itemName[id_selectedMenu][idCollection][i+1]
		-- LOG("IdInCollectionList : "..IdInCollectionList)
		-- LOG("name : "..name)
		-- LOG("Collection_Item"..idCollection.."_"..IdInCollectionList)
		
		item = winMgr:createWindow("TaharezLook/Button", "Collection_Item"..idCollection.."_"..IdInCollectionList)
		item:setTexture("Normal", "UIData/Collection/Collection_UI.png", 35*i, 815)
		-- item:setTexture("Hover", "UIData/Collection/Collection_Register_UI.png", 0, 515)
		item:setPosition(170+(i*(30+marginIcon)), (rowHigh-25)/2)
		item:setSize(30, 30)
		item:setVisible(true)
		item:setAlwaysOnTop(false)
		item:setZOrderingEnabled(true)
		
		Rowtable:addChildWindow(item)


		-- Collection_Item_Check item
		ItemButton = winMgr:createWindow("TaharezLook/Button", "Collection_Item_Check"..idCollection.."_"..IdInCollectionList)
		ItemButton:setTexture("Normal", "UIData/Collection/Collection_UI.png", 625, 793) -- ใช้ Texture สำหรับปุ่มรางวัล
		ItemButton:setPosition(180+(i*(30+marginIcon)), (rowHigh-10)/2)
		ItemButton:setSize(24, 21) 
		ItemButton:setVisible(false)
		ItemButton:setAlwaysOnTop(true)
		ItemButton:setZOrderingEnabled(true)
		Rowtable:addChildWindow(ItemButton)


		local secondValue = ""
		if id_selectedMenu == 1 then
			secondValue = collectionData_path[id_selectedMenu][id_collection_Character[index+1]][i+1]
		elseif id_selectedMenu == 2 then
			secondValue = collectionData_path[id_selectedMenu][id_collection_Costume[index+1]][i+1]
		elseif id_selectedMenu == 3 then
			secondValue = collectionData_path[id_selectedMenu][id_collection_PVE[index+1]][i+1]
		elseif id_selectedMenu == 4 then
			secondValue = collectionData_path[id_selectedMenu][id_collection_PVP[index+1]][i+1]
		elseif id_selectedMenu == 5 then
			secondValue = collectionData_path[id_selectedMenu][id_collection_Event[index+1]][i+1]
		elseif id_selectedMenu == 6 then
			secondValue = collectionData_path[id_selectedMenu][id_collection_Secret[index+1]][i+1]
		end

		-- LOG("secondValue : "..secondValue)
		-- local secondValue = collectionData_path[id_selectedMenu][id_collection[index+1]][i+1]
		item_img = winMgr:createWindow("TaharezLook/StaticImage", "img_Collection_Item"..idCollection.."_"..IdInCollectionList)
		item_img:setTexture("Enabled", "UIData/ItemUIData/"..secondValue, 0, 0)
		item_img:setTexture("Disabled", "UIData/ItemUIData/"..secondValue, 0, 0)
			-- item_img:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
			-- item_img:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		item_img:setPosition(2, 3)
		item_img:setSize(110, 110)
		item_img:setScaleHeight(65)
		item_img:setScaleWidth(65)
		item_img:setEnabled(false)
		item_img:setVisible(true)
		item_img:setAlwaysOnTop(true)
		winMgr:getWindow("Collection_Item"..idCollection.."_"..IdInCollectionList):addChildWindow(item_img)
	end

	-- RowtableBtn = winMgr:createWindow("TaharezLook/RadioButton", "Collection_Btn"..index)
	-- RowtableBtn:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	-- RowtableBtn:setTexture("SelectedNormal", "UIData/Collection/Collection_Register_UI.png", 0, 515)
	-- RowtableBtn:setTexture("SelectedHover", "UIData/Collection/Collection_Register_UI.png", 0, 515)
	-- RowtableBtn:setTexture("SelectedPushed", "UIData/Collection/Collection_Register_UI.png", 0, 515)
	-- RowtableBtn:setTexture("SelectedPushedOff", "UIData/Collection/Collection_Register_UI.png", 0, 515)
	-- RowtableBtn:setPosition(15, 125+(index*50))
	-- RowtableBtn:setSize(rowWidth, rowHigh)
	-- RowtableBtn:setAlwaysOnTop(true)
	-- RowtableBtn:setZOrderingEnabled(true)
	-- RowtableBtn:setProperty("GroupID", 10001)
	-- RowtableBtn:subscribeEvent("SelectStateChanged", function()
	-- end)

	background:addChildWindow(RowtableBtn)
	-- add btn claim or add item
	btnClaim = winMgr:createWindow("TaharezLook/Button", "Collection_Claim"..id_selectedMenu.."-"..idCollection)
	-- btnClaim:setTexture("Normal", "UIData/Collection/Collection_Register_UI.png", 2, 479)
	btnClaim:setTexture("Normal", "UIData/Collection/Collection_Register_UI.png", 455, 437)
	btnClaim:setTexture("Hover", "UIData/Collection/Collection_Register_UI.png", 113, 479)
	
	btnClaim:setPosition(510, (rowHigh-25)/2)
	-- btnClaim:setSize(100, 33):setSize(105, 33)
	btnClaim:setSize(105, 33)
	btnClaim:setVisible(true)
	btnClaim:setAlwaysOnTop(true)
	btnClaim:setEnabled(false)
	-- btnClaim:setEnabled(false)
	btnClaim:setZOrderingEnabled(true)
	btnClaim:subscribeEvent("Clicked", function()
		-- onRowClick(index, data)
		ClaimReward(idCollection)
		
			
	end)
	Rowtable:addChildWindow(btnClaim)		
end

function ClaimReward(id_Collection)

	local reward_item_string = collectionData_reward[id_selectedMenu][id_Collection]
	-- ใช้ string.match เพื่อแยกค่า
	local item_number, count, uprand = reward_item_string:match("([^,]+),([^,]+),([^,]+)")
    SendReward(tonumber(item_number) ,tonumber(count) ,tonumber(id_selectedMenu), tonumber(id_Collection)) 
	
end

function clearAllRows()
	background = winMgr:getWindow("Collection_BackImage")
   for i = 0, 5 do
		row = background:getChild("Collection_Table" .. i)
	   if row then
		   background:removeChildWindow(row)
		   winMgr:destroyWindow(row)
	   end

		btn = background:getChild("Collection_Btn" .. i)
	   if btn then
		   background:removeChildWindow(btn)
		   winMgr:destroyWindow(btn)
	   end

	   Chack = background:getChild("Collection_ItemCollectionBackround")
	   if Chack then
		   background:removeChildWindow(Chack)
		   winMgr:destroyWindow(Chack)
	   end
   end
end

function changeFavoriteIcon(favFlag)
	if favFlag then
		return "UIData/Collection/Collection_UI.png",625, 872
	else
		return "UIData/Collection/Collection_UI.png",625, 852
	end
end


function onclickPagination(mode)
	if mode == "prev" and number_current_page > 1 then
		number_current_page = number_current_page - 1
	elseif mode == "next" and number_current_page < number_all_page  then
		number_current_page = number_current_page + 1
	end
	local text_paging = number_current_page.."/"..number_all_page 
	-- winMgr:getWindow("Collection_Pagination"):setText(text_paging)
	winMgr:getWindow("Collection_Pagination"):setText(text_paging)
	
	GetCollectionHistory(id_selectedMenu)
	
	local startPage = ((number_current_page-1)*max_1Page) 
	local endPage = (startPage + max_1Page)
	if endPage > all_item_list then
        endPage = all_item_list
    end
	-- favFlagList = {0, 0, 0, 0, 0, 0}
	clearAllRows() 
	bg = winMgr:getWindow("Collection_OverAllFrame")
	bg:setVisible(true)
	for i = startPage, endPage - 1  do
		DrawerRowTable(i, number_current_page, 0)
	end
	
end

function onRowClick(index, data)
	-- Logic for handling row clicks
	-- Rowtable is Id Row Collection'
	winMgr:destroyWindow("Collection_ItemRequirement")
	local id_col = 0
	local collection_Name_onCilck = ""
	
	local items = 1 -- Total number of items
	if id_selectedMenu == 1 then
		id_col = id_collection_Character[index+1]
		collection_Name_onCilck = collectionData_collectionName[id_selectedMenu][id_collection_Character[index+1]][index+1]
		items = #collectionData_collectionName[id_selectedMenu][id_collection_Character[index+1]]
	elseif id_selectedMenu == 2 then
		id_col = id_collection_Costume[index+1]
		collection_Name_onCilck = collectionData_collectionName[id_selectedMenu][id_collection_Costume[index+1]][index+1]
		items = #collectionData_collectionName[id_selectedMenu][id_collection_Costume[index+1]]

	elseif id_selectedMenu == 3 then
		id_col = id_collection_PVE[index+1]
		collection_Name_onCilck = collectionData_collectionName[id_selectedMenu][id_collection_PVE[index+1]][index+1]
		items = #collectionData_collectionName[id_selectedMenu][id_collection_PVE[index+1]]

	elseif id_selectedMenu == 4 then
		id_col = id_collection_PVP[index+1]
		collection_Name_onCilck = collectionData_collectionName[id_selectedMenu][id_collection_PVP[index+1]][index+1]
		items = #collectionData_collectionName[id_selectedMenu][id_collection_PVP[index+1]]

	elseif id_selectedMenu == 5 then
		id_col = id_collection_Event[index+1]
		collection_Name_onCilck = collectionData_collectionName[id_selectedMenu][id_collection_Event[index+1]][index+1]
		items = #collectionData_collectionName[id_selectedMenu][id_collection_Event[index+1]]

	elseif id_selectedMenu == 6 then
		id_col = id_collection_Secret[index+1]
		collection_Name_onCilck = collectionData_collectionName[id_selectedMenu][id_collection_Secret[index+1]][index+1]
		items = #collectionData_collectionName[id_selectedMenu][id_collection_Secret[index+1]]

	end
	-- rq_data = GetCollectionRequirement(index)
	-- re_data = GetCollectionReward(index)
	-- LOG("rq_data : "..rq_data)
	-- LOG("re_data : "..re_data)
	if someItem then
		bg = winMgr:getWindow("Collection_OverAllFrame")
		bg:setVisible(true)
	else
		RenderItemReward() 
	end

	ItemCollectionBackround = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemCollectionBackround")
    ItemCollectionBackround:setTexture("Enabled", "UIData/Collection/Collection_Register_UI.png", 0, 565)
    ItemCollectionBackround:setPosition(645, 50)
    ItemCollectionBackround:setSize(235,425)
    ItemCollectionBackround:setVisible(true)
    ItemCollectionBackround:setAlwaysOnTop(true)
    ItemCollectionBackround:setZOrderingEnabled(true)
    background:addChildWindow(ItemCollectionBackround)
	-- winMgr:getWindow('Collection_ItemRequirement'):addChildWindow(ItemRequirement)


	local aspectRatio_ItemRequirement = 200 / 100
    local newWidth_ItemRequirement = 145
    local newHeight_ItemRequirement = newWidth_ItemRequirement * aspectRatio_ItemRequirement
    ItemRequirement = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemRequirement")
    ItemRequirement:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 314, 765)
    ItemRequirement:setPosition((210-200)/2, 80)
    ItemRequirement:setSize(200,100 )
	ItemRequirement:setScaleWidth(newHeight_ItemRequirement)
    ItemRequirement:setScaleHeight(newHeight_ItemRequirement)
    ItemRequirement:setVisible(true)
    ItemRequirement:setAlwaysOnTop(true)
    ItemRequirement:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(ItemRequirement)
	
	text = Text("Collection_Item_Requirement")
	text:setText("Item")
	--mid top background
	text:setPosition(90, 50)
	text:setSize(1, 1)
	text:setFont("tahoma", 15)
	text:setTextColor(255, 182,80,255)
	ItemCollectionBackround:addChildWindow(text)

	local aspectRatio_ItemCollection = 200 / 100
    local newWidth_ItemCollection = 145
    local newHeight_ItemCollection = newWidth_ItemCollection * aspectRatio_ItemCollection
	ItemReward = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemReward")
    ItemReward:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 314, 765)
    ItemReward:setPosition((210-200)/2,215)
    ItemReward:setSize(200,100 )
	ItemReward:setScaleWidth(newHeight_ItemCollection)
    ItemReward:setScaleHeight(newHeight_ItemCollection)
    ItemReward:setVisible(true)
    ItemReward:setAlwaysOnTop(true)
    ItemReward:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(ItemReward)

	text = Text("Collection_Item_Reward")
	text:setText("Reward")
	--mid top background
	text:setPosition(85, 195)
	text:setSize(200, 20)
	text:setFont("tahoma", 15)
	text:setTextColor(255, 182,80,255)
	ItemCollectionBackround:addChildWindow(text)

	text_collection_Name = winMgr:createWindow("TaharezLook/StaticText", "Collection_Item_Set")
	text_collection_Name:setText(collection_Name_onCilck)
	
	--mid top background
	
	text_collection_Name:setPosition(85, 5)
	text_collection_Name:setAlign(8)
	text_collection_Name:setSize(200, 20)
	text_collection_Name:setFont("tahoma", 10)
	text_collection_Name:setAlwaysOnTop(true)
	text_collection_Name:setTextColor(43, 255,0,255)
	ItemRequirement:addChildWindow(text_collection_Name)

	ItemReward = winMgr:createWindow("TaharezLook/Button", "Collection_ItemAdd")
    ItemReward:setTexture("Normal", "UIData/Collection/Collection_Register_UI.png", 439, 479)
	ItemReward:setTexture("Hover", "UIData/Collection/Collection_Register_UI.png", 224, 479)
    ItemReward:setPosition((330-200)/2,340)
    ItemReward:setSize(100,31 )
    ItemReward:setVisible(false)
    ItemReward:setAlwaysOnTop(true)
    ItemReward:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(ItemReward)

	local currentIndex = 0
	while currentIndex < items do
		RenderItemSet("item_set_"..currentIndex, "", posX[currentIndex], posY[currentIndex], sizeX[currentIndex], sizeY[currentIndex], cropX[currentIndex], cropY[currentIndex]
			, currentIndex
			-- , Rowtable
			, id_col
		)
		currentIndex = currentIndex + 1
	end

	-- end
	winMgr:getWindow('Collection_RegisterSetCollectionBackround'):setVisible(false)
	winMgr:getWindow('Collection_ItemRewardDetail'):setVisible(false)
	winMgr:getWindow('Collection_Background'):setVisible(false)
	winMgr:getWindow('Collection_ItemSet10'):setVisible(false)
end

function RenderPagination()
	background = winMgr:getWindow("Collection_BackImage")
	
	-- prev button
	prevPgn = winMgr:createWindow("TaharezLook/Button", "Collection_Prev")
	prevPgn:setTexture("Normal", "UIData/Collection/Collection_Register_UI.png", 610, 494)
	prevPgn:setTexture("Hover","UIData/Collection/Collection_Register_UI.png",590,494)
	prevPgn:setPosition((625-50)/2, 420)
	prevPgn:setSize(20, 20)
	prevPgn:setVisible(true)
	prevPgn:setAlwaysOnTop(true)
	prevPgn:setZOrderingEnabled(true)
	prevPgn:subscribeEvent("Clicked", function()
		onclickPagination("prev")
	end)
	background:addChildWindow(prevPgn)


	--text x/x
	-- text = Text("Collection_Pagination")
	text = winMgr:createWindow("TaharezLook/StaticText", "Collection_Pagination")
	local text_paging = number_current_page .."/".. number_all_page
	text:setTextColor(255, 255, 255, 255)
	text:setText(text_paging)
	text:setPosition((625-10)/2, 420)
	text:setSize(20, 20)
	text:setAlphaWithChild(0)
	text:setUseEventController(false)
	background:addChildWindow(text)

	-- next button
	nextPgn = winMgr:createWindow("TaharezLook/Button", "Collection_Next")
	nextPgn:setTexture("Normal", "UIData/Collection/Collection_Register_UI.png", 565, 494)
	nextPgn:setTexture("Hover","UIData/Collection/Collection_Register_UI.png",544,494)
	nextPgn:setPosition((625+50)/2, 420)
	nextPgn:setSize(20, 20)
	nextPgn:setVisible(true)
	nextPgn:setAlwaysOnTop(true)
	nextPgn:setZOrderingEnabled(true)
	nextPgn:subscribeEvent("Clicked", function()
		onclickPagination("next")
		-- LOG("number_current_page : "..(number_current_page+1))
	end)
	background:addChildWindow(nextPgn)
end

function RenderRedioFilterCollection()
	background = winMgr:getWindow("Collection_BackImage")
	radioFrame = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RadioFrame")
	radioFrame:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	radioFrame:setPosition(360, 450)
	radioFrame:setSize(500, 100)
	background:addChildWindow(radioFrame)
	-- radio button
	RenderRadioAllCollection(radioFrame)
	RenderRadioInCompletedCollection(radioFrame)
	RenderRadioCompletedCollection(radioFrame)
	


end
function RenderRadioAllCollection(radioFrame)
	radioAll = winMgr:createWindow("TaharezLook/RadioButton", "Collection_Radio_All")
	radioAll:setTexture("Normal", "UIData/Collection/Collection_UI.png", 625, 915)
	radioAll:setTexture("SelectedNormal", "UIData/Collection/Collection_UI.png", 625, 895)
	radioAll:setTexture("SelectedHover", "UIData/Collection/Collection_UI.png", 625, 895)
	radioAll:setTexture("SelectedPushed", "UIData/Collection/Collection_UI.png", 625, 895)
	radioAll:setTexture("SelectedPushedOff", "UIData/Collection/Collection_UI.png", 625, 895)

	radioAll:setPosition(10, 10)
	radioAll:setSize(40, 20)
	radioAll:setVisible(true)
	radioAll:setAlwaysOnTop(true)
	radioAll:setZOrderingEnabled(true)
	radioAll:setProperty('Selected', 'true')
	-- event on select radio button
	-- radioAll:subscribeEvent("SelectStateChanged", "Collection_Radio_All_SelectStateChanged")

	radioFrame:addChildWindow(radioAll)
	-- add text ALL right of radio button
	textAll = Text("Collection_Radio_All_Text")
	textAll:setText("ALL")
	textAll:setPosition(30, 8)
	textAll:setSize(20, 20)
	radioFrame:addChildWindow(textAll)
end

function RenderRadioInCompletedCollection(radioFrame)
	radioInCompleted = winMgr:createWindow("TaharezLook/RadioButton", "Collection_Radio_InCompleted")
	radioInCompleted:setTexture("Normal", "UIData/Collection/Collection_UI.png", 625, 915)
	radioInCompleted:setTexture("SelectedNormal", "UIData/Collection/Collection_UI.png", 625, 895)
	radioInCompleted:setTexture("SelectedHover", "UIData/Collection/Collection_UI.png", 625, 895)
	radioInCompleted:setTexture("SelectedPushed", "UIData/Collection/Collection_UI.png", 625, 895)
	radioInCompleted:setTexture("SelectedPushedOff", "UIData/Collection/Collection_UI.png", 625, 895)
	radioInCompleted:setPosition(60, 10)
	radioInCompleted:setSize(110, 20)
	-- radioInCompleted:setSelected(true)
	radioInCompleted:setVisible(true)
	radioInCompleted:setAlwaysOnTop(true)
	radioInCompleted:setZOrderingEnabled(true)
	-- event on select radio button
	radioInCompleted:subscribeEvent("SelectStateChanged", "Collection_Radio_InCompleted_SelectStateChanged")

	radioFrame:addChildWindow(radioInCompleted)
	-- add text InCompleted right of radio button
	textInCompleted = Text("Collection_Radio_InCompleted_Text")
	textInCompleted:setText("InCompleted")
	textInCompleted:setPosition(80, 8)
	textInCompleted:setSize(20, 20)
	radioFrame:addChildWindow(textInCompleted)

end

function RenderRadioCompletedCollection(radioFrame)
	radioCompleted = winMgr:createWindow("TaharezLook/RadioButton", "Collection_Radio_Completed")
	radioCompleted:setTexture("Normal", "UIData/Collection/Collection_UI.png", 625, 915)
	radioCompleted:setTexture("SelectedNormal", "UIData/Collection/Collection_UI.png", 625, 895)
	radioCompleted:setTexture("SelectedHover", "UIData/Collection/Collection_UI.png", 625, 895)
	radioCompleted:setTexture("SelectedPushed", "UIData/Collection/Collection_UI.png", 625, 895)
	radioCompleted:setTexture("SelectedPushedOff", "UIData/Collection/Collection_UI.png", 625, 895)
	radioCompleted:setPosition(180, 10)
	radioCompleted:setSize(100, 20)
	-- radioCompleted:setSelected(true)
	radioCompleted:setVisible(true)
	radioCompleted:setAlwaysOnTop(true)
	radioCompleted:setZOrderingEnabled(true)
	-- event on select radio button
	radioCompleted:subscribeEvent("SelectStateChanged", "Collection_Radio_InCompleted_SelectStateChanged")

	radioFrame:addChildWindow(radioCompleted)
	-- add text InCompleted right of radio button
	textCompleted = Text("Collection_Radio_Completed_Text")
	textCompleted:setText("Completed")
	textCompleted:setPosition(200, 8)
	textCompleted:setSize(120, 20)
	radioFrame:addChildWindow(textCompleted)

end

function CollectionSeachbar()

	background = winMgr:getWindow("Collection_BackImage")
	
	--icon search
	searchBar = winMgr:createWindow("TaharezLook/Editbox", "Collection_SearchBar")
	-- searchBar:setTexture("Normal", "UIData/Collection/Collection_UI.png", 0, 500)
	searchBar:setPosition(680, 60)
	searchBar:setSize(180, 30)
	searchBar:setVisible(true)
	searchBar:setAlwaysOnTop(true)
	-- text align center
	--disable background
	searchBar:setProperty("FrameEnabled", "false")
	searchBar:setProperty("BackgroundEnabled", "false")
	
	searchBar:setZOrderingEnabled(false)
	searchBar:setTextColor(255, 255, 255, 255)
	searchBar:setProperty("TextPadding", "{{0,0},{5,0}}")
	-- text is white
	searchBar:setText("Enter text here")

	-- searchBar:setProperty("NormalTextColour", "FFFFFFFF") -- RGBA format: white with full opacity

	background:addChildWindow(searchBar)

	--search bar background
	searchBarBackground = winMgr:createWindow("TaharezLook/Button", "Collection_SearchBarBackground")
	searchBarBackground:setTexture("Normal", "UIData/Collection/Collection_UI.png", 0, 870)
	searchBarBackground:setPosition(655, 60)
	searchBarBackground:setSize(30, 30)
	searchBarBackground:setVisible(true)
	searchBarBackground:setAlwaysOnTop(true)
	searchBarBackground:setZOrderingEnabled(true)
	background:addChildWindow(searchBarBackground)
	-- btn refresh
	searchBarRefresh = winMgr:createWindow("TaharezLook/Button", "Collection_SearchBarRefresh")
	searchBarRefresh:setTexture("Normal", "UIData/Collection/Collection_UI.png", 270, 870)
	searchBarRefresh:setPosition(850, 60)
	searchBarRefresh:setSize(30, 30)
	searchBarRefresh:setVisible(true)
	searchBarRefresh:setAlwaysOnTop(true)
	searchBarRefresh:setZOrderingEnabled(true)
	searchBarRefresh:subscribeEvent("Clicked", function()
		-- LOG("SearchBarRefresh Clicked")
		LoadCollectionList()
	end)
	background:addChildWindow(searchBarRefresh)
end


function MyCollectionInfo()
	background = winMgr:getWindow("Collection_BackImage")
	Max_common = 99
	Max_high = 99
	Max_Unique = 99
	Max_Rare = 99
	Max_Legendary = 99
	Max_Ultimate = 99
	Common = 70
	High = 10
	Unique = 10
	Rare = 20
	Legendary = 10
	Ultimate = 20
	-- body

	InfoBackground = winMgr:createWindow("TaharezLook/StaticImage", "Collection_Background")
	InfoBackground:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 785, 515)
	InfoBackground:setPosition(650, 125)
	InfoBackground:setSize(230,350 )
	InfoBackground:setVisible(true)
	InfoBackground:setAlwaysOnTop(true)
	InfoBackground:setZOrderingEnabled(true)
	background:addChildWindow(InfoBackground)
	InfoOverAllFrame = winMgr:createWindow("TaharezLook/StaticImage", "Collection_OverAllFrame")
	InfoOverAllFrame:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	InfoOverAllFrame:setPosition(650, 115)
	InfoOverAllFrame:setSize(230,350 )
	InfoOverAllFrame:setAlwaysOnTop(true)
	InfoOverAllFrame:setZOrderingEnabled(true)
	background:addChildWindow(InfoOverAllFrame)
	-- icon
	icon = winMgr:createWindow("TaharezLook/StaticImage", "Collection_Icon")
	icon:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 630, 515)
	icon:setPosition(50, 40)
	icon:setSize(150,180)
	icon:setVisible(true)
	icon:setAlwaysOnTop(true)
	icon:setZOrderingEnabled(true)
	InfoOverAllFrame:addChildWindow(icon)
	-- text
	text = Text("Collection_Header")
	text:setText("Collection Achievement")
	--mid top background
	text:setPosition(30, 10)
	text:setSize(200, 20)
	InfoOverAllFrame:addChildWindow(text)
	marginX = 15
	ProgressBar("Common",		InfoOverAllFrame,	Max_common,		Common,		marginX,	180)
	ProgressBar("High",			InfoOverAllFrame,	Max_high,		High,		marginX,	200)
	ProgressBar("Unique",		InfoOverAllFrame,	Max_Unique,		Unique,		marginX,	220)
	ProgressBar("Rare",			InfoOverAllFrame,	Max_Rare,		Rare,		marginX,	240)
	ProgressBar("Legendary",	InfoOverAllFrame,	Max_Legendary,	Legendary,	marginX,	260)
	ProgressBar("Ultimate",		InfoOverAllFrame,	Max_Ultimate,	Ultimate,	marginX,	280)
end

function ProgressBar(name,infoBackground,max,now,posX,posY)
		
		lengthBar = 200
		gap=15
	
		-- text common
		text = Text("Collection_"..name)
		text:setText(name)
		text:setPosition(posX, posY)
		text:setSize(200, 20)
		text:setFont("tahoma", 10)
		text:setTextColor(255, 255, 255, 255)
		infoBackground:addChildWindow(text)
		
		--text count common
	
		text = Text("Collection_Count_"..name)
		text:setText(now.."/"..max)
		text:setPosition(posX+170, posY)
		text:setSize(200, 20)
		text:setFont("tahoma", 10)
		text:setTextColor(255, 255, 255, 255)
		infoBackground:addChildWindow(text)
		
		--progress bar
		progressBarBackgroundCommon = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ProgressBar_background_"..name)
		progressBarBackgroundCommon:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 0, 850)
		progressBarBackgroundCommon:setPosition(posX, posY+gap)
		progressBarBackgroundCommon:setSize(200, 5)
		progressBarBackgroundCommon:setVisible(true)
		progressBarBackgroundCommon:setAlwaysOnTop(true)
		progressBarBackgroundCommon:setZOrderingEnabled(true)
		infoBackground:addChildWindow(progressBarBackgroundCommon)
	
		progressBarCommon = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ProgressBar_"..name)
		progressBarCommon:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 0, 860)
		progressBarCommon:setPosition(posX, posY+gap)
		progressBarCommon:setSize((now*lengthBar)/max, 5)
		progressBarCommon:setVisible(true)
		progressBarCommon:setAlwaysOnTop(true)
		progressBarCommon:setZOrderingEnabled(true)
		infoBackground:addChildWindow(progressBarCommon)
	
end
function WndMyCollectionToggle()
	background = winMgr:getWindow("Collection_BackImage")
	if background:isVisible() == true then
		background:setVisible(false)
	else
		background:setVisible(true)
	end
end

function MyCollectionModeOpen()
   
	MyCollectionLogger("Start MyCollectionModeOpen")
	WndMyCollection()
	winMgr:getWindow("Collection_BackImage"):setVisible(true)
end



function RemoveRowTable()
	background = winMgr:getWindow("Collection_BackImage")
	MyCollectionLogger("RemoveRowTable")
	for i = 0, 5 do
		item = winMgr:getWindow("Collection_Table"..i)
		-- destroy item
		background:removeChildWindow(item)

	end
end


function RenderItemReward()
	ItemCollectionBackround = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemCollectionBackround")
    ItemCollectionBackround:setTexture("Enabled", "UIData/Collection/Collection_Register_UI.png", 0, 565)
    ItemCollectionBackround:setPosition(645, 50)
    ItemCollectionBackround:setSize(235,425)
    ItemCollectionBackround:setVisible(true)
    ItemCollectionBackround:setAlwaysOnTop(true)
    ItemCollectionBackround:setZOrderingEnabled(true)
    background:addChildWindow(ItemCollectionBackround)
	-- winMgr:getWindow('Collection_ItemRequirement'):addChildWindow(ItemRequirement)

	local aspectRatio_ItemRequirement = 200 / 100
    local newWidth_ItemRequirement = 145
    local newHeight_ItemRequirement = newWidth_ItemRequirement * aspectRatio_ItemRequirement
    ItemRequirement = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemRequirement")
    ItemRequirement:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 314, 765)
    ItemRequirement:setPosition((210-200)/2, 80)
    ItemRequirement:setSize(200,100 )
	ItemRequirement:setScaleWidth(newHeight_ItemRequirement)
    ItemRequirement:setScaleHeight(newHeight_ItemRequirement)
    ItemRequirement:setVisible(true)
    ItemRequirement:setAlwaysOnTop(true)
    ItemRequirement:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(ItemRequirement)

	text = Text("Collection_Item_Requirement")
	text:setText("Item")
	--mid top background
	text:setPosition(90, 50)
	text:setSize(1, 1)
	text:setFont("tahoma", 15)
	text:setTextColor(255, 182,80,255)
	ItemCollectionBackround:addChildWindow(text)

	local aspectRatio_ItemCollection = 200 / 100
    local newWidth_ItemCollection = 145
    local newHeight_ItemCollection = newWidth_ItemCollection * aspectRatio_ItemCollection
	ItemReward = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemReward")
    ItemReward:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 314, 765)
    ItemReward:setPosition((210-200)/2,215)
    ItemReward:setSize(200,100 )
	ItemReward:setScaleWidth(newHeight_ItemCollection)
    ItemReward:setScaleHeight(newHeight_ItemCollection)
    ItemReward:setVisible(true)
    ItemReward:setAlwaysOnTop(true)
    ItemReward:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(ItemReward)

	text = Text("Collection_Item_Reward")
	text:setText("Reward")
	--mid top background
	text:setPosition(85, 195)
	text:setSize(200, 20)
	text:setFont("tahoma", 15)
	text:setTextColor(255, 182,80,255)
	ItemCollectionBackround:addChildWindow(text)


	text = Text("Collection_Item_Set")
	text:setText("High Adventure Set")
	--mid top background
	text:setPosition(70, 5)
	text:setSize(200, 20)
	text:setFont("tahoma", 10)
	text:setAlwaysOnTop(true)
	text:setTextColor(43, 255,0,255)
	ItemRequirement:addChildWindow(text)

	ItemReward = winMgr:createWindow("TaharezLook/Button", "Collection_ItemAdd")
    ItemReward:setTexture("Normal", "UIData/Collection/Collection_Register_UI.png", 439, 479)
	ItemReward:setTexture("Hover", "UIData/Collection/Collection_Register_UI.png", 224, 479)
    ItemReward:setPosition((330-200)/2,340)
    ItemReward:setSize(100,31 )
    ItemReward:setVisible(false)
    ItemReward:setAlwaysOnTop(true)
    ItemReward:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(ItemReward)

	-- MockUpLoopItemSet() 
	MockUpLoopItemReward()
end	

-- ฟังก์ชันตรวจสอบว่า itemId อยู่ใน collectionData_History หรือไม่
local function isInHistory(category_id, collection_id, itemId)
    for _, id in ipairs(collectionData_History[category_id][collection_id]) do
        if id == itemId then
            return true
        end
    end
    return false
end

local function EnabledInHistory(category_id, collection_id, itemId)
    for _, id in ipairs(collectionData_History[category_id][collection_id]) do
        if id == itemId then
            return false
        end
    end
    return true
end	

function RenderItemSet(i,item_path,posX,posY,sizeX,sizeY,cropX,cropY
		, currentIndex_in_row, Rowtable_id
	)
    ItemCollectionBackround = winMgr:getWindow("Collection_ItemRequirement")
    ItemFrame = winMgr:createWindow("TaharezLook/Button", "Collection_ItemFrame"..i) 
    ItemFrame:setTexture("Normal", "UIData/Collection/Collection_UI.png",cropX,cropY)
    ItemFrame:setTexture("Hover","UIData/Collection/Collection_UI.png", cropX, cropY-40)
	ItemFrame:subscribeEvent("Clicked", function()
		winMgr:getWindow("Collection_ItemReward"):setVisible(false)
		RegisterItem(currentIndex_in_row, Rowtable_id)
        
    end)
    ItemFrame:setPosition(posX,posY)
    ItemFrame:setSize(32, 32)
    ItemFrame:setVisible(true)
    ItemFrame:setAlwaysOnTop(false)
    ItemFrame:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(ItemFrame)

	local renderItem_Path = collectionData_path[id_selectedMenu][Rowtable_id][currentIndex_in_row+1]
	local renderItemSet_itemId = collectionData_itemId[id_selectedMenu][Rowtable_id][currentIndex_in_row+1]

	img_ItemFrame = winMgr:createWindow("TaharezLook/StaticImage", "img_Collection_ItemFrame_"..currentIndex_in_row)
	img_ItemFrame:setTexture("Enabled", "UIData/ItemUIData/"..renderItem_Path, 0, 0)
	img_ItemFrame:setTexture("Disabled", "UIData/ItemUIData/"..renderItem_Path, 0, 0)
	-- item_img:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	-- item_img:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	img_ItemFrame:setPosition(2, 3)
	img_ItemFrame:setSize(110, 110)
	img_ItemFrame:setScaleHeight(65)
	img_ItemFrame:setScaleWidth(65)
	img_ItemFrame:setEnabled(false)
	img_ItemFrame:setVisible(true)
	img_ItemFrame:setAlwaysOnTop(true)
	winMgr:getWindow("Collection_ItemFrame"..i):addChildWindow(img_ItemFrame)
	
	local aspectRatio_CheckImg = 24 / 22
    local newWidth_CheckImg = 1000
    local newHeight_CheckImg = newWidth_CheckImg * aspectRatio_CheckImg
	-- Collection_Item_Check item
	CheckImg = winMgr:createWindow("TaharezLook/Button", "img_Collection_Check_ItemFrame_"..currentIndex_in_row)
	CheckImg:setTexture("Normal", "UIData/Collection/Collection_UI.png", 625, 793) -- ใช้ Texture สำหรับปุ่มรางวัล
	CheckImg:setPosition(6, 2)
	CheckImg:setSize(24, 21) 
	CheckImg:setScaleWidth(newHeight_CheckImg)
    CheckImg:setScaleHeight(newHeight_CheckImg)
	-- CheckImg:setVisible(false)
	CheckImg:setVisible(isInHistory(id_selectedMenu, Rowtable_id, renderItemSet_itemId))
	CheckImg:setAlwaysOnTop(true)
	CheckImg:setZOrderingEnabled(true)
	img_ItemFrame:addChildWindow(CheckImg)

	local aspectRatio_BtnReward = 24 / 22
    local newWidth_BtnReward = 120
    local newHeight_BtnReward = newWidth_BtnReward * aspectRatio_BtnReward
    -- createRewardButtonsBackround = winMgr:getWindow("Collection_ItemRequirement")
	BtnReward = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemRewardDetail_"..i)
	BtnReward:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 625, 793)
    BtnReward:setPosition(posX,posY)
    BtnReward:setSize(24,22)
	BtnReward:setScaleWidth(newWidth_BtnReward+40)
    BtnReward:setScaleHeight(newWidth_BtnReward+20)
    BtnReward:setVisible(false)
    BtnReward:setAlwaysOnTop(true)
    BtnReward:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(BtnReward)
end	

function RenderItemRewards(i,item_path,posX,posY,sizeX,sizeY,cropX,cropY)
    ItemCollectionBackround = winMgr:getWindow("Collection_ItemReward")
    ItemFrame = winMgr:createWindow("TaharezLook/Button", "Collection_ItemFrame"..i)
    ItemFrame:setTexture("Normal", "UIData/Collection/Collection_Register_UI.png",cropX,cropY)
    -- ItemFrame:setTexture("Hover","UIData/Collection/Collection_UI.png", cropX, cropY-40)
    
    ItemFrame:setPosition(posX,posY)
    ItemFrame:setSize(sizeX,sizeY)
    ItemFrame:setVisible(true)
    ItemFrame:setAlwaysOnTop(true)
    ItemFrame:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(ItemFrame)
    
    if item_path ~= "" then
        -- LOG("item_path is not null after render ".. item_path)
        ItemImg = winMgr:createWindow("TaharezLook/Button", "Collection_ItemImgData"..i)
        ItemImg:setTexture("Normal", item_path, 0, 0)
        
        -- ItemImg:setTexture("Normal", "UIData/Collection/Collection_UI.png", 95, cropY)
        ItemImg:setPosition(2,2)
        ItemImg:setSize(100, 100)
        ItemImg:setScaleWidth(65)
        ItemImg:setScaleHeight(65)
        ItemImg:setVisible(true)
    -- hover event
    
    ItemFrame:addChildWindow(ItemImg)
    end
end


function MockUpLoopItemSet()
	-- Configuration
	local cardwidth = 570
	local items = 8 -- Total number of items
	local columns = 5 -- Max columns per row
	local padding = 5 -- Space between items
	local sizeX, sizeY = 30, 30 -- Size of each item
	local containerWidth = (cardwidth - ((sizeX * columns) + (padding * (columns - 1)))) / 2 -- Width of the container (ItemCollectionBackround)
	local startY = 20 -- Starting Y-coordinate
	local cropItemArr = {
		{0, 815}, {35, 815}, {70, 815}, {105, 815}, {140, 815},
		{175, 815}, {210, 815}, {245, 815}
	}

	-- Loop to render items dynamically with center alignment
	local currentIndex = 0
	while currentIndex < items do
	-- Calculate the number of items in the current row
		local itemsInRow = math.min(columns, items - currentIndex)

		-- Calculate total row width
		local totalRowWidth = itemsInRow * sizeX + (itemsInRow - 1) * padding

		-- Calculate starting X to center items
		local startX = (containerWidth - totalRowWidth) / 2

		-- Render items in the current row
		for i = 1, itemsInRow do
			local posX = startX + (i - 1) * (sizeX + padding)
			local posY = startY + math.floor(currentIndex / columns) * (sizeY + padding)

			-- Get crop coordinates
			local cropX, cropY = cropItemArr[currentIndex + 1][1], cropItemArr[currentIndex + 1][2]

			-- Render the item
			-- RenderItemSet("item_set_"..currentIndex, "", posX, posY, sizeX, sizeY, cropX, cropY, currentIndex)
			currentIndex = currentIndex + 1
		end
	end
end

function MockUpLoopItemReward()
	-- LOG("MockUpLoopItemReward")
	-- Configuration
	local cardwidth = 600
	local items = 6 -- Total number of items
	local columns = 3 -- Max columns per row
	local padding = 5 -- Space between items
	local sizeX, sizeY = 40, 40 -- Size of each item
	local containerWidth = (cardwidth - ((sizeX * columns) + (padding * (columns - 1)))) / 2 -- Width of the container (ItemCollectionBackround)
	local startY = 5-- Starting Y-coordinate
	local cropItemArr = {
		{45, 435}, {0, 435}, {45*2,435 }, {45*3, 435}, {45*4, 435},
		{45*5, 435}, {45*6,435}, {80, 435}
	}

	-- Loop to render items dynamically with center alignment
	local currentIndex = 0
	while currentIndex < items do
		-- Calculate the number of items in the current row
		local itemsInRow = math.min(columns, items - currentIndex)

		-- Calculate total row width
		local totalRowWidth = itemsInRow * sizeX + (itemsInRow - 1) * padding

		-- Calculate starting X to center items
		local startX = (containerWidth - totalRowWidth) / 2

		-- Render items in the current row
		for i = 1, itemsInRow do
			local posX = startX + (i - 1) * (sizeX + padding)-15
			local posY = startY + math.floor(currentIndex / columns) * (sizeY + padding)

			-- Get crop coordinates
			local cropX, cropY = cropItemArr[currentIndex + 1][1], cropItemArr[currentIndex + 1][2]

			-- Render the item
			RenderItemRewards("item_reward"..currentIndex, "", posX, posY, sizeX, sizeY, cropX, cropY)
			currentIndex = currentIndex + 1
		end
	end
end


local renderItemSet_itemName = ""
local Rowtable_id_onClick = 0
local data_on_selected_item = {}


function removeItemWhenAfterRegister(ItemNumber,slotIndex)
	
	if data_on_selected_item[0] == ItemNumber and  data_on_selected_item[1] == slotIndex then
		winMgr:destroyWindow("Collection_RegisterSetItem_"..data_on_selected_item[3])
		Rowtable_id_onClick = 0
		currentIndex_in_row_onClick = 0
		data_on_selected_item[0] = 0 --itemNumber
		data_on_selected_item[1] = 0 --possesionIndex
		data_on_selected_item[2] = 0 --Rowtable_id_onClick
		data_on_selected_item[3] = 0 --index winMgr
		
	end
end

local dataList_y_RegisterSetItem = {115, 165, 216}

 function RegisterSet(index, storageIndex, possesionIndex, itemNumber, fileName, fileName2, itemCount, itemGrade)
	local buttonsRegister = {}
	RegisterSetCollectionBackround = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RegisterSetCollectionBackround")
    RegisterSetCollectionBackround:setTexture("Enabled", "UIData/Collection/Collection_Register_UI.png", 0, 0)
    RegisterSetCollectionBackround:setPosition(300, 50)
    RegisterSetCollectionBackround:setSize(312,432 )
    RegisterSetCollectionBackround:setVisible(true)
    RegisterSetCollectionBackround:setAlwaysOnTop(true)
    RegisterSetCollectionBackround:setZOrderingEnabled(true)
    background:addChildWindow(RegisterSetCollectionBackround)

	text = Text("Collection_Register_Requirement")
	text:setText("Register")
	--mid top background
	text:setPosition(115, 10)
	text:setSize(200, 20)
	text:setFont("tahoma", 15)
	text:setTextColor(255, 182,80,255)
	RegisterSetCollectionBackround:addChildWindow(text)

	text = Text("Collection_Register_Requirement2")
	text:setText("Register this item ?")
	--mid top background
	text:setPosition(100, 49)
	text:setSize(200, 20)
	text:setFont("tahoma", 10)
	text:setTextColor(255, 255,255,255)
	RegisterSetCollectionBackround:addChildWindow(text)

	text = Text("Collection_Register_Requirement3")
	text:setText("Registering this item will destroy it.")
	--mid top background
	text:setPosition(70, 65)
	text:setSize(200, 20)
	text:setFont("tahoma", 10)
	text:setTextColor(255, 0,0,255)
	RegisterSetCollectionBackround:addChildWindow(text)

	RegistecCancel = winMgr:createWindow("TaharezLook/Button", "Collection_RegistecCancel")
    RegistecCancel:setTexture("Normal", "UIData/Collection/Collection_UI.png", 624, 724)
	RegistecCancel:setTexture("Hover", "UIData/Collection/Collection_UI.png", 624, 724+16)
    RegistecCancel:setPosition(289, 4)
    RegistecCancel:setSize(17,16 )
    RegistecCancel:setVisible(true)
    RegistecCancel:setAlwaysOnTop(true)
    RegistecCancel:setZOrderingEnabled(true)
    RegisterSetCollectionBackround:addChildWindow(RegistecCancel)
	RegistecCancel:subscribeEvent("MouseClick", function()
		RegisterSetCollectionBackround:setVisible(false)  
	end)

	local aspectRatio_RegisterRequirement = 200 / 100
    local newWidth_RegisterRequirement = 141
    local newHeight_RegisterRequirement = newWidth_RegisterRequirement * aspectRatio_RegisterRequirement
    RegisterRequirement = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RegisterRequirement")
    RegisterRequirement:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 314, 765)
    RegisterRequirement:setPosition((210-200)/2,110)
    RegisterRequirement:setSize(200,100 )
	RegisterRequirement:setScaleWidth(newHeight_RegisterRequirement+90)
    RegisterRequirement:setScaleHeight(newHeight_RegisterRequirement+380)
    RegisterRequirement:setVisible(true)
    -- RegisterRequirement:setAlwaysOnTop(true)
    RegisterRequirement:setZOrderingEnabled(false)
    RegisterSetCollectionBackround:addChildWindow(RegisterRequirement)

	
    RegisterPagination = winMgr:createWindow("TaharezLook/Button", "Collection_RegisterPagination")
	RegisterPagination:setTexture("Normal", "UIData/Collection/Collection_Register_UI.png", 610, 494)
	RegisterPagination:setTexture("Hover","UIData/Collection/Collection_Register_UI.png",590,494)
    RegisterPagination:setPosition(115,330)
    RegisterPagination:setSize(18,17 )
    RegisterPagination:setVisible(true)
    RegisterPagination:setAlwaysOnTop(true)
    -- RegisterPagination:setZOrderingEnabled(true)
    RegisterSetCollectionBackround:addChildWindow(RegisterPagination)

	RegisterPagination2 = winMgr:createWindow("TaharezLook/Button", "Collection_RegisterPagination2")
	RegisterPagination2:setTexture("Normal", "UIData/Collection/Collection_Register_UI.png", 565, 494)
	RegisterPagination2:setTexture("Hover","UIData/Collection/Collection_Register_UI.png",544,494)
    RegisterPagination2:setPosition(165,330)
    RegisterPagination2:setSize(18,17 )
    RegisterPagination2:setVisible(true)
    RegisterPagination2:setAlwaysOnTop(true)
    RegisterPagination2:setZOrderingEnabled(true)
    RegisterSetCollectionBackround:addChildWindow(RegisterPagination2)

	text = Text("Collection_Registe_Pagination")
	text:setText("1/1")
	text:setPosition(135, 330)
	text:setSize(20, 10)
	RegisterSetCollectionBackround:addChildWindow(text)
	if index ~= nil and index ~= 0 then
		
		local aspectRatio_RegisterSetItem = 275 / 50
		local newWidth_RegisterSetItem = 50
		local newHeight_RegisterSetItem = newWidth_RegisterSetItem * aspectRatio_RegisterSetItem
		RegisterSetItem = winMgr:createWindow("TaharezLook/Button", "Collection_RegisterSetItem_"..index)
		buttonsRegister[index] = RegisterSetItem 
		RegisterSetItem:setTexture("Normal", "UIData/Collection/Collection_UI.png", 0, 965)
		RegisterSetItem:setTexture("Hover", "UIData/Collection/Collection_UI.png", 0, 910)
		RegisterSetItem:setPosition((216-200)/2,dataList_y_RegisterSetItem[index])
		RegisterSetItem:setSize(275,50 )
		RegisterSetItem:setScaleWidth(newHeight_RegisterSetItem+15)
		RegisterSetItem:setScaleHeight(newHeight_RegisterSetItem)
		RegisterSetItem:setVisible(true)
		RegisterSetItem:setAlwaysOnTop(true)
		RegisterSetItem:setZOrderingEnabled(true)
		RegisterSetItem:subscribeEvent("Clicked", function()
			for j = 1, 5 do
				-- if buttonsRegister[j] then
					if j == index then
						data_on_selected_item[0] = itemNumber
						data_on_selected_item[1] = possesionIndex
						data_on_selected_item[2] = Rowtable_id_onClick
						data_on_selected_item[3] = index
						winMgr:getWindow("Collection_RegisterSetItem_"..j):setTexture("Normal", "UIData/Collection/Collection_UI.png", 0, 910)
					else
						winMgr:getWindow("Collection_RegisterSetItem_"..j):setTexture("Normal", "UIData/Collection/Collection_UI.png", 0, 965)
					end
				-- end
			end
		end)
		RegisterSetCollectionBackround:addChildWindow(RegisterSetItem)

		local aspectRatio_RegisterIconItem = 33 / 31
		local newWidth_RegisterIconItem = 310
		local newHeight_RegisterIconItem = newWidth_RegisterIconItem * aspectRatio_RegisterIconItem
		RegisterIconItem = winMgr:createWindow("TaharezLook/StaticImage", "Collection_RegisterIconItem_"..index)
		RegisterIconItem:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 210, 815)
		RegisterIconItem:setPosition(5,5)
		RegisterIconItem:setSize(31,33 )
		RegisterIconItem:setScaleWidth(newHeight_RegisterIconItem+5)
		RegisterIconItem:setScaleHeight(newHeight_RegisterIconItem+10)
		RegisterIconItem:setVisible(true)
		RegisterIconItem:setAlwaysOnTop(true)
		RegisterIconItem:setZOrderingEnabled(true)
		RegisterSetItem:addChildWindow(RegisterIconItem)

		img_RegisterIconItem = winMgr:createWindow("TaharezLook/StaticImage", "img_Collection_RegisterIconItem_"..index)
		img_RegisterIconItem:setTexture("Enabled", "UIData/"..fileName, 0, 0)
		img_RegisterIconItem:setTexture("Disabled", "UIData/"..fileName, 0, 0)
		-- item_img:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		-- item_img:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		img_RegisterIconItem:setPosition(2, 3)
		img_RegisterIconItem:setSize(110, 110)
		img_RegisterIconItem:setScaleHeight(65)
		img_RegisterIconItem:setScaleWidth(65)
		img_RegisterIconItem:setEnabled(false)
		img_RegisterIconItem:setVisible(true)
		img_RegisterIconItem:setAlwaysOnTop(true)
		winMgr:getWindow("Collection_RegisterIconItem_"..index):addChildWindow(img_RegisterIconItem)

		text = Text("Collection_Register_Icon_Item_"..index)
		text:setText(renderItemSet_itemName.." +"..itemGrade)
		--mid top background
		text:setPosition(50, 15)
		text:setSize(1, 1)
		text:setFont("tahoma", 10)
		text:setTextColor(43, 255,0,255)
		winMgr:getWindow("Collection_RegisterIconItem_"..index):addChildWindow(text)
	end
	RegisterBtnAdd = winMgr:createWindow("TaharezLook/Button", "Collection_RegisterBtnAdd")
	RegisterBtnAdd:setTexture("Normal", "UIData/Collection/Collection_Register_UI.png", 235, 479)
	RegisterBtnAdd:setTexture("Hover", "UIData/Collection/Collection_Register_UI.png", 434, 479)
    RegisterBtnAdd:setPosition(100,380)
    RegisterBtnAdd:setSize(100,33 )
    RegisterBtnAdd:setVisible(true)
    RegisterBtnAdd:setAlwaysOnTop(true)
    RegisterBtnAdd:setZOrderingEnabled(true)
	RegisterBtnAdd:subscribeEvent("Clicked", function()
		-- removeItemWhenAfterRegister(data_on_selected_item[3], data_on_selected_item[1], data_on_selected_item[0])
		AddItemCollection(data_on_selected_item[0], data_on_selected_item[1], data_on_selected_item[2])
	end)
    RegisterSetCollectionBackround:addChildWindow(RegisterBtnAdd)
	

 end


 function RegisterItem(currentIndex_in_row, Rowtable_id)
	local renderItemSet_itemId = collectionData_itemId[id_selectedMenu][Rowtable_id][currentIndex_in_row+1]
	renderItemSet_itemName = collectionData_itemName[id_selectedMenu][Rowtable_id][currentIndex_in_row+1]
	-- list item 
	ItemCollectionBackround = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemCollectionBackround")
    ItemCollectionBackround:setTexture("Enabled", "UIData/Collection/Collection_Register_UI.png", 0, 565)
    ItemCollectionBackround:setPosition(645, 50)
    ItemCollectionBackround:setSize(235,425 )
    ItemCollectionBackround:setVisible(true)
    ItemCollectionBackround:setAlwaysOnTop(true)
    ItemCollectionBackround:setZOrderingEnabled(true)
	
    background:addChildWindow(ItemCollectionBackround)



	local aspectRatio_ItemCollection = 200 / 100
    local newWidth_ItemCollection = 145
    local newHeight_ItemCollection = newWidth_ItemCollection * aspectRatio_ItemCollection
	RegisterItemdCilck = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemRewardDetail")
    RegisterItemdCilck:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 314, 765)
    -- RegisterItemdCilck:setPosition((210-200)/2,186)
     RegisterItemdCilck:setPosition((10)/2, 200)

    RegisterItemdCilck:setSize(200,100 )
	RegisterItemdCilck:setScaleWidth(newHeight_ItemCollection)
    RegisterItemdCilck:setScaleHeight(newHeight_ItemCollection)
    RegisterItemdCilck:setVisible(true)
    RegisterItemdCilck:setAlwaysOnTop(true)
    RegisterItemdCilck:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(RegisterItemdCilck)
	

	text = Text("Collection_Item_Reward")
	text:setText(renderItemSet_itemName)
	--mid top background
	text:setPosition(70,5)
	text:setSize(200, 20)
	text:setFont("tahoma", 10)
	text:setTextColor(43, 255,0,255)
	RegisterItemdCilck:addChildWindow(text)


	text = Text("Collection_ItemSet11")
	text:setText("Good quality travel sun hat.")
	--mid top background
	text:setPosition(55, 90)
	text:setSize(200, 20)
	text:setFont("tahoma", 10)
	text:setTextColor(229, 224,224,255)
	RegisterItemdCilck:addChildWindow(text)


	local aspectRatio_ItemSetShow = 33 / 31
    local newWidth_ItemSetShow = 400
    local newHeight_ItemSetShow = newWidth_ItemSetShow * aspectRatio_ItemSetShow
	ItemSetShow = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemSet10")
    ItemSetShow:setTexture("Enabled", "UIData/Collection/Collection_UI.png", 210, 815)
    ItemSetShow:setPosition(80,20)
    ItemSetShow:setSize(31, 33)
	ItemSetShow:setScaleWidth(newHeight_ItemSetShow)
    ItemSetShow:setScaleHeight(newHeight_ItemSetShow)
    ItemSetShow:setVisible(true)
    ItemSetShow:setAlwaysOnTop(true)
    ItemSetShow:setZOrderingEnabled(true)
    RegisterItemdCilck:addChildWindow(ItemSetShow)

	local renderItemSet_secondValue = collectionData_path[id_selectedMenu][Rowtable_id][currentIndex_in_row+1]

	img_ItemRewardDetail = winMgr:createWindow("TaharezLook/StaticImage", "img_ItemRewardDetail")
	img_ItemRewardDetail:setTexture("Enabled", "UIData/ItemUIData/"..renderItemSet_secondValue, 0, 0)
	img_ItemRewardDetail:setTexture("Disabled", "UIData/ItemUIData/"..renderItemSet_secondValue, 0, 0)
	-- item_img:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	-- item_img:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	img_ItemRewardDetail:setPosition(2, 3)
	img_ItemRewardDetail:setSize(110, 110)
	img_ItemRewardDetail:setScaleHeight(65)
	img_ItemRewardDetail:setScaleWidth(65)
	img_ItemRewardDetail:setEnabled(false)
	img_ItemRewardDetail:setVisible(true)
	img_ItemRewardDetail:setAlwaysOnTop(true)
	winMgr:getWindow("Collection_ItemSet10"):addChildWindow(img_ItemRewardDetail)

	ItemBtnAdd = winMgr:createWindow("TaharezLook/StaticImage", "Collection_ItemAdd")
	ItemBtnAdd:setTexture("Normal", "UIData/Collection/Collection_Register_UI.png", 235, 479)
	ItemBtnAdd:setTexture("Hover", "UIData/Collection/Collection_Register_UI.png", 434, 479)
    ItemBtnAdd:setPosition((340-200)/2,340)
    ItemBtnAdd:setSize(100,30 )
   ItemBtnAdd:setVisible(EnabledInHistory(id_selectedMenu, Rowtable_id, renderItemSet_itemId))
    ItemBtnAdd:setEnabled(EnabledInHistory(id_selectedMenu, Rowtable_id, renderItemSet_itemId))
    ItemBtnAdd:setAlwaysOnTop(true)
    ItemBtnAdd:setZOrderingEnabled(true)
    ItemCollectionBackround:addChildWindow(ItemBtnAdd)
	ItemBtnAdd:subscribeEvent("MouseClick", function()
		data_on_selected_item[0] = 0 --itemNumber
		data_on_selected_item[1] = 0 --possesionIndex
		data_on_selected_item[2] = 0 --Rowtable_id_onClick
		data_on_selected_item[3] = 0 --index winMgr
		Rowtable_id_onClick = 0
		Rowtable_id_onClick = Rowtable_id
		currentIndex_in_row_onClick = currentIndex_in_row+1
		-- winMgr:destroyWindow("Collection_RegisterSetCollectionBackround")
		RegisterItemSet(renderItemSet_itemId, Rowtable_id)
		
	end)


end

--  RegistEscEventInfo("Collection_BackImage","WndMyCollectionClose")
