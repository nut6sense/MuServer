--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)


--------------------------------------------------------------------
-- ���ڿ��� ���� ���� �޾ƿ´�
--------------------------------------------------------------------


--------------------------------------------------------------------
-- �������� �����? ������
--------------------------------------------------------------------
-- �������� �ѷ����� �������������? ��Ȳ ǥ���� �ε���
local UserInfo_Hear	= 0	-- ���?
local UserInfo_Upper= 1	-- ����
local UserInfo_Lower= 2	-- ����
local UserInfo_Hat	= 3	-- ����(�Ӹ���)
local UserInfo_Ring	= 4	-- ����

local UserInfo_Face	= 5	-- ��
local UserInfo_Hand	= 6	-- ��
local UserInfo_Foot	= 7	-- �Ź�
local UserInfo_Back	= 8	-- ����
local UserInfo_Set	= 9	-- ��Ʈ


local tItemWearTable = {['err'] = 0, [0]=UserInfo_Upper, UserInfo_Lower, UserInfo_Hand, UserInfo_Foot, UserInfo_Face,
											UserInfo_Hear, UserInfo_Back, UserInfo_Hat, UserInfo_Ring}


local bShowEvent = true
--------------------------------------------------------------------
-- ���� ���� ���� ���� ������
--------------------------------------------------------------------
-- ���� ����â
UserInfoMain = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_Main")
UserInfoMain:setTexture("Enabled", "UIData/myinfo3.tga", 0, 0)
UserInfoMain:setPosition((g_MAIN_WIN_SIZEX - 505) / 2, (g_MAIN_WIN_SIZEY - 488) / 2)
UserInfoMain:setSize(505, 488)
UserInfoMain:setVisible(false)
UserInfoMain:setAlwaysOnTop(true)
UserInfoMain:setZOrderingEnabled(true)
root:addChildWindow(UserInfoMain)

RegistEscEventInfo("UserInfo_Main", "CloseUserInfoWindow")




-- ���� �̹���. 
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_TitleImage")
mywindow:setTexture("Disabled", "UIData/myinfo.tga", 810, 0)
mywindow:setPosition((501 - 86) / 2, 5)
mywindow:setSize(86, 29)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
UserInfoMain:addChildWindow(mywindow)

-- Ÿ��Ʋ��(���콺 ���� �����̰� �ϱ�)
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "UserInfo_TitleBar")
mywindow:setPosition(3, 1)
mywindow:setSize(470, 36)
UserInfoMain:addChildWindow(mywindow)


--------------------------------------------------------------------
-- ������ �ݱ� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "UserInfo_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(472, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "CloseUserInfoWindow")
UserInfoMain:addChildWindow(mywindow)


if IsKoreanLanguage() then
	MyUserSelectName	= {['protecterr']=0, [0]="UserInfo_Character", "UserInfo_Skill", "UserInfo_Rank" , "UserInfo_Pet"}
	MyUserSelectTexX	= {['protecterr']=0, [0]=	534,	828,	632,	926}
	MyUserSelectPosX	= {['protecterr']=0, [0]=	7,		7+98,	7+98*2,	7+98*3 }
	MyUserSelectEvent	= {['protecterr']=0, [0]="ShowUserInfoCharacter", "ShowUserInfoSkill", "ShowUserInfoRank", "ShowUserInfoPet"}
else
	MyUserSelectName	= {['protecterr']=0, [0]="UserInfo_Character", "UserInfo_Skill", "UserInfo_Rank", "UserInfo_TitleName", "UserInfo_Pet" }
	MyUserSelectTexX	= {['protecterr']=0, [0]=	534,	828,	632,	730,  926 }
	MyUserSelectPosX	= {['protecterr']=0, [0]=	7,		7+98,	7+98*2,	7+98*3, 7+98*4}
	MyUserSelectEvent	= {['protecterr']=0, [0]="ShowUserInfoCharacter", "ShowUserInfoSkill", "ShowUserInfoRank", "ShowUserInfoTitleName", "ShowUserInfoPet" }
end

-- Character����, ������/��ŷ, Īȣ ���� ������ư


for i=0, #MyUserSelectName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", MyUserSelectName[i])
	mywindow:setTexture("Normal", "UIData/myinfo3.tga", MyUserSelectTexX[i], 931)
	mywindow:setTexture("Hover", "UIData/myinfo3.tga", MyUserSelectTexX[i], 962 )
	mywindow:setTexture("Pushed", "UIData/myinfo3.tga", MyUserSelectTexX[i], 993 )
	mywindow:setTexture("Disabled", "UIData/myinfo3.tga", MyUserSelectTexX[i], 931 )
	mywindow:setTexture("SelectedNormal", "UIData/myinfo3.tga", MyUserSelectTexX[i], 993 )
	mywindow:setTexture("SelectedHover", "UIData/myinfo3.tga", MyUserSelectTexX[i], 993 )
	mywindow:setTexture("SelectedPushed", "UIData/myinfo3.tga", MyUserSelectTexX[i], 993 )
	mywindow:setPosition(MyUserSelectPosX[i], 37)
	mywindow:setProperty("GroupID", 15)
	mywindow:setSize(97, 31)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", MyUserSelectEvent[i])
	UserInfoMain:addChildWindow(mywindow)
end

if CheckfacilityData(FACILITYCODE_PETSYSTEM) == 1 then
	winMgr:getWindow("UserInfo_Pet"):setVisible(true)
else
	winMgr:getWindow("UserInfo_Pet"):setVisible(false)
end

function VisibleUserInfo_Pet(bShow)
	if bShow == 1 then
		winMgr:getWindow("UserInfo_Pet"):setVisible(true)
	else
		winMgr:getWindow("UserInfo_Pet"):setVisible(false)
	end
end

-----------------------------------------------------------------------------------------
-- Character���� ������ ���� ============================================================
-----------------------------------------------------------------------------------------




local CharacterInfoMain = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_characterMain")
CharacterInfoMain:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
CharacterInfoMain:setPosition(8, 72)
CharacterInfoMain:setSize(489, 374)
CharacterInfoMain:setVisible(false)
CharacterInfoMain:setAlwaysOnTop(true)
CharacterInfoMain:setZOrderingEnabled(false)
UserInfoMain:addChildWindow(CharacterInfoMain)



-- ĳ���� �������? ����(�Ϲ�/�����?) ==============
local WearedItemMain = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_WearedItemBack")
WearedItemMain:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
WearedItemMain:setPosition(7, 13)
WearedItemMain:setSize(230, 150)
WearedItemMain:setVisible(true)
WearedItemMain:setAlwaysOnTop(true)
WearedItemMain:setZOrderingEnabled(false)
CharacterInfoMain:addChildWindow(WearedItemMain)

-- �������� ������ �̹��� ������
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_WearedItemWin")
mywindow:setTexture("Enabled", "UIData/myinfo.tga", 0, 364)
mywindow:setPosition(0, 19)
mywindow:setSize(230, 113)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
WearedItemMain:addChildWindow(mywindow)


-- �Ϲ� ���� ���?, �������� ���� ��ư
SelectName	= {['protecterr']=0, [0]="WearedItem_Normal", "WearedItem_Special"}
SelectTexX	= {['protecterr']=0, [0]=		505,	567}
SelectPosX	= {['protecterr']=0, [0]=		1,		65}


for i=0, #SelectName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", SelectName[i])
	mywindow:setTexture("Normal", "UIData/myinfo3.tga", SelectTexX[i], 186)
	mywindow:setTexture("Hover", "UIData/myinfo3.tga", SelectTexX[i], 207 )
	mywindow:setTexture("Pushed", "UIData/myinfo3.tga", SelectTexX[i], 228 )
	mywindow:setTexture("SelectedNormal", "UIData/myinfo3.tga", SelectTexX[i], 228 )
	mywindow:setTexture("SelectedHover", "UIData/myinfo3.tga", SelectTexX[i], 228 )
	mywindow:setTexture("SelectedPushed", "UIData/myinfo3.tga", SelectTexX[i], 228 )
	mywindow:setPosition(SelectPosX[i], 0)
	mywindow:setProperty("GroupID", 16)
	mywindow:setSize(62, 21)
	mywindow:setAlwaysOnTop(true)
--	if i == 1 then
--		mywindow:setVisible(false)
--	end
	mywindow:setZOrderingEnabled(true)
	mywindow:setUserString("Index", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "SelectWearedItemType")
	WearedItemMain:addChildWindow(mywindow)
end



-- �������� ���̴� �������� �������ִ´�.
local tWearAttachName	  = {['err']=0, [0]= "UserWear_Hear", "UserWear_Upper", "UserWear_Lower"
											, "UserWear_Hat", "UserWear_Ring", "UserWear_Face"
											, "UserWear_Hand", "UserWear_Foot", "UserWear_Back", "UserWear_Set"} 
local tWearAttachItemName = {['err']=0, [0]= "UserInfoHear_Item", "UserInfoUpper_Item", "UserInfoLower_Item"
											, "UserInfoHat_Item", "UserInfoRing_Item", "UserInfoFace_Item"
											, "UserInfoHand_Item", "UserInfoFoot_Item", "UserInfoBack_Item", "UserInfoSet_Item"}
											
-- �ڽ�Ƭ �ƹ�Ÿ ���� �� �̹���
local tBackWearAttachItemName = {['err']=0, [0]= "UserInfoHear_Back_Item", "UserInfoUpper_Back_Item", "UserInfoLower_Back_Item"
											, "UserInfoHat_Back_Item", "UserInfoRing_Back_Item", "UserInfoFace_Back_Item"
											, "UserInfoHand_Back_Item", "UserInfoFoot_Back_Item", "UserInfoBack_Back_Item", "UserInfoSet_Back_Item"}
											
local tWearAttachButtonName = {['err']=0, [0]= "UserInfoHear_Button", "UserInfoUpper_Button", "UserInfoLower_Button"
											, "UserInfoHat_Button", "UserInfoRing_Button", "UserInfoFace_Button"
											, "UserInfoHand_Button", "UserInfoFoot_Button", "UserInfoBack_Button", "UserInfoSet_Button"}
local tWearAttachPosX = {['err']=0, [0]= 0,41,82,136,177, 0,41,82,136,177}
local tWearAttachPosY = {['err']=0, [0]= 0,0,0,0,0, 41,41,41,41,41}

for i=0, #tWearAttachName do
	-- �̹��� ���� ����� ������ �̹���.
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWearAttachName[i])
	mywindow:setTexture("Enabled", "UIData/my_room.tga", 556,573)
	mywindow:setPosition(tWearAttachPosX[i] + 6, tWearAttachPosY[i] + 24)
	mywindow:setSize(41, 41)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	WearedItemMain:addChildWindow(mywindow)

	-- �������� �ѷ��� �����̹���(���? ��Ҹ�? �ϴ°Ŷ� �� ũ�� �̹����� ��ƾ��Ѵ�?.)
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWearAttachItemName[i])
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
	mywindow:setPosition(3,3)
	mywindow:setSize(110, 110)
	mywindow:setScaleHeight(90)	-- ����س��´�?.
	mywindow:setScaleWidth(90)		-- ����س��´�?.
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setLayered(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUseEventController(false)	-- �̺�Ʈ�� ���� �ʴ´�.
	winMgr:getWindow(tWearAttachName[i]):addChildWindow(mywindow)
	
	-- ��ų ���?
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWearAttachName[i].."_gradeImg")
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(tWearAttachPosX[i] + 16, tWearAttachPosY[i] + 26)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	WearedItemMain:addChildWindow(mywindow)
	
	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tWearAttachName[i].."_gradeText")
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(tWearAttachPosX[i] + 21, tWearAttachPosY[i] + 27)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	WearedItemMain:addChildWindow(mywindow)
	
	
	-- ���콺 ���� ȿ������ ��ư
	mywindow = winMgr:createWindow("TaharezLook/Button", tWearAttachButtonName[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/my_room.tga", 597, 573)
	mywindow:setTexture("Pushed", "UIData/my_room.tga", 638, 573)
	mywindow:setTexture("PushedOff", "UIData/my_room.tga", 638, 573)
	mywindow:setTexture("Disabled", "UIData/my_room.tga", 556, 573)
	mywindow:setPosition(tWearAttachPosX[i] + 6, tWearAttachPosY[i] + 24)
	mywindow:setSize(41,41)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", tostring(-1))
--	mywindow:subscribeEvent("Clicked", "Userinfo_Item_MouseClick")
	mywindow:subscribeEvent("MouseEnter", "Userinfo_Item_MouseEnter")
	mywindow:subscribeEvent("MouseLeave", "Userinfo_Item_MouseLeave")
	mywindow:subscribeEvent("MouseRButtonUp", "Userinfo_Item_MouseRButtonUp")
	WearedItemMain:addChildWindow(mywindow)	
end


-- �������� ������(�Ϲ� / �����?) ��ư ���� �̺�Ʈ
function SelectWearedItemType(args)

	local EventWindow	= CEGUI.toWindowEventArgs(args).window 
	if CEGUI.toRadioButton(EventWindow):isSelected() then
		local Index = EventWindow:getUserString("Index")
			
		SelectedItemTypeItem(Index)		-- ���� �������ְ�
		ShowUserInfoWearItemSetting()
	end

end


-- ���콺�� ���Դ�
function Userinfo_Item_MouseEnter(args)
	local enterWindow	= CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(enterWindow)
	local ItemIndex = enterWindow:getUserString("Index")
	
	local itemNumber = GetUserinfoTooltipInfo(ItemIndex, -1)
	if itemNumber < 0 then
		return
	end
	
	-- �ڽ�Ƭ �ƹ�Ÿ ���� ���� ������ ����
	-- ���� 0�̿��� �����ε������� -4�� �����ؼ� �־���
	-- �����ϸ� �ȵǿ�~ �̤�
	GetToolTipBaseInfo(x + 43, y, 2, KIND_COSTUM, -4, itemNumber)
	SetShowToolTip(true)
end

-- ���콺�� ������.
function Userinfo_Item_MouseLeave(args)
	SetShowToolTip(false)
end


function Userinfo_Item_MouseClick(args)
	local enterWindow	= CEGUI.toWindowEventArgs(args).window

	local ItemIndex = enterWindow:getUserString("Index")
	UserinfoUnWearItem(ItemIndex)
end


function Userinfo_Item_MouseRButtonUp(args)
	local enterWindow	= CEGUI.toWindowEventArgs(args).window

	local ItemIndex = enterWindow:getUserString("Index")
	UserinfoUnWearItem(ItemIndex)

end


-- ���콺 ���� ȿ������ ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "ShowSettingButton")
mywindow:setTexture("Normal", "UIData/myinfo.tga", 279, 622)
mywindow:setTexture("Hover", "UIData/myinfo.tga", 279, 640)
mywindow:setTexture("Pushed", "UIData/myinfo.tga", 279, 658)
mywindow:setTexture("PushedOff", "UIData/myinfo.tga", 279, 658)
mywindow:setTexture("Disabled", "UIData/myinfo.tga", 279, 676)
mywindow:setPosition(113, 108)
mywindow:setSize(108, 18)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "Userinfo_ShowSettingButtonClick")
WearedItemMain:addChildWindow(mywindow)	


function Userinfo_ShowSettingButtonClick()
	ShowShowPartInfowindow()
end



--[[

-- normal / special üũ�ڽ�
local tWearedItemTypeName	= {['protecterr'] = 0, [0]=	"UserInfo_WearedItemNormal", "UserInfo_WearedItemSpecial" }
local tWearedItemTypePosX	= {['protecterr'] = 0, [0]=		78,	152 }
local tWearedItemTypeEvent	= {['protecterr'] = 0, [0]=	"WearedItemNormalCheckEvent", "WearedItemSpecialCheckEvent" }

for i=0, #tWearedItemTypeName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", tWearedItemTypeName[i])
	mywindow:setTexture("Normal", "UIData/popup001.tga", 441, 754)
	mywindow:setTexture("Hover", "UIData/popup001.tga", 441, 754)
	mywindow:setTexture("Pushed", "UIData/popup001.tga", 441, 773)
	mywindow:setTexture("PushedOff", "UIData/popup001.tga", 441, 754)
	mywindow:setTexture("SelectedNormal", "UIData/popup001.tga", 441, 773)
	mywindow:setTexture("SelectedHover", "UIData/popup001.tga", 441, 773)
	mywindow:setTexture("SelectedPushed", "UIData/popup001.tga", 441, 773)
	mywindow:setTexture("SelectedPushedOff", "UIData/popup001.tga", 441, 773)
	mywindow:setPosition(tWearedItemTypePosX[i], 109)
	mywindow:setSize(60, 17)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("GroupID", 17)
	mywindow:subscribeEvent("SelectStateChanged", tWearedItemTypeEvent[i])
	WearedItemMain:addChildWindow(mywindow)
end


-- �Ϲ� üũ�ڽ� Ŭ����.
function WearedItemNormalCheckEvent(args)
	if CEGUI.toRadioButton(winMgr:getWindow("UserInfo_WearedItemNormal")):isSelected() then
		SetUserWearedCostumeFlag(0)	
	end
end



-- �����? üũ�ڽ� Ŭ����.
function WearedItemSpecialCheckEvent(args)
	if CEGUI.toRadioButton(winMgr:getWindow("UserInfo_WearedItemSpecial")):isSelected() then
		SetUserWearedCostumeFlag(1)	
	end
end


-- 
function UserInfo_ShowSelectEvent(flag)
	if CEGUI.toRadioButton(winMgr:getWindow(tWearedItemTypeName[flag])):isSelected() == false then
		winMgr:getWindow(tWearedItemTypeName[flag]):setProperty("Selected", "true")	
	end
end
--]]
--=============================================



-- ĳ���� ���� ==============================
local CharacterBaseInfo = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_CharacterInfoBack")
CharacterBaseInfo:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
CharacterBaseInfo:setPosition(7, 161)
CharacterBaseInfo:setSize(230, 211)
CharacterBaseInfo:setVisible(true)
CharacterBaseInfo:setAlwaysOnTop(true)
CharacterBaseInfo:setZOrderingEnabled(false)
CharacterInfoMain:addChildWindow(CharacterBaseInfo)

-- 
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_CharacterBaseInfo")
mywindow:setTexture("Enabled", "UIData/myinfo.tga", 724, 193)
mywindow:setPosition(0, 0)
mywindow:setSize(230, 211)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
CharacterBaseInfo:addChildWindow(mywindow)


-- �ɸ� Ÿ��(�̹���), �ɸ���(�ؽ�Ʈ), Īȣ(�̹���, �ؽ�Ʈ), Ŭ����(�̹���), Ŭ����(�ؽ�Ʈ), ����(�ؽ�Ʈ), ����(�̹���)


-- �ؽ�Ʈ �κ�
local tUserBaseInfoTextName  = {['err']=0, [0]="UserInfoNameText", "UserInfoTitleText", "UserInfoClubNameText", "UserInfoLevelText", "UserInfoLadderText"}
local tUserBaseInfoTextPosX  = {['err']=0, [0]=		90,					90,						60,						60,					95}
local tUserBaseInfoTextPosY	 = {['err']=0, [0]=		23,					55,						109,					137,				163}
local tUserBaseInfoTextSizeX = {['err']=0, [0]=		135,				135,					170,					20,					50}

for i=0, #tUserBaseInfoTextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tUserBaseInfoTextName[i])
	--mywindow:setTexture("Enabled", "UIData/nm1.tga", 0,0)
	mywindow:setPosition(tUserBaseInfoTextPosX[i], tUserBaseInfoTextPosY[i])
	mywindow:setSize(tUserBaseInfoTextSizeX[i], 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setFont(g_STRING_FONT_GULIM, 12)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("UserInfo_CharacterBaseInfo"):addChildWindow(mywindow)
end


-- �̹��� �κ�
local tUserBaseInfoImageName  = {['err']=0, [0]="UserInfoTypeImage", "UserInfoTitleImage", "UserInfoClassImage", "UserInfoLadderImage"}
local tUserBaseInfoImagePosX  = {['err']=0, [0]=		5,					90,						90,					56}
local tUserBaseInfoImagePosY  = {['err']=0, [0]=		12,					53,						82,					163}
local tUserBaseInfoImageSizeX = {['err']=0, [0]=		72,					112,					89,					47}
local tUserBaseInfoImageSizeY = {['err']=0, [0]=		82,					18,						35,					21}
--local tUserBaseInfoImageTexName = {['err']=0, [0]="myinfo3.tga", "numberUi001.tga", "skillitem001.tga", "numberUi001.tga"}

for i=0, #tUserBaseInfoImageName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", tUserBaseInfoImageName[i])
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	if i == 2 then
		mywindow:setTexture("Layered", "UIData/invisible.tga", 0, 0)
		mywindow:setLayered(true)
	end
	mywindow:setPosition(tUserBaseInfoImagePosX[i], tUserBaseInfoImagePosY[i])
	mywindow:setSize(tUserBaseInfoImageSizeX[i], tUserBaseInfoImageSizeY[i])
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("UserInfo_CharacterBaseInfo"):addChildWindow(mywindow)
end



--[[
--- Īȣ �ִϸ��̼� ȿ��
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserInfoTitleWnd3")
mywindow:setTexture("Enabled", "UIData/nm0.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/nm0.tga", 0, 0)
mywindow:setPosition(90, 53)
mywindow:setSize(112, 18)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("UserInfo_CharacterBaseInfo"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserInfoTitleWnd1")
mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 0, 643)-- + 21*(titleIndex-22))
mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 0, 643)-- + 21*(titleIndex-22))
mywindow:setPosition(90, 53)
mywindow:setSize(112, 18)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addController("titleMotion", "titleMotionEvent", "alpha", "Sine_EaseInOut", 255, 0, 16, true, true, 10)
mywindow:addController("titleMotion", "titleMotionEvent", "alpha", "Sine_EaseInOut", 0, 255, 16, true, true, 10)
winMgr:getWindow("UserInfo_CharacterBaseInfo"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserInfoTitleWnd2")
mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 0, 726)-- + 21*(titleIndex-22))
mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 0, 726)-- + 21*(titleIndex-22))
mywindow:setPosition(90, 53)
mywindow:setSize(112, 18)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addController("titleMotion", "titleMotionEvent", "alpha", "Sine_EaseInOut", 0, 255, 16, true, true, 10)
mywindow:addController("titleMotion", "titleMotionEvent", "alpha", "Sine_EaseInOut", 255, 0, 16, true, true, 10)			
winMgr:getWindow("UserInfo_CharacterBaseInfo"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserInfoTitleWnd0")
mywindow:setTexture("Enabled", "UIData/numberUi001.tga", 0, 201)--+21*(titleIndex-1))
mywindow:setTexture("Disabled", "UIData/numberUi001.tga", 0, 201)--+21*(titleIndex-1))
mywindow:setPosition(90, 53)
mywindow:setSize(112, 18)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("UserInfo_CharacterBaseInfo"):addChildWindow(mywindow)

