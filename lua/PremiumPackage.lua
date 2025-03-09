----------------------------------------------------------------------
-- ���� �����ڽ�
----------------------------------------------------------------------
--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")



------------------------------------------------------------------------------
-- ��Ű�� ������ ���Խ� ������ �˾�â
------------------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PackageItemListBack")
mywindow:setTexture("Enabled", "UIData/frame/frame_006.tga", 0, 0)
mywindow:setframeWindow(true)
mywindow:setPosition(210, 130)
mywindow:setSize(604, 469)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("PackageItemListBack", "HidePackageItemList")		-- escŰ

-- ��Ű�� ������ ���Խ� ������ �˾�â Ÿ��Ʋ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PackageItemListBackTitleImage")
mywindow:setTexture("Enabled", "UIData/deal3.tga", 390, 491)
mywindow:setTexture("Disabled", "UIData/deal3.tga", 390, 491)
mywindow:setPosition(244, 8)
mywindow:setSize(112, 21)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("PackageItemListBack"):addChildWindow(mywindow)


local Max_PackageList = 8
local X_PackageList = 2
local Y_PackageList = 4

for i=0, Max_PackageList-1 do
	-- ����
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PackageItemBack_"..i)
	mywindow:setTexture("Enabled", "UIData/deal3.tga", 0, 421)
	mywindow:setPosition(14 + (i % X_PackageList) * 291, 43 + (i / X_PackageList) * 95)
	mywindow:setSize(287, 91)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("PackageItemListBack"):addChildWindow(mywindow)
	
	-- ������ �̸�
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "PackageItemName_"..i)
	mywindow:setPosition(0, 6)
	mywindow:setSize(287, 18)
	mywindow:setViewTextMode(1)
	mywindow:setLineSpacing(2)
	mywindow:setAlign(8)
	mywindow:setZOrderingEnabled(false)
	mywindow:setTextExtends("sadsad", g_STRING_FONT_GULIM, 12, 255,198,30,255,   0, 255,255,255,255)
	winMgr:getWindow("PackageItemBack_"..i):addChildWindow(mywindow)
	
	-- ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PackageItemImg_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(10, 33)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(110)
	mywindow:setScaleHeight(110)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setLayered(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("PackageItemBack_"..i):addChildWindow(mywindow)
	
	-- ��ų ���� �׵θ� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PackageItemImg_SkillLevelImage_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(14, 34)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("PackageItemBack_"..i):addChildWindow(mywindow)
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "PackageItemImg_SkillLevelText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(35, 34)
	mywindow:setSize(40, 20)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("PackageItemBack_"..i):addChildWindow(mywindow)
	
	-- ���� �̺�Ʈ�� ���� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PackageItemImg_EventImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(7, 30)
	mywindow:setSize(49, 49)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", i)
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_PackageItem")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_PackageItem")
	winMgr:getWindow("PackageItemBack_"..i):addChildWindow(mywindow)	
	
	-- ������ ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "PackageItemImg_DescText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(63, 20)
	mywindow:setSize(226, 40)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("PackageItemBack_"..i):addChildWindow(mywindow)
	
	-- ������ �Ⱓ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "PackageItemImg_PeriodText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(63, 62)
	mywindow:setSize(226, 40)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("PackageItemBack_"..i):addChildWindow(mywindow)
	
end



mywindow = winMgr:createWindow("TaharezLook/Button", "PackageItem_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(576, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HidePackageItemList")
winMgr:getWindow("PackageItemListBack"):addChildWindow(mywindow)