--]]







-- ����ġ ��������
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_ExpGaugeBack")
mywindow:setTexture("Disabled", "UIData/myinfo.tga", 230, 450)
mywindow:setPosition(95, 137)
mywindow:setSize(122, 14)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("UserInfo_CharacterBaseInfo"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_ExpGauge")
mywindow:setTexture("Disabled", "UIData/myinfo.tga", 230, 464)
mywindow:setPosition(0,0)
mywindow:setSize(1, 14)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("UserInfo_ExpGaugeBack"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserInfo_ExpGaugeText")
mywindow:setPosition(1, 2)
mywindow:setSize(120, 14)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("UserInfo_ExpGaugeBack"):addChildWindow(mywindow)


-- ������ ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "MyUserInfo_porfileBtn")
mywindow:setTexture("Normal", "UIData/myinfo.tga", 737, 404)
mywindow:setTexture("Hover", "UIData/myinfo.tga", 737, 404 + 21)
mywindow:setTexture("Pushed", "UIData/myinfo.tga", 737, 404 + 21*2)
mywindow:setTexture("PushedOff", "UIData/myinfo.tga", 737, 404 + 21*2)
mywindow:setTexture("Disabled", "UIData/myinfo.tga", 737, 404 + 21*3)
mywindow:setPosition(55, 184)
mywindow:setSize(116, 21)

if CheckfacilityData(FACILITYCODE_PROFILE) == 0 then
	mywindow:setVisible(false)
end
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "MyUserInfo_porfileBtnEvent")
winMgr:getWindow("UserInfo_CharacterBaseInfo"):addChildWindow(mywindow)	


function MyUserInfo_porfileBtnEvent(args)
	ShowProfileRequest(GetCurrentShowInfoName())
end

-- ������ Ŭ�� �̸��� �˾ƿͼ� �����Ѵ�.
function GetUserInfoClubName(Name)
	winMgr:getWindow("UserInfoClubNameText"):setText(Name)
end

-- ������ �⺻������ �������ش�.
function SettingBaseUserInfo(characterName, clubTitleName, boneType, titleIndex, promotionIndex
							, styleIndex, attributeIndex, level, exp, maxExp, GaugePersent, laddergrade, ladderExp)
	
	-- ĳ���� �̸�
	winMgr:getWindow("UserInfoNameText"):setText(characterName)

	
	-- Īȣ
	if titleIndex == 26 then	-- Ŭ�� Īȣ�̸�
		winMgr:getWindow("UserInfoTitleImage"):setVisible(false)
		winMgr:getWindow("UserInfoTitleText"):setText(clubTitleName)
	elseif titleIndex > 0 and #tTitleFilName >= titleIndex then
		winMgr:getWindow("UserInfoTitleText"):setText("")
		winMgr:getWindow("UserInfoTitleImage"):setVisible(true)
		winMgr:getWindow("UserInfoTitleImage"):setTexture("Disabled", "UIData/"..tTitleFilName[titleIndex], tTitleTexX[titleIndex], tTitleTexY[titleIndex])
	elseif titleIndex >= 10001 then
		winMgr:getWindow("UserInfoTitleImage"):setSize(110, 16)
		winMgr:getWindow("UserInfoTitleImage"):setPosition(95, 55)
		winMgr:getWindow("UserInfoTitleImage"):setTexture("Disabled", "UIData/"..tAniTitleFilName[titleIndex - 10001], tAniTitleTexX[titleIndex - 10001], 1)
	else
		winMgr:getWindow("UserInfoTitleImage"):setVisible(false)
		winMgr:getWindow("UserInfoTitleText"):setText("-")
	end
	-- ����
	winMgr:getWindow("UserInfoLevelText"):setText("Lv."..level)
	-- ����
	-- Ranking represent here
	winMgr:getWindow("UserInfoLadderImage"):setTexture("Disabled", "UIData/numberUi001.tga", 113, 600 + 21 * laddergrade)
	winMgr:getWindow("UserInfoLadderImage"):setScaleWidth(200)
	winMgr:getWindow("UserInfoLadderImage"):setScaleHeight(200)
	winMgr:getWindow("UserInfoLadderText"):setText("( "..ladderExp.." )")

	-- ���� ������
	--DebugStr("styleIndex : " .. styleIndex)
	--DebugStr("attributeIndex : " .. attributeIndex)
	--DebugStr("promotionIndex : " .. promotionIndex)
	
	winMgr:getWindow("UserInfoClassImage"):setTexture("Disabled", "UIData/Skill_up2.tga", tAttributeImgTexXTable[styleIndex][attributeIndex], tAttributeImgTexYTable[styleIndex][attributeIndex])
	winMgr:getWindow("UserInfoClassImage"):setTexture("Layered", "UIData/Skill_up2.tga", promotionImgTexXTable[styleIndex], promotionImgTexYTable[promotionIndex])
	winMgr:getWindow("UserInfoClassImage"):setScaleWidth(255)
	winMgr:getWindow("UserInfoClassImage"):setScaleHeight(200)
	
	winMgr:getWindow("UserInfoTypeImage"):setTexture("Disabled", "UIData/myinfo3.tga", 505 + (boneType * 72), 104)
	
	winMgr:getWindow("UserInfo_ExpGauge"):setSize(122 * GaugePersent / 100, 14)
	
	local expText
	
	if IsEngLanguage() or IsKoreanLanguage() or IsGSPLanguage() then
		expText = tostring(exp).." / "..maxExp.." ("..GaugePersent.."%)"
	else
		expText = tostring(GaugePersent) .. "%"
	end

	winMgr:getWindow("UserInfo_ExpGaugeText"):setTextExtends(expText, g_STRING_FONT_GULIM,10, 255,198,0,255,  1,  0,0,0,255);

end


-- ������ �����? �������ش�.
function SettingRecordInfo(koRate, singleCount, teamCount, totalExp, ladderExp, koCount, mvpCount, team, double, perfect, maximum, breakCount)
	
	winMgr:getWindow("KORate"):setTextExtends(koRate, g_STRING_FONT_GULIM,25, 255,255,255,255, 1, 243,16,0,255)
	winMgr:getWindow("SinglePlayCount"):setTextExtends(singleCount, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 0,0,0,255)
	winMgr:getWindow("TeamPlayCount"):setTextExtends(teamCount, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 0,0,0,255)
	
	if IsKoreanLanguage() then

	else
		winMgr:getWindow("ExpRecord"):setTextExtends(totalExp, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 243,16,0,255)
		winMgr:getWindow("BrokenRecord"):setTextExtends(breakCount, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 153,0,157,255)
		winMgr:getWindow("MaximumRecord"):setTextExtends(maximum, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 0,157,59,255)
	end
	
	winMgr:getWindow("LadderRecord"):setTextExtends(ladderExp, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 243,93,0,255)
	winMgr:getWindow("KORecord"):setTextExtends(koCount, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 243,178,0,255)
	winMgr:getWindow("MVPRecord"):setTextExtends(mvpCount, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 84,191,52,255)
	winMgr:getWindow("TeamRecord"):setTextExtends(team, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 52,160,191,255)
	winMgr:getWindow("DoubleRecord"):setTextExtends(double, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 42,74,115,255)
	winMgr:getWindow("PerfectRecord"):setTextExtends(perfect, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 52,86,191,255)
end

-- ������ ��ŷ�� �������ش�.
function SettingRankInfo(totalExp, ladderExp, ko, mvp, teamAttack, doubleAttack, perfect, maximum, breakCount)

	if IsKoreanLanguage() then

	else
		winMgr:getWindow("ExpRank"):setTextExtends(totalExp, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 243,16,0,255)
		winMgr:getWindow("BrokenRank"):setTextExtends(breakCount, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 153,0,157,255)
		winMgr:getWindow("MaximumRank"):setTextExtends(maximum, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 0,157,59,255)
	end
	
	winMgr:getWindow("LadderRank"):setTextExtends(ladderExp, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 243,93,0,255)
	winMgr:getWindow("KORank"):setTextExtends(ko, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 243,178,0,255)
	winMgr:getWindow("MVPRank"):setTextExtends(mvp, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 84,191,52,255)
	winMgr:getWindow("TeamRank"):setTextExtends(teamAttack, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 52,160,191,255)
	winMgr:getWindow("DoubleRank"):setTextExtends(doubleAttack, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 42,74,115,255)
	winMgr:getWindow("PerfectRank"):setTextExtends(perfect, g_STRING_FONT_GULIM,13, 255,255,255,255, 1, 52,86,191,255)
	


end

--=============================================


-- ĳ���� ��������, Ư��ȿ�� ===========
local CharacterAdditionInfo = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_CharacterAdditionInfoBack")
CharacterAdditionInfo:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
CharacterAdditionInfo:setPosition(250, 3)
CharacterAdditionInfo:setSize(235, 371)
CharacterAdditionInfo:setVisible(false)
CharacterAdditionInfo:setAlwaysOnTop(true)
CharacterAdditionInfo:setZOrderingEnabled(false)
CharacterInfoMain:addChildWindow(CharacterAdditionInfo)


-- ĳ���� ��������, Ư��ȿ�� ����
local BackWindowName	= {['protecterr']=0, [0]="StatInfoBack", "SpecialEffectBack"}
SelectName	= {['protecterr']=0, [0]="StatInfoBtn", "SpecialEffect"}
SelectTexX	= {['protecterr']=0, [0]=		737,	811}
SelectPosX	= {['protecterr']=0, [0]=		1,		77}

for i=0, #SelectName do	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", BackWindowName[i])
	mywindow:setTexture("Enabled", "UIData/myinfo.tga", i * 230, 15)
	mywindow:setPosition(0, 20)
	mywindow:setSize(230, 349)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	CharacterAdditionInfo:addChildWindow(mywindow)
	
end

for i=0, #SelectName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", SelectName[i])
	mywindow:setTexture("Normal", "UIData/myinfo.tga", SelectTexX[i], 488)
	mywindow:setTexture("Hover", "UIData/myinfo.tga", SelectTexX[i], 488 + 22 )
	mywindow:setTexture("Pushed", "UIData/myinfo.tga", SelectTexX[i], 488 + 44 )
	mywindow:setTexture("Disabled", "UIData/myinfo.tga", SelectTexX[i], 488)
	mywindow:setTexture("SelectedNormal", "UIData/myinfo.tga", SelectTexX[i], 488 + 44 )
	mywindow:setTexture("SelectedHover", "UIData/myinfo.tga", SelectTexX[i], 488 + 44 )
	mywindow:setTexture("SelectedPushed", "UIData/myinfo.tga", SelectTexX[i], 488 + 44 )
	mywindow:setPosition(SelectPosX[i], 0)
	mywindow:setProperty("GroupID", 17)
	mywindow:setUserString("index", i)
	mywindow:setSize(74, 22)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("SelectStateChanged", "SelectAdditionInfo")
	CharacterAdditionInfo:addChildWindow(mywindow)
end
	
winMgr:getWindow("SpecialEffect"):setVisible(false)

local tUserStatInfoTextName  = {['err']=0, [0]="A_Atk", "A_Gra", "A_Team", "A_Double", "A_Special"
												, "D_Atk", "D_Gra", "D_Team", "D_Double", "D_Special"
												, "N_Hp", "N_Sp", "N_Cri", "N_CriDamage", "mannerP"
												, "matchmaking_zp", "matchmaking_level", "matchmaking_rank_name", "matchmaking_rank_max"}
local tUserStatInfoTextPosX  = {['err']=0, [0]=	135,135,135,135,135,135,135,135,135,135  ,120,120,120,120,120,174,174,174,174}
local tUserStatInfoTextPosY  = {['err']=0, [0]=	12+18*0, 12+18*1, 12+18*2, 12+18*3, 12+18*4, 
												21+18*5, 21+18*6, 21+18*7, 21+18*8, 21+18*9, 
												211, 211+18*1, 211+18*2, 211+18*3, 211+18*4, 
												187+18*5, 186+18*6, 186+18*7, 184+18*8}

local tBaseStatValue  = {['err']=0, [0]=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
local tTotalStatValue = {['err']=0, [0]=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
-- local tPlusStatValue  = {['err']=0, [0]=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
local tPlusStatValue = nil
local ImportStat = {['err']=-99, [0]=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}

-- Maxion
-- Using to prevent to calculated enable of (+/-)
local ClickStatCount = {['err']=-99, [0]=0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}

												--12*6,12*7,12*8,12*9,12*10 ,18*11,18*12,18*13,18*14,18*15,18*16}
--local tUserStatInfoTextPosY	 = {['err']=0, [0]=		23,					55,						96,						130}
--local tUserStatInfoTextSizeX = {['err']=0, [0]=		135,				135,						170,					20}

for i=0, #tUserStatInfoTextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tUserStatInfoTextName[i])
	mywindow:setPosition(tUserStatInfoTextPosX[i],tUserStatInfoTextPosY[i])
	mywindow:setSize(80, 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("StatInfoBack"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Total_"..tUserStatInfoTextName[i])
	mywindow:setPosition(tUserStatInfoTextPosX[i],tUserStatInfoTextPosY[i])
	mywindow:setSize(40, 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(6)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("StatInfoBack"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "Plus_"..tUserStatInfoTextName[i])
	mywindow:setPosition(tUserStatInfoTextPosX[i] + 40,tUserStatInfoTextPosY[i])
	mywindow:setSize(40, 18)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(0)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("StatInfoBack"):addChildWindow(mywindow)

		
	-- Add Status Button
	myWindow = winMgr:createWindow("TaharezLook/Button", "Add_Status"..i)
	myWindow:setTexture("Normal", "UIData/mainBG_Button001.tga", 608.5, 185.58)
	myWindow:setTexture("Hover", "UIData/mainBG_Button001.tga", 608.5, 192.58)
	myWindow:setTexture("Pushed", "UIData/mainBG_Button001.tga", 608.5, 198.58)
	myWindow:setTexture("PushedOff", "UIData/mainBG_Button001.tga", 608.5, 185.58)
	myWindow:setTexture("Disabled", "UIData/mainBG_Button001.tga", 608.5, 198.58)
	myWindow:setPosition(tUserStatInfoTextPosX[i] + 40,tUserStatInfoTextPosY[i])
	myWindow:setSize(7.75, 14.13)
	myWindow:setVisible(true)
	myWindow:setAlwaysOnTop(true)
	myWindow:setZOrderingEnabled(false)
	myWindow:subscribeEvent("Clicked", "AddStatusBtn")
	winMgr:getWindow("StatInfoBack"):addChildWindow(mywindow)

	-- Reduce Status Button
	myWindow = winMgr:createWindow("TaharezLook/Button", "Reduce_Status"..i)
	myWindow:setTexture("Normal", "UIData/mainBG_Button001.tga", 628.75, 185.33)
	myWindow:setTexture("Hover", "UIData/mainBG_Button001.tga", 628.75, 188.33)
	myWindow:setTexture("Pushed", "UIData/mainBG_Button001.tga", 628.75, 191.33)
	myWindow:setTexture("PushedOff", "UIData/mainBG_Button001.tga", 628.75, 185.33)
	myWindow:setTexture("Disabled", "UIData/mainBG_Button001.tga", 628.75, 191.33)
	myWindow:setPosition(tUserStatInfoTextPosX[i] + 55,tUserStatInfoTextPosY[i])
	myWindow:setSize(4, 14.13)
	myWindow:setVisible(true)
	myWindow:setAlwaysOnTop(true)
	myWindow:setZOrderingEnabled(false)
	myWindow:subscribeEvent("Clicked", "ReduceStatusBtn")
	winMgr:getWindow("StatInfoBack"):addChildWindow(mywindow)

end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "myInfo_rankImage")
mywindow = drawRankWindow(mywindow, 0, 18, 296, 220)
winMgr:getWindow("StatInfoBack"):addChildWindow(mywindow)

-- �ΰ����� ���� �̺�Ʈ
function SelectAdditionInfo(args)
	local EventWindow	= CEGUI.toWindowEventArgs(args).window 
	local index = tonumber(EventWindow:getUserString("index"))
	if CEGUI.toRadioButton(EventWindow):isSelected() then		
		if index == 1 then
			ShowMyUserInfoBuff()
		end
		winMgr:getWindow(BackWindowName[index]):setVisible(true)
	else
		winMgr:getWindow(BackWindowName[index]):setVisible(false)
	end
end
local CurrentStatPoint = winMgr:createWindow("TaharezLook/StaticText", "_CurrentStatPoint")
local DebugText = winMgr:createWindow("TaharezLook/StaticText", "_DebugText")

-- ĳ������ ��ü ���������� �������ִ�.
function SettingTotalStatInfo(A_Atk, A_Gra, A_Team, A_Double, A_Special, D_Atk, D_Gra, D_Team, D_Double, D_Special
							, N_Hp, N_Sp, N_Cri, N_CriDamage, mannerP, matchmaking_zp, matchmaking_level, matchmaking_rank_name, matchmaking_rank_max,stat_total)


	tBaseStatValue = {['err']=0, [0]=A_Atk, A_Gra, A_Team, A_Double, A_Special, D_Atk, D_Gra, D_Team, D_Double, D_Special
							, N_Hp, N_Sp, N_Cri, N_CriDamage, mannerP, matchmaking_zp, matchmaking_level, matchmaking_rank_name, matchmaking_rank_max,stat_total}

	ImportStat = {['err']=0, [0]=A_Atk, A_Gra, A_Team, A_Double, A_Special, D_Atk, D_Gra, D_Team, D_Double, D_Special
	, N_Hp, N_Sp, N_Cri, N_CriDamage, mannerP, matchmaking_zp, matchmaking_level, matchmaking_rank_name, matchmaking_rank_max,stat_total}						
end


-- ĳ������ ������ / Īȣ�� �ö󰡴� ������ ������ �������ش�.
function SettingItemStatInfo(A_Atk, A_Gra, A_Team, A_Double, A_Special, D_Atk, D_Gra, D_Team, D_Double, D_Special
							, N_Hp, N_Sp, N_Cri, N_CriDamage, mannerP)
	tPlusStatValue = {['err']=0, [0]=A_Atk, A_Gra, A_Team, A_Double, A_Special, D_Atk, D_Gra, D_Team, D_Double, D_Special
							, N_Hp, N_Sp, N_Cri, N_CriDamage, mannerP}
end


-- ĳ���� ���� ����
function SettingStatApplication()
	for i=0, #tPlusStatValue do
		local baseString = tostring(tBaseStatValue[i])

		-----------------------------------------------------------------------------------------------------------------
		-- Maxion
		-- Skill Point Text
		CurrentStatPoint:setText("Stat: " .. ImportStat[19])
	
		-----------------------------------------------------------------------------------------------------------------

		local plusString = tostring(tPlusStatValue[i])
		if i == 12 or i == 13 then
			baseString = tostring(tBaseStatValue[i]/10).."."..tostring(tBaseStatValue[i]%10).."%"--plusString.."%"
			plusString = tostring(tPlusStatValue[i]/10).."."..tostring(tPlusStatValue[i]%10).."%"--plusString.."%"
--		elseif i == 13 then
--			baseString = "+"..tostring(tBaseStatValue[i]).."%"--plusString.."%"
--			plusString = tostring(tPlusStatValue[i]).."%"--plusString.."%"
		end
		if tPlusStatValue ~= nil and tPlusStatValue[i] < 0 then		-- ������ ������ �￴����.
		
			-- winMgr:getWindow(tUserStatInfoTextName[i]):clearTextExtends()
			local statInfoWindow = winMgr:getWindow(tUserStatInfoTextName[i])
			if statInfoWindow ~= nil then
				statInfoWindow:clearTextExtends()
			end

			-- winMgr:getWindow("Total_"..tUserStatInfoTextName[i]):setTextExtends(baseString, g_STRING_FONT_GULIM,11, 230,50,50,255,  0,  0,0,0,255);
			statInfoWindow = winMgr:getWindow("Total_"..tUserStatInfoTextName[i])
			if statInfoWindow ~= nil then
				statInfoWindow:setTextExtends(baseString, g_STRING_FONT_GULIM,11, 230,50,50,255,  0,  0,0,0,255);
			end

			-- winMgr:getWindow("Plus_"..tUserStatInfoTextName[i]):setTextExtends("("..plusString..")", g_STRING_FONT_GULIM,11, 255,0,255,255,  0,  0,0,0,255);
			
			statInfoWindow = winMgr:getWindow("Plus_"..tUserStatInfoTextName[i])
			if statInfoWindow ~= nil then
				statInfoWindow:setTextExtends("("..plusString..")", g_STRING_FONT_GULIM,11, 255,0,255,255,  0,  0,0,0,255);
			end

		elseif tPlusStatValue ~= nil and tPlusStatValue[i] == 0 then	-- ���̞� ������ ������.
			if tBaseStatValue[i] < 0 then
				winMgr:getWindow(tUserStatInfoTextName[i]):setTextExtends(baseString, g_STRING_FONT_GULIM,11, 230,50,50,255,  0,  0,0,0,255);
			else
				winMgr:getWindow(tUserStatInfoTextName[i]):setTextExtends(baseString, g_STRING_FONT_GULIM,11, 255,255,255,255,  0,  0,0,0,255);
			end	
			
			winMgr:getWindow("Total_"..tUserStatInfoTextName[i]):clearTextExtends()
			winMgr:getWindow("Plus_"..tUserStatInfoTextName[i]):clearTextExtends()
		else								-- ������ ���� ������ ������.
			winMgr:getWindow(tUserStatInfoTextName[i]):clearTextExtends()
			winMgr:getWindow("Total_"..tUserStatInfoTextName[i]):setTextExtends(baseString, g_STRING_FONT_GULIM,11, 0,230,0,255,  0,  0,0,0,255);
			winMgr:getWindow("Plus_"..tUserStatInfoTextName[i]):setTextExtends("(+"..plusString..")", g_STRING_FONT_GULIM,11, 0,255,255,255,  0,  0,0,0,255);			
		end
			
	end	

	-- Old Rank System
	-- local baseString = tostring(tBaseStatValue[17])--.." ("..tostring(tBaseStatValue[16])..") "
	-- winMgr:getWindow("Total_"..tUserStatInfoTextName[17]):setTextExtends(baseString, g_STRING_FONT_GULIM,11, 255,255,255,255,  0,  0,0,0,255);

	-- local baseString = tostring(tBaseStatValue[15]).." / "..tostring(tBaseStatValue[18])
	-- winMgr:getWindow("Total_"..tUserStatInfoTextName[18]):setTextExtends(baseString, g_STRING_FONT_GULIM,11, 255,255,255,255,  0,  0,0,0,255);

	-- mywindow = winMgr:getWindow("myInfo_rankImage")
	-- mywindow = drawRankWindow(mywindow, tBaseStatValue[16], 18, 296, 220)
end



--------------------------------------------------------------------
-- ���� ����
--------------------------------------------------------------------
local MAX_HEIGHT_COUNT	= 8
local BUF_SIZE			= 32
--local tBuffBooleanInfo = {['err'] = 0, false, 0, 0, "", ""}

for i = 0, MAX_HEIGHT_COUNT - 1 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_Buf"..i)
	mywindow:setTexture("Enabled", "UIData/mainBG_button002.tga", 0, 788)
	mywindow:setTexture("Disabled", "UIData/mainBG_button002.tga", 0, 788)
	mywindow:setPosition(7, 7 + (BUF_SIZE + 7) * i) 
	mywindow:setSize(BUF_SIZE, BUF_SIZE)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("SpecialEffectBack"):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserInfo_BufTextDesc"..i)
	mywindow:setPosition(47, 8 + (BUF_SIZE + 7) * i) 
	mywindow:setSize(80, 18)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIM, 11)
	mywindow:setTextColor(230,0,230, 255)
	winMgr:getWindow("SpecialEffectBack"):addChildWindow(mywindow)	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "UserInfo_BufTextTime"..i)
	mywindow:setPosition(47, 23 + (BUF_SIZE + 7) * i) 
	mywindow:setSize(80, 18)
	mywindow:setZOrderingEnabled(false)
	mywindow:setFont(g_STRING_FONT_GULIM, 11)
	mywindow:setTextColor(255, 255, 255, 255)
	winMgr:getWindow("SpecialEffectBack"):addChildWindow(mywindow)	
end


-- ���������� ����ش�?.
function ShowMyUserInfoBuff()
	for i = 0, MAX_HEIGHT_COUNT - 1 do
		winMgr:getWindow("UserInfo_Buf"..i):setTexture("Enabled", "UIData/mainBG_button002.tga", 0, 788)
		winMgr:getWindow("UserInfo_BufTextDesc"..i):setText("")
		winMgr:getWindow("UserInfo_BufTextTime"..i):setText("")
	end
	
	-- Īȣ ����
	local Count = 0
	-- ���࿡ 1�������� ���ִ�
	local title = GetUserinfoTitleIndex()
	if title ~= 0 then
		TitleString = GetTitleEffectString(title)
		TitleString	= AdjustString(g_STRING_FONT_GULIM, 11, TitleString, 160)
		winMgr:getWindow("UserInfo_Buf"..Count):setTexture("Enabled", "UIData/numberUi001.tga", 0, 992)
		winMgr:getWindow("UserInfo_BufTextDesc"..Count):setText(TitleString)
		winMgr:getWindow("UserInfo_BufTextTime"..Count):setText("")
		Count = Count + 1
	end
	
	
	local Max_count = GetMaxBufItem()
	for i = 0, Max_count-1 do
		local use, type	= GetUseBufItem(i)
		local desc = GetBuffDesc(i)
		local time = GetBuffRemainTime(i)
		local timestr = string.format(PreCreateString_2154, time)
				
		if use then
			local TexXIndex = i % 20
			local TexYIndex = i / 20
			
			if Count >= 8 then
				-- ������ 8�� �̻��϶� ��ƿ�����? ����
				-- UserInfo_Buf1 ~ UserInfo_Buf7 �̹Ƿ�..
				-- �켱 ������ �� �̻� �޴°� ��ü�� �Ұ��� �ϹǷ� ������
				Count = 7
			end
			winMgr:getWindow("UserInfo_Buf"..Count):setTexture("Enabled", "UIData/mainBG_button002.tga", 32+(TexXIndex*32), 788 + TexYIndex*32)
			winMgr:getWindow("UserInfo_BufTextDesc"..Count):setText(desc)
			winMgr:getWindow("UserInfo_BufTextTime"..Count):setText(timestr)
			Count = Count + 1
		end
	end		
end

--=============================================



-- ĳ���� ��ŷ ���� ===========
local CharacterRankingInfo = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_CharacterRankInfoBack")
CharacterRankingInfo:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
CharacterRankingInfo:setPosition(250, 3)
CharacterRankingInfo:setSize(235, 375)
CharacterRankingInfo:setVisible(false)
CharacterRankingInfo:setAlwaysOnTop(true)
CharacterRankingInfo:setZOrderingEnabled(false)
CharacterInfoMain:addChildWindow(CharacterRankingInfo)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_CharacterRankInfo")
mywindow:setTexture("Enabled", "UIData/myinfo2.tga", 781, 0)
mywindow:setPosition(7, 30)
mywindow:setSize(217, 335)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
CharacterRankingInfo:addChildWindow(mywindow)


-- ��ũ ���� �ؽ�Ʈ ������
-- �ѱ� �����϶��� ����ġ ��ŷ�� ����.
if IsKoreanLanguage() then
	local baseY = 126
	local YTerm = 26
	
	tRankInfoTextName = {['err']=0, [0]="SinglePlayCount", "TeamPlayCount", "KORate"
								,"LadderRecord", "LadderRank", "KORecord", "KORank", "MVPRecord", "MVPRank"
								,"TeamRecord", "TeamRank", "DoubleRecord", "DoubleRank", "PerfectRecord", "PerfectRank"
								,"MaximumRecord", "MaximumRank", "BrokenRecord", "BrokenRank"}
	tRankInfoTextPosX = {['err']=0, [0]=46, 46, 146, 83, 148, 83, 148, 83, 148, 83, 148, 83, 148, 83, 148, 83, 148, 83, 148}
	tRankInfoTextPosY = {['err']=0, [0]=11, 46, 33, baseY, baseY, baseY + YTerm, baseY + YTerm, baseY + YTerm*2, baseY + YTerm*2
								, baseY + YTerm*3, baseY + YTerm*3, baseY + YTerm*4, baseY + YTerm*4, baseY + YTerm*5, baseY + YTerm*5
								, baseY + YTerm*6, baseY + YTerm*6, baseY + YTerm*7, baseY + YTerm*7}
								
	tRankInfoTextSizeX = {['err']=0, [0]=50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50}
	tRankInfoTextSizeY = {['err']=0, [0]=20, 20, 40, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20}

else
	local baseY = 122
	local YTerm = 24
	tRankInfoTextName = {['err']=0, [0]="SinglePlayCount", "TeamPlayCount", "KORate", "ExpRecord", "ExpRank"
								,"LadderRecord", "LadderRank", "KORecord", "KORank", "MVPRecord", "MVPRank"
								,"TeamRecord", "TeamRank", "DoubleRecord", "DoubleRank", "PerfectRecord", "PerfectRank"
								,"MaximumRecord", "MaximumRank", "BrokenRecord", "BrokenRank"}
	tRankInfoTextPosX = {['err']=0, [0]=46, 46, 146, 83, 148, 83, 148, 83, 148, 83, 148, 83, 148, 83, 148, 83, 148, 83, 148, 83, 148}
	tRankInfoTextPosY = {['err']=0, [0]=11, 46, 33, baseY, baseY, baseY + YTerm, baseY + YTerm, baseY + YTerm*2, baseY + YTerm*2
								, baseY + YTerm*3, baseY + YTerm*3, baseY + YTerm*4, baseY + YTerm*4, baseY + YTerm*5, baseY + YTerm*5
								, baseY + YTerm*6, baseY + YTerm*6, baseY + YTerm*7, baseY + YTerm*7, baseY + YTerm*8, baseY + YTerm*8}
								
	tRankInfoTextSizeX = {['err']=0, [0]=50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50}
	tRankInfoTextSizeY = {['err']=0, [0]=20, 20, 40, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20}

end

for i=0, #tRankInfoTextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tRankInfoTextName[i])
	mywindow:setPosition(tRankInfoTextPosX[i],tRankInfoTextPosY[i])
	mywindow:setSize(tRankInfoTextSizeX[i], tRankInfoTextSizeY[i])
	mywindow:setZOrderingEnabled(false)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(6)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("UserInfo_CharacterRankInfo"):addChildWindow(mywindow)
end


--------------------------------------------------------------------
-- ������ ����Ʈ, ĳ�� �̹���.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "MyUserInfo_MoneyBack")
mywindow:setTexture("Disabled", "UIData/myinfo2.tga", 503, 360)
mywindow:setPosition(10, 440)
mywindow:setSize(485, 30)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
UserInfoMain:addChildWindow(mywindow)


--------------------------------------------------------------------
-- ������ ����Ʈ, ĳ�� ���� text
--------------------------------------------------------------------
local tMyUserMoneyName	= {['protecterr']=0, [0]= "MyUserInfo_GranText", "MyUserInfo_CoinText", "MyUserInfo_CashText"}
local tMyUserMoneyPosX	= {['protecterr']=0, [0]= 55, 215, 375}--, 416}

for i = 0, #tMyUserMoneyName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", tMyUserMoneyName[i])
	mywindow:setPosition(tMyUserMoneyPosX[i], 15)
	mywindow:setSize(105, 13)
	mywindow:setZOrderingEnabled(true)	
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	winMgr:getWindow("MyUserInfo_MoneyBack"):addChildWindow(mywindow)

end

-- �� ������ �������� �����ش�.
function GetMyUserInfoMoney(Point)
	local r, g, b	= GetGranColor(Point)
	winMgr:getWindow("MyUserInfo_GranText"):setTextExtends(CommatoMoneyStr64(Point), g_STRING_FONT_GULIMCHE,12, r, g, b,255,  0,  0,0,0,255);
end


function GetMyUserInfoCoin(coin)	--������ ��������
	local r, g, b	= ColorToMoney(coin)
	winMgr:getWindow("MyUserInfo_CoinText"):setTextExtends(CommatoMoneyStr(coin), g_STRING_FONT_GULIMCHE,12, r, g, b,255,  0,  0,0,0,255);
end


function GetMyUserInfoCash(Cash)	--ĳ���� ��������
	local r, g, b	= ColorToMoney(Cash)
	winMgr:getWindow("MyUserInfo_CashText"):setTextExtends(CommatoMoneyStr(Cash), g_STRING_FONT_GULIMCHE,12, r, g, b,255,  0,  0,0,0,255);
	--winMgr:getWindow("PetInfo_CashText"):setTextExtends(CommatoMoneyStr(Cash), g_STRING_FONT_GULIMCHE,12, r, g, b,255,  0,  0,0,0,255);
	
end

-- �������� �������� �����ش�.
function RefreshTotalMoney(zen, coin, cash)
	GetMyUserInfoMoney(zen)
	GetMyUserInfoCoin(coin)
	GetMyUserInfoCash(cash)
end

-----------------------------------------------------------------------------------------
-- Character���� ������ �� ==============================================================
-----------------------------------------------------------------------------------------


-- �������� ���? �����ش�()
function ShowUserInfoWearItemSetting()
	if UserInfoMain:isVisible() == false then
		return
	end
	for i = 0, #tWearAttachItemName do
		winMgr:getWindow(tWearAttachButtonName[i]):setUserString("Index", tostring(-1))		-- ���� �ε��� �ʱ�ȭ
		winMgr:getWindow(tWearAttachName[i]):setVisible(false)
		winMgr:getWindow(tWearAttachItemName[i]):setTexture("Enabled",	"UIData/invisible.tga", 0,0)
		winMgr:getWindow(tWearAttachItemName[i]):setTexture("Disabled", "UIData/invisible.tga", 0,0)
		winMgr:getWindow(tWearAttachItemName[i]):setLayered(false)
		
		winMgr:getWindow(tWearAttachName[i].."_gradeImg"):setVisible(false)
		winMgr:getWindow(tWearAttachName[i].."_gradeText"):setText("")
		
	end

	for i = 0, #tItemWearTable do
		SetUserWearItem(i, 0, 0)
	end
end