-- ���� ������ / �ִ� ������
mywindow = winMgr:createWindow("TaharezLook/StaticText", "PackageItem_PageText")
mywindow:setFont(g_STRING_FONT_GULIMCHE, 14)
mywindow:setTextColor(255,255,255,255)
mywindow:setPosition(188 + 74, 390 + 48)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setZOrderingEnabled(false)
mywindow:setTextExtends("1 / 1", g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
winMgr:getWindow("PackageItemListBack"):addChildWindow(mywindow)


-- ������ �¿� ��ư
local tPackageItem_BtnName  = {["err"]=0, [0]="PackageItem_LBtn", "PackageItem_RBtn"}
local tPackageItem_BtnTexX  = {["err"]=0, [0]=0, 22}
local tPackageItem_BtnPosX  = {["err"]=0, [0]=178, 258}
local tPackageItem_BtnEvent = {["err"]=0, [0]="OnClickPackageItem_PrevPage", "OnClickPackageItem_NextPage"}
for i=0, #tPackageItem_BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", tPackageItem_BtnName[i])
	mywindow:setTexture("Normal", "UIData/C_Button.tga", tPackageItem_BtnTexX[i], 0)
	mywindow:setTexture("Hover", "UIData/C_Button.tga", tPackageItem_BtnTexX[i], 27)
	mywindow:setTexture("Pushed", "UIData/C_Button.tga", tPackageItem_BtnTexX[i], 54)
	mywindow:setTexture("PushedOff", "UIData/C_Button.tga", tPackageItem_BtnTexX[i], 0)
	mywindow:setTexture("Disabled", "UIData/C_Button.tga", tPackageItem_BtnTexX[i], 81)
	mywindow:setPosition(tPackageItem_BtnPosX[i] + 72, 387 + 44)
	mywindow:setSize(22, 27)
	mywindow:setSubscribeEvent("Clicked", tPackageItem_BtnEvent[i])
	winMgr:getWindow("PackageItemListBack"):addChildWindow(mywindow)
end

-- ������ �¹�ư Ŭ���̺�Ʈ
function OnClickPackageItem_PrevPage()
	PackageItemPageEvent(0)
end

-- ������ ���ư Ŭ���̺�Ʈ
function OnClickPackageItem_NextPage()
	PackageItemPageEvent(1)
end



-- �����ۿ� ���콺 ������ ��,
function OnMouseEnter_PackageItem(arge)

end


-- �����ۿ��� ���콺 ������ ��
function OnMouseLeave_PackageItem(arge)

end


function packageItemPageSetting(current, total)
	winMgr:getWindow("PackageItem_PageText"):setTextExtends(tostring(current).." / "..tostring(total), g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)

end

-- ��Ű�� ������ ����Ʈ�� �����ش�.
function ClearPackageItemList()
	for i=0, Max_PackageList-1 do
		winMgr:getWindow("PackageItemBack_"..i):setVisible(false)
		winMgr:getWindow("PackageItemImg_"..i):setLayered(false)
	end
end


-- ��Ű�� �����۸���Ʈ�� �������ش�.
function SetPackageItemList(index, itemName, fileName, fileName2, itemCount, period, itemDesc, itemGrade)
	-- �� �����찡 ���� �Ѵٸ�
	if winMgr:getWindow("PackageItemBack_"..index) then
		winMgr:getWindow("PackageItemBack_"..index):setVisible(true)
		
		-- ������ �̸�
		winMgr:getWindow("PackageItemName_"..index):setTextExtends(itemName, g_STRING_FONT_GULIM, 12, 255,198,30,255,   0, 255,255,255,255)
		-- ������ ����
--		winMgr:getWindow("PackageItemImg_Count_"..index):setTextExtends("x "..itemCount, g_STRING_FONT_GULIM, 10, 255,255,255,255,   0, 255,255,255,255)
		-- ������ �̹���
		winMgr:getWindow("PackageItemImg_"..index):setTexture("Disabled", fileName, 0, 0)
		if fileName2 ~= "" then
			winMgr:getWindow("PackageItemImg_"..index):setLayered(true)
			winMgr:getWindow("PackageItemImg_"..index):setTexture("Layered", fileName2, 0, 0)
		else
			winMgr:getWindow("PackageItemImg_"..index):setLayered(false)
		end

		itemDesc = AdjustString(g_STRING_FONT_GULIMCHE, 11, itemDesc, 200)	-- ������ ����
		itemDesc = SummaryString(g_STRING_FONT_GULIMCHE, 11, itemDesc, 600)
		
		
		winMgr:getWindow("PackageItemImg_DescText_"..index):setText(itemDesc)--Extends(itemDesc, g_STRING_FONT_GULIM, 11, 255,255,255,255,   0, 255,255,255,255)
		-- ������ ���� �Ⱓ
		if IsKoreanLanguage() then
			winMgr:getWindow("PackageItemImg_PeriodText_"..index):setText(itemCount.."��")--.."EA / "..period)
		else
			winMgr:getWindow("PackageItemImg_PeriodText_"..index):setText(itemCount.."EA / "..period)
		end
		
	end	
end


-- �˾�â�� �����ش�.
function ShowPackageItemList()
	root:addChildWindow(winMgr:getWindow("PackageItemListBack"))
	winMgr:getWindow("PackageItemListBack"):setVisible(true)

end

function HidePackageItemList()
	winMgr:getWindow("PackageItemListBack"):setVisible(false)
end