-- �������� ���? ������ �ڸ��� �������ش�.
function ShowMyUserInfoWearItem(AttachIndex, Index, fileName, fileName2, grade)
	
	local wearIndex = tItemWearTable[AttachIndex]
	winMgr:getWindow(tWearAttachName[wearIndex]):setVisible(true)
	winMgr:getWindow(tWearAttachButtonName[wearIndex]):setUserString("Index", tostring(Index))		-- ���� �ε��� �ʱ�ȭ
	winMgr:getWindow(tWearAttachItemName[wearIndex]):setTexture("Enabled", fileName, 0,0)
	winMgr:getWindow(tWearAttachItemName[wearIndex]):setTexture("Disabled", fileName, 0,0)
	
	if fileName2 == "" then
		winMgr:getWindow(tWearAttachItemName[wearIndex]):setLayered(false)
	else
		winMgr:getWindow(tWearAttachItemName[wearIndex]):setLayered(true)
		winMgr:getWindow(tWearAttachItemName[wearIndex]):setTexture("Layered", fileName2, 0, 0)
	end
	
	if grade > 0 then
		winMgr:getWindow(tWearAttachName[wearIndex].."_gradeImg"):setVisible(true)
		winMgr:getWindow(tWearAttachName[wearIndex].."_gradeImg"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow(tWearAttachName[wearIndex].."_gradeText"):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow(tWearAttachName[wearIndex].."_gradeText"):setText("+"..grade)
	else
		winMgr:getWindow(tWearAttachName[wearIndex].."_gradeImg"):setVisible(false)
		winMgr:getWindow(tWearAttachName[wearIndex].."_gradeText"):setText("")
	end
end



-- �������� ���? ������ �ڸ��� �������ش�
-- �ڽ�Ƭ �ƹ�Ÿ ���� �Լ�
function ShowMyUserInfoWearItemTwo(AttachIndex, Index, fileName, fileName2, grade , PosX , PosY)
	
	local wearIndex = tItemWearTable[AttachIndex]
	
	winMgr:getWindow(tWearAttachName[wearIndex]):setVisible(true)
	winMgr:getWindow(tWearAttachButtonName[wearIndex]):setUserString("Index", tostring(Index))		-- ���� �ε��� �ʱ�ȭ
	winMgr:getWindow(tWearAttachItemName[wearIndex]):setTexture("Enabled",	fileName,	PosX , PosY)
	winMgr:getWindow(tWearAttachItemName[wearIndex]):setTexture("Disabled", fileName,	PosX , PosY)
	
	if fileName2 == "" then
		winMgr:getWindow(tWearAttachItemName[wearIndex]):setLayered(false)
	else
		winMgr:getWindow(tWearAttachItemName[wearIndex]):setLayered(true)
		winMgr:getWindow(tWearAttachItemName[wearIndex]):setTexture("Layered", fileName2, 0, 0)
	end
	
	if grade > 0 then
		winMgr:getWindow(tWearAttachName[wearIndex].."_gradeImg"):setVisible(true)
		winMgr:getWindow(tWearAttachName[wearIndex].."_gradeImg"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow(tWearAttachName[wearIndex].."_gradeText"):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow(tWearAttachName[wearIndex].."_gradeText"):setText("+"..grade)
	else
		winMgr:getWindow(tWearAttachName[wearIndex].."_gradeImg"):setVisible(false)
		winMgr:getWindow(tWearAttachName[wearIndex].."_gradeText"):setText("")
	end
end





-- ���� ��ų ����
function ShowUserInfoSkill()
	if CEGUI.toRadioButton(winMgr:getWindow("UserInfo_Skill")):isSelected() == false then
		return
	end
	setVisibleUserSkillInfo(true, MyinfoCheck())
	CharacterInfoMain:setVisible(false)			-- ĳ���� ���� ������ ����ش�?.
	CharacterAdditionInfo:setVisible(false)		-- ����, Ư��ȿ�� ������
	CharacterRankingInfo:setVisible(false)		-- ��ŷ ������
	MyTitleMain:setVisible(false)				-- Īȣ ������
	PetInfoMain:setVisible(false)
	winMgr:getWindow("MyUserInfo_MoneyBack"):setVisible(false)
end




-- ���� Īȣ�� �����ش�.
function ShowUserInfoTitleName()
	if CEGUI.toRadioButton(winMgr:getWindow("UserInfo_TitleName")):isSelected() == false then
		return
	end
	UseRefreshTitleInfoList(1)
	winMgr:getWindow("Userinfo_TitleButton1"):setProperty("Selected", "true")
	setVisibleUserSkillInfo(false, false)
	CharacterInfoMain:setVisible(false)
	PetInfoMain:setVisible(false)
	MyTitleMain:setVisible(true)
	if MyinfoCheck() then
		winMgr:getWindow("MyUserInfo_MoneyBack"):setVisible(true)
	end
end

-- ���� �� ����
function ShowUserInfoPet()
	
	if CEGUI.toRadioButton(winMgr:getWindow("UserInfo_Pet")):isSelected() == false then
		return
	end
	
	CharacterInfoMain:setVisible(false)			-- ĳ���� ���� ������ ����ش�?.
	CharacterAdditionInfo:setVisible(false)		-- ����, Ư��ȿ�� ������
	CharacterRankingInfo:setVisible(false)		-- ��ŷ ������
	MyTitleMain:setVisible(false)				-- Īȣ ������
	setVisibleUserSkillInfo(false, false)
	winMgr:getWindow("MyUserInfo_MoneyBack"):setVisible(false)
	winMgr:getWindow("UserInfo_PetMain"):setVisible(true)
	ClearCharacterPetDetailInfo()
	winMgr:getWindow("PetInfoImage"):setTexture("Enabled", "UIData/invisible.tga", 0 , 0)
	RequestPetDetailInfo(g_curPage_SelectShowPet)
	--[[
	for i= 1, #SelectShowPetRadio do
		winMgr:getWindow(SelectShowPetRadio[i]):setProperty('Selected', 'false');
	end
	
	winMgr:getWindow(SelectShowPetRadio[1]):setProperty('Selected', 'true');
	--]]

	-- �ӽ�
	if IsEngLanguage() or IsGSPLanguage()  then
		winMgr:getWindow("PetInfoBtn_upgrade"):setEnabled(false)
		winMgr:getWindow("PetInfoBtn_grow"):setEnabled(false)
	end
end

function ShowUserInfoPetafterHatch()
	CloseUserInfoWindow()
	ShowUserInfoWindow()
	winMgr:getWindow("UserInfo_Pet"):setProperty("Selected", "true")	
end



-- ���� ������ ����ش�?.
function ShowUserInfoWindow()
	root:addChildWindow(UserInfoMain)
	UserInfoMain:setVisible(true)
	if CEGUI.toRadioButton(winMgr:getWindow("UserInfo_Character")):isSelected() == false then
		winMgr:getWindow("UserInfo_Character"):setProperty("Selected", "true")	
	end
		
	--ShowUserInfoWearItemSetting()	
end

-- ���� ������ �ݾ��ش�.
function CloseUserInfoWindow()
	UserInfoMain:setVisible(false)
	SetShowToolTip(false)
	if GetCurrentWndType() ~= WND_LUA_VILLAGE then	-- ���常
		return
	end
	HideAnimationWindow()

	-- Maxion
	-- Close all edit stat panal when closing UserStatInfo
	Submitbutton:setVisible(false)
	Cancelbutton:setVisible(false)
	EditStatusBtn:setVisible(false)	

	for i=0, 10 do
		winMgr:getWindow("Add_Status"..i):setVisible(false)
		winMgr:getWindow("Reduce_Status"..i):setVisible(false)
	end
	-- ShowEditStatusPlus()	
end


-- �� ������ ����ִ°���? �����������? Ȯ���� �������? ���ƾ��Ұ�
-- ��, Ư��ȿ��, Īȣ�� ��Ȱ��
function CheckMyInfo(bCheck)
	if bCheck == 1 then	-- �� �������?
		winMgr:getWindow("UserInfo_TitleImage"):setTexture("Disabled", "UIData/myinfo.tga", 810, 0)
		winMgr:getWindow("UserInfo_TitleImage"):setSize(86, 29)
		winMgr:getWindow("SpecialEffect"):setEnabled(true)
		if winMgr:getWindow("UserInfo_TitleName") then
			winMgr:getWindow("UserInfo_TitleName"):setEnabled(true)
		end
		winMgr:getWindow("MyUserInfo_MoneyBack"):setVisible(true)
		
		ShowMyUserInfoBuff()
		winMgr:getWindow("ShowSettingButton"):setEnabled(true)
		
--		for i=0, #tWearedItemTypeName do
--			winMgr:getWindow(tWearedItemTypeName[i]):setEnabled(true)
--		end		
	else			-- ���������? �����ִ� �Ŷ��?
		DebugStr("äũ ���� ���� ���� �����ֱ�")
		winMgr:getWindow("UserInfo_TitleImage"):setTexture("Disabled", "UIData/myinfo.tga", 845, 0)
		winMgr:getWindow("UserInfo_TitleImage"):setSize(105, 29)		
		winMgr:getWindow("ShowSettingButton"):setEnabled(false)
--		for i=0, #tWearedItemTypeName do
--			winMgr:getWindow(tWearedItemTypeName[i]):setEnabled(false)
--		end
		winMgr:getWindow("SpecialEffect"):setEnabled(false)			-- Ư��ȿ���� ��Ȱ��
		if winMgr:getWindow("UserInfo_TitleName") then
			winMgr:getWindow("UserInfo_TitleName"):setEnabled(false)	-- Īȣ �� ��Ȱ��ȭ
		end
		winMgr:getWindow("MyUserInfo_MoneyBack"):setVisible(false)
	end	
end

-----
-- item show setting alpha imaage
-----
-- alpha window
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ShowPartInfoAlpha")
mywindow:setTexture("Enabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/OnDLGBackImage.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(1920, 1200)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("ShowPartInfoAlpha", "HideShowPartInfowindow")

-- main window
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "ShowPartInfoMain")
mywindow:setTexture("Enabled", "UIData/myinfo.tga", 0, 480)
mywindow:setPosition(372, 180)
mywindow:setSize(279, 383)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("ShowPartInfoAlpha"):addChildWindow(mywindow)


-- Ÿ��Ʋ��(���콺 ���� �����̰� �ϱ�)
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "ShowPartInfoMainTitlebar")
mywindow:setPosition(3, 1)
mywindow:setSize(276, 36)
winMgr:getWindow("ShowPartInfoMain"):addChildWindow(mywindow)

--[[
-- ���? ���� �ٲٱ� üũ�ڽ�.
local AllShowSettingBoxName = {['protecterr'] = 0, [0]=	"NormalShowSettingBox", "CashShowSettingBox" }
local AllShowSettingBoxPosX	= {['protecterr'] = 0, [0]=		110,	188 }


for i=0, #AllShowSettingBoxName do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", AllShowSettingBoxName[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 362, 534)
	mywindow:setTexture("PushedOff", "UIData/myinfo.tga", 362, 534)
	mywindow:setTexture("SelectedNormal", "UIData/myinfo.tga", 362, 480)
	mywindow:setTexture("SelectedHover", "UIData/myinfo.tga", 362, 507)
	mywindow:setTexture("SelectedPushed", "UIData/myinfo.tga", 362, 534)
	mywindow:setTexture("SelectedPushedOff", "UIData/myinfo.tga", 362, 534)
	mywindow:setPosition(AllShowSettingBoxPosX[i], 33)
	mywindow:setSize(27, 27)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setProperty("GroupID", 55)
	mywindow:setUserString("Index", tostring(i))
	mywindow:setProperty("Selected", "false")
	mywindow:subscribeEvent("SelectStateChanged", "AllSlotShowSelectEvent")
	winMgr:getWindow("ShowPartInfoMain"):addChildWindow(mywindow)
end

--]]



-- ������ ��Ʈ �κ� ���� ��ư(c�� ������ ���� �̳Ұ��� ���� �ε����� �����?.)
local PartUpper = 0
local PartLower = 1
local PartHand	= 2
local PartFoot  = 3
local PartFace  = 4
local PartHear  = 5
local PartBack  = 6
local PartHat   = 7
local PartRing  = 8
-- normal / special üũ�ڽ�
local tPartSettingTypeName	= {['err'] = 0, [0]=	"PartSettingNormal", "PartSettingSpecial" }
local tPartSettingTypePosX	= {['err'] = 0, [0]=		111,	192 }
local tPartSettingTypeEvent	= {['err'] = 0, [0]=	"PartSettingNormalEvent", "PartSettingSpecialEvent" }
local tPartSettingTypeTable = {['err'] = 0, [0]=PartHear, PartFace, PartUpper, PartHand, PartLower, PartFoot, PartHat, PartRing, PartBack}

for i=0, #tPartSettingTypeTable do
	for j=0, #tPartSettingTypeName do
		mywindow = winMgr:createWindow("TaharezLook/RadioButton", tPartSettingTypeName[j]..i)
		mywindow:setTexture("Normal", "UIData/popup001.tga", 441, 754)
		mywindow:setTexture("Hover", "UIData/popup001.tga", 441, 754)
		mywindow:setTexture("Pushed", "UIData/popup001.tga", 441, 773)
		mywindow:setTexture("PushedOff", "UIData/popup001.tga", 441, 754)
		mywindow:setTexture("SelectedNormal", "UIData/popup001.tga", 441, 773)
		mywindow:setTexture("SelectedHover", "UIData/popup001.tga", 441, 773)
		mywindow:setTexture("SelectedPushed", "UIData/popup001.tga", 441, 773)
		mywindow:setTexture("SelectedPushedOff", "UIData/popup001.tga", 441, 773)
		mywindow:setPosition(tPartSettingTypePosX[j], 80+(i*26))
		mywindow:setSize(60, 17)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setProperty("GroupID", 25+i)
		mywindow:setUserString("Index", tostring(tPartSettingTypeTable[i]))
		mywindow:subscribeEvent("SelectStateChanged", tPartSettingTypeEvent[j])
		winMgr:getWindow("ShowPartInfoMain"):addChildWindow(mywindow)
	end
end


-- �Ϲ� ������ ���� üũ
function PartSettingNormalEvent(args)
	local eventWindow = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(eventWindow):isSelected() then
		if bShowEvent == false then
			bShowEvent = true
			return
		end
		local index = tonumber(eventWindow:getUserString("Index"))
		SetPartSettingIndex(index, 0)
		
	end
end


-- ĳ�� ������ ����üũ
function PartSettingSpecialEvent(args)
	local eventWindow = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(eventWindow):isSelected() then
		if bShowEvent == false then
			bShowEvent = true
			return
		end
		local index = tonumber(eventWindow:getUserString("Index"))
		SetPartSettingIndex(index, 1)		
		
	end
end



--  ���? ���� �ٲٱ� üũ�ڽ��� �̺�Ʈ�� ���Դ�.
function AllSlotShowSelectEvent(args)
	local eventWindow = CEGUI.toWindowEventArgs(args).window
	if CEGUI.toRadioButton(eventWindow):isSelected() then
		local allCheckboxIndex = tonumber(eventWindow:getUserString("Index"))
		for i=0, #tItemWearTable do
			local radioButtonWindow = winMgr:getWindow(tPartSettingTypeName[allCheckboxIndex]..tostring(i))
			if CEGUI.toRadioButton(radioButtonWindow):isSelected() == false then
				radioButtonWindow:setProperty("Selected", "true")
				
				
				
			end		
		end		
	end
end




function SetSetItemShowSelect(flag, index)
	local radioButtonWindow = winMgr:getWindow(tPartSettingTypeName[flag]..tostring(index))
	if CEGUI.toRadioButton(radioButtonWindow):isSelected() == false then
		radioButtonWindow:setProperty("Selected", "true")

	end
end


function SetChangeShowCheck(index, flag)
	local buttonIndex = -1
	for i=0, #tPartSettingTypeTable do
		if tPartSettingTypeTable[i] == index then
			buttonIndex = i
		end
	end
	if buttonIndex < 0 then
		return
	end
	local radioButtonWindow = winMgr:getWindow(tPartSettingTypeName[flag]..buttonIndex)
	bShowEvent = false
	if CEGUI.toRadioButton(radioButtonWindow):isSelected() == false then
		radioButtonWindow:setProperty("Selected", "true")		
	end
	bShowEvent = true
end


-- �ڽ�Ƭ ��Ʈ ���� ������?
mywindow = winMgr:createWindow("TaharezLook/Button", "PartSettingApplyButton")
mywindow:setTexture("Normal", "UIData/myinfo.tga", 279, 480)
mywindow:setTexture("Hover", "UIData/myinfo.tga", 279, 507)
mywindow:setTexture("Pushed", "UIData/myinfo.tga", 279, 534)
mywindow:setTexture("PushedOff", "UIData/myinfo.tga", 279, 534)
mywindow:setTexture("Disabled", "UIData/myinfo.tga", 279, 561)
mywindow:setPosition(100, 343)
mywindow:setSize(81, 27)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "PartSettingApplyEvent")
winMgr:getWindow("ShowPartInfoMain"):addChildWindow(mywindow)	


function PartSettingApplyEvent(args)
	HideShowPartInfowindow()
end


-- �ڽ�Ƭ show setting ���� �����츦 �����ش�.
function ShowShowPartInfowindow()
	ShowSetPartWindow()
	root:addChildWindow(winMgr:getWindow("ShowPartInfoAlpha"))
	winMgr:getWindow("ShowPartInfoAlpha"):setVisible(true)
	winMgr:getWindow("ShowPartInfoMain"):setPosition(372, 180)
end

-- �ڽ�Ƭ show setting ���� �����츦 �����ش�.
function HideShowPartInfowindow()
	winMgr:getWindow("ShowPartInfoAlpha"):setVisible(false)	
end








-- ĳ���� �������? ����(�Ϲ�/�����?) ==============
local UseGM_WearedItemMain = winMgr:createWindow("TaharezLook/StaticImage", "UseGM_WearedItemBack")
UseGM_WearedItemMain:setTexture("Enabled", "UIData/myinfo.tga", 389, 462)
UseGM_WearedItemMain:setPosition(372, 150)
UseGM_WearedItemMain:setSize(279, 354)
UseGM_WearedItemMain:setVisible(false)
UseGM_WearedItemMain:setAlwaysOnTop(true)
UseGM_WearedItemMain:setZOrderingEnabled(false)
root:addChildWindow(UseGM_WearedItemMain)

-- Ÿ��Ʋ��(���콺 ���� �����̰� �ϱ�)
mywindow = winMgr:createWindow("TaharezLook/Titlebar", "UseGM_WearedItem_TitleBar")
mywindow:setPosition(3, 1)
mywindow:setSize(245, 35)
UseGM_WearedItemMain:addChildWindow(mywindow)

RegistEscEventInfo("UseGM_WearedItemBack", "HideUseGMWearItem")

--------------------------------------------------------------------
-- �ݱ� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "UseGM_WearedItemCloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(248, 5)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "HideUseGMWearItem")
UseGM_WearedItemMain:addChildWindow(mywindow)


local DestanceY = 150
local GMX = 25
local GMY = 46
for j=0, 1 do
	-- �������� ������ �̹��� ������
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UseGM_WearedItemWin".."_"..j)
	mywindow:setTexture("Enabled", "UIData/myinfo.tga", 0, 364)
	mywindow:setPosition(GMX, GMY + 19 + j*150)
	mywindow:setSize(230, 113)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	UseGM_WearedItemMain:addChildWindow(mywindow)
	
	-- ���� ��
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "UseGM_SelectNameWin".."_"..j)
	mywindow:setTexture("Enabled", "UIData/myinfo3.tga", 505+j*62, 228)
	mywindow:setPosition(GMX + 1, GMY + 0 + j*150)
	mywindow:setSize(62, 21)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	UseGM_WearedItemMain:addChildWindow(mywindow)
	
	for i=0, #tWearAttachName do
		-- �̹��� ���� ����� ������ �̹���.
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWearAttachName[i].."_"..j)
		mywindow:setTexture("Enabled", "UIData/my_room.tga", 556,573)
		mywindow:setPosition(GMX + tWearAttachPosX[i] + 6, GMY + tWearAttachPosY[i] + 24 + j*150)
		mywindow:setSize(41, 41)
		mywindow:setVisible(false)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		UseGM_WearedItemMain:addChildWindow(mywindow)

		-- �������� �ѷ��� �����̹���(���? ��Ҹ�? �ϴ°Ŷ� �� ũ�� �̹����� ��ƾ��Ѵ�?.)
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWearAttachItemName[i].."_"..j)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
		mywindow:setPosition(3,3)
		mywindow:setSize(110, 110)
		mywindow:setScaleHeight(90)	-- ����س��´�?.
		mywindow:setScaleWidth(90)		-- ����س��´�?.
		mywindow:setEnabled(false)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setLayered(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUseEventController(false)	-- �̺�Ʈ�� ���� �ʴ´�.
		winMgr:getWindow(tWearAttachName[i].."_"..j):addChildWindow(mywindow)
		
		-- ��ų ���?
		mywindow = winMgr:createWindow("TaharezLook/StaticImage", tWearAttachName[i].."_"..j.."_gradeImg")
		mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
		mywindow:setPosition(GMX + tWearAttachPosX[i] + 16, GMY + tWearAttachPosY[i] + 26 + j*150)
		mywindow:setSize(29, 16)
		mywindow:setAlwaysOnTop(true)
		mywindow:setEnabled(false)
		mywindow:setZOrderingEnabled(false)
		UseGM_WearedItemMain:addChildWindow(mywindow)
		
		-- ��ų���� + ����
		mywindow = winMgr:createWindow("TaharezLook/StaticText", tWearAttachName[i].."_"..j.."_gradeText")
		mywindow:setTextColor(255,255,255,255)
		mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
		mywindow:setPosition(GMX + tWearAttachPosX[i] + 21, GMY + tWearAttachPosY[i] + 27 + j*150)
		mywindow:setSize(40, 20)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		UseGM_WearedItemMain:addChildWindow(mywindow)
			
		
		-- ���콺 ���� ȿ������ ��ư
		mywindow = winMgr:createWindow("TaharezLook/Button", tWearAttachButtonName[i].."_"..j)
		mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
		mywindow:setTexture("Hover", "UIData/my_room.tga", 597, 573)
		mywindow:setTexture("Pushed", "UIData/my_room.tga", 638, 573)
		mywindow:setTexture("PushedOff", "UIData/my_room.tga", 638, 573)
		mywindow:setTexture("Disabled", "UIData/my_room.tga", 556, 573)
		mywindow:setPosition(GMX + tWearAttachPosX[i] + 6, GMY + tWearAttachPosY[i] + 24 + j*150)
		mywindow:setSize(41,41)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		mywindow:setZOrderingEnabled(false)
		mywindow:setUserString("Index", tostring(-1))
		mywindow:setUserString("type", tostring(j))
		mywindow:subscribeEvent("MouseEnter", "UseGM_Item_MouseEnter")
		mywindow:subscribeEvent("MouseLeave", "UseGM_Item_MouseLeave")
		UseGM_WearedItemMain:addChildWindow(mywindow)	
	end
end

function ShowUseGMWearItemShow()
	root:addChildWindow(UseGM_WearedItemMain)
	UseGM_WearedItemMain:setVisible(true)
end

-- �������� ���? �����ش�()
function ShowUseGMWearItemSetting()
	if UseGM_WearedItemMain:isVisible() == false then
		return
	end
		
	for j=0, 1 do
		for i = 0, #tWearAttachItemName do
			winMgr:getWindow(tWearAttachButtonName[i].."_"..j):setUserString("Index", tostring(-1))		-- ���� �ε��� �ʱ�ȭ
			winMgr:getWindow(tWearAttachName[i].."_"..j):setVisible(false)
			winMgr:getWindow(tWearAttachItemName[i].."_"..j):setTexture("Enabled", "UIData/invisible.tga", 0,0)
			winMgr:getWindow(tWearAttachItemName[i].."_"..j):setTexture("Disabled", "UIData/invisible.tga", 0,0)
			winMgr:getWindow(tWearAttachItemName[i].."_"..j):setLayered(false)
			winMgr:getWindow(tWearAttachName[i].."_"..j.."_gradeImg"):setVisible(false)
			winMgr:getWindow(tWearAttachName[i].."_"..j.."_gradeText"):setText("")
			
		end
	end
	for j=0, 1 do
		for i = 0, #tItemWearTable do
			SetUserWearItem(i, 1, j)
		end
	end
end

-- ������ �������? �����ִ� �κ��� �����ش�.
function HideUseGMWearItem()
	if UseGM_WearedItemMain:isVisible() then
		UseGM_WearedItemMain:setVisible(false)
	end
end

-- �������� ���? ������ �ڸ��� �������ش�.
function ShowUseGMWearItem(AttachIndex, Index, fileName, fileName2, flag, grade)
	
	local wearIndex = tItemWearTable[AttachIndex]

	winMgr:getWindow(tWearAttachName[wearIndex].."_"..flag):setVisible(true)
	winMgr:getWindow(tWearAttachButtonName[wearIndex].."_"..flag):setUserString("Index", tostring(Index))		-- ���� �ε��� �ʱ�ȭ
	winMgr:getWindow(tWearAttachItemName[wearIndex].."_"..flag):setTexture("Enabled", fileName, 0,0)
	winMgr:getWindow(tWearAttachItemName[wearIndex].."_"..flag):setTexture("Disabled", fileName, 0,0)
	
	if fileName2 == "" then
		winMgr:getWindow(tWearAttachItemName[wearIndex].."_"..flag):setLayered(false)
	else
		winMgr:getWindow(tWearAttachItemName[wearIndex].."_"..flag):setLayered(true)
		winMgr:getWindow(tWearAttachItemName[wearIndex].."_"..flag):setTexture("Layered", fileName2, 0, 0)
	end
	
	
	if grade > 0 then
		winMgr:getWindow(tWearAttachName[wearIndex].."_"..flag.."_gradeImg"):setVisible(true)
		winMgr:getWindow(tWearAttachName[wearIndex].."_"..flag.."_gradeImg"):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow(tWearAttachName[wearIndex].."_"..flag.."_gradeText"):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow(tWearAttachName[wearIndex].."_"..flag.."_gradeText"):setText("+"..grade)
	else
		winMgr:getWindow(tWearAttachName[wearIndex].."_"..flag.."_gradeImg"):setVisible(false)
		winMgr:getWindow(tWearAttachName[wearIndex].."_"..flag.."_gradeText"):setText("")
	end
	
end

function UseGM_Item_MouseEnter(args)
	local enterWindow	= CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(enterWindow)
	local ItemIndex = enterWindow:getUserString("Index")
	local flagType	= tonumber(enterWindow:getUserString("type"))
	
	local itemNumber = GetUserinfoTooltipInfo(ItemIndex, flagType)
	if itemNumber < 0 then
		return
	end
	GetToolTipBaseInfo(x + 43, y, 2, KIND_COSTUM, 0, itemNumber)
	SetShowToolTip(true)
	
end

function UseGM_Item_MouseLeave(args)
	SetShowToolTip(false)
end
























local MAX_PET_GROW = 4
local MAX_PET_LIST	= 5	
local MAX_PET_LOVEPOINT	= 12	

-----------------------------------------------------------------------------------------
-- Pet���� ������ ���� ============================================================
-----------------------------------------------------------------------------------------
PetInfoMain = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_PetMain")
PetInfoMain:setTexture("Enabled", "UIData/pet_01.tga", 0, 0)
PetInfoMain:setPosition(7, 67)
PetInfoMain:setSize(488, 409)
PetInfoMain:setVisible(false)
PetInfoMain:setAlwaysOnTop(true)
PetInfoMain:setZOrderingEnabled(false)
UserInfoMain:addChildWindow(PetInfoMain)


local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetInfoImage")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0 , 0)
mywindow:setTexture("Disabled", "UIData/debug_b.tga", 0 , 0)		
mywindow:setPosition(5 ,5)
mywindow:setSize(273, 241)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
PetInfoMain:addChildWindow(mywindow)

local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetItemBackImage")
mywindow:setTexture("Enabled",	"UIData/pet_02.tga", 0 , 467)
mywindow:setTexture("Disabled", "UIData/pet_02.tga", 0 , 467)
mywindow:setPosition(281 ,0)
mywindow:setSize(206, 110)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
PetInfoMain:addChildWindow(mywindow)

----------------------------------------------------------------------
-- �Ͼ��? ����Ʈ �̹���
-----------------------------------------------------------------------
local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetInfoEffectImage")
mywindow:setTexture("Enabled", "UIData/Blwhite.tga", 0 , 0)
mywindow:setTexture("Disabled", "UIData/Blwhite.tga", 0 , 0)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setPosition(0, 0)
mywindow:setSize(273, 241)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addController("PetInfoEffectOn", "PetInfoEffectOn", "alpha", "Linear_EaseNone", 0, 0 , 20, true, false, 10)
mywindow:addController("PetInfoEffectOn", "PetInfoEffectOn", "alpha", "Linear_EaseNone", 0, 255 , 5, true, false, 10)
mywindow:addController("PetInfoEffectOn", "PetInfoEffectOn", "alpha", "Linear_EaseNone", 255,0 , 5, true, false, 10)
winMgr:getWindow('PetInfoImage'):addChildWindow(mywindow)


local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetGrowNoticeImage")
mywindow:setTexture("Enabled",	"UIData/pet_01.tga", 878 , 125+140)
mywindow:setTexture("Disabled", "UIData/pet_01.tga", 878 , 125+140)
mywindow:setPosition(10 , 30)
mywindow:setSize(90, 70)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
PetInfoMain:addChildWindow(mywindow)

local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetStateNoticeImage")
mywindow:setTexture("Enabled",	"UIData/pet_01.tga", 878 , 125)
mywindow:setTexture("Disabled", "UIData/pet_01.tga", 878 , 125)
mywindow:setPosition(160 , 30)
mywindow:setSize(90, 70)
mywindow:setEnabled(false)
--mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
PetInfoMain:addChildWindow(mywindow)



-- �� ������ �̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetDecoItemImage")
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0 , 0)
mywindow:setPosition(440, 35)
mywindow:setSize(110, 110)
mywindow:setScaleHeight(90)		-- ����س��´�?.
mywindow:setScaleWidth(90)		-- ����س��´�?.
mywindow:setEnabled(false)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setLayered(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUseEventController(false)	-- �̺�Ʈ�� ���� �ʴ´�.
PetInfoMain:addChildWindow(mywindow)


-- ���콺 ���� ȿ������ ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "PetDecoItemBtn")
mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Hover", "UIData/pet_01.tga", 878, 335)
mywindow:setTexture("Pushed", "UIData/pet_01.tga", 878, 335)
mywindow:setTexture("PushedOff", "UIData/pet_01.tga", 878, 335)
mywindow:setTexture("SelectedNormal", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("SelectedHover", "UIData/pet_01.tga", 878, 335)
mywindow:setTexture("SelectedPushed", "UIData/pet_01.tga", 878, 335)
mywindow:setTexture("SelectedPushedOff", "UIData/pet_01.tga", 878, 335)
mywindow:setPosition(428, 24)
mywindow:setSize(57, 57)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setUserString("Index", tostring(-1))
--mywindow:subscribeEvent("MouseEnter", "Userinfo_PetDecoItem_MouseEnter")
--mywindow:subscribeEvent("MouseLeave", "Userinfo_PetDecoItem_MouseLeave")
mywindow:subscribeEvent("MouseRButtonUp", "OnClickPet_MouseRButtonUp")
PetInfoMain:addChildWindow(mywindow)	




--------------------------------------------------------------------
-- ���̷� ���� ĳ���� ȸ����ư
--------------------------------------------------------------------
PetInfoRotateBtn_Name		= {['protecterr']=0, "PetInfo_LRotate", "PetInfo_RRotate" }
PetInfoRotateBtn_TexX		= {['protecterr']=0, 	484,	535 }
PetInfoRotateBtn_PosX		= {['protecterr']=0, 	16,		210 }
PetInfoRotateBtn_Event	= {['protecterr']=0, "PetInfo_LRotateDownEvent", "PetInfo_RRotateDownEvent" }

for i = 1, #PetInfoRotateBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/Button", PetInfoRotateBtn_Name[i])
	mywindow:setTexture("Normal",	 "UIData/my_room2.tga", PetInfoRotateBtn_TexX[i], 306)
	mywindow:setTexture("Hover",	 "UIData/my_room2.tga", PetInfoRotateBtn_TexX[i], 353)
	mywindow:setTexture("Pushed",	 "UIData/my_room2.tga", PetInfoRotateBtn_TexX[i], 400)
	mywindow:setTexture("PushedOff", "UIData/my_room2.tga", PetInfoRotateBtn_TexX[i], 400)
	mywindow:setPosition(PetInfoRotateBtn_PosX[i], 155)
	mywindow:setSize(51, 47)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("MouseButtonDown", PetInfoRotateBtn_Event[i])
	mywindow:subscribeEvent("MouseButtonUp",  "PetInfo_RRotateEndEvent")
	PetInfoMain:addChildWindow(mywindow)
end


function PetInfo_LRotateDownEvent()
	SetPetRotateState(1)
end

function PetInfo_RRotateDownEvent()
	SetPetRotateState(2)
end

function PetInfo_RRotateEndEvent()
	SetPetRotateState(0)
end



-- ������ �̹���
PetInfogageName	= {['protecterr']=0, "PetInfogage_Exp", "PetInfogage_Hungry", "PetInfogage_love", "PetInfogage_getlove" }
PetInfogageTexX	= {['protecterr']=0, 	132,		0,		0,		488}
PetInfogageTexY	= {['protecterr']=0, 	410,	415,	421,	94}
PetInfogagePosX	= {['protecterr']=0, 	296,    345,	345,	91}
PetInfogagePosY	= {['protecterr']=0, 	165,	150,	171,	390}
PetInfogageSizeX = {['protecterr']=0, 	176,	120,	120,	150}
PetInfogageSizeY = {['protecterr']=0, 	6,		6,		6,		7}

for i=1, #PetInfogageName do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", PetInfogageName[i])
	mywindow:setTexture("Enabled",	"UIData/pet_01.tga", PetInfogageTexX[i] , PetInfogageTexY[i])
	mywindow:setTexture("Disabled", "UIData/pet_01.tga", PetInfogageTexX[i] , PetInfogageTexY[i])		
	mywindow:setPosition(PetInfogagePosX[i] , PetInfogagePosY[i])
	mywindow:setSize(PetInfogageSizeX[i], PetInfogageSizeY[i])
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	PetInfoMain:addChildWindow(mywindow)
end


-- �ؽ�Ʈ
PetInfotextName	= {['protecterr']=0, "PetInfo_CharacterLove", "PetInfo_Enableslot", "PetInfo_Level", 
										"PetInfo_Name", "PetInfo_loveText", "PetInfo_ExpText" , "PetInfo_HungryText", "PetInfo_Enablemate" }
PetInfoTextPosX	= {['protecterr']=0,  102, 245,	8,  45,	340, 340 ,340, 70}
PetInfoTextPosY	= {['protecterr']=0,  387, 390, 7,	7,	167,  125 , 148, 387}

for i=1, #PetInfotextName do
	mywindow = winMgr:createWindow("TaharezLook/StaticText", PetInfotextName[i])
	mywindow:setPosition(PetInfoTextPosX[i], PetInfoTextPosY[i])
	mywindow:setSize(120, 14)
	mywindow:setViewTextMode(1)
	if i > 4 then
		mywindow:setAlign(8)
	end
	mywindow:setLineSpacing(2)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)	
	PetInfoMain:addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticText", "PetInfo_CashText")
mywindow:setPosition(371, 388)
mywindow:setSize(120, 14)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setVisible(false)
mywindow:setLineSpacing(2)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
PetInfoMain:addChildWindow(mywindow)

-- �ؽ�Ʈ

PetInfoStatName	= {['protecterr']=0, "PetInfoStat_1", "PetInfoStat_2", "PetInfoStat_3",  "PetInfoStat_4"}
PetInfoStatPosY	= {['protecterr']=0,  10, 20, 30, 40}

for i=1, #PetInfoStatName do
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetInfoStatImage"..i)
	mywindow:setTexture("Enabled",	"UIData/pet_01.tga", 0 , 535)
	mywindow:setTexture("Disabled", "UIData/pet_01.tga", 0 , 535)	
	mywindow:setPosition(290 , (18*i)-8)
	mywindow:setSize(84, 14)
	mywindow:setEnabled(false)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	PetInfoMain:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetInfoStatcorverImage"..i)
	mywindow:setTexture("Enabled",	"UIData/pet_02.tga", 206 , 467)
	mywindow:setTexture("Disabled", "UIData/pet_02.tga", 206 , 467)
	mywindow:setPosition(288 , (18*i)-10)
	mywindow:setSize(139, 17)
	mywindow:setEnabled(false)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	PetInfoMain:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", PetInfoStatName[i])
	mywindow:setPosition(380 , (18*i)-8)
	mywindow:setSize(1, 14)
	mywindow:setViewTextMode(1)
	--mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)	
	PetInfoMain:addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "PetInfoPluStatName"..i)
	mywindow:setPosition(390 , (18*i)-8)
	mywindow:setSize(1, 14)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(0)
	mywindow:setLineSpacing(2)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)	
	PetInfoMain:addChildWindow(mywindow)
end




--------------------------------------------------------------------

-- ��ư
PetInfoBtnName	= {['protecterr']=0, "PetInfoBtn_ChangeName", "PetInfoBtn_egg", "PetInfoBtn_grow", "PetInfoBtn_upgrade"}
PetInfoBtnTexX	= {['protecterr']=0, 	784,	198, 264 , 687}
PetInfoBtnTexY	= {['protecterr']=0, 	898,	427, 427 , 172}
PetInfoBtnPosX	= {['protecterr']=0, 	283,   415,	283, 284 }
PetInfoBtnPosY	= {['protecterr']=0, 	190,   190,	219, 76 }
PetInfoBtnSizeX	= {['protecterr']=0, 	198,		66,	198, 198 }
PetInfoBtnEvent	= {['protecterr']=0, "ReqeustPetChangeName", "RequestPetUselovePoint" , "RequestPetGrow", "RequestPetUpgrade"}
PetInfoTexFile	= {['protecterr']=0, "UIData/pet_01.tga", "UIData/pet_01.tga", "UIData/pet_01.tga", "UIData/pet_02.tga"}

for i=1, #PetInfoBtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", PetInfoBtnName[i])
	mywindow:setTexture("Normal", PetInfoTexFile[i], PetInfoBtnTexX[i], PetInfoBtnTexY[i])
	mywindow:setTexture("Hover",  PetInfoTexFile[i], PetInfoBtnTexX[i], PetInfoBtnTexY[i]+27)
	mywindow:setTexture("Pushed", PetInfoTexFile[i], PetInfoBtnTexX[i], PetInfoBtnTexY[i]+54)
	mywindow:setTexture("PushedOff", PetInfoTexFile[i], PetInfoBtnTexX[i], PetInfoBtnTexY[i])
	mywindow:setTexture("Disabled", PetInfoTexFile[i], PetInfoBtnTexX[i], PetInfoBtnTexY[i]+81)
	mywindow:setPosition(PetInfoBtnPosX[i]+3, PetInfoBtnPosY[i]+3)
	mywindow:setSize(PetInfoBtnSizeX[i], 27)
	mywindow:setZOrderingEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:subscribeEvent("Clicked", PetInfoBtnEvent[i])
	PetInfoMain:addChildWindow(mywindow)
end

------------------------------------------------------
-- �̸�����
------------------------------------------------------

function ReqeustPetChangeName(args)
	ShowCommonAlertOkCancelBoxWithFunctionWithEdit(PreCreateString_4395, 'OnClickPetNameChangeOKEvent', 'OnClickPetNameChangeCancelEvent', 'PetNameEditText');
end													--GetSStringInfo(LAN_PET_NAMECHANGE_DESCRIPTION_01)


function OnClickPetNameChangeOKEvent(args)
	
	
	if winMgr:getWindow('CommonAlertOkCancelBoxWithEdit') then
		
		local okfunc = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):getUserString("okFunction")
		
		if okfunc ~= "OnClickPetNameChangeOKEvent" then
			
			return
		end
		winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
		
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );
		local local_window = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit');
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		local_window:setVisible(false)
		
		local string = winMgr:getWindow('CommonAlertEditBox'):getText();
		
		if string == "" then
			return
		end 
		
		local petkey = 0
		for i= 1, #SelectShowPetRadio do
			if CEGUI.toRadioButton(winMgr:getWindow(SelectShowPetRadio[i])):isSelected() then
				petkey = winMgr:getWindow(SelectShowPetRadio[i]):getUserString("PetIndex")
			end
		end
		
		RequestPetChangeState(petkey, 3 , string)
	end
end


function OnClickPetNameChangeCancelEvent(args)
	
	if winMgr:getWindow('CommonAlertOkCancelBoxWithEdit') then
		
		local nofunc = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):getUserString("noFunction")
		
		if nofunc ~= "OnClickPetNameChangeCancelEvent" then
			return
		end
		
		winMgr:getWindow('CommonAlertOkCancelBoxWithEdit'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
		winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
		
		root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg') );   --����
		
		local local_window = winMgr:getWindow('CommonAlertOkCancelBoxWithEdit');  
		winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow( local_window );
		
		local_window:setVisible(false)
	end
	
end

function PetNameEditText(args)
	DebugStr("PetNameEditText")
end





------------------------------------------------------
-- �����ֱ�
------------------------------------------------------
function RequestPetFeed()
	ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_4406, 'OnClickPetFeedOKEvent', 'OnClickPetFeedCancelEvent')
end												--GetSStringInfo(LAN_PET_FEEDSTUFF_DESCRIPTION_01)

function OnClickPetFeedOKEvent()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickPetFeedOKEvent" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	local petkey = 0
	for i= 1, #SelectShowPetRadio do
		if CEGUI.toRadioButton(winMgr:getWindow(SelectShowPetRadio[i])):isSelected() then
			petkey = winMgr:getWindow(SelectShowPetRadio[i]):getUserString("PetIndex")
		end
	end
	
	RequestPetChangeState(petkey, 1 , "")
end


function OnClickPetFeedCancelEvent()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickPetFeedCancelEvent" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	
	
end





------------------------------------------------------
-- �˳���
------------------------------------------------------
function RequestPetUselovePoint()
	ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_4419, 'OnClickPetUseEggOKEvent', 'OnClickPetUseEggCancelEvent')
end												--GetSStringInfo(PET_EGG_003)


function OnClickPetUseEggOKEvent()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickPetUseEggOKEvent" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	local petkey = 0
	for i= 1, #SelectShowPetRadio do
		if CEGUI.toRadioButton(winMgr:getWindow(SelectShowPetRadio[i])):isSelected() then
			petkey = winMgr:getWindow(SelectShowPetRadio[i]):getUserString("PetIndex")
		end
	end
	
	RequestPetUseEgg(petkey)
end


function OnClickPetUseEggCancelEvent()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickPetUseEggCancelEvent" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	
	
end


------------------------------------------------------
-- �����ֱ�
------------------------------------------------------
function RequestPetGaveLove()
	ShowCommonAlertOkCancelBoxWithFunction("", PreCreateString_4412, 'OnClickPetLoveOKEvent', 'OnClickPetLoveCancelEvent')
end												--GetSStringInfo(LAN_PET_AFFECTION_DESCRIPTION_02)


function OnClickPetLoveOKEvent()
	local okfunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("okFunction")
	if okfunc ~= "OnClickPetLoveOKEvent" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("okFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow(winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)
	
	local petkey = 0
	for i= 1, #SelectShowPetRadio do
		if CEGUI.toRadioButton(winMgr:getWindow(SelectShowPetRadio[i])):isSelected() then
			petkey = winMgr:getWindow(SelectShowPetRadio[i]):getUserString("PetIndex")
		end
	end
	
	RequestPetChangeState(petkey, 2 , "")
end


function OnClickPetLoveCancelEvent()
	local nofunc = winMgr:getWindow('CommonAlertOkCancelBox'):getUserString("noFunction")
	if nofunc ~= "OnClickPetLoveCancelEvent" then
		return
	end
	winMgr:getWindow('CommonAlertOkCancelBox'):setUserString("noFunction", "")	-- �ʱ�ȭ�� �ؾ���
	
	winMgr:getWindow('CommonAlertAlphaImg'):setVisible(false)
	root:removeChildWindow( winMgr:getWindow('CommonAlertAlphaImg'))
	local local_window = winMgr:getWindow('CommonAlertOkCancelBox')
	winMgr:getWindow('CommonAlertAlphaImg'):removeChildWindow(local_window)
	local_window:setVisible(false)	
	
end

function PetNameEditText(args)
	DebugStr("PetNameEditText")
end


----------------------------------------------------------------------------------------------
-- �� ��ȭ�ϱ�
----------------------------------------------------------------------------------------------
function RequestPetUpgrade()
	
	--[[
	root:addChildWindow(winMgr:getWindow("PetStatUpgrade_MainWindow"))
	winMgr:getWindow("PetStatUpgrade_MainWindow"):setVisible(true)
	--]]
	
	local SelectPetindex = 0
	for i= 1, #SelectShowPetRadio do
		if CEGUI.toRadioButton(winMgr:getWindow(SelectShowPetRadio[i])):isSelected() then
			SelectPetindex = i
		end
	end
	
	PetDecoUpgradeUi(SelectPetindex)
end

----------------------------------------------------------------------------------------------
-- �� �����ϱ�
----------------------------------------------------------------------------------------------
function RequestPetGrow()
	winMgr:getWindow("CommonPreAlphaImage"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("CommonPreAlphaImage"))
	
	winMgr:getWindow("PetGrow_MainWindow"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("PetGrow_MainWindow"))
end

PET_GROW_SELECT_TYPE = 0

RegistEscEventInfo("PetGrow_MainWindow", "PetGrowClose")
-- �� ���� ���? 
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetGrow_MainWindow")
mywindow:setTexture("Enabled",	"UIData/frame/frame_010.tga", 0 , 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_010.tga", 0 , 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6)
mywindow:setPosition(320 , 240)
mywindow:setSize(449, 297)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

-- �� ���� ���� ��Ƽ�� �� ������
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetGrow_PartWindow")
mywindow:setTexture("Enabled", "UIData/pet_01.tga", 0, 786 )
mywindow:setTexture("Disabled", "UIData/pet_01.tga",  0, 786 )
mywindow:setPosition(18 , 40)
mywindow:setSize(413, 238)
--mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("PetGrow_MainWindow"):addChildWindow(mywindow)

-- �� ���� Ÿ��Ʋ�̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetGrow_TitleWindow")
mywindow:setTexture("Enabled", "UIData/pet_01.tga", 488, 101 )
mywindow:setTexture("Disabled", "UIData/pet_01.tga", 488, 101 )
mywindow:setPosition(130 , 5)
mywindow:setSize(179, 27)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("PetGrow_MainWindow"):addChildWindow(mywindow)



--------------------------------------------------------------------
-- �� ���� �ݱ� ��ư
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/Button", "PetGrow_CloseButton")
mywindow:setTexture("Normal", "UIData/mainBG_button002.tga", 354, 159)
mywindow:setTexture("Hover", "UIData/mainBG_button002.tga", 354, 182)
mywindow:setTexture("Pushed", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setTexture("PushedOff", "UIData/mainBG_button002.tga", 354, 205)
mywindow:setPosition(420, 6)
mywindow:setSize(23, 23)
mywindow:setZOrderingEnabled(false)
mywindow:subscribeEvent("Clicked", "PetGrowClose")
winMgr:getWindow("PetGrow_MainWindow"):addChildWindow(mywindow)

	
--------------------------------------------------------------------

-- ��ư
PetGrowBtnName	= {['protecterr']=0, "PetGrowBtn_zen", "PetGrowBtn_cash"}
PetGrowBtnTexX	= {['protecterr']=0, 	488,    488 + 195 }
PetGrowBtnPosX	= {['protecterr']=0, 	15,  240 }
PetGrowBtnEvent	= {['protecterr']=0, "RequestPetGrowZen", "RequestPetGrowCash"}

for i=1, #PetGrowBtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", PetGrowBtnName[i])
	mywindow:setTexture("Normal", "UIData/pet_01.tga", PetGrowBtnTexX[i], 128)
	mywindow:setTexture("Hover", "UIData/pet_01.tga", PetGrowBtnTexX[i], 128*2)
	mywindow:setTexture("Pushed", "UIData/pet_01.tga", PetGrowBtnTexX[i], 128*3)
	mywindow:setTexture("PushedOff", "UIData/pet_01.tga", PetGrowBtnTexX[i], 128)
	mywindow:setTexture("Disabled", "UIData/pet_01.tga", PetGrowBtnTexX[i], 128*4)
	mywindow:setPosition(PetGrowBtnPosX[i], 50)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSize(195, 128)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", PetGrowBtnEvent[i])
	winMgr:getWindow("PetGrow_MainWindow"):addChildWindow(mywindow)
end



PetGrowZenValue	 = {['protecterr']=0, 	130000,   350000 , 700000}

if IsEngLanguage() or IsGSPLanguage() then
	PetGrowCashValue = {['protecterr']=0, 	50,    200,  400 }
else
	PetGrowCashValue = {['protecterr']=0, 	3200000, 8400000 ,  18000000  }
end

--zen ������ �������� ������ ����
function RequestPetGrowZen()
	
	PET_GROW_SELECT_TYPE = 0
	
	PetGrowClose()
	
	winMgr:getWindow("CommonPreAlphaImage"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("CommonPreAlphaImage"))
	
	winMgr:getWindow("PetGrowDetail_MainWindow"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("PetGrowDetail_MainWindow"))
	
	local PreCreateString_pet = PreCreateString_4391	--GetSStringInfo(LAN_PET_EVOLUTION_DESCRIPTION_02)
	local petstring = string.format(PreCreateString_pet, PetGrowZenValue[SelectPetgrow])
	
	winMgr:getWindow("PetGrow_NoticeText"):setTextExtends( petstring , g_STRING_FONT_GULIM,13, 255,255,0,255,  1,  0,0,0,255);
end

function RequestPetGrowCash()

	PET_GROW_SELECT_TYPE = 1
	
	PetGrowClose()
	
	winMgr:getWindow("CommonPreAlphaImage"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("CommonPreAlphaImage"))
	
	winMgr:getWindow("PetGrowDetail_MainWindow"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("PetGrowDetail_MainWindow"))

	DebugStr('SelectPetgrow:'..SelectPetgrow)
	local PreCreateString_pet = PreCreateString_4393	--GetSStringInfo(LAN_PET_EVOLUTION_DESCRIPTION_04)
	local petstring = string.format(PreCreateString_pet, PetGrowCashValue[SelectPetgrow])
	
	winMgr:getWindow("PetGrow_NoticeText"):setTextExtends( petstring , g_STRING_FONT_GULIM,13, 255,255,0,255,  1,  0,0,0,255);
end

function PetGrowClose()
	winMgr:getWindow("CommonPreAlphaImage"):setVisible(false)
	winMgr:getWindow("PetGrow_MainWindow"):setVisible(false)
end


RegistEscEventInfo("PetGrowDetail_MainWindow", "PetDetailGrowClose")

-- �� ���� ���? �ι�° 
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetGrowDetail_MainWindow")
mywindow:setTexture("Enabled",	"UIData/frame/frame_010.tga", 0 , 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_010.tga", 0 , 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6)
mywindow:setPosition(340 , 210)
mywindow:setSize(382, 409)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)


-- �� ���� �ι�° Ÿ��Ʋ�̹���
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetGrowDetail_TitleWindow")
mywindow:setTexture("Enabled", "UIData/pet_01.tga", 667, 101 )
mywindow:setTexture("Disabled", "UIData/pet_01.tga", 667, 101 )
mywindow:setPosition(100 , 5)
mywindow:setSize(179, 27)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("PetGrowDetail_MainWindow"):addChildWindow(mywindow)


-- �� ���� ���� ��Ƽ�� �� ������
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetGrowDetail_PartWindow")
mywindow:setTexture("Enabled", "UIData/pet_01.tga", 413, 760 )
mywindow:setTexture("Disabled", "UIData/pet_01.tga",  413, 760 )
mywindow:setPosition(5 , 40)
mywindow:setSize(371, 217)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("PetGrowDetail_MainWindow"):addChildWindow(mywindow)


-- �� ��Ȯ�� ����
mywindow = winMgr:createWindow("TaharezLook/StaticText", "PetGrow_NoticeText")
mywindow:setPosition(130 , 288)
mywindow:setSize(120, 14)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)	
winMgr:getWindow("PetGrowDetail_MainWindow"):addChildWindow(mywindow)


mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetGrowDetail_Before")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 328, 418)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 328, 418)
mywindow:setPosition(20, 20)
mywindow:setScaleHeight(140)	-- ����س��´�?.
mywindow:setScaleWidth(140)		-- ����س��´�?.
mywindow:setAlign(8)
mywindow:setEnabled(false)
mywindow:setSize(128, 128)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("PetGrowDetail_PartWindow"):addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetGrowDetail_After")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 328, 418)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 328, 418)
mywindow:setPosition(225, 20)
mywindow:setScaleHeight(140)	-- ����س��´�?.
mywindow:setScaleWidth(140)		-- ����س��´�?.
mywindow:setAlign(8)
mywindow:setEnabled(false)
mywindow:setSize(128, 128)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("PetGrowDetail_PartWindow"):addChildWindow(mywindow)
	
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetGrowDetail_statimage")
mywindow:setTexture("Enabled", "UIData/pet_01.tga", 0 ,  535)
mywindow:setTexture("Disabled", "UIData/pet_01.tga", 0, 535)
mywindow:setPosition(142, 175)
mywindow:setAlign(8)
mywindow:setEnabled(false)
mywindow:setSize(84, 14)
mywindow:setZOrderingEnabled(true)
winMgr:getWindow("PetGrowDetail_PartWindow"):addChildWindow(mywindow)

for i = 1, 2 do 
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "PetGrowDetail_stat"..i)
	mywindow:setPosition(84+ (i*206)- 266 , 177)
	mywindow:setSize(120, 14)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)	
	winMgr:getWindow("PetGrowDetail_PartWindow"):addChildWindow(mywindow)
end
	
-- ��ư
PetGrowDetailBtnName	= {['protecterr']=0, "PetGrowDetailBtn_Ok", "PetGrowDetailBtn_Cancel"}
PetGrowDetailBtnTexX	= {['protecterr']=0, 	488,    488 + 117 }
PetGrowDetailBtnPosX	= {['protecterr']=0, 	70,  210 }
PetGrowDetailBtnEvent	= {['protecterr']=0, "RequestPetGrowDetail", "PetDetailGrowClose"}

for i=1, #PetGrowDetailBtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", PetGrowDetailBtnName[i])
	mywindow:setTexture("Normal", "UIData/pet_01.tga", PetGrowDetailBtnTexX[i], 640)
	mywindow:setTexture("Hover", "UIData/pet_01.tga", PetGrowDetailBtnTexX[i], 670)
	mywindow:setTexture("Pushed", "UIData/pet_01.tga", PetGrowDetailBtnTexX[i], 700)
	mywindow:setTexture("PushedOff", "UIData/pet_01.tga", PetGrowDetailBtnTexX[i], 670)
	mywindow:setTexture("Disabled", "UIData/pet_01.tga", PetGrowDetailBtnTexX[i], 640)
	mywindow:setPosition(PetGrowDetailBtnPosX[i], 350)
	mywindow:setAlwaysOnTop(true)
	mywindow:setSize(117, 30)
	mywindow:setZOrderingEnabled(false)
	mywindow:subscribeEvent("Clicked", PetGrowDetailBtnEvent[i])
	winMgr:getWindow("PetGrowDetail_MainWindow"):addChildWindow(mywindow)
end

function PetDetailGrowClose()
	winMgr:getWindow("CommonPreAlphaImage"):setVisible(false)
	winMgr:getWindow("PetGrowDetail_MainWindow"):setVisible(false)
end

function RequestPetGrowDetail()
	
	local petkey = 0
	for i= 1, #SelectShowPetRadio do
		if CEGUI.toRadioButton(winMgr:getWindow(SelectShowPetRadio[i])):isSelected() then
			petkey = tonumber(winMgr:getWindow(SelectShowPetRadio[i]):getUserString("PetIndex"))
		end
	end
	
	if petkey > 0 then
		RequestPetGrowUp(petkey, PET_GROW_SELECT_TYPE)
	end
	
	PetDetailGrowClose()
end


g_curPage_SelectShowPet = 1
g_maxPage_SelectShowPet = 1

--------------------------------------------------------------------
-- �� ���� ��ư ������ �ѱ��?
--------------------------------------------------------------------
ShowPetRadioPageBtn_Name		= {['protecterr']=0, "ShowPetRadioPage_PreBtn", "ShowPetRadioPage_PreNext" }
ShowPetRadioPageBtn_TexX		= {['protecterr']=0, 	397,	397+14 }
ShowPetRadioPageBtn_PosX		= {['protecterr']=0, 	200,	280 }
ShowPetRadioPageBtn_Event		= {['protecterr']=0,  "OnClickPetRadioPagePre", "OnClickPetRadioPageNext" }

for i = 1, #ShowPetRadioPageBtn_Name do
	mywindow = winMgr:createWindow("TaharezLook/Button", ShowPetRadioPageBtn_Name[i])
	mywindow:setTexture("Normal",	 "UIData/pet_01.tga", ShowPetRadioPageBtn_TexX[i], 535)
	mywindow:setTexture("Hover",	 "UIData/pet_01.tga", ShowPetRadioPageBtn_TexX[i], 535+17)
	mywindow:setTexture("Pushed",	 "UIData/pet_01.tga", ShowPetRadioPageBtn_TexX[i], 535+34)
	mywindow:setTexture("PushedOff", "UIData/pet_01.tga", ShowPetRadioPageBtn_TexX[i], 535+51)
	mywindow:setPosition(ShowPetRadioPageBtn_PosX[i], 355)
	mywindow:setSize(14, 17)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:subscribeEvent("Clicked", ShowPetRadioPageBtn_Event[i])
	PetInfoMain:addChildWindow(mywindow)
end


mywindow = winMgr:createWindow("TaharezLook/StaticText", "ShowPetRadioPage_Text")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setTextColor(255,255,255,255)
mywindow:setFont(g_STRING_FONT_GULIMCHE, 16)
mywindow:setPosition(205, 355)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:clearTextExtends()
mywindow:setZOrderingEnabled(false)
mywindow:addTextExtends(tostring(g_curPage_SelectShowPet), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
PetInfoMain:addChildWindow(mywindow)


---------------------------------------
---�� ���? ���������� ��ư--
---------------------------------------
function OnClickPetRadioPagePre()
	if	g_curPage_SelectShowPet  > 1 then
		RefreshPetDetailInfo(g_curPage_SelectShowPet - 1)
	end
end

---------------------------------------
---�� ���? ���������� ��ư--
---------------------------------------
function OnClickPetRadioPageNext()
	
	if g_curPage_SelectShowPet < g_maxPage_SelectShowPet then
		RefreshPetDetailInfo(g_curPage_SelectShowPet + 1)
	end
end
---------------------------------------
---�� ���? ������ ����--
---------------------------------------
function SettingPetPage(currentPage, maxPage)
	
	g_curPage_SelectShowPet = currentPage
	g_maxPage_SelectShowPet = maxPage
	
	winMgr:getWindow('ShowPetRadioPage_Text'):clearTextExtends()
	winMgr:getWindow('ShowPetRadioPage_Text'):addTextExtends(tostring(g_curPage_SelectShowPet.." / " ..g_maxPage_SelectShowPet), g_STRING_FONT_GULIMCHE, 114,    230,230,230,255,     0,     0,0,0,255)
end


----------------------------------------------------------------------------------------------
-- �� ������ư
----------------------------------------------------------------------------------------------
SelectShowPetRadio	= {['protecterr']=0, "SelectShowPet1", "SelectShowPet2", "SelectShowPet3", "SelectShowPet4", "SelectShowPet5",
										 "SelectShowPet6", "SelectShowPet7", "SelectShowPet8", "SelectShowPet9", "SelectShowPet10",
										 "SelectShowPet11", "SelectShowPet12", "SelectShowPet13", "SelectShowPet14", "SelectShowPet15",
										  "SelectShowPet16", "SelectShowPet17", "SelectShowPet18", "SelectShowPet19", "SelectShowPet20"
										 }

for i= 1, #SelectShowPetRadio do

	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetRadioButtonDefaultBack"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 264, 431)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 264, 431)
	
	if i <= 5 then
		mywindow:setPosition((90* i)-70, 259)
	elseif i <= 10 then
		mywindow:setPosition((90* i)-70 - 450, 259)
	elseif i <= 15 then
		mywindow:setPosition((90* i)-70 - 900, 259)
	else
		mywindow:setPosition((90* i)-70 - 1350, 259)
	end
	mywindow:setSize(92, 94)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	PetInfoMain:addChildWindow(mywindow)
	
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SelectShowPetBackImage"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 264, 431)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 264, 431)
	mywindow:setPosition(0, 0)
	mywindow:setEnabled(false)
	mywindow:setSize(92, 94)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("PetRadioButtonDefaultBack"..i):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SelectShowPetBackSelectImage"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 264, 431)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 264, 431)
	mywindow:setPosition(0, 0)
	mywindow:setEnabled(false)
	mywindow:setSize(92, 94)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("PetRadioButtonDefaultBack"..i):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SelectShowPetImage"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 328, 418)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 328, 418)
	mywindow:setPosition(10, 10)
	mywindow:setScaleHeight(140)	-- ����س��´�?.
	mywindow:setScaleWidth(140)		-- ����س��´�?.
	mywindow:setEnabled(false)
	mywindow:setSize(128, 128)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("PetRadioButtonDefaultBack"..i):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "SelectShowPetvisibleImage"..i)
	mywindow:setTexture("Enabled", "UIData/PET_01.tga", 846, 101)
	mywindow:setTexture("Disabled", "UIData/PET_01.tga", 846, 101)
	mywindow:setPosition(0, 0)
	mywindow:setVisible(false)
	mywindow:setEnabled(false)
	mywindow:setSize(92, 24)
	mywindow:setZOrderingEnabled(true)
	winMgr:getWindow("PetRadioButtonDefaultBack"..i):addChildWindow(mywindow)

	mywindow = winMgr:createWindow("TaharezLook/RadioButton", SelectShowPetRadio[i])
	mywindow:setTexture("Normal", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Hover", "UIData/PET_01.tga", 488+(92*2), 0)
	mywindow:setTexture("Pushed", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("SelectedNormal", "UIData/invisible.tga", 488+(92*2), 0)
	mywindow:setTexture("SelectedHover", "UIData/invisible.tga", 488+(92*2), 0)
	mywindow:setTexture("SelectedPushed", "UIData/invisible.tga", 488+(92*2), 0)
	if i <= 5 then
		mywindow:setPosition((90* i)-70, 259)
	elseif i <= 10 then
		mywindow:setPosition((90* i)-70 - 450, 259)
	elseif i <= 15 then
		mywindow:setPosition((90* i)-70 - 900, 259)
	else
		mywindow:setPosition((90* i)-70 - 1350, 259)
	end
	mywindow:setProperty("GroupID", 7272)
	mywindow:setSize(92, 94)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(true)
	mywindow:setEnabled(false)
	mywindow:setUserString("PetIndex", tostring(i))
	mywindow:subscribeEvent("SelectStateChanged", "SelectCharacterPetInfo")
	mywindow:subscribeEvent("MouseDoubleClicked", "SelectVisiblePetInfo")
	mywindow:subscribeEvent("MouseEnter", "OnMouseEnter_ShowPetTooltipInfo")
	mywindow:subscribeEvent("MouseLeave", "OnMouseLeave_HidePetTooltipInfo")
	PetInfoMain:addChildWindow(mywindow)
end

mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetRadiowDisibleImg")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(20 , 259)
mywindow:setSize(450, 110)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(true)
--root:addChildWindow(mywindow)
PetInfoMain:addChildWindow(mywindow)
	


-- Ŭ��
function SelectCharacterPetInfo(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	if CEGUI.toRadioButton(local_window):isSelected() then
		RefreshPetDetailInfo(g_curPage_SelectShowPet)
	end
end

-- ����Ŭ��
function SelectVisiblePetInfo(args)
	local local_window = CEGUI.toWindowEventArgs(args).window;
	local petkey = tonumber(local_window:getUserString("PetIndex"))
	DebugStr('petkey:'..petkey)
	if petkey > 0 then
		RequestPetChangeState(petkey, 4 , "")
	end
end


----------------------------------------------------------------------------------------------
-- �� ui ���� �ʱ�ȭ
---------------------------------------------------------------------------------------------- 
function ClearCharacterPetInfo()
	
end
----------------------------------------------------------------------------------------------
-- �� ui ���� �ʱ�ȭ
---------------------------------------------------------------------------------------------- 
function ClearCharacterPetDetailInfo()

	winMgr:getWindow("PetInfo_CharacterLove"):setTextExtends("" , g_STRING_FONT_GULIM,13, 255,255,0,255,  1,  0,0,0,255);
	winMgr:getWindow("PetInfo_Enableslot"):setTextExtends("", g_STRING_FONT_GULIM,13, 255,198,0,255,  1,  0,0,0,255);
	
	for i=1, #PetInfotextName do
		winMgr:getWindow(PetInfotextName[i]):setTextExtends("", g_STRING_FONT_GULIM,13, 255,198,0,255,  1,  0,0,0,255);
	end

	for i=1, #PetInfogageName do
		winMgr:getWindow(PetInfogageName[i]):setSize(0, 0)
	end
	
	for i=1 , #SelectShowPetRadio do
		winMgr:getWindow("SelectShowPetBackImage"..i):setTexture("Disabled", "UIData/invisible.tga", 254, 425)
		winMgr:getWindow("SelectShowPetBackSelectImage"..i):setTexture("Disabled", "UIData/invisible.tga", 254, 425)
		winMgr:getWindow("SelectShowPetImage"..i):setTexture("Disabled", "UIData/invisible.tga", 254, 425)
		winMgr:getWindow(SelectShowPetRadio[i]):setEnabled(false)
		winMgr:getWindow(SelectShowPetRadio[i]):setUserString("PetIndex", -1)
		winMgr:getWindow("SelectShowPetvisibleImage"..i):setVisible(false)
	end
	
	winMgr:getWindow("SelectShowPetBackImage"..1):setTexture("Disabled", "UIData/pet_01.tga", 488, 0)
	
	for i=1, #PetInfoStatName do
		winMgr:getWindow("PetInfoStatImage"..i):setVisible(false)
		winMgr:getWindow( PetInfoStatName[i]):setTextExtends("", g_STRING_FONT_GULIM,13, 255,198,0,255,  1,  0,0,0,255)
		winMgr:getWindow("PetInfoPluStatName"..i):setTextExtends("", g_STRING_FONT_GULIM,13, 255,198,0,255,  1,  0,0,0,255)
		
		-- 1��° Ŀ���� ų�ʿ����? 
		if i > 1 then
			winMgr:getWindow("PetInfoStatcorverImage"..i):setVisible(true)
		end
	end
	
	for i=1, #PetInfoBtnName do
		winMgr:getWindow(PetInfoBtnName[i]):setVisible(false)
	end
	
	for i = 1, #PetInfoRotateBtn_Name do
		winMgr:getWindow(PetInfoRotateBtn_Name[i]):setVisible(false)
	end
	
	winMgr:getWindow("PetRadioToolTipImage"):setTexture("Disabled", "UIData/invisible.tga", 878, 125 +70)
		
	winMgr:getWindow("PetStateNoticeImage"):setTexture("Disabled", "UIData/invisible.tga", 878, 125 +70)
	winMgr:getWindow("PetGrowNoticeImage"):setVisible(false)
	winMgr:getWindow("PetInfoImage"):setVisible(false)
	winMgr:getWindow("PetItemBackImage"):setVisible(false)
	SettingPetPage(1,1)
end


function DisiblePetButton()
	for i=1, #PetInfoBtnName do
		winMgr:getWindow(PetInfoBtnName[i]):setVisible(false)
	end
	
	for i = 1, #PetInfoRotateBtn_Name do
		winMgr:getWindow(PetInfoRotateBtn_Name[i]):setVisible(false)
	end
	
	
	winMgr:getWindow("PetRadiowDisibleImg"):setVisible(true)
	
end
----------------------------------------------------------------------------------------------
-- �� ĳ�� �⺻ ���� ����
---------------------------------------------------------------------------------------------- 
function SettingCharacterPetInfo( Enablemate, visibleKey, mycharacter)
	-- ĳ���� ����ġ 

	--winMgr:getWindow("PetInfo_Enablemate"):setTextExtends(Enablemate.." / "..100 , g_STRING_FONT_GULIM,13, 255,255,0,255,  1,  0,0,0,255);
	--if visibleKey == 0 and mycharacter == true then
	--	winMgr:getWindow("PetRadioToolTipImage"):setTexture("Disabled", "UIData/PET_01.tga", 784, 843)
	--end
end

----------------------------------------------------------------------------------------------
-- �� ĳ�� ���� ����
---------------------------------------------------------------------------------------------- 
function SettingPetRadioInfo(EnableSlot, page)

	local startIndex = (page * 5) - 5 + 1
	local lastIndex  =  startIndex + 4
	for i=1 , #SelectShowPetRadio do
		
		if EnableSlot >= i then
			winMgr:getWindow("SelectShowPetBackImage"..i):setTexture("Disabled", "UIData/pet_01.tga", 488, 0)
		end
		
		if i >= startIndex and i <= lastIndex then
			winMgr:getWindow("PetRadioButtonDefaultBack"..i):setVisible(true)
			winMgr:getWindow(SelectShowPetRadio[i]):setVisible(true)
		else
			winMgr:getWindow("PetRadioButtonDefaultBack"..i):setVisible(false)
			winMgr:getWindow(SelectShowPetRadio[i]):setVisible(false)
		end
		
		
	end	
end


function OnClickPet_MouseRButtonUp()
	local SelectPetindex = 0
	for i= 1, #SelectShowPetRadio do
		if CEGUI.toRadioButton(winMgr:getWindow(SelectShowPetRadio[i])):isSelected() then
			SelectPetindex = i
		end
	end
	
	PetDecoItem_MouseRButtonUp(SelectPetindex)
end

----------------------------------------------------------------------------------------------
-- �� �������� ui ����
---------------------------------------------------------------------------------------------- 

PetGrowTexX	= {['protecterr']=0, 	0,		128,	0,  128 }
PetGrowTexY = {['protecterr']=0, 	0,		0,		128,	128 }

SelectPetgrow = 1

function SettingCharacterPetDetailInfo(index ,name, color , exp, kind, level, love , show, petkey, exppoint, hungry, hungrypercent, grow, 
										stattype, statvalue, stattype1, stattype2, stattype3, statvalue1, statvalue2, statvalue3,
										afterstatvalue, Enablemate, visibleKey, currentExp, maxExp ,enableSlot, my, itemimage)

	-- ���õ� �� ���� �˾ƿ���
	winMgr:getWindow("PetRadiowDisibleImg"):setVisible(false)
	
	local SelectPetindex = 0
	for i= 1, #SelectShowPetRadio do
		if CEGUI.toRadioButton(winMgr:getWindow(SelectShowPetRadio[i])):isSelected() then
			SelectPetindex = i
		end
	end
	

	local loveBarsize = (love * 120) / 12
	
	-- ���� ��ư Ȱ��ȭ
	winMgr:getWindow(SelectShowPetRadio[index]):setEnabled(true)
	winMgr:getWindow(SelectShowPetRadio[index]):setUserString("PetIndex", petkey)
	winMgr:getWindow("SelectShowPetImage"..index):setTexture("Disabled", "UIData/pet/PET_"..kind.."_"..color..".tga", PetGrowTexX[grow], PetGrowTexY[grow])
	
	-- ��ȯ�� �� UI ǥ��
	if petkey == visibleKey then
		winMgr:getWindow("SelectShowPetvisibleImage"..index):setVisible(true)
		winMgr:getWindow("SelectShowPetBackSelectImage"..index):setTexture("Disabled", "UIData/pet_01.tga", 488+ (92*3), 0)
	end
		
	-- ���õ� �� ������ ����
	if index == SelectPetindex then
	
		-- ������ �� ����ܰ�?
		SelectPetgrow = grow 
		
		-- ���� uiǥ�� 
		winMgr:getWindow("SelectShowPetBackSelectImage"..index):setTexture("Disabled", "UIData/pet_01.tga", 488+ (92*1), 0)
		
		
		winMgr:getWindow("PetInfo_Name"):setTextExtends(name, g_STRING_FONT_GULIM,13, 255,198,0,255,  1,  0,0,0,255);
		winMgr:getWindow("PetInfo_Level"):setTextExtends("Lv."..level, g_STRING_FONT_GULIM,13, 255,255,255,255,  1,  0,0,0,255);
		winMgr:getWindow("PetInfogage_Exp"):setSize(exp, 7)
		--winMgr:getWindow("PetInfo_ExpText"):setTextExtends(exppoint.."% ("..currentExp.." / "..maxExp..") " , g_STRING_FONT_GULIM,11, 255,255,255,255,  1,  0,0,0,255);
		--winMgr:getWindow("PetInfogage_love"):setSize(loveBarsize, 7)
		--winMgr:getWindow("PetInfo_loveText"):setTextExtends(love.." / 12", g_STRING_FONT_GULIM,11, 255,255,255,255,  1,  0,0,0,255);
		--winMgr:getWindow("PetInfo_HungryText"):setTextExtends(hungrypercent.."%", g_STRING_FONT_GULIM,11, 255,255,255,255,  1,  0,0,0,255);
		--winMgr:getWindow("PetInfogage_Hungry"):setSize(hungry, 7)
		winMgr:getWindow("PetInfoImage"):setVisible(true)	
		
		for i = 1, #PetInfoRotateBtn_Name do
			winMgr:getWindow(PetInfoRotateBtn_Name[i]):setVisible(true)
		end
		
		-- �� ���� ���?
		if my == true then
			
			-- ��ư�� ���� �����ش�
			for i=1, #PetInfoBtnName do
				winMgr:getWindow(PetInfoBtnName[i]):setVisible(true)
			end
		
			-- �� ���� ȭ�� �̸� ����
			if grow < MAX_PET_GROW then
				winMgr:getWindow("PetInfoBtn_grow"):setEnabled(true)
				winMgr:getWindow("PetGrowDetail_Before"):setTexture("Disabled", "UIData/pet/PET_"..kind.."_"..color..".tga", PetGrowTexX[grow], PetGrowTexY[grow])
				winMgr:getWindow("PetGrowDetail_After"):setTexture("Disabled", "UIData/pet/PET_"..kind.."_"..color..".tga", PetGrowTexX[grow+1], PetGrowTexY[grow+1])
				winMgr:getWindow("PetGrowDetail_stat"..1):setTextExtends(statvalue , g_STRING_FONT_GULIM,11, 255,255,255,255,  1,  0,0,0,255);
				winMgr:getWindow("PetGrowDetail_stat"..2):setTextExtends(afterstatvalue , g_STRING_FONT_GULIM,11, 255,255,255,255,  1,  0,0,0,255);
				winMgr:getWindow("PetGrowDetail_statimage"):setTexture("Disabled", "UIData/PET_01.tga", 0, 535+(stattype*14))
				
			else
				winMgr:getWindow("PetInfoBtn_grow"):setEnabled(false)
			end
			
			
			DebugStr("level : " .. level)
			DebugStr("grow : " .. grow * 5 + 5)
			--if level == (grow * 5 + 5) then
			--	winMgr:getWindow("PetGrowNoticeImage"):setVisible(true)
			--	winMgr:getWindow("PetGrowBtn_zen"):setEnabled(true)
			--else
				winMgr:getWindow("PetGrowNoticeImage"):setVisible(false)
				winMgr:getWindow("PetGrowBtn_zen"):setEnabled(true)
			--end
			
	
			-- �˳��� ���¿� ���� ��ư ����
			if love >= MAX_PET_LOVEPOINT then
				winMgr:getWindow("PetStateNoticeImage"):setTexture("Disabled", "UIData/PET_01.tga", 878, 125)
				winMgr:getWindow("PetInfoBtn_egg"):setVisible(true)
			else
				winMgr:getWindow("PetInfoBtn_egg"):setVisible(false)
			end
		end
		
		
		-- �� ���� �̹��� ǥ��
		winMgr:getWindow("PetItemBackImage"):setVisible(true)
		
		if itemimage ~= "" then
			winMgr:getWindow("PetDecoItemImage"):setTexture("Disabled", itemimage, 0, 0)
			winMgr:getWindow("PetInfoBtn_upgrade"):setEnabled(true)
			winMgr:getWindow("PetDecoItemBtn"):setEnabled(true)
		else
			winMgr:getWindow("PetDecoItemImage"):setTexture("Disabled", "UIData/invisible.tga", 0, 0)
			winMgr:getWindow("PetInfoBtn_upgrade"):setEnabled(false)
			winMgr:getWindow("PetDecoItemBtn"):setEnabled(false)
		end
		
		-- ���� ���� ǥ��
		SettingPetStat(1, statvalue, stattype,  hungrypercent)
		SettingPetStat(2, statvalue1, stattype1 , hungrypercent)
		SettingPetStat(3, statvalue2, stattype2 , hungrypercent)
		SettingPetStat(4, statvalue3, stattype3 , hungrypercent)
	end
	
	
	if SelectPetindex > 0 then
		SettingPet3DInfo(SelectPetindex)
	end
	
	-- �ӽ�
	if IsEngLanguage() or IsGSPLanguage() then
		winMgr:getWindow("PetInfoBtn_upgrade"):setEnabled(false)
		winMgr:getWindow("PetInfoBtn_grow"):setEnabled(false)
	end
end

function SettingPetStat(index, statvalue, stattype, hungrypercent)
	
	if stattype < 0 then
		return
	end
	
	if statvalue == 0 then
		return
	end
	
	winMgr:getWindow("PetInfoStatcorverImage"..index):setVisible(false)
	winMgr:getWindow("PetInfoStatImage"..index):setVisible(true)
	winMgr:getWindow("PetInfoStatImage"..index):setTexture("Disabled", "UIData/PET_01.tga", 0, 535+(stattype*14))
	
	local changestatvalue = statvalue
	-- �����? ��ġ�� ���� ���� ��ȭ
	
	if hungrypercent <= PET_FEED_STATE_ONE then
		winMgr:getWindow("PetStateNoticeImage"):setTexture("Disabled", "UIData/PET_01.tga", 878, 125 +70)
		changestatvalue = PET_FEED_STATE_DAMAGE1 
	elseif hungrypercent <= PET_FEED_STATE_TWO then
		changestatvalue =  statvalue * PET_FEED_STATE_DAMAGE2 /100
	elseif hungrypercent <= PET_FEED_STATE_THREE then
		changestatvalue =  statvalue * PET_FEED_STATE_DAMAGE3 /100
	else
		changestatvalue =  statvalue * PET_FEED_STATE_DAMAGE4 /100
	end
	
	
	
	if changestatvalue > statvalue then
		local diffvalue = changestatvalue - statvalue	
		local textsize = GetStringSize(g_STRING_FONT_GULIMCHE, 11, changestatvalue)
		
		winMgr:getWindow(PetInfoStatName[index]):setTextExtends(changestatvalue, g_STRING_FONT_GULIM,11, 0,230,0,255,  1,  0,0,0,255);	
		winMgr:getWindow("PetInfoPluStatName"..index):setTextExtends('(+'..diffvalue..')', g_STRING_FONT_GULIM,11, 0,255,255,255,  1,  0,0,0,255);
		winMgr:getWindow("PetInfoPluStatName"..index):setPosition(382+textsize  , ( 18* index)-8);
		if stattype == 2 or stattype == 13 then
			winMgr:getWindow(PetInfoStatName[index]):setTextExtends( (changestatvalue/10).."."..(changestatvalue%10) ,g_STRING_FONT_GULIM,11, 0,230,0,255,  1,  0,0,0,255);	
			winMgr:getWindow("PetInfoPluStatName"..index):setTextExtends('(+'..(diffvalue/10).."."..(diffvalue%10)..')', g_STRING_FONT_GULIM,11, 0,255,255,255,  1,  0,0,0,255);
			winMgr:getWindow("PetInfoPluStatName"..index):setPosition(385+textsize  , ( 18* index)-8);
		end
		
		
		winMgr:getWindow(PetInfoStatName[index]):setPosition(380, ( 18* index)-8);
	elseif changestatvalue < statvalue then
		local diffvalue = statvalue - changestatvalue 
		local textsize = GetStringSize(g_STRING_FONT_GULIMCHE, 11, changestatvalue)
		
		winMgr:getWindow(PetInfoStatName[index]):setTextExtends(changestatvalue , g_STRING_FONT_GULIM,11, 155,155,155,255,  1,  0,0,0,255);
		winMgr:getWindow("PetInfoPluStatName"..index):setTextExtends('(-'..diffvalue..')', g_STRING_FONT_GULIM,11, 230,50,50,255,  1,  0,0,0,255);
		winMgr:getWindow("PetInfoPluStatName"..index):setPosition(382+textsize  , ( 18* index)-8);
		
		if stattype == 2 or stattype == 13 then
			winMgr:getWindow(PetInfoStatName[index]):setTextExtends( (changestatvalue/10).."."..(changestatvalue%10) ,  g_STRING_FONT_GULIM,11, 155,155,155,255,  1,  0,0,0,255);
			winMgr:getWindow("PetInfoPluStatName"..index):setTextExtends('(-'..(diffvalue/10).."."..(diffvalue%10)..')',  g_STRING_FONT_GULIM,11, 230,50,50,255,  1,  0,0,0,255);
			winMgr:getWindow("PetInfoPluStatName"..index):setPosition(385+textsize  , ( 18* index)-8);
		end
		
		winMgr:getWindow(PetInfoStatName[index]):setPosition(380, ( 18* index)-8);
	else
		winMgr:getWindow(PetInfoStatName[index]):setTextExtends(changestatvalue, g_STRING_FONT_GULIM,11, 255,255,255,255,  1,  0,0,0,255);
		winMgr:getWindow(PetInfoStatName[index]):setPosition(400, ( 18* index)-8);
		
		if stattype == 2 or stattype == 13 then
			winMgr:getWindow(PetInfoStatName[index]):setTextExtends( (changestatvalue/10).."."..(changestatvalue%10) , g_STRING_FONT_GULIM,11, 255,255,255,255,  1,  0,0,0,255);
		end
	end
	
end


----------------------------------------------------------------------------------------------
-- �� ���? ����
----------------------------------------------------------------------------------------------
RegistEscEventInfo("PetReward_MainWindow", "UseEggResultClose")
-- ���?
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetReward_MainWindow")
mywindow:setTexture("Enabled",	"UIData/frame/frame_010.tga", 0 , 0)
mywindow:setTexture("Disabled", "UIData/frame/frame_010.tga", 0 , 0)
mywindow:setframeWindow(true)
mywindow:setWideType(6)
mywindow:setPosition(320 , 240)
mywindow:setSize(339, 267)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

------------------------------------------------------------------
--  ������ �̹���.
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetReward_TitleImage")
mywindow:setTexture("Enabled", "UIData/PET_01.tga", 592, 977)
mywindow:setTexture("Disabled", "UIData/PET_01.tga",  592, 977)
mywindow:setPosition(80, 3)
mywindow:setSize(179, 27)
mywindow:setVisible(true)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow('PetReward_MainWindow'):addChildWindow(mywindow)

-- Ȯ��
mywindow = winMgr:createWindow("TaharezLook/Button", "PetReward_OkBtn")
mywindow:setTexture("Normal", "UIData/PET_01.tga", 722, 640)
mywindow:setTexture("Hover", "UIData/PET_01.tga", 722, 640+30)
mywindow:setTexture("Pushed", "UIData/PET_01.tga", 722, 640+60)
mywindow:setTexture("PushedOff", "UIData/PET_01.tga", 722, 640)
mywindow:setTexture("Disabled", "UIData/PET_01.tga", 722, 640)
mywindow:setPosition(115, 210)
mywindow:setSize(117, 30)
mywindow:subscribeEvent("Clicked", "UseEggResultClose")
winMgr:getWindow('PetReward_MainWindow'):addChildWindow(mywindow)

for i = 1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetReward_PartWindow"..i)
	mywindow:setTexture("Enabled",	"UIData/PET_01.tga", 84 , 705)
	mywindow:setTexture("Disabled", "UIData/PET_01.tga", 84 , 705)
	mywindow:setPosition(15 , ( i* 70)- 19)
	mywindow:setSize(308, 69)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("PetReward_MainWindow"):addChildWindow(mywindow)
	
	------------------------------------------------------------------
    --  ������ �̹���.
	------------------------------------------------------------------
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetReward_itemImage"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 281, 42)
	mywindow:setTexture("Disabled", "UIData/debug_b.tga", 281, 42)
	mywindow:setPosition(11, 13)
	mywindow:setSize(128, 128)
	mywindow:setScaleWidth(110)
	mywindow:setScaleHeight(110)
	mywindow:setVisible(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow('PetReward_PartWindow'..i):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "PetReward_count"..i)
	mywindow:setPosition(-3, 10)
	mywindow:setSize(120, 14)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setTextExtends("x10", g_STRING_FONT_GULIM,10, 255,255,255,255,  1,  0,0,0,255);
	winMgr:getWindow('PetReward_PartWindow'..i):addChildWindow(mywindow)
	
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "PetReward_itemname"..i)
	mywindow:setPosition(100, 20)
	mywindow:setSize(120, 14)
	mywindow:setViewTextMode(1)
	mywindow:setAlign(8)
	mywindow:setLineSpacing(2)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)	
	mywindow:setTextExtends("item name hahahah", g_STRING_FONT_GULIM,15, 255,255,255,255,  1,  0,0,0,255);
	winMgr:getWindow('PetReward_PartWindow'..i):addChildWindow(mywindow)
	
end


function ShowUseEggResult(Path1, Path2, Path3, ItemName1, ItemName2, ItemName3, count1, count2, count3)
	
	
	winMgr:getWindow("CommonPreAlphaImage"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("CommonPreAlphaImage"))
	
	winMgr:getWindow("PetReward_MainWindow"):setVisible(true)
	root:addChildWindow(winMgr:getWindow("PetReward_MainWindow"))
	
	winMgr:getWindow("PetReward_itemImage"..1):setTexture("Disabled", Path1 , 0 , 0)
	winMgr:getWindow("PetReward_itemImage"..2):setTexture("Disabled", Path2 , 0 , 0)
	
	winMgr:getWindow("PetReward_count"..1):setTextExtends('x '..count1, g_STRING_FONT_GULIM,10, 255,255,255,255,  1,  0,0,0,255);
	winMgr:getWindow("PetReward_count"..2):setTextExtends('x '..count2, g_STRING_FONT_GULIM,10, 255,255,255,255,  1,  0,0,0,255);
	
	winMgr:getWindow("PetReward_itemname"..1):setTextExtends(ItemName1, g_STRING_FONT_GULIM,14, 255,255,255,255,  1,  0,0,0,255);
	winMgr:getWindow("PetReward_itemname"..2):setTextExtends(ItemName2, g_STRING_FONT_GULIM,14, 255,255,255,255,  1,  0,0,0,255);
end

function UseEggResultClose()
	winMgr:getWindow("CommonPreAlphaImage"):setVisible(false)
	winMgr:getWindow("PetReward_MainWindow"):setVisible(false)
end




------------------------------------------------------------------
--  ���� �̹���.
------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "PetRadioToolTipImage")
mywindow:setTexture("Enabled", "UIData/PET_01.tga", 784, 843)
mywindow:setTexture("Disabled", "UIData/PET_01.tga", 784, 843)
mywindow:setPosition(0, 0)
mywindow:setSize(230, 83)
mywindow:setVisible(false)
mywindow:setEnabled(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

function OnMouseEnter_ShowPetTooltipInfo(args)
	root:addChildWindow(winMgr:getWindow('PetRadioToolTipImage'))
	winMgr:getWindow('PetRadioToolTipImage'):setVisible(true)
	-- ���� ����ش�?.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	
	-- ���� ���õ� �����츦 ã�´�.
	--[[
	local index = tonumber(EnterWindow:getUserString("DetailIndex"))
	--]]
	winMgr:getWindow('PetRadioToolTipImage'):setPosition(x+30, y-30)
end	

function OnMouseLeave_HidePetTooltipInfo(args)
	winMgr:getWindow('PetRadioToolTipImage'):setVisible(false)
end
	
	
function PetWhiteEffectStart()
	winMgr:getWindow("PetInfoEffectImage"):setVisible(true)
	winMgr:getWindow("PetInfoEffectImage"):clearActiveController()
	winMgr:getWindow("PetInfoEffectImage"):activeMotion("PetInfoEffectOn")
end





----------------------------------------------------------------------------------------------
-- �� �����ؽ��� �Ѹ���
---------------------------------------------------------------------------------------------- 
function PetSetting(filename)
	if winMgr:getWindow("PetInfoImage") then
		winMgr:getWindow("PetInfoImage"):setTexture("Enabled",	filename, 0 , 0)
	end
end


local StatusEdit = winMgr:createWindow("TaharezLook/StaticImage", "UserInfo_StatusEdit")
StatusEdit:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
StatusEdit:setPosition(323, 5)
StatusEdit:setSize(135, 16)
StatusEdit:setVisible(true)
StatusEdit:setAlwaysOnTop(true)
CharacterInfoMain:setZOrderingEnabled(false)
CharacterInfoMain:addChildWindow(StatusEdit)

-----------------------------------------------------------------------------------------------------------------------------------
-- Maxion
-- Edit Status Button
EditStatusBtn = winMgr:createWindow("TaharezLook/Button", "MyUserInfo_EditStatus")
EditStatusBtn:setTexture("Normal", "UIData/mainBG_Button001.tga", 555, 187)
EditStatusBtn:setTexture("Hover", "UIData/mainBG_Button001.tga", 555, 202)
EditStatusBtn:setTexture("Pushed", "UIData/mainBG_Button001.tga", 555, 217)
EditStatusBtn:setTexture("PushedOff", "UIData/mainBG_Button001.tga", 555, 187)
EditStatusBtn:setTexture("Disabled", "UIData/mainBG_Button001.tga", 555, 232)
EditStatusBtn:setPosition(125, 0)
EditStatusBtn:setSize(15, 15)
EditStatusBtn:setAlwaysOnTop(true)
EditStatusBtn:setZOrderingEnabled(false)
EditStatusBtn:subscribeEvent("Clicked", "ShowEditStatusPlus")
StatusEdit:addChildWindow(EditStatusBtn)


------------------------------------------------------------------------------------------------

local MaxCurrentStatPoint
------------------------------------------------------------------------------------------------
CurrentStatPoint:setPosition(5,-375)
CurrentStatPoint:setTextColor(255,255,255,255)
StatusEdit:addChildWindow(CurrentStatPoint)

local DebugRankBadge = winMgr:createWindow("TaharezLook/StaticImage", "Debug_RankBadge")
local RankLevel = winMgr:createWindow("TaharezLook/StaticText", "_RankLevel")

-- Dragon's Debug Text
DebugText:setPosition(5, -400)
StatusEdit:addChildWindow(DebugText)

-- Accepted Button 
Submitbutton = winMgr:createWindow("TaharezLook/Button", "Injecter_PopUp_Ok")
Submitbutton:setTexture("Normal",	"UIData/Avata.tga", 774, 464)
Submitbutton:setTexture("Hover",	"UIData/Avata.tga", 774, 496)
Submitbutton:setTexture("Pushed",	"UIData/Avata.tga", 774, 528)
Submitbutton:setTexture("PushedOff","UIData/Avata.tga", 774, 560)
Submitbutton:setTexture("Enabled",	"UIData/Avata.tga", 774, 560)
Submitbutton:setTexture("Disabled",	"UIData/Avata.tga", 774, 560)
Submitbutton:setSize(89, 30)
-- Submitbutton:setPosition(60 , -1)
Submitbutton:setPosition(67 , -1)
Submitbutton:setVisible(false)
Submitbutton:setScaleHeight(147)
Submitbutton:setScaleWidth(125)	
Submitbutton:setAlwaysOnTop(true)

-- Attemp to fixed Button Collison #1
-- Submitbutton:setEnabled(false)
Submitbutton:setZOrderingEnabled(false)

Submitbutton:subscribeEvent("Clicked", function()   		
	Submitbutton:setVisible(false)
	Cancelbutton:setVisible(false)
	EditStatusBtn:setVisible(true)	
	ShowEditStatusPlus(1)
	for i = 0, 19 do
		ClickStatCount[i] = 0
	end
end)   
StatusEdit:addChildWindow(Submitbutton)

------------------------------------------------------------
Cancelbutton = winMgr:createWindow("TaharezLook/Button", "Injecter_PopUp_No")
Cancelbutton:setTexture("Normal",	"UIData/Avata.tga", 863, 464)

---------------------
-- Dragon 's thrid attemps
Cancelbutton:setTexture("Normal",	"UIData/NewAvata.tga", 864, 605)
Cancelbutton:setTexture("Hover",	"UIData/NewAvata.tga", 864, 624)
Cancelbutton:setTexture("Pushed",	"UIData/NewAvata.tga", 864, 642)
Cancelbutton:setTexture("PushedOff","UIData/NewAvata.tga", 864, 659)
Cancelbutton:setTexture("Enabled",	"UIData/NewAvata.tga", 864, 605)
Cancelbutton:setTexture("Disabled",	"UIData/NewAvata.tga", 864, 659)
---------------------
Cancelbutton:setSize(50, 17)
Cancelbutton:setPosition(113 , -0.5)

Cancelbutton:setVisible(false)
Cancelbutton:setAlwaysOnTop(true)

Cancelbutton:setScaleWidth(210)

-- Attemp to fixed Button Collison #1
Cancelbutton:setZOrderingEnabled(false)

Cancelbutton:subscribeEvent("Clicked", function()   				
	Submitbutton:setVisible(false)
	Cancelbutton:setVisible(false)
	EditStatusBtn:setVisible(true)	
	ShowEditStatusPlus(2)	
	--AddRankProtectionScore(0) --Using for Testing Reduce star 
	ModifyBehaviourScore(1)
end)   
StatusEdit:addChildWindow(Cancelbutton)


-- Recursive function to calculate posY based on the pattern
function getPosY(n)
    if n == 1 then
        return 33
    end

    -- Determine the difference based on the repeating pattern
    local previousPosY = getPosY(n - 1)
    local difference

    if (n - 2) % 3 == 0 then
        difference = 19
    elseif (n - 2) % 3 == 1 then
        difference = 17
    else
        difference = 18
    end
	
    -- Return the current posY
    return previousPosY + difference
end

-- Loop to create buttons
for i = 1, 10 do
    myButton = winMgr:createWindow("TaharezLook/Button", "Add_Status"..i)
    myButton:setTexture("Normal", "UIData/mainBG_Button001.tga", 555, 270)
    myButton:setTexture("Hover", "UIData/mainBG_Button001.tga", 555, 284)
    myButton:setTexture("Pushed", "UIData/mainBG_Button001.tga", 555, 298)
    myButton:setTexture("PushedOff", "UIData/mainBG_Button001.tga", 555, 270)

	myButton:setTexture("Enabled", "UIData/mainBG_Button001.tga", 555, 270)
	myButton:setTexture("Disabled", "UIData/mainBG_Button001.tga", 555, 298)
    
    -- Get the posY value using the recursive function
    local posY = getPosY(i)
	if i >= 6 then
		posY = posY + 9
	end	

    myButton:setPosition(440, posY)  -- 450px X-axis, variable Y-axis    
    -- Set size, visibility, and other properties
    myButton:setSize(14, 14)  -- 20px x 20px button
    myButton:setVisible(false)
    myButton:setZOrderingEnabled(false)
    myButton:setAlwaysOnTop(true)
    
    -- Subscribe to the "Clicked" event for each button
    myButton:subscribeEvent("Clicked", function() 
		-- DebugText:setText("DebugStat: " .. ImportStat[19])	    
		if ImportStat[19] > 0 then
			AddStatUserInfo(i-1)		
			ClickStatCount[i-1] = ClickStatCount[i-1] + 1;
		end	 				
    end)     
    CharacterInfoMain:addChildWindow(myButton)

	myButtonMinus = winMgr:createWindow("TaharezLook/Button", "Reduce_Status"..i)
	myButtonMinus:setTexture("Normal", "UIData/mainBG_Button001.tga", 555, 344)
	myButtonMinus:setTexture("Hover", "UIData/mainBG_Button001.tga", 555, 358)
	myButtonMinus:setTexture("Pushed", "UIData/mainBG_Button001.tga", 555, 372)
	myButtonMinus:setTexture("PushedOff", "UIData/mainBG_Button001.tga", 555, 344)   
	myButtonMinus:setTexture("disable", "UIData/mainBG_Button001.tga", 555, 344)

	myButtonMinus:setTexture("Enabled", "UIData/mainBG_Button001.tga", 555, 344)
	myButtonMinus:setTexture("Disabled", "UIData/mainBG_Button001.tga", 555, 372)

	myButtonMinus:setPosition(455, posY)  -- Same Y position as the main button
	myButtonMinus:setSize(14, 14)  -- 20px x 20px button
	myButtonMinus:setVisible(false)	
	myButtonMinus:setZOrderingEnabled(false)
	myButtonMinus:setAlwaysOnTop(true)  	

	-- Subscribe to the "Clicked" event for the minus button
	myButtonMinus:subscribeEvent("Clicked", function()   	
		-- DebugText:setText("DebugStat: " .. ImportStat[19])	
		if ImportStat[19] < MaxCurrentStatPoint and ClickStatCount[i-1] > 0 then
			ReduceStatUserInfo(i-1)				
			ClickStatCount[i-1] = ClickStatCount[i-1] - 1;
		end
	end)     
	CharacterInfoMain:addChildWindow(myButtonMinus)	
end

function ShowEditStatusBtn(value) 
		if value == 1 then
			winMgr:getWindow("MyUserInfo_EditStatus"):setVisible(true)
			SettingStatApplication()
			-- if editStatusWindow ~= nil then
			-- 	editStatusWindow:setVisible(true)
			-- 	SettingStatApplication()
			-- end

			-- winMgr:getWindow("MyUserInfo_EditStatus"):setVisible(true)		
			--winMgr:getWindow("_CurrentStatPoint"):setVisible(true)
		else 
			local editStatusWindow = winMgr:getWindow("MyUserInfo_EditStatus")
			if editStatusWindow ~= nil then
				editStatusWindow:setVisible(false)
			end
			-- winMgr:getWindow("MyUserInfo_EditStatus"):setVisible(false)
			--winMgr:getWindow("_CurrentStatPoint"):setVisible(false)
		end
end

-- number_Type 0 = open edit
-- number_Type 1 = save and exit
-- number_Type 2 = exit only

function ShowEditStatusPlus(numberTypes) 
	local number_Type = (numberTypes) and numberTypes or 0
	local result = ShowEditStatusPlusFunc(number_Type)		
	MaxCurrentStatPoint = SaveMaxCurrentStatPoint()

	if result == 1 then			
		-- Submit & Cancel Status button	
		-- DebugText:setText("DebugStat: " .. ImportStat[19])						
		Submitbutton:setVisible(true)
		Cancelbutton:setVisible(true)	
		EditStatusBtn:setVisible(false)	
		
		if ImportStat[19] > 0 then
			for i=0, 10 do
				winMgr:getWindow("Add_Status"..i):setVisible(true)
				winMgr:getWindow("Reduce_Status"..i):setVisible(true)
			end		
		else
			for i=0, 10 do
				winMgr:getWindow("Add_Status"..i):setVisible(true)
				winMgr:getWindow("Add_Status"..i):setEnabled(false)
				winMgr:getWindow("Reduce_Status"..i):setVisible(true)
				winMgr:getWindow("Reduce_Status"..i):setEnabled(false)
			end
		end
	else
		-- winMgr:getWindow("MyUserInfo_EditStatus"):setTexture("Normal", "UIData/mainBG_Button001.tga", 555, 187)
		for i=0, 10 do
			winMgr:getWindow("Add_Status"..i):setVisible(false)
			winMgr:getWindow("Reduce_Status"..i):setVisible(false)
		end
	end	
end


-- ����/��ŷ������ �����ش�.
function ShowUserInfoRank()
	if CEGUI.toRadioButton(winMgr:getWindow("UserInfo_Rank")):isSelected() == false then
		return
	end
	-- Maxion	
	-- New Rank Badge Maxion
	setRankBadge("Close")
	setRankBadgeLevel("Close")
	StatusEdit:setVisible(false)	
	for i=0, 10 do
		winMgr:getWindow("Add_Status"..i):setVisible(false)
		winMgr:getWindow("Reduce_Status"..i):setVisible(false)
	end

	CharacterInfoMain:setVisible(true)			-- ĳ���� ���� ������ ����ش�?.
	CharacterAdditionInfo:setVisible(false)		-- ����, Ư��ȿ�� ������
	setVisibleUserSkillInfo(false, false)
	CharacterRankingInfo:setVisible(true)		-- ��ŷ ������
	MyTitleMain:setVisible(false)				-- Īȣ ������
	PetInfoMain:setVisible(false)
	if MyinfoCheck() then
		winMgr:getWindow("MyUserInfo_MoneyBack"):setVisible(true)
	end
end

-- ĳ���� ������ �����ش�
function ShowUserInfoCharacter()
	DebugStr('ĳ��������')
	if CEGUI.toRadioButton(winMgr:getWindow("UserInfo_Character")):isSelected() == false then
		return
	end
	-- New Rank Badge Maxion
	-- ReGetRankUI()


	root:addChildWindow(UserInfo_Main)
	CharacterInfoMain:setVisible(true)			-- ĳ���� ���� ������ ����ش�?.
	if CEGUI.toRadioButton(winMgr:getWindow("WearedItem_Normal")):isSelected() == false then
		winMgr:getWindow("WearedItem_Normal"):setProperty("Selected", "true")	
	end

	local flag = GetCurrentItemShowFlag()

	-- Maxion
	StatusEdit:setVisible(true)	
	for i=0, 10 do
		winMgr:getWindow("Add_Status"..i):setVisible(false)
		winMgr:getWindow("Reduce_Status"..i):setVisible(false)
	end

--	if CEGUI.toRadioButton(winMgr:getWindow(tWearedItemTypeName[flag])):isSelected() == false then
--		winMgr:getWindow(tWearedItemTypeName[flag]):setProperty("Selected", "true")	
--	end

	CharacterAdditionInfo:setVisible(true)		-- ����, Ư��ȿ�� ������
	if CEGUI.toRadioButton(winMgr:getWindow("StatInfoBtn")):isSelected() == false then
		winMgr:getWindow("StatInfoBtn"):setProperty("Selected", "true")	
	end
	CharacterRankingInfo:setVisible(false)		-- ��ŷ ������
	MyTitleMain:setVisible(false)				-- Īȣ ������
	PetInfoMain:setVisible(false)
	setVisibleUserSkillInfo(false, false)
	if MyinfoCheck() then
		winMgr:getWindow("MyUserInfo_MoneyBack"):setVisible(true)
	end
end

function romanToInt(roman)
    if roman == "I" then
        return "1"
    elseif roman == "II" then
        return "2"
    elseif roman == "III" then
        return "3"
    elseif roman == "IV" then
        return "4"
    elseif roman == "V" then
        return "5"
    else
        return nil -- for cases where the numeral is not between I and V
    end
end

local RankNameDB = ""
local RankLevelDB = ""
_G.RankPersonalData = ""

function setRankBadge(rankName)
    -- Create the DebugRankBadge window
   	DebugRankBadge:setVisible(true)
	   local base_rank = rankName:match("^(%a+)_")
    -- Set the rank icon based on the rankName
    if base_rank == "Rookie" then
        DebugRankBadge:setTexture("Enabled", "UIData/Raking_Badge.png", 70, 35)
        DebugRankBadge:setScaleHeight(75)
        DebugRankBadge:setScaleWidth(95)
        DebugRankBadge:setPosition(-50, 312)
        DebugRankBadge:setSize(220, 220)
		-- Property of New Sprite Sheet
		-- DebugRankBadge:setTexture("Enabled", "UIData/Raking_Badge.png", 0, 0)
        -- DebugRankBadge:setScaleHeight(160)
        -- DebugRankBadge:setScaleWidth(210)
        -- DebugRankBadge:setPosition(-70, 300)
        -- DebugRankBadge:setSize(120, 120)        
    elseif base_rank == "Bronze" then
        DebugRankBadge:setTexture("Enabled", "UIData/Raking_Badge.png", 70, 246)
        DebugRankBadge:setScaleHeight(75)
        DebugRankBadge:setScaleWidth(95)
        DebugRankBadge:setPosition(-50, 312)
        DebugRankBadge:setSize(220, 220)
        
    elseif base_rank == "Iron" then
        DebugRankBadge:setTexture("Enabled", "UIData/Raking_Badge.png", 70, 440)
        DebugRankBadge:setScaleHeight(75)
        DebugRankBadge:setScaleWidth(95)
        DebugRankBadge:setPosition(-50, 312)
        DebugRankBadge:setSize(220, 220)
        
    elseif base_rank == "Silver" then
        DebugRankBadge:setTexture("Enabled", "UIData/Raking_Badge.png", 45, 650)
        DebugRankBadge:setScaleHeight(75)
        DebugRankBadge:setScaleWidth(95)
        DebugRankBadge:setPosition(-58, 308)
        DebugRankBadge:setSize(300, 220)
        
    elseif base_rank == "Gold" then
        DebugRankBadge:setTexture("Enabled", "UIData/Raking_Badge.png", 45, 870)
        DebugRankBadge:setScaleHeight(75)
        DebugRankBadge:setScaleWidth(95)
        DebugRankBadge:setPosition(-60, 304)
        DebugRankBadge:setSize(300, 220)
        
    elseif base_rank == "Platinum" then
        DebugRankBadge:setTexture("Enabled", "UIData/Raking_Badge.png", 45, 1075)
        DebugRankBadge:setScaleHeight(75)
        DebugRankBadge:setScaleWidth(95)
        DebugRankBadge:setPosition(-60, 304)
        DebugRankBadge:setSize(300, 220)
        
    elseif base_rank == "Diamond" then
        DebugRankBadge:setTexture("Enabled", "UIData/Raking_Badge.png", 30, 1285)
        DebugRankBadge:setScaleHeight(75)
        DebugRankBadge:setScaleWidth(95)
        DebugRankBadge:setPosition(-66, 298)
        DebugRankBadge:setSize(350, 220)
        
    elseif base_rank == "Master" then
        DebugRankBadge:setTexture("Enabled", "UIData/Raking_Badge.png", 45, 1520)
        DebugRankBadge:setScaleHeight(65)
        DebugRankBadge:setScaleWidth(85)
        DebugRankBadge:setPosition(-57, 306)
        DebugRankBadge:setSize(350, 220)
        
    elseif base_rank == "GrandMaster" then
        DebugRankBadge:setTexture("Enabled", "UIData/Raking_Badge.png", 25, 1800)
        DebugRankBadge:setScaleHeight(65)
        DebugRankBadge:setScaleWidth(85)
        DebugRankBadge:setPosition(-62, 312)
        DebugRankBadge:setSize(380, 220)
    
	elseif rankName == "Close" then
		DebugRankBadge:setVisible(false)
    else
        print("Unknown rank: " .. rankName)
    end
    -- Add DebugRankBadge as a child of StatusEdit
    StatusEdit:addChildWindow(DebugRankBadge)

	if rankName ~= "Close" then
		--local baseString = tostring(rankName) -- set Rankname in userinfo
		local baseString = RankNameDB .. " " .. RankLevelDB -- set Rankname in userinfo
		
		winMgr:getWindow("Total_"..tUserStatInfoTextName[17]):setTextExtends(baseString, g_STRING_FONT_GULIM,11, 255,255,255,255,  0,  0,0,0,255);
	end
end

function setRankBadgeLevel(Level)
	-- Create the DebugRankBadge window
	RankLevel:setVisible(true)
	RankLevel:setTextColor(255,255,255,255)
	if Level == "1" then
		RankLevel:setText("I")
		RankLevel:setFont(g_STRING_FONT_GULIMCHE, 25)
		RankLevel:setSize(40, 20)
		RankLevel:setPosition(-33, 322)
		RankLevel:setAlwaysOnTop(true)
	elseif Level == "2" then
		RankLevel:setText("II")
		RankLevel:setFont(g_STRING_FONT_GULIMCHE, 25)
		RankLevel:setSize(40, 20)
		RankLevel:setPosition(-38, 322)
		RankLevel:setAlwaysOnTop(true)
	elseif Level == "3" then
		RankLevel:setText("III")
		RankLevel:setFont(g_STRING_FONT_GULIMCHE, 23)
		RankLevel:setSize(40, 20)
		RankLevel:setPosition(-42, 326)
		RankLevel:setAlwaysOnTop(true)
	elseif Level == "4" then
		RankLevel:setText("IV")
		RankLevel:setFont(g_STRING_FONT_GULIMCHE, 25)
		RankLevel:setSize(40, 20)
		RankLevel:setPosition(-40, 326)
		RankLevel:setAlwaysOnTop(true)
	elseif Level == "5" then
		RankLevel:setText("V")
		RankLevel:setFont(g_STRING_FONT_GULIMCHE, 25)
		RankLevel:setSize(40, 20)
		RankLevel:setPosition(-36, 324)
		RankLevel:setAlwaysOnTop(true)
	elseif Level == "Close" then
	 	RankLevel:setVisible(false)  	 
 end
 StatusEdit:addChildWindow(RankLevel)

end

-- Function to split rank names into two parts
function split_rank_name(rank_name)
    local category, level = string.match(rank_name, "([^_]+)_([^_]+)")
    RankNameDB = category;
	RankLevelDB = romanToInt(level);
end

function GetRankUI(ID,Name,Path,PosX,PosY)
	_G.RankPersonalData = ID .. "," .. Name .. "," .. Path .. "," ..PosX .. "," .. PosY
	RankNameDB = ""
	RankLevelDB = ""
	RankNameDB = Name
	RankLevelDB = ID
	LOG("GetRankUI: ".. ID .. " , " .. Name)
	split_rank_name(Name)
	setRankBadge(Name)
	setRankBadgeLevel(RankLevelDB)
	--LOG("RankNameDB: ".. RankNameDB .. " , RankLevelDB: " .. RankLevelDB)
end

function GetNameAndLevel(Name,Level)
	_G.PersonalData = Name .. "," .. Level
	--LOG("GetNameAndLevel")
end

