--------------------------------------------------------------------

-- Script Entry Point

--------------------------------------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
guiSystem:setGUISheet(root)

 
local g_STRING_TOOLTIP_MESSAGE = PreCreateString_3567	--GetSStringInfo(LAN_CLONE_MESSAGE_6) -- ���� �ڽ�Ƭ 
--------------------------------------------------------------------
-- ��������
--------------------------------------------------------------------
-- ���� Ÿ��
TYPE_ROOM = 0		-- ��(�� �̿�)���� ����ϴ� ����
TYPE_SHOP = 1		-- ������ ����ϴ� ����
TYPE_TRADE = 2		-- ������ ����ϴ� ����

-- ���� ������ ����
KIND_COSTUM = 0		-- �ڽ�Ƭ
KIND_SKILL	= 1		-- ��ų
KIND_ITEM	= 2		-- ������
KIND_ORB	= 3		-- orb������


-- ������ ���
GRADE_LOW	 = 0		-- 
GRADE_MEDIUM = 1		-- 
GRADE_HIGH	 = 2		-- 
GRADE_UNIQUE = 3		-- 
GRADE_RARE	 = 4		--
GRADE_LEGEND = 5		--
GRADE_ULTIMATE = 6		--

ITEM_NAME	  = 1
ITEM_FILENAME = 2
ITEM_INDEX	  = 3
ITEM_STAT	  = 4
ITEM_STATSTR  = 5
ITEM_CHECK	  = 6
ITEM_INDEX2	  = 7
ITEM_STAT2	  = 8
ITEM_STATSTR2  = 9


-- ������ ����������
PRICE_BCHECK		= 0
PRICE_STATE			= 1
PRICE_SALEPRICE		= 2
PRICE_PRODUCTPRICE	= 3
PRICE_PERIOD		= 4
PRICE_PRODUCTNO		= 5
PRICE_PAYMENTTYPE	= 6

--------------------------------------------------------------------
-- ��������
--------------------------------------------------------------------
-- ���� ���� ����â�� ������.
local MainSizeX = 236
local MainSizeY = 431
local Term		= 20
local LineCount = 0
local FirstPosY = 16
local PosX = 0
local PosY = 0

local WearedPosX = 0
local WearedPosY = 0
local WearedLineCount = 0

local SelectItem_kind = -1
local WearedSelectItem_kind = -1


local tgray   = {['err'] = 0, 150, 150, 150}
local twhite  = {['err'] = 0, 255, 255, 255}
local tblue   = {['err'] = 0,  33, 203, 255}
local tpurple = {['err'] = 0, 172,  89, 255}
local tyellow = {['err'] = 0, 255, 251,  71}
local torange = {['err'] = 0, 255, 167,  25}
local tmagenta= {['err'] = 0, 255,  18, 239}
local tGradeColorTable = {['err'] = 0, [0] = tgray, twhite, tblue, tpurple, tyellow, torange, tmagenta}
local tGradeStringTable = {['err'] = 0, [0] = "Low", "Medium", "High", "Unique", "Rare", "Legend", "Ultimate"}

tSkillGradeStringTable = {['err'] = 0, [0] = "Basic", "Extend", "Pro"}
tStateStringTable = {['err'] = 0, [0]="New", "Hot", "Sale", "", ""}


local tStateCheck		= {['err'] = 0, [0]=false, false, false, false, false , false, false}
local tStateIndex		= {['err'] = 0, [0]=2, 4, 8, 128, 256, 512, 1024}

if IsKoreanLanguage() then
	tStateIndex	= {['err'] = 0, [0]=5, 6, 2, -1, -1}
else
	tStateIndex	= {['err'] = 0, [0]=2, 4, 8, 128, 256, 512, 1024}
end


local tCostumeTTAddInfo = { ['err']=0 , "" , 0}	-- fileName , iscostumeavatar? �ڡ�
local tCostumTTInfo = {['err'] = 0, "", "", "",0,0,0,0,0,0,0,"",0,0,0,0,0,0,0}	-- name, desc, level, grade, bonetype, maxreform, currentreform, time, tradeable, usable, attach
local tSkillTTInfo = {['err'] = 0, "", "", "", 0,0,0,0,0,0,0,0,0,0,0,0,0}	-- name, desc, skillkind, level, promotion, skillgrade, time, commandIndex, tradeable, usable
local tItemTTInfo = {['err'] = 0, "", "", 0,0,0,0,0,0}	-- name, desc, level, time, tradeable, usable
local tOrbTTInfo = {['err'] = 0, "", "", 0,0,0,0}	-- name, desc, level, time, tradeable, usable
local tToolTipInfoTable = {['err'] = 0, [0] = tCostumTTInfo, tSkillTTInfo, tItemTTInfo, tOrbTTInfo}
local ToolTipType = 0;


local tWeardCostumeTTAddInfo = { ['err']=0 , "" , 0}	-- fileName , iscostumeavatar? �ڡ�
local tWeardCostumTTInfo = {['err'] = 0, "", "", "",0,0,0,0,0,0,0,"",0,0,0,0,0,0,0}	-- name, desc, level, grade, bonetype, maxreform, currentreform, time, tradeable, usable, attach
local WearedTotalStatInfo = {['err'] = 0, }
local WearedAddStatInfo	= {['err'] = 0, }
local WearedUpgradeStatInfo= {['err'] = 0, }
local WearedtStatString	= {['err'] = 0, }
-- From Jiyuu
--local WearedHotfixStat = ""
local WearedHotfixStat = {['err'] = 0, }
-- End of Jiyuu
local WearedToolTipType = 0;


local TotalStatInfo = {['err'] = 0, }
local AddStatInfo	= {['err'] = 0, }
local UpgradeStatInfo= {['err'] = 0, }
local tStatString	= {['err'] = 0, }
-- From Jiyuu
local HotfixStat = {['err'] = 0, }


-- ����ġ����
local COSTUM_UPPER		= 1
local COSTUM_LOWER		= 2
local COSTUM_HAND		= 4
local COSTUM_FOOT		= 8
local COSTUM_FACE		= 16
local COSTUM_HAIR		= 32
local COSTUM_BACK		= 64
local COSTUM_HAT		= 128
local COSTUM_RING		= 256
local tCostumAttach		= {['err'] = 0, false, false, false, false, false, false, false, false, false }		-- ������ �ڽ�Ƭ ����ġ�� Ȯ�����ش�
local tCostumAttachTable= {['err'] = 0, COSTUM_UPPER, COSTUM_LOWER, COSTUM_HAND, COSTUM_FOOT, COSTUM_FACE, COSTUM_HAIR, COSTUM_BACK, COSTUM_HAT, COSTUM_RING }		-- ������ �ڽ�Ƭ ����ġ�� Ȯ�����ش�
local tCostumKind		= {['err'] = 0, PreCreateString_1841, PreCreateString_1842, PreCreateString_1843, PreCreateString_1844, PreCreateString_1845,
													PreCreateString_1846, PreCreateString_1847, PreCreateString_1848, PreCreateString_1849, PreCreateString_1850}
local tStatNameText = {['protecterr']=0, PreCreateString_1122, PreCreateString_1123, PreCreateString_1124, "HP", "SP", PreCreateString_1125, PreCreateString_1126, PreCreateString_2646
											, PreCreateString_2648, PreCreateString_2650, PreCreateString_2647, PreCreateString_2649, PreCreateString_2651, PreCreateString_2652 }

local tUpgradeStatNameText = {['err']=0, "All Attack", "All Defence"}


local tHotfixInfo1 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tHotfixInfo2 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tHotfixInfo3 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tHotfixInfo4 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tHotfixInfo5 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tHotfixInfo6 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tHotfixInfo7 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tHotfixInfo8 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tHotfixInfo9 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tHotfixInfoTable = {['err'] = 0, tHotfixInfo1, tHotfixInfo2, tHotfixInfo3, tHotfixInfo4, tHotfixInfo5, 
										tHotfixInfo6, tHotfixInfo7, tHotfixInfo8, tHotfixInfo9 }
										
										
										
local tWearedHotfixInfo1 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tWearedHotfixInfo2 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tWearedHotfixInfo3 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tWearedHotfixInfo4 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tWearedHotfixInfo5 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tWearedHotfixInfo6 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tWearedHotfixInfo7 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tWearedHotfixInfo8 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tWearedHotfixInfo9 = {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}
local tWearedHotfixInfoTable = {['err'] = 0, tWearedHotfixInfo1, tWearedHotfixInfo2, tWearedHotfixInfo3, tWearedHotfixInfo4, tWearedHotfixInfo5, 
										tWearedHotfixInfo6, tWearedHotfixInfo7, tWearedHotfixInfo8, tWearedHotfixInfo9 }
										
										
										
-- ���������� ���� ���̺�
local tPriceInfo = {['err'] = 0, -1,-1,-1,-1}
local tPriceInfoTable = {['err'] = 0, [0]={['err'] = 0, [0]= false}, {['err'] = 0, [0]= false}, {['err'] = 0, [0]= false}}
local tPayMentType	= {['err'] = 0, [0]=PreCreateString_200, PreCreateString_1955}
local tPayMentTypeImg = {['err'] = 0, [0] = 482, 462}
TYPE_CASH	= 13001		-- ĳ�� ����
TYPE_GRAN	= 25005		-- �׶� ����

local tSetItemInfoTable = {['err']=0, }	-- ��Ʈ�����ۿ� ���� ���� ���̺�(���� ����������..)
local aaa = 0
local aa1 = 0
local aa2 = 0

-- ��Ʈ �����۰��� ����, ���̺��
local tSetNameString = {['err']=0, [0]="", "", "", "", "", "", "", "", ""}
local tbSetNameCheck = {['err']=0, [0]=false, false, false, false, false, false, false, false, false}
local tSetEffectString = {['err']=0, [0]="", "", "", "", "", "", "", "", "", ""}
local tbSetEffectcheck = {['err']=0, [0]=false, false, false, false, false, false, false, false, false, false}
local SetCurrentCount = 0
local SetTotalCount	 = 0

-- �Ϲ� ������ ȿ���� ��Ÿ���� ������
local HaveItemState2	= 0	-- �������� Ư��ȿ���� �������ִ��� Ȯ���ϴ� ����
local ItemState2_String	= ""	-- �������� Ư��ȿ�� ��Ʈ��

local HaveAddSkill = 0
local AddSkill_String = ""

local WeardHaveItemState2	= 0	-- �������� Ư��ȿ���� �������ִ��� Ȯ���ϴ� ����
local WeardItemState2_String	= ""	-- �������� Ư��ȿ�� ��Ʈ��

local WeardHaveAddSkill = 0
local WeardAddSkill_String = ""

local ItemLevel = 0 -- ������ ����

--------------------------------------------------------------------
-- ���� ���� ���� �̹���
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Common_ToolTip")
mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(MainSizeX, MainSizeY)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:subscribeEvent('EndRender', "Common_ToolTipRender")
root:addChildWindow(mywindow)


--------------------------------------------------------------------
-- ���� ���� ���� �̹��� Weared ���� ��
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Common_WearedToolTip")
mywindow:setTexture("Enabled",	"UIData/invisible.tga", 0, 0)
mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
mywindow:setPosition(0, 0)
mywindow:setSize(MainSizeX, MainSizeY)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:subscribeEvent('EndRender', "Common_WearedToolTipRender")
root:addChildWindow(mywindow)

--------------------------------------------------------------------
-- ���� ���� ���� ����
--------------------------------------------------------------------
function Common_ToolTipRender(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local _drawer		= local_window:getDrawer()
	
	-- ù��° ����
	_drawer:setTextColor(255,205,86,255) -- ������ �̸�(�� ��޿� ����)
	_drawer:setFont(g_STRING_FONT_GULIM, 12)
	
	if SelectItem_kind == KIND_COSTUM then
		SettingCostumToolTip(_drawer)
	elseif SelectItem_kind == KIND_SKILL then
		SettingSkillToolTip(_drawer)
	elseif SelectItem_kind == KIND_ITEM or SelectItem_kind == KIND_ORB then
		SettingItemToolTip(_drawer, SelectItem_kind)
	end
	
	-- ���
--	_drawer:drawTextureA("UIData/skillitem001.tga", 0, 0, MainSizeX, 10, 787, 917, 255)

--	-- �ϴ�.
--	_drawer:drawTextureA("UIData/skillitem001.tga", 0, MainSizeY - 10, MainSizeX, 10, 787, 1013, 255)

--	local Size = GetStringSize(g_STRING_FONT_GULIM, 12, String) -- ������ �̸�
--	_drawer:drawText(String, (340 - Size) / 2, 54)
end


--------------------------------------------------------------------
-- �ι�° ���� ���� ��
--------------------------------------------------------------------
function Common_WearedToolTipRender(args)
	local local_window	= CEGUI.toWindowEventArgs(args).window
	local _drawer		= local_window:getDrawer()
	
	-- ù��° ����
	_drawer:setTextColor(255,205,86,255) -- ������ �̸�(�� ��޿� ����)
	_drawer:setFont(g_STRING_FONT_GULIM, 12)
	
	if WearedSelectItem_kind == KIND_COSTUM then
		SettingWearedCostumToolTip(_drawer)
	else
		winMgr:getWindow("Common_WearedToolTip"):setVisible(false)
	end
end


-- �ڽ�Ƭ�� ������ �������ش�.
function SettingCostumToolTip(drawer)
	if ToolTipType == TYPE_SHOP then
		RenderShopCostumToolTip(drawer)		
	else
		RenderRoomCostumToolTip(drawer)
	end
end

-- ��ų�� ������ �������ش�.
function SettingSkillToolTip(drawer)
	if ToolTipType == TYPE_SHOP then
		RenderShopSkillToolTip(drawer)		
	else
		RenderRoomSkillToolTip(drawer)
	end

end

-- �������� ������ �������ش�.
function SettingItemToolTip(drawer, Type)
	if ToolTipType == TYPE_SHOP then
		RenderShopItemToolTip(drawer, Type)
	else
		RenderRoomItemToolTip(drawer, Type)
	end	
end

-- ORB�� ������ �������ش�.
function SettingOrbToolTip()
end


-- �ι�° ������ �������ش�. ��
function SettingWearedCostumToolTip(drawer)
	if WearedToolTipType == TYPE_SHOP then
		--��������Shop(drawer)		
	else
		RenderWearedCostumToolTip(drawer)
	end
end


-------------------------------------
-- �԰� �ִ� ��� ���� ��
-------------------------------------
function RenderWearedCostumToolTip(drawer)
	--DebugStr('RenderWeared')
	local ysize = 0
	local count = 0
	
	-- ���(�̸� ��������.)
	-- From Jiyuu
	--drawer:drawTexture("UIData/skillitem001.tga", 0, 0, 236, 39, 787, 917)
	--drawer:drawTexture("UIData/skillitem001.tga", 0, 29, 236, 5, 787, 912)		-- ������ �̸� �ؿ� ��
	drawer:drawTexture("UIData/skillitem001.tga", 0, 0, MainSizeX, 39, 787, 917)
	drawer:drawTexture("UIData/skillitem001.tga", 0, 29, MainSizeX, 5, 787, 912)		-- ������ �̸� �ؿ� ��

	-- ������ ���
	if tWeardCostumTTInfo[19] ~= 0 then
		drawer:setFontc(g_STRING_FONT_GULIMCHE, 11)
		drawer:drawTexture("UIData/powerup.tga", 1, 1, 29, 16, tGradeTexTable[tWeardCostumTTInfo[19]], 486)			-- ������ �̹���
		drawer:setTextColor(tGradeTextColorTable[tWeardCostumTTInfo[19]][1],
							tGradeTextColorTable[tWeardCostumTTInfo[19]][2],
							tGradeTextColorTable[tWeardCostumTTInfo[19]][3], 255)
		local Size = GetStringSize(g_STRING_FONT_GULIM, 11, "+"..tWeardCostumTTInfo[19])
		drawer:drawText("+"..tWeardCostumTTInfo[19], 5, 5)		
	end

	--=================
	-- ������ �̸�
	drawer:setTextColor(255,190,62,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	local nameAdjust = SummaryString(g_STRING_FONT_GULIMCHE, 12, tWeardCostumTTInfo[1], 200)
	local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, nameAdjust)
	drawer:drawText(nameAdjust, 118 - Size/2, 13)
	

	--=================
	-- ������ ����
	FirstPosY = 39
	LineCount = 0
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term, 787, 952)
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)

	local LevelDown		= GetLevelDownBuff()
	local StrLevelDown	= ""
	local StrPosX		= 55

	if LevelDown == -1 then
		if ItemLevel < 1 then
			tWeardCostumTTInfo[3] = "-"
		else
			tWeardCostumTTInfo[3] = "Level. "..ItemLevel
		end
	elseif LevelDown == 1 then
		if (ItemLevel-5) < 1 then
			tWeardCostumTTInfo[3] = "-"
		else
			StrPosX = 30
			tWeardCostumTTInfo[3] = "Level. "..(ItemLevel-5)
			StrLevelDown = " ( "..ItemLevel.." - 5 )"
		end
	elseif LevelDown == 2 then
		if (ItemLevel-10) < 1 then
			tWeardCostumTTInfo[3] = "-"
		else
			StrPosX = 30
			tWeardCostumTTInfo[3] = "Level. "..(ItemLevel-10)
			StrLevelDown = " ( "..ItemLevel.." - 10 )"
		end
	end

	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tWeardCostumTTInfo[3])
	drawer:drawText(tWeardCostumTTInfo[3], StrPosX - Size/2, FirstPosY+(LineCount*Term))

	drawer:setTextColor(255,0,0,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, StrLevelDown)
	drawer:drawText(StrLevelDown, 83 - Size/2, FirstPosY+(LineCount*Term))
	
	--=================
	-- ������ ���
	local color = tGradeColorTable[tWeardCostumTTInfo[4]]
	drawer:setTextColor(color[1],color[2],color[3],255)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tGradeStringTable[tWeardCostumTTInfo[4]])
	drawer:drawText(tGradeStringTable[tWeardCostumTTInfo[4]], 175 - Size/2, FirstPosY+(LineCount*Term))
	
	LineCount = LineCount+1
	
	
	--=================	
	-- ������ ��Ÿ��
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term, 787, 952)
	drawer:setTextColor(255,255,255,255)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tWeardCostumTTInfo[5])
	drawer:drawText(tWeardCostumTTInfo[5], 54 - Size/2, FirstPosY+(LineCount*Term))
	
	
	--=================
	-- ���� �Ⱓ
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tWeardCostumTTInfo[8])
	drawer:drawText(tWeardCostumTTInfo[8], 173 - Size/2, FirstPosY+(LineCount*Term))	
	
	LineCount = LineCount+1


	--=================	
	-- ��밡�� / ���Ұ�
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term, 787, 952)
	local useString = ""
	if tWeardCostumTTInfo[10] == 0 then
		drawer:setTextColor(255,28,20,255)
		useString = PreCreateString_2280
	else
		drawer:setTextColor(255,255,255,255)
		useString = PreCreateString_2276
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, useString)
	drawer:drawText(useString, 54 - Size/2, FirstPosY+(LineCount*Term))


	--=================	
	-- �ŷ����� / �ŷ��Ұ�
	local tradeString = "";
	if tWeardCostumTTInfo[9] == 0 then
		drawer:setTextColor(255,28,20,255)
		tradeString = PreCreateString_2281
	else
		drawer:setTextColor(255,255,255,255)
		tradeString = PreCreateString_2277
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tradeString)
	drawer:drawText(tradeString, 173 - Size/2, FirstPosY+(LineCount*Term))
	
	LineCount = LineCount + 1
	
	
	--=================	
	-- �����ۼ���
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term*3, 787, 952)
	drawer:setTextColor(7,150,252,255)
	local aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, tWeardCostumTTInfo[2], 200)
	drawer:drawText(aa, 12, FirstPosY+(LineCount*Term))
	LineCount = LineCount + 3
	
	
	--=================		
	-- ������ �ڽ�Ƭ �ƹ�Ÿ�� ���� �̹��� �׸��� ��
	if IsKoreanLanguage() == false then
		if tWeardCostumeTTAddInfo[2] == 1 then
			
			-- 1. ������ �׸���
			drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term*3, 787, 952)
			
			-- 2. �ؽ�Ʈ�� ���´�.
			drawer:setTextColor(7,150,252,255)
			local aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, g_STRING_TOOLTIP_MESSAGE, 200)
			drawer:drawText(aa, 12, FirstPosY+(LineCount*Term))
			LineCount = LineCount+2
				
			-- 1. ������ �׸���
			drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term*3, 787, 952)						
							
			-- 2. �׵θ��� �׸���																						--texpos --������180/180 --����255
			drawer:drawTextureWithScale_Angle_Offset("UIData/match002.tga", 50, FirstPosY+(LineCount*Term+10), 48, 48  ,   667, 742 ,   380, 380, 255, 0, 8, 0,0)
			
			-- 3. �ƹ�Ÿ �̹����� �׸���.
			drawer:drawTextureWithScale_Angle_Offset(tWeardCostumeTTAddInfo[1] , 98, FirstPosY+(LineCount*Term+10), 536, Term*5, 0, 0 ,   180, 180, 255, 0, 8, 0,0)

			LineCount = LineCount + 3
		end
	end
	
	
	--=================
	-- �������
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term*2, 787, 952)
	drawer:setTextColor(226,1,255,255)
	if tWeardCostumTTInfo[17] == 0 then
		aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, PreCreateString_2495.." : "..tWeardCostumTTInfo[11], 200)
	else
		aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, PreCreateString_2496.." : "..tWeardCostumTTInfo[11], 200)
	end
	drawer:drawText(aa, 12, FirstPosY+(LineCount*Term)+10)
	
	LineCount = LineCount+2
	
	ysize = FirstPosY+(LineCount*Term)
	drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 10, 787, 952)
	ysize = ysize + 10	-- ����


	--=================
	-- ����
	drawer:setTextColor(253,199,2,255)
	local StatCount = 0
	for i = 1, #WearedtStatString do
		StatCount = StatCount + 1
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize + (i-1)*20, MainSizeX, Term, 787, 952)
		drawer:drawText(WearedtStatString[i], 12, ysize + (i-1)*20)
		--DebugStr("WearedtStatString[i] : " .. WearedtStatString[i]) 
	end
	if StatCount > 0 then
		ysize = ysize + (StatCount-1)*20 + 20
	end
	
	drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 10, 787, 952)
	ysize = ysize + 10	-- ����
	
	
	--=================
	-- ���Ƚ�
	local HotfixCount = 0
	drawer:setTextColor(38,255,86,255)
	
	for i = 1, #tWearedHotfixInfoTable do
		
		if tWearedHotfixInfoTable[i][ITEM_CHECK] == true then
			DebugStr("Hotfix2")
			drawer:drawTexture("UIData/skillitem001.tga", 0, ysize + (i-1)*20, MainSizeX, Term, 787, 952)
			drawer:drawTextureSA("UIData/ItemUIData/" .. tWearedHotfixInfoTable[i][ITEM_FILENAME], 3, ysize + (i-1)*Term - 4,   100, 100,   0, 0,   50, 50,   255, 0, 0);
			drawer:drawText(tWearedHotfixInfoTable[i][ITEM_NAME] .. " (" .. tWearedHotfixInfoTable[i][ITEM_STATSTR] .. ")", 22, ysize + (i-1)*Term)
			HotfixCount = HotfixCount + 1		
		end
	end
	if HotfixCount > 0 then
		ysize = ysize + (HotfixCount-1)*20 + 20
	end
	
	--=================
	-- ��Ʈ �κ� ������
	if tWeardCostumTTInfo[15] == 1 then
		drawer:setFont(g_STRING_FONT_GULIMCHE, 11)
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, Term, 787, 952)
		local String = string.format(PreCreateString_2360, SetCurrentCount, SetTotalCount)
		drawer:drawText("# "..String, 10, ysize)		
		ysize = ysize + Term	-- ����	
		
		local SetNameCount = 0
		for i=0, #tSetNameString do
			if tSetNameString[i] == "" then
				break
			end
			SetNameCount = SetNameCount + 1
		end
		
		-- ����� ���Դٸ�
		if SetNameCount ~= 0 then
			for i=0, SetNameCount-1 do				
				drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15, 787, 952)
				if tbSetNameCheck[i] then
					-- �԰��ִ� ������ : �����
					drawer:setTextColor(255,198,30,255)	
				else
					-- ���� ������ : ȸ��
					drawer:setTextColor(120,120,120,255)	
				end
				drawer:drawText(tSetNameString[i], 10, ysize)
				ysize = ysize + 15	-- ����

			end
			drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15, 787, 952)
			ysize = ysize + 15	-- ����
			for i=0, #tSetEffectString do
				if tSetEffectString[i] == "" then
					break
				end
				drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15, 787, 952)
				if tbSetEffectcheck[i] then
					drawer:setTextColor(255,198,30,255)	
				else
					drawer:setTextColor(120,120,120,255)	
				end
				drawer:drawText(tSetEffectString[i], 10, ysize)
				ysize = ysize + 15	-- ����
			end	
		end
	end
	
	
	--======================================
	-- �������ϳ��� �پ��ִ� ȿ��
	if HaveItemState2 > 0 then
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15 * HaveItemState2, 787, 952)
		drawer:setTextColor(255,198,30,255)	
		drawer:drawText(ItemState2_String, 10, ysize)
		ysize = ysize + (15 * HaveItemState2)
	end

	if HaveAddSkill > 0 then
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15 * HaveAddSkill, 787, 952)
		drawer:setTextColor(255,198,30,255)	
		drawer:drawText(AddSkill_String, 10, ysize)
		ysize = ysize + (15 * HaveAddSkill)
	end

	drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 10, 787, 952)
	ysize = ysize + 10	-- ����

	
	--===================================================
	-- ���� ����Ƚ��(�����Ұ�) : ���Ϲ��� ��� / ORB
	drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, Term, 787, 952)
	drawer:setTextColor(255,255,255,255)
	local String = ""
	
	if IsThaiLanguage() then
		if tWeardCostumTTInfo[6] == 0 or tWeardCostumTTInfo[12] ~= -1 then
			-- enum : ���� �Ұ�				PreCreateString_2139
			String = PreCreateString_2139
		else
			-- enum : ORB ���� ���� Ƚ��	PreCreateString_2080
			String = PreCreateString_2080.." ( "..tWeardCostumTTInfo[7].." / "..tWeardCostumTTInfo[6].." )"
		end
		Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, String)
		drawer:drawText(String, 118 - Size/2, ysize)
		if tWeardCostumTTInfo[14] == 1 then
			drawer:setTextColor(255,255,0,255)
			ysize = ysize+Term
			drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, Term, 787, 952)
			Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "( "..PreCreateString_2329.." )")
			drawer:drawText("( "..PreCreateString_2329.." )", 118 - Size/2, ysize) -- ĳ���� �������� ���氡��(PreCreateString_2329)
			LineCount = LineCount+1
		end	
	end	
	
	drawer:drawTextureA("UIData/skillitem001.tga", 0, ysize+Term, MainSizeX, 5, 787, 1018, 255)	-- ����
end


--------------------------------------------------------------------
-- ������ �� �������� �������ش�.
-- ������ �ʿ��� �ӽ÷� ���� �Լ� ��
--------------------------------------------------------------------
function SettingWearedToolTipValue( name, desc, bonetype, remaintime, level, grade, attach, time, kind, tooltiptype, 
									promotion, skillgrade, maxreform, currentreform, giftable, 
									tradeable, usable, propindex, AdapterAble, bSetParts, bEffectItem, itemtypeValue,
									AddSkillCount, attributeType, style, EventString, UiFileName, IScostumeavatar)
	DebugStr("SettingWearedToolTipValue")
	if kind == KIND_COSTUM then
		tWeardCostumeTTAddInfo[1] = UiFileName	-- ui fileName ���� ��
		tWeardCostumeTTAddInfo[2] = IScostumeavatar -- 1�̸� �ڽ�Ƭ �ƹ�Ÿ , 0�̸� �Ϲݾƹ�Ÿ ��
		
		tWeardCostumTTInfo[1] = name
		tWeardCostumTTInfo[2] = desc
		--DebugStr("desc" .. desc)
	
		ItemLevel = level
		
		tWeardCostumTTInfo[4]  = grade
		tWeardCostumTTInfo[5]  = bonetype
		tWeardCostumTTInfo[6]  = maxreform
		tWeardCostumTTInfo[7]  = currentreform
		tWeardCostumTTInfo[8]  = remaintime
		tWeardCostumTTInfo[9]  = tradeable
		tWeardCostumTTInfo[10] = usable
		tWeardCostumTTInfo[11] = ""
		tWeardCostumTTInfo[12] = time
		tWeardCostumTTInfo[13] = giftable
		tWeardCostumTTInfo[14] = AdapterAble
		tWeardCostumTTInfo[15] = bSetParts
		tWeardCostumTTInfo[16] = bEffectItem
		tWeardCostumTTInfo[17] = itemtypeValue
		tWeardCostumTTInfo[18] = AddSkillCount
		tWeardCostumTTInfo[19] = skillgrade
		
		local Attach = attach
		
		for i = #tCostumAttachTable, 1, -1 do
			if Attach >= tCostumAttachTable[i] then
				
				if tWeardCostumTTInfo[11] == "" then
					tWeardCostumTTInfo[11] = tCostumKind[i] -- tCostumKind : ��Ʈ���� �������!
				else
					tWeardCostumTTInfo[11] = tCostumKind[i]..", " .. tWeardCostumTTInfo[11]
				end
				
				Attach = Attach - tCostumAttachTable[i]
			end
		end
		
		-- ���� �˾ƿ�,
		GetTotalWearedStat();
		
		-- ���Ƚ� ���� ��
		GetHotfixWearedStat();
		
		-- ��Ʈ �������̸� bSetParts
		if tWeardCostumTTInfo[15] == 1 then
			GetWearedSetPartsInfo() -- ������ ������ �ʾ���.
		end
				
		-- �ΰ� ���ݿ� ���� ���� �˾ƿ´�.
		GetWeardItemState2Info()
		WearedLineCount = WearedLineCount + tWeardCostumTTInfo[16]
		
		GetWeardAddSkillInfo()
		WearedLineCount = WearedLineCount + tWeardCostumTTInfo[18]
		
		if tooltiptype ~= TYPE_SHOP then
			DebugStr("tooltiptype�� ���� �ƴϴ�")
			
			SetWearedHotfixItemNumber()
		else
			--WearedLineCount = WearedLineCount + 7
		end
	end
	
	WearedToolTipType		= tooltiptype;
	WearedSelectItem_kind	= kind
	
	if tooltiptype == TYPE_SHOP then
		--tPriceInfoTable = {['err'] = 0, [0]={['err'] = 0, [0]= false}, {['err'] = 0, [0]= false}, {['err'] = 0, [0]= false}}
	end
end



--------------------------------------------------------------------
-- ���� 2���� ������ ���������� �˾Ƴ���.(+�� ���ݱ���.)
--------------------------------------------------------------------
function GetTotalWearedStat()
	local AtkStr, AtkGra, Cri, Hp, Sp, DefStr, DefGra,TeamA, DoubleA, SpecialA, TeamD, DoubleD, SpecialD, CriDmg = GetWearedItemStatInfo()
	local AddAtkStr, AddAtkGra, AddCri, AddHp, AddSp, AddDefStr, AddDefGra, AddTeamA, AddDoubleA, AddSpecialA, AddTeamD, AddDoubleD, AddSpecialD, AddCriDmg = GetWearedItemAddStatInfo()
	local RStr, RGra, RCri, RHp, RSp, RDefStr, RDefGra, RTeamA, RDoubleA, RSpecialA, RTeamD, RDoubleD, RSpecialD, RCriDmg = GetWearedRandomStatInfo()
	local AllAtkValue, AllDefValue = GetWearedUpgradeStatInfo()
	
	
	WearedTotalStatInfo[1] = AtkStr + RStr
	WearedTotalStatInfo[2] = AtkGra + RGra
	WearedTotalStatInfo[3] = Cri + RCri
	WearedTotalStatInfo[4] = Hp + RHp
	WearedTotalStatInfo[5] = Sp + RSp
	WearedTotalStatInfo[6] = DefStr + RDefStr
	WearedTotalStatInfo[7] = DefGra + RDefGra
	WearedTotalStatInfo[8]  = TeamA + RTeamA
	WearedTotalStatInfo[9]  = DoubleA + RDoubleA
	WearedTotalStatInfo[10] = SpecialA + RSpecialA
	WearedTotalStatInfo[11] = TeamD + RTeamD
	WearedTotalStatInfo[12] = DoubleD + RDoubleD
	WearedTotalStatInfo[13] = SpecialD + RSpecialD
	WearedTotalStatInfo[14] = CriDmg + RCriDmg
	
	
	WearedAddStatInfo[1] = AddAtkStr
	WearedAddStatInfo[2] = AddAtkGra
	WearedAddStatInfo[3] = AddCri
	WearedAddStatInfo[4] = AddHp
	WearedAddStatInfo[5] = AddSp
	WearedAddStatInfo[6] = AddDefStr
	WearedAddStatInfo[7] = AddDefGra
	WearedAddStatInfo[8]  = AddTeamA
	WearedAddStatInfo[9]  = AddDoubleA
	WearedAddStatInfo[10] = AddSpecialA
	WearedAddStatInfo[11] = AddTeamD
	WearedAddStatInfo[12] = AddDoubleD
	WearedAddStatInfo[13] = AddSpecialD
	WearedAddStatInfo[14] = AddCriDmg


	WearedUpgradeStatInfo[1] = AllAtkValue
	WearedUpgradeStatInfo[2] = AllDefValue
	

	WearedtStatString = {['err'] = 0, }	-- �ʱ�ȭ
	local Index = 1
	local MainYCount = 0
	
	
	for i = 1, #WearedTotalStatInfo do
		if WearedTotalStatInfo[i] > 0 then
			if i == 3  or i == 14 then
				local aa = WearedTotalStatInfo[i] / 10
				local bb = WearedTotalStatInfo[i] % 10
				WearedTotalStatInfo[i] = tostring(aa).."."..bb
			end
			
			WearedtStatString[Index] = tStatNameText[i].." +"..WearedTotalStatInfo[i]
			
			MainSizeY = 175 + (i-1)*20 + 15	-- ������ ��ġ
			Index = Index + 1
		end
	end
	
	for i = 1, #WearedUpgradeStatInfo do
		if 0 < WearedUpgradeStatInfo[i] then
			WearedtStatString[Index] = tUpgradeStatNameText[i].." +"..WearedUpgradeStatInfo[i]
			--MainSizeY = 175 + (i-1)*20 + 15	-- ������ ��ġ
			Index = Index + 1
		elseif 0 > WearedUpgradeStatInfo[i] then
			WearedtStatString[Index] = tUpgradeStatNameText[i].." "..WearedUpgradeStatInfo[i]
			--MainSizeY = 175 + (i-1)*20 + 15	-- ������ ��ġ
			Index = Index + 1
		else
			
		end
	end


	WearedLineCount = Index
end

function GetHotfixWearedStat()
	local AtkStr, AtkGra, Cri, Hp, Sp, DefStr, DefGra,TeamA, DoubleA, SpecialA, TeamD, DoubleD, SpecialD, CriDmg = GetWearedItemStatInfo()

	WearedTotalStatInfo[1] = AtkStr
	WearedTotalStatInfo[2] = AtkGra
	WearedTotalStatInfo[3] = Cri
	WearedTotalStatInfo[4] = Hp
	WearedTotalStatInfo[5] = Sp
	WearedTotalStatInfo[6] = DefStr
	WearedTotalStatInfo[7] = DefGra
	WearedTotalStatInfo[8]  = TeamA
	WearedTotalStatInfo[9]  = DoubleA
	WearedTotalStatInfo[10] = SpecialA
	WearedTotalStatInfo[11] = TeamD
	WearedTotalStatInfo[12] = DoubleD
	WearedTotalStatInfo[13] = SpecialD
	WearedTotalStatInfo[14] = CriDmg	
	
	-- From Jiyuu
	WearedHotfixStat = {['err'] = 0, }	-- �ʱ�ȭ
	-- End of Jiyuu
	
	local WearedHotfixStatCnt = 1;
	for i = 1, #WearedTotalStatInfo do
		if WearedTotalStatInfo[i] > 0 then
			if i == 3  or i == 14 then
				local aa = WearedTotalStatInfo[i] / 10
				local bb = WearedTotalStatInfo[i] % 10
				WearedTotalStatInfo[i] = tostring(aa).."."..bb				
			end
			
			-- From Jiyuu
			--WearedHotfixStat = tStatNameText[i].." +"..WearedTotalStatInfo[i]
			--return
			WearedHotfixStat[WearedHotfixStatCnt] = tStatNameText[i].." +"..WearedTotalStatInfo[i]
			-- End of Jiyuu
			WearedHotfixStatCnt = WearedHotfixStatCnt + 1;
			
		end
	end
end




--------------------------------------------------------------------
-- ������ �� �������� �������ش�.
--------------------------------------------------------------------
function SettingToolTiValue(name, desc, bonetype, remaintime, level, grade, attach, time, kind, tooltiptype, 
							promotion, skillgrade, maxreform, currentreform, giftable, 
							tradeable, usable, propindex, AdapterAble, bSetParts, bEffectItem, itemtypeValue,
							AddSkillCount, attributeType, style, EventString, UiFileName, IScostumeavatar)
	DebugStr("SettingToolTiValue")
	if kind == KIND_COSTUM then
		tCostumeTTAddInfo[1] = UiFileName	-- ui fileName ���� ��
		tCostumeTTAddInfo[2] = IScostumeavatar -- 1�̸� �ڽ�Ƭ �ƹ�Ÿ , 0�̸� �Ϲݾƹ�Ÿ ��
		
		tCostumTTInfo[1]  = name
		tCostumTTInfo[2]  = desc
		ItemLevel = level
		if level < 1 then
			tCostumTTInfo[3] = "-"
		else
			tCostumTTInfo[3]  = "Level."..level
		end
		tCostumTTInfo[4]  = grade
		tCostumTTInfo[5]  = bonetype
		tCostumTTInfo[6]  = maxreform
		tCostumTTInfo[7]  = currentreform
		tCostumTTInfo[8]  = remaintime
		tCostumTTInfo[9]  = tradeable
		tCostumTTInfo[10] = usable
		tCostumTTInfo[11] = ""
		tCostumTTInfo[12] = time
		tCostumTTInfo[13] = giftable
		tCostumTTInfo[14] = AdapterAble
		tCostumTTInfo[15] = bSetParts
		tCostumTTInfo[16] = bEffectItem
		tCostumTTInfo[17] = itemtypeValue
		tCostumTTInfo[18] = AddSkillCount
		tCostumTTInfo[19] = skillgrade
		
		local Attach = attach
		
		for i = #tCostumAttachTable, 1, -1 do
			if Attach >= tCostumAttachTable[i] then
				if tCostumTTInfo[11] == "" then
					tCostumTTInfo[11] = tCostumKind[i]
				else
					tCostumTTInfo[11] = tCostumKind[i]..", "..tCostumTTInfo[11]
				end
				Attach	= Attach - tCostumAttachTable[i]
			end
		end		
		
		GetTotalStat()			-- ���� �˾ƿ�,
		if tCostumTTInfo[15] == 1 then
			GetSetPartsInfo()
		end
		-- �ΰ� ���ݿ� ���� ���� �˾ƿ´�.
		GetItemState2Info()
		LineCount = LineCount + tCostumTTInfo[16]
		GetAddSkillInfo()
		LineCount = LineCount + tCostumTTInfo[18]
		if tooltiptype ~= TYPE_SHOP then
			SetHotfixItemNumber()	-- 
		else
			SetHotfixItemNumber()
			--LineCount = LineCount + 7
		end
		
		--DebugStr("SettingToolTiValueEnd")
	elseif kind == KIND_SKILL then
		tSkillTTInfo[1]  = name
		tSkillTTInfo[3], tSkillTTInfo[2] = SkillDescDivide(desc)	-- ��Ʈ�� �ɰ��� ����.
		if level < 1 then
			tSkillTTInfo[4] = "-"
		else
			tSkillTTInfo[4]  = "Level."..level
		end		
		tSkillTTInfo[5]  = promotion
		tSkillTTInfo[6]  = skillgrade
		tSkillTTInfo[7]  = remaintime
		tSkillTTInfo[8]  = attach		-- Ŀ�ǵ�
		tSkillTTInfo[9]  = tradeable
		tSkillTTInfo[10] = usable
		tSkillTTInfo[11] = 0		-- 
		tSkillTTInfo[12] = giftable		-- 
		tSkillTTInfo[13] = propindex
		tSkillTTInfo[14] = AdapterAble
		tSkillTTInfo[15] = attributeType
		tSkillTTInfo[16] = style
		
		--DebugStr("tradeable : " .. tradeable)
		
		
	elseif kind == KIND_ITEM or kind == KIND_ORB then
		tItemTTInfo[1] = name
		local aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, desc, 200)
		if style == ITEMKIND_TITLE or style == ITEMKIND_RIDE then
			local bb = AdjustString(g_STRING_FONT_GULIMCHE, 12, bonetype, 200)
			tItemTTInfo[2] = aa.."\n"..bb
		else
			tItemTTInfo[2] = aa
		end	
		if level < 1 then
			tItemTTInfo[3] = "-"
		else
			tItemTTInfo[3]  = "Level."..level
		end		
		tItemTTInfo[4] = remaintime
		tItemTTInfo[5] = tradeable
		tItemTTInfo[6] = usable
		tItemTTInfo[7] = giftable
		tItemTTInfo[8] = AdapterAble
		if EventString ~= "" then
			tItemTTInfo[9] = AdjustString(g_STRING_FONT_GULIMCHE, 12, EventString, 200)
		else
			tItemTTInfo[9] = ""
		end
		
		
		GetHotfixStat()
	end
	ToolTipType = tooltiptype;
	SelectItem_kind = kind
	if tooltiptype == TYPE_SHOP then
		tPriceInfoTable = {['err'] = 0, [0]={['err'] = 0, [0]= false}, {['err'] = 0, [0]= false}, {['err'] = 0, [0]= false}}
	end
end



--------------------------------------------------------------------
-- ���������� �˾Ƴ���.(+�� ���ݱ���.)
--------------------------------------------------------------------
function GetTotalStat()
	local AtkStr, AtkGra, Cri, Hp, Sp, DefStr, DefGra,TeamA, DoubleA, SpecialA, TeamD, DoubleD, SpecialD, CriDmg = GetItemStatInfo()
	local AddAtkStr, AddAtkGra, AddCri, AddHp, AddSp, AddDefStr, AddDefGra, AddTeamA, AddDoubleA, AddSpecialA, AddTeamD, AddDoubleD, AddSpecialD, AddCriDmg = GetItemAddStatInfo()
	local RStr, RGra, RCri, RHp, RSp, RDefStr, RDefGra, RTeamA, RDoubleA, RSpecialA, RTeamD, RDoubleD, RSpecialD, RCriDmg = GetRandomStatInfo()
	local AllAtkValue, AllDefValue = GetUpgradeStatInfo()
	
	
	TotalStatInfo[1] = AtkStr + RStr
	TotalStatInfo[2] = AtkGra + RGra
	TotalStatInfo[3] = Cri + RCri
	TotalStatInfo[4] = Hp + RHp
	TotalStatInfo[5] = Sp + RSp
	TotalStatInfo[6] = DefStr + RDefStr
	TotalStatInfo[7] = DefGra + RDefGra
	TotalStatInfo[8]  = TeamA + RTeamA
	TotalStatInfo[9]  = DoubleA + RDoubleA
	TotalStatInfo[10] = SpecialA + RSpecialA
	TotalStatInfo[11] = TeamD + RTeamD
	TotalStatInfo[12] = DoubleD + RDoubleD
	TotalStatInfo[13] = SpecialD + RSpecialD
	TotalStatInfo[14] = CriDmg + RCriDmg
	
	
	AddStatInfo[1] = AddAtkStr
	AddStatInfo[2] = AddAtkGra
	AddStatInfo[3] = AddCri
	AddStatInfo[4] = AddHp
	AddStatInfo[5] = AddSp
	AddStatInfo[6] = AddDefStr
	AddStatInfo[7] = AddDefGra
	AddStatInfo[8]  = AddTeamA
	AddStatInfo[9]  = AddDoubleA
	AddStatInfo[10] = AddSpecialA
	AddStatInfo[11] = AddTeamD
	AddStatInfo[12] = AddDoubleD
	AddStatInfo[13] = AddSpecialD
	AddStatInfo[14] = AddCriDmg


	UpgradeStatInfo[1] = AllAtkValue
	UpgradeStatInfo[2] = AllDefValue
	

	tStatString = {['err'] = 0, }	-- �ʱ�ȭ
	local Index = 1
	local MainYCount = 0
	
	for i = 1, #TotalStatInfo do
		if TotalStatInfo[i] > 0 then
			if i == 3  or i == 14 then
				local aa = TotalStatInfo[i] / 10
				local bb = TotalStatInfo[i] % 10
				TotalStatInfo[i] = tostring(aa).."."..bb				
			end
			tStatString[Index] = tStatNameText[i].." +"..TotalStatInfo[i]
		--	if AddStatInfo[i] > 0 then
		--		if i == 3 then
		--			local aa	= AddStatInfo[i] / 10
		--			local bb	= AddStatInfo[i] % 10
		--			AddStatInfo[i] = tostring(aa).."."..bb
		--		end
		--		tStatString[Index] = tStatString[Index].." (+"..AddStatInfo[i]..")"
		--	end
			MainSizeY = 175 + (i-1)*20 + 15	-- ������ ��ġ
			Index = Index + 1
		end
	end
	
	for i = 1, #UpgradeStatInfo do
		if 0 < UpgradeStatInfo[i] then
			tStatString[Index] = tUpgradeStatNameText[i].." +"..UpgradeStatInfo[i]
			--MainSizeY = 175 + (i-1)*20 + 15	-- ������ ��ġ
			Index = Index + 1
		elseif 0 > UpgradeStatInfo[i] then
			tStatString[Index] = tUpgradeStatNameText[i].." "..UpgradeStatInfo[i]
			--MainSizeY = 175 + (i-1)*20 + 15	-- ������ ��ġ
			Index = Index + 1
		else
			
		end
	end
--[[	
	for i = 1, #RandomStatInfo do
		if RandomStatInfo[i] > 0 then
			if i == 3 then
				local aa = RandomStatInfo[i] / 10
				local bb = RandomStatInfo[i] % 10
				RandomStatInfo[i] = tostring(aa).."."..bb				
			end
			tStatString[Index] = "Random : "..tStatNameText[i].." +"..RandomStatInfo[i]

			Index = Index + 1
		end
	end	
--]]
	LineCount = Index
	
end

function GetHotfixStat()
	local AtkStr, AtkGra, Cri, Hp, Sp, DefStr, DefGra,TeamA, DoubleA, SpecialA, TeamD, DoubleD, SpecialD, CriDmg = GetItemStatInfo()

	TotalStatInfo[1] = AtkStr
	TotalStatInfo[2] = AtkGra
	TotalStatInfo[3] = Cri
	TotalStatInfo[4] = Hp
	TotalStatInfo[5] = Sp
	TotalStatInfo[6] = DefStr
	TotalStatInfo[7] = DefGra
	TotalStatInfo[8]  = TeamA
	TotalStatInfo[9]  = DoubleA
	TotalStatInfo[10] = SpecialA
	TotalStatInfo[11] = TeamD
	TotalStatInfo[12] = DoubleD
	TotalStatInfo[13] = SpecialD
	TotalStatInfo[14] = CriDmg	
	
	-- From Jiyuu
	HotfixStat = {['err'] = 0, }	-- �ʱ�ȭ
	local HotfixStatCnt = 1;
	for i = 1, #TotalStatInfo do
		if TotalStatInfo[i] > 0 then
			if i == 3  or i == 14 then
				local aa = TotalStatInfo[i] / 10
				local bb = TotalStatInfo[i] % 10
				TotalStatInfo[i] = tostring(aa).."."..bb				
			end
			--HotfixStat = tStatNameText[i].." +"..TotalStatInfo[i]
			HotfixStat[HotfixStatCnt] = tStatNameText[i].." +"..TotalStatInfo[i]
			HotfixStatCnt = HotfixStatCnt + 1;
		end
	end
end



function GetPriceInfo(Index, State, Saleprice, ProductPrice, productNo, paymenttype, Period)
	
	if Index < 0 or Index > #tPriceInfoTable then
		return
	end	
--	local tStateStringTable = {['err'] = 0, [0]="Sale", "Hot", "New"}
--	local tStateCheck		= {['err'] = 0, [0]=false, false, false}

	for i = 0, #tStateIndex do
		tStateCheck[i] = GetPurchaseStateTooltip(productNo, tStateIndex[i])
	end
	
	
	tPriceInfoTable[Index][PRICE_BCHECK]		= true
	tPriceInfoTable[Index][PRICE_STATE]			= State 
	tPriceInfoTable[Index][PRICE_SALEPRICE]		= Saleprice
	tPriceInfoTable[Index][PRICE_PRODUCTPRICE]	= ProductPrice
	tPriceInfoTable[Index][PRICE_PERIOD]		= Period
	tPriceInfoTable[Index][PRICE_PRODUCTNO]		= productNo
	tPriceInfoTable[Index][PRICE_PAYMENTTYPE]	= paymenttype
	
	if IsKoreanLanguage() then
		tStateCheck[3] = false
		tStateCheck[4] = false
	end	
end



-- ��Ʈ�� ���õ� �������� �˾ƿ´�.
function GetSetPartsInfo()
	local count = 0
	
	for i=0, #tSetNameString do
		tSetNameString[i], tbSetNameCheck[i] = GetSetPartsItemNameString(i)
		if tSetNameString[i] == "" then
			break;	
		end
		count = count + 1
	end
	
	for i=0, #tSetEffectString do
		tSetEffectString[i], tbSetEffectcheck[i] = GetSetPartsItemEffectString(i)
		if tSetEffectString[i] == "" then
			break;	
		end
		count = count + 1
	end
	
	SetCurrentCount, SetTotalCount = GetPartsCount()
	LineCount = LineCount + count
end

-- 2�� ���� - ��Ʈ�� ���õ� �������� �˾ƿ´�.
function GetWearedSetPartsInfo()
	local count = 0
	
	for i=0, #tSetNameString do
		tSetNameString[i], tbSetNameCheck[i] = GetSetPartsItemNameString(i)
		if tSetNameString[i] == "" then
			break;	
		end
		count = count + 1
	end
	
	for i=0, #tSetEffectString do
		tSetEffectString[i], tbSetEffectcheck[i] = GetSetPartsItemEffectString(i)
		if tSetEffectString[i] == "" then
			break;	
		end
		count = count + 1
	end
	
	SetCurrentCount, SetTotalCount = GetWearedPartsCount()
	WearedLineCount = WearedLineCount + count
end


-- �������� Ư��ȿ���� �ִ��� Ȯ���Ѵ�.
function GetItemState2Info()
	HaveItemState2, ItemState2_String = GetPieceItemEffectString()	
end

-- �������� Ư��ȿ���� �ִ��� Ȯ���Ѵ�.
function GetAddSkillInfo()
	HaveAddSkill, AddSkill_String = GetEachAddSkillString()	
end



-- Weard�������� Ư��ȿ���� �ִ��� Ȯ���Ѵ�.
function GetWeardItemState2Info()
	WeardHaveItemState2, WeardItemState2_String = GetWearedPieceItemEffectString()	
end

-- Weard�������� Ư��ȿ���� �ִ��� Ȯ���Ѵ�.
function GetWeardAddSkillInfo()
	WeardHaveAddSkill, WeardAddSkill_String = GetWearedEachAddSkillString()	
end

--[[
local SetCurrentCount = 0
local SetTotalCount	 = 0
local tSetNameString = {['err']=0, [0]="", "", "", "", "", "", "", "", ""}
local tbSetNameCheck = {['err']=0, [0]=false, false, false, false, false, false, false, false, false}
local tSetEffectString = {['err']=0, [0]="", "", "", "", "", "", "", "", ""}
local tbSetEffectcheck = {['err']=0, [0]=false, false, false, false, false, false, false, false, false}
--]]


--------------------------------------------------------------------
-- ���Ƚ� ������ ��ȣ�� �˾ƿ´�.
--------------------------------------------------------------------
function SetHotfixItemNumber()
	local a,b,c,d,e,f,g,h,i = GetHotfixItemNumber()
	local thotfixNumber = {['err'] = 0, [0]=a,b,c,d,e,f,g,h,i}
	local Index = 1
	
	-- �ʱ�ȭ
	for i = 1, #tHotfixInfoTable do
		tHotfixInfoTable[i] =  {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}		
	end
		
	for i = 0, #thotfixNumber do
		if thotfixNumber[i] ~= 0 then
			tHotfixInfoTable[Index][ITEM_NAME], tHotfixInfoTable[Index][ITEM_FILENAME], 
			tHotfixInfoTable[Index][ITEM_INDEX], tHotfixInfoTable[Index][ITEM_STAT],
			tHotfixInfoTable[Index][ITEM_INDEX2], tHotfixInfoTable[Index][ITEM_STAT2] = GetToolTipHotfixInfo(thotfixNumber[i])
			
			-- ù��° ORB
			if tHotfixInfoTable[Index][ITEM_INDEX] == 3 or tHotfixInfoTable[Index][ITEM_INDEX] == 14 then		-- ũ��Ƽ��
				local aa = tHotfixInfoTable[Index][ITEM_STAT] / 10
				local bb = tHotfixInfoTable[Index][ITEM_STAT] % 10
				local statstring = tostring(aa).."."..bb
				tHotfixInfoTable[Index][ITEM_STATSTR] = tStatNameText[tHotfixInfoTable[Index][ITEM_INDEX]].." +"..statstring
			else
				tHotfixInfoTable[Index][ITEM_STATSTR] = tStatNameText[tHotfixInfoTable[Index][ITEM_INDEX]].." +"..tHotfixInfoTable[Index][ITEM_STAT]
			end
			
			DebugStr(tHotfixInfoTable[Index][ITEM_INDEX2])
			
			-- �ι�° ORBStat
			if tHotfixInfoTable[Index][ITEM_INDEX2] ~= 0 then
				if tHotfixInfoTable[Index][ITEM_INDEX2] == 3 or tHotfixInfoTable[Index][ITEM_INDEX2] == 14 then		-- ũ��Ƽ��
					local cc = tHotfixInfoTable[Index][ITEM_STAT2] / 10
					local dd = tHotfixInfoTable[Index][ITEM_STAT2] % 10
					local statstring2 = tostring(cc).."."..dd
					tHotfixInfoTable[Index][ITEM_STATSTR2] = tStatNameText[tHotfixInfoTable[Index][ITEM_INDEX2]].." +"..statstring2
				else
					tHotfixInfoTable[Index][ITEM_STATSTR2] = tStatNameText[tHotfixInfoTable[Index][ITEM_INDEX2]].." +"..tHotfixInfoTable[Index][ITEM_STAT2]
				end
			end
			
			tHotfixInfoTable[Index][ITEM_CHECK]	  = true
			Index = Index + 1
		end
	end
	LineCount = LineCount + Index
end

function SetWearedHotfixItemNumber()
	local a,b,c,d,e,f,g,h,i = GetWearedHotfixItemNumber()
	local thotfixNumber = {['err'] = 0, [0]=a,b,c,d,e,f,g,h,i}
	local Index = 1
	
	-- �ʱ�ȭ
	for i = 1, #tWearedHotfixInfoTable do
		tWearedHotfixInfoTable[i] =  {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}		
	end
		
	DebugStr("111")
	for i = 0, #thotfixNumber do
		DebugStr("222 : " .. thotfixNumber[i])
		if thotfixNumber[i] ~= 0 then
			DebugStr("333")
			tWearedHotfixInfoTable[Index][ITEM_NAME], tWearedHotfixInfoTable[Index][ITEM_FILENAME], 
			tWearedHotfixInfoTable[Index][ITEM_INDEX], tWearedHotfixInfoTable[Index][ITEM_STAT],
			tWearedHotfixInfoTable[Index][ITEM_INDEX2], tWearedHotfixInfoTable[Index][ITEM_STAT2] = GetToolTipHotfixInfo(thotfixNumber[i])
			
			-- ù��° �ɷ�ġ
			if tWearedHotfixInfoTable[Index][ITEM_INDEX] == 3 or tWearedHotfixInfoTable[Index][ITEM_INDEX] == 14 then		-- ũ��Ƽ��
				DebugStr("444")
				local aa = tWearedHotfixInfoTable[Index][ITEM_STAT] / 10
				local bb = tWearedHotfixInfoTable[Index][ITEM_STAT] % 10
				local statstring = tostring(aa).."."..bb
				tWearedHotfixInfoTable[Index][ITEM_STATSTR] = tStatNameText[tWearedHotfixInfoTable[Index][ITEM_INDEX]].." +"..statstring
				DebugStr("tWearedHotfixInfoTable[Index][ITEM_STATSTR] : " .. tWearedHotfixInfoTable[Index][ITEM_STATSTR])
			else
				tWearedHotfixInfoTable[Index][ITEM_STATSTR] = tStatNameText[tWearedHotfixInfoTable[Index][ITEM_INDEX]].." +"..tWearedHotfixInfoTable[Index][ITEM_STAT]
				DebugStr("222222tWearedHotfixInfoTable[Index][ITEM_STATSTR] : " .. tWearedHotfixInfoTable[Index][ITEM_STATSTR])
			end				
			
			-- �ι�° �ɷ�ġ
			if tWearedHotfixInfoTable[Index][ITEM_INDEX2] ~= 0 then
				if tWearedHotfixInfoTable[Index][ITEM_INDEX2] == 3 or tWearedHotfixInfoTable[Index][ITEM_INDEX2] == 14 then		-- ũ��Ƽ��
					local cc = tWearedHotfixInfoTable[Index][ITEM_STAT2] / 10
					local dd = tWearedHotfixInfoTable[Index][ITEM_STAT2] % 10
					local statstring2 = tostring(cc).."."..dd
					tWearedHotfixInfoTable[Index][ITEM_STATSTR2] = tStatNameText[tWearedHotfixInfoTable[Index][ITEM_INDEX2]].." +"..statstring2
					DebugStr("tWearedHotfixInfoTable[Index][ITEM_STATSTR2] : " .. tWearedHotfixInfoTable[Index][ITEM_STATSTR2])
				else
					tWearedHotfixInfoTable[Index][ITEM_STATSTR2] = tStatNameText[tWearedHotfixInfoTable[Index][ITEM_INDEX2]].." +"..tWearedHotfixInfoTable[Index][ITEM_STAT2]
				end				
			end
			
			tWearedHotfixInfoTable[Index][ITEM_CHECK] = true
			Index = Index + 1
		end
	end

	LineCount = LineCount + Index
end

--------------------------------------------------------------------
-- ����â�� ����ش�.
--------------------------------------------------------------------
function Common_ToolTipShow()
	root:addChildWindow(winMgr:getWindow("Common_ToolTip"))
	winMgr:getWindow("Common_ToolTip"):setVisible(true)	
	winMgr:getWindow("Common_ToolTip"):setPosition(PosX, PosY)
end


--------------------------------------------------------------------
-- �ι��� ����â�� ����ش�.��
--------------------------------------------------------------------
function Common_WearedToolTipShow()
	root:addChildWindow(winMgr:getWindow("Common_WearedToolTip"))
	winMgr:getWindow("Common_WearedToolTip"):setVisible(true)
	winMgr:getWindow("Common_WearedToolTip"):setPosition(WearedPosX, WearedPosY)
end



--------------------------------------------------------------------
-- ���� ����â�� ����� �����ش�
--------------------------------------------------------------------
function GetCommon_ToolTipPos(x, y, WearedX , WearedY, IsCostumeAvatar)
	local sizey = 0
	
	if SelectItem_kind == KIND_COSTUM then
		winMgr:getWindow("Common_ToolTip"):setSize(MainSizeX, 189+(LineCount+1)*20)
	
		local MaxLine = LineCount * 20
	
		-- �ڽ�Ƭ �ƹ�Ÿ
		if IsCostumeAvatar == 1 then
			-- From Jiyuu : ������ ����
			--if y+300+MaxLine > g_CURRENT_WIN_SIZEY then
			--	y = g_CURRENT_WIN_SIZEY - 235 - MaxLine - 100
			if y+190+MaxLine > g_CURRENT_WIN_SIZEY then
				y = g_CURRENT_WIN_SIZEY - 235 - MaxLine 
			end
			
		-- �Ϲ� �ƹ�Ÿ ���
		else
			if y+190+MaxLine > g_CURRENT_WIN_SIZEY then
				y = g_CURRENT_WIN_SIZEY - 235 - MaxLine 
			end
		end
		
	elseif SelectItem_kind == KIND_SKILL then
		if ToolTipType == TYPE_TRADE then
			winMgr:getWindow("Common_ToolTip"):setSize(MainSizeX, 296)
			sizey = 296
		elseif ToolTipType ~= TYPE_SHOP then
			winMgr:getWindow("Common_ToolTip"):setSize(MainSizeX, 431)
			sizey = 431
		else
			winMgr:getWindow("Common_ToolTip"):setSize(MainSizeX, 326)
			sizey = 326
		end		
		if y + sizey > g_CURRENT_WIN_SIZEY then
			y = g_CURRENT_WIN_SIZEY - sizey
		end
	
	elseif SelectItem_kind == KIND_ITEM or SelectItem_kind == KIND_ORB then
		if ToolTipType ~= TYPE_SHOP then
			winMgr:getWindow("Common_ToolTip"):setSize(MainSizeX, 202)
			sizey = 202
		else
			winMgr:getWindow("Common_ToolTip"):setSize(MainSizeX, 222)
			sizey = 222
		end
		
		if y + sizey > g_CURRENT_WIN_SIZEY then
			y = g_CURRENT_WIN_SIZEY - sizey
		end		
	end
	
	-- ���� X�� �����Ǵ� �κ� ����ֱ�
	if x + MainSizeX > g_CURRENT_WIN_SIZEX then
		x = g_CURRENT_WIN_SIZEX - MainSizeX
	end
	
	PosX = x
	PosY = y
	--DebugStr("PosX : " .. PosX);
	--DebugStr("PosY : " .. PosY);
	
	WearedPosX = WearedX + 240;
	WearedPosY = WearedY;
	--DebugStr("WearedPosX : " .. WearedPosX);
	--DebugStr("WearedPosY : " .. WearedPosY);
end

--------------------------------------------------------------------
-- ����â�� �����ش�
--------------------------------------------------------------------
function Common_ToolTipHide()
	winMgr:getWindow("Common_ToolTip"):setVisible(false)
	
	-- �ʱ�ȭ
	for i = 1, #tHotfixInfoTable do
		tHotfixInfoTable[i] =  {['err'] = 0, "", "", 0, 0,"",false}		
	end
end

--------------------------------------------------------------------
-- ����â�� �����ش�
--------------------------------------------------------------------
function Common_WearedToolTipHide()
	winMgr:getWindow("Common_WearedToolTip"):setVisible(false)	-- ��
	
	-- �ʱ�ȭ
	for i = 1, #tHotfixInfoTable do
		tHotfixInfoTable[i] =  {['err'] = 0, "", "", 0, 0,"",false}		
	end
end


--------------------------------------------------------------------
-- ��ų ��Ʈ�� �ɰ��� �����ش�.
--------------------------------------------------------------------
function SkillDescDivide(str)
	local _DescStart	= ""
	local _DescStart2	= ""
	local _DescEnd		= ""
	local _DescEnd2		= ""
	local _SkillKind = "";		--��ų����
	local _DetailDesc = "";		--��ų����
	
	_DescStart, _DescEnd = string.find(str, "%$");
	
	if _DescStart ~= nil then
		_SkillKind = string.sub(str, 1, _DescStart - 1);
		_DetailDesc = string.sub(str, _DescEnd + 1);
		_DescStart2, _DescEnd2 = string.find(_DetailDesc, "%$");
		if _DescStart2 ~= nil then
			_DetailDesc = string.sub(_DetailDesc, _DescEnd2 + 1);
		end
	else
		_DetailDesc = str
	end
	
	return _SkillKind, _DetailDesc
end










-- �ڽ�Ƭ(��) ����
function RenderRoomCostumToolTip(drawer)
	local ysize = 0
	local count = 0
	-- ���(�̸� ��������.)
	drawer:drawTexture("UIData/skillitem001.tga", 0, 0, MainSizeX, 39, 787, 917)
	drawer:drawTexture("UIData/skillitem001.tga", 0, 29, MainSizeX, 5, 787, 912)		-- ������ �̸� �ؿ� ��

--������ ���
	if tCostumTTInfo[19] ~= 0 then
		drawer:setFont(g_STRING_FONT_GULIMCHE, 11)
		drawer:drawTexture("UIData/powerup.tga", 1, 1, 29, 16, tGradeTexTable[tCostumTTInfo[19]], 486)			-- ������ �̹���
		drawer:setTextColor(tGradeTextColorTable[tCostumTTInfo[19]][1],
							tGradeTextColorTable[tCostumTTInfo[19]][2],
							tGradeTextColorTable[tCostumTTInfo[19]][3], 255)
		local Size = GetStringSize(g_STRING_FONT_GULIM, 11, "+"..tCostumTTInfo[19])
		drawer:drawText("+"..tCostumTTInfo[19], 5, 5)		
	end

--=================
-- ������ �̸�
	drawer:setTextColor(255,190,62,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	local nameAdjust = SummaryString(g_STRING_FONT_GULIMCHE, 12, tCostumTTInfo[1], 200)
	local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, nameAdjust)
	drawer:drawText(nameAdjust, 118 - Size/2, 13)
--=================
-- ù��° ��
--=================
--=================
-- ������ ����
FirstPosY = 39
LineCount = 0
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term, 787, 952)
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)

	local LevelDown		= GetLevelDownBuff()
	local StrLevelDown	= ""
	local StrPosX		= 55

	if LevelDown == -1 then
		if ItemLevel < 1 then
			tCostumTTInfo[3] = "-"
		else
			tCostumTTInfo[3] = "Level. "..ItemLevel
		end
	elseif LevelDown == 1 then
		if (ItemLevel-5) < 1 then
			tCostumTTInfo[3] = "-"
		else
			StrPosX = 30
			tCostumTTInfo[3] = "Level. "..(ItemLevel-5)
			StrLevelDown = " ( "..ItemLevel.." - 5 )"
		end
	elseif LevelDown == 2 then
		if (ItemLevel-10) < 1 then
			tCostumTTInfo[3] = "-"
		else
			StrPosX = 30
			tCostumTTInfo[3] = "Level. "..(ItemLevel-10)
			StrLevelDown = " ( "..ItemLevel.." - 10 )"
		end
	end

	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tCostumTTInfo[3])
	drawer:drawText(tCostumTTInfo[3], StrPosX - Size/2, FirstPosY+(LineCount*Term))

	drawer:setTextColor(255,0,0,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, StrLevelDown)
	drawer:drawText(StrLevelDown, 83 - Size/2, FirstPosY+(LineCount*Term))

--=================
-- ������ ���
	local color = tGradeColorTable[tCostumTTInfo[4]]
	
	drawer:setTextColor(color[1],color[2],color[3],255)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tGradeStringTable[tCostumTTInfo[4]])
	drawer:drawText(tGradeStringTable[tCostumTTInfo[4]], 175 - Size/2, FirstPosY+(LineCount*Term))
	
	--=================
	LineCount = LineCount+1
	--=================
	
--=================	
-- ������ ��Ÿ��
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term, 787, 952)
	drawer:setTextColor(255,255,255,255)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tCostumTTInfo[5])
	drawer:drawText(tCostumTTInfo[5], 54 - Size/2, FirstPosY+(LineCount*Term))
	
--=================
-- ���� �Ⱓ
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tCostumTTInfo[8])
	drawer:drawText(tCostumTTInfo[8], 173 - Size/2, FirstPosY+(LineCount*Term))	
		
	--=================
	LineCount = LineCount+1
	--=================
--=================	
-- ��밡��
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term, 787, 952)
	local useString = ""
	if tCostumTTInfo[10] == 0 then
		drawer:setTextColor(255,28,20,255)
		useString = PreCreateString_2280
	else
		drawer:setTextColor(255,255,255,255)
		useString = PreCreateString_2276
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, useString)
	drawer:drawText(useString, 54 - Size/2, FirstPosY+(LineCount*Term))
--=================	
-- �ŷ�����
	local tradeString = "";
	if tCostumTTInfo[9] == 0 then
		drawer:setTextColor(255,28,20,255)
		tradeString = PreCreateString_2281
	else
		drawer:setTextColor(255,255,255,255)
		tradeString = PreCreateString_2277
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tradeString)
	drawer:drawText(tradeString, 173 - Size/2, FirstPosY+(LineCount*Term))
	--=================
	LineCount = LineCount+1
	--=================
	
	-- �����ۼ���
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term*3, 787, 952)
	drawer:setTextColor(7,150,252,255)
	local aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, tCostumTTInfo[2], 200)
	drawer:drawText(aa, 12, FirstPosY+(LineCount*Term))
	--=================
	LineCount = LineCount+3
	--=================
	
	
	------------------------------------------------------
	-- ������ �ڽ�Ƭ �ƹ�Ÿ�� ���� �̹��� �׸��� ��
	------------------------------------------------------
	if IsKoreanLanguage() == false then
		if tCostumeTTAddInfo[2] == 1 then
			
			-- 1. ������ �׸���
			drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term*2, 787, 952)
			
			-- 2. �ؽ�Ʈ�� ���´�.
			drawer:setTextColor(7,150,252,255)
			local aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, g_STRING_TOOLTIP_MESSAGE, 200)
			drawer:drawText(aa, 12, FirstPosY+(LineCount*Term))
			LineCount = LineCount+2
				
			-- 1. ������ �׸���
			drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term, 787, 952)						
							
			-- 2. �׵θ��� �׸���																						--texpos --������180/180 --����255
			--drawer:drawTextureWithScale_Angle_Offset("UIData/match002.tga", 50, FirstPosY+(LineCount*Term+10), 48, 48  ,   667, 742 ,   380, 380, 255, 0, 8, 0,0)
			drawer:drawTextureWithScale_Angle_Offset("UIData/match002.tga", 25, FirstPosY+(LineCount*Term + 1), 48, 48  ,   667, 742 ,   190, 190, 255, 0, 8, 0,0)
			
			-- 3. �ƹ�Ÿ �̹����� �׸���.
			--drawer:drawTextureWithScale_Angle_Offset(tCostumeTTAddInfo[1] , 98, FirstPosY+(LineCount*Term+10), 536, Term*5, 0, 0 ,   180, 180, 255, 0, 8, 0,0)
			drawer:drawTextureWithScale_Angle_Offset(tCostumeTTAddInfo[1] , 49, FirstPosY+(LineCount*Term + 1), 536, Term*5, 0, 0 ,   90, 90, 255, 0, 8, 0,0)

			--=================
			LineCount = LineCount+1
			--=================
		end
	end
	--DebugStr("LineCount2 : " .. LineCount)
	
	
	
	
	-- �������
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term*2, 787, 952)
	drawer:setTextColor(226,1,255,255)
	if tCostumTTInfo[17] == 0 then
		aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, PreCreateString_2495.." : "..tCostumTTInfo[11], 200)
	else
		aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, PreCreateString_2496.." : "..tCostumTTInfo[11], 200)
	end
	
	drawer:drawText(aa, 12, FirstPosY+(LineCount*Term)+10)
	--=================
	LineCount = LineCount+2
	--=================
	
	ysize = FirstPosY+(LineCount*Term)
	--=========================
	drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 10, 787, 952)
	ysize = ysize + 10	-- ����
	--=========================
	local statTerm = 16
	-- ����
	drawer:setTextColor(253,199,2,255)
	local StatCount = 0
	for i = 1, #tStatString do
		StatCount = StatCount + 1
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize + (i-1)*statTerm, MainSizeX, statTerm, 787, 952)
		drawer:drawText(tStatString[i], 12, ysize + (i-1)*statTerm)
	end
	if StatCount > 0 then
		ysize = ysize + (StatCount-1)*statTerm + statTerm
	end
	--=========================
	drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 10, 787, 952)
	ysize = ysize + 10	-- ����
	--=========================
	
	-- ���Ƚ�
	local HotfixCount = 0
	drawer:setTextColor(38,255,86,255)
	for i = 1, #tHotfixInfoTable do
		if tHotfixInfoTable[i][ITEM_CHECK] == true then
			drawer:drawTexture("UIData/skillitem001.tga", 0, ysize + (i-1)*20, MainSizeX, Term, 787, 952)
			drawer:drawTextureSA("UIData/ItemUIData/"..tHotfixInfoTable[i][ITEM_FILENAME], 3, ysize + (i-1)*Term - 4,   100, 100,   0, 0,   50, 50,   255, 0, 0);
			drawer:drawText(tHotfixInfoTable[i][ITEM_NAME], 22, ysize + (i-1)*Term)
			HotfixCount = HotfixCount + 1		
		end
	end
	if HotfixCount > 0 then
		ysize = ysize + (HotfixCount-1)*20 + 20
	end
	if tCostumTTInfo[15] == 1 then		-- ��Ʈ �κ� �������̴�.
		drawer:setFont(g_STRING_FONT_GULIMCHE, 11)
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, Term, 787, 952)
		local String = string.format(PreCreateString_2360, SetCurrentCount, SetTotalCount)
		drawer:drawText("# "..String, 10, ysize)		
		ysize = ysize + Term	-- ����	
		
		local SetNameCount = 0
		for i=0, #tSetNameString do
			if tSetNameString[i] == "" then
				break
			end
			SetNameCount = SetNameCount + 1
		end
		
		-- ����� ���Դٸ�
		if SetNameCount ~= 0 then
			for i=0, SetNameCount-1 do				
				drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15, 787, 952)
				if tbSetNameCheck[i] then
					-- �԰��ִ� ������ : �����
					drawer:setTextColor(255,198,30,255)	
				else
					-- ���� ������ : ȸ��
					drawer:setTextColor(120,120,120,255)	
				end
				drawer:drawText(tSetNameString[i], 10, ysize)
				ysize = ysize + 15	-- ����

			end
			drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15, 787, 952)
			ysize = ysize + 15	-- ����
			for i=0, #tSetEffectString do
				if tSetEffectString[i] == "" then
					break
				end
				drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15, 787, 952)
				if tbSetEffectcheck[i] then
					drawer:setTextColor(255,198,30,255)	
				else
					drawer:setTextColor(120,120,120,255)	
				end
				drawer:drawText(tSetEffectString[i], 10, ysize)
				ysize = ysize + 15	-- ����
			end	
		end
			
	end
	-- �������ϳ��� �پ��ִ� ȿ��
	if HaveItemState2 > 0 then
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15 * HaveItemState2, 787, 952)
		drawer:setTextColor(255,198,30,255)	
		drawer:drawText(ItemState2_String, 10, ysize)
		ysize = ysize + (15 * HaveItemState2)
	end

	if HaveAddSkill > 0 then
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15 * HaveAddSkill, 787, 952)
		drawer:setTextColor(255,198,30,255)	
		drawer:drawText(AddSkill_String, 10, ysize)
		ysize = ysize + (15 * HaveAddSkill)
	end

--[[	
local tSetNameString = {['err']=0, [0]="", "", "", "", "", "", "", "", ""}
local tbSetNameCheck = {['err']=0, [0]=false, false, false, false, false, false, false, false, false}
local tSetEffectString = {['err']=0, [0]="", "", "", "", "", "", "", "", ""}
local tbSetEffectcheck = {['err']=0, [0]=false, false, false, false, false, false, false, false, false}
	
	--]]
	
	if IsThaiLanguage() then
	--=========================
	drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 10, 787, 952)
	ysize = ysize + 10	-- ����
	--=========================
		

		-- ���� ����Ƚ��(�����Ұ�)
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, Term, 787, 952)
		drawer:setTextColor(255,255,255,255)
		local String = ""
		if tCostumTTInfo[6] == 0 or tCostumTTInfo[12] ~= -1 then
			String = PreCreateString_2139
		else
			String = PreCreateString_2080.." ( "..tCostumTTInfo[7].." / "..tCostumTTInfo[6].." )"
		end
		Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, String)
		drawer:drawText(String, 118 - Size/2, ysize)
		
		
		if tCostumTTInfo[14] == 1 then
			drawer:setTextColor(255,255,0,255)
			ysize = ysize+Term
			drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 5, 787, 952)
			ysize = ysize + 5
			drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, Term, 787, 952)

			if tCostumTTInfo[8] == PreCreateString_1056 then
				Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "( "..PreCreateString_2329.." )")
				drawer:drawText("( "..PreCreateString_2329.." )", 118 - Size/2, ysize)
				LineCount = LineCount+1
			end
		end	
		drawer:drawTextureA("UIData/skillitem001.tga", 0, ysize + Term, MainSizeX, 5, 787, 1018, 255)	-- ����
	else
		drawer:drawTextureA("UIData/skillitem001.tga", 0, ysize , MainSizeX, 5, 787, 1018, 255)	-- ����
	end
	
end


--=================--=================
-- �ڽ�Ƭ(����) ����
--=================--=================
function RenderShopCostumToolTip(drawer)
	local ysize = 0
	local count = 0
	-- ���(�̸� ��������.)
	drawer:drawTexture("UIData/skillitem001.tga", 0, 0, MainSizeX, 39, 787, 917)
	drawer:drawTexture("UIData/skillitem001.tga", 0, 29, MainSizeX, 5, 787, 912)		-- ������ �̸� �ؿ� ��
--=================
-- ������ �̸�
	drawer:setTextColor(255,190,62,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	local nameAdjust = SummaryString(g_STRING_FONT_GULIMCHE, 12, tCostumTTInfo[1], 200)
	local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, nameAdjust)
	drawer:drawText(nameAdjust, 118 - Size/2, 13)
	
--=================
-- ù��° ��
--=================
	FirstPosY = 39
	LineCount = 0
--=================
-- ������ ����	
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term, 787, 952)
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tCostumTTInfo[3])
	drawer:drawText(tCostumTTInfo[3], 54 - Size/2, FirstPosY+(LineCount*Term))
--=================
-- ������ ���
	local color = tGradeColorTable[tCostumTTInfo[4]]
	drawer:setTextColor(color[1],color[2],color[3],255)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tGradeStringTable[tCostumTTInfo[4]])
	drawer:drawText(tGradeStringTable[tCostumTTInfo[4]], 175 - Size/2, FirstPosY+(LineCount*Term))
	
	--=================
	LineCount = LineCount+1
	--=================
	
--=================	
-- ������ ��Ÿ��
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term, 787, 952)
	drawer:setTextColor(255,255,255,255)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tCostumTTInfo[5])
	drawer:drawText(tCostumTTInfo[5], 54 - Size/2, FirstPosY+(LineCount*Term))
	
--=================
-- �ǸŻ���
	local StateCount = 0
	local StateString = ""
	for i = 0, #tStateCheck do
		if tStateCheck[i] then
			if StateCount ~= 0 then
				StateString = StateString.." / "..tStateStringTable[i]
			else
				StateString = tStateStringTable[i]
			end
			StateCount = StateCount + 1
		end
	end
	if StateString == "" then
		StateString = "-"
	end
	
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, StateString)
	drawer:drawText(StateString, 173 - Size/2, FirstPosY+(LineCount*Term))	
	--=================
	LineCount = LineCount+1
	--=================
--=================	
-- ���԰���, ��������(������ �� �ִ� �������� ������ �����ϴ�.)
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term, 787, 952)
	local PurchaseString = ""
	local PresentString = "";
	if tCostumTTInfo[13] == 0 then
		drawer:setTextColor(255,28,20,255)
		PurchaseString = PreCreateString_2282
		PresentString = PreCreateString_2283
	else
		drawer:setTextColor(255,255,255,255)
		PurchaseString = PreCreateString_2278
		PresentString = PreCreateString_2279
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, PurchaseString)
	drawer:drawText(PurchaseString, 54 - Size/2, FirstPosY+(LineCount*Term))
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, PresentString)
	drawer:drawText(PresentString, 173 - Size/2, FirstPosY+(LineCount*Term))
	--=================
	LineCount = LineCount+1
	--=================

--=================	
-- ��밡��
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term, 787, 952)
	local useString = ""
	if tCostumTTInfo[10] == 0 then
		drawer:setTextColor(255,28,20,255)
		useString = PreCreateString_2280
	else
		drawer:setTextColor(255,255,255,255)
		useString = PreCreateString_2276
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, useString)
	drawer:drawText(useString, 54 - Size/2, FirstPosY+(LineCount*Term))
--=================	
-- �ŷ�����
	local tradeString = "";
if IsKoreanLanguage() then	
	if tCostumTTInfo[9] == 0 then
		drawer:setTextColor(255,28,20,255)
		tradeString = PreCreateString_2281
	else
		drawer:setTextColor(255,255,255,255)
		tradeString = PreCreateString_2277
	end
else
	drawer:setTextColor(255,255,255,255)
	tradeString = "-"
end
--	local tradeString = "";
--	if tCostumTTInfo[9] == 0 then
--		drawer:setTextColor(255,28,20,255)
--		tradeString = PreCreateString_2281
--	else
--		drawer:setTextColor(255,255,255,255)
--		tradeString = PreCreateString_2277
--	end

	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tradeString)
	drawer:drawText(tradeString, 173 - Size/2, FirstPosY+(LineCount*Term))
	--=================
	LineCount = LineCount+1
	--=================
	
--=================
-- �����ۼ���
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term), MainSizeX, Term*4, 787, 922)
	drawer:setTextColor(7,150,252,255)
	local aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, tCostumTTInfo[2], 200)
	drawer:drawText(aa, 12, FirstPosY+(LineCount*Term)+10)
	--=================
	LineCount = LineCount+3
	--=================
--=================	
-- �������
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+(LineCount*Term)+Term, MainSizeX, Term*2, 787, 952)
	drawer:setTextColor(226,1,255,255)
	if tCostumTTInfo[17] == 0 then
		aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, PreCreateString_2495.." : "..tCostumTTInfo[11], 200)
	else
		aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, PreCreateString_2496.." : "..tCostumTTInfo[11], 200)
	end
	drawer:drawText(aa, 12, FirstPosY+(LineCount*Term)+Term)
	--=================
	LineCount = LineCount+2
	--=================


	--=================
	--LineCount = LineCount+3
	--=================

	ysize = FirstPosY+(LineCount*Term)+Term
	--=========================
	drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 10, 787, 952)
	ysize = ysize + 10	-- ����
	--=========================
	-- ����
	drawer:setTextColor(253,199,2,255)
	local StatCount = 0
	for i = 1, #tStatString do
		StatCount = StatCount + 1
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize + (i-1)*20, MainSizeX, Term, 787, 952)
		drawer:drawText(tStatString[i], 12, ysize + (i-1)*20)
	end
	if StatCount > 0 then
		ysize = ysize + (StatCount-1)*20 + 20
	end
	
	--=========================
	drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 10, 787, 952)
	ysize = ysize + 10	-- ����
	--=========================	
	
	if tCostumTTInfo[15] == 1 then		-- ��Ʈ �κ� �������̴�.
		drawer:setFont(g_STRING_FONT_GULIMCHE, 11)
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, Term, 787, 952)
		local String = string.format(PreCreateString_2360, SetCurrentCount, SetTotalCount)
		drawer:drawText("# "..String, 10, ysize)		
		ysize = ysize + Term	-- ����	
		
		local SetNameCount = 0
		for i=0, #tSetNameString do
			if tSetNameString[i] == "" then
				break
			end
			SetNameCount = SetNameCount + 1
		end
		
		-- ����� ���Դٸ�
		if SetNameCount ~= 0 then
			for i=0, SetNameCount-1 do				
				drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15, 787, 952)
				if tbSetNameCheck[i] then
					drawer:setTextColor(255,198,30,255)	
				else
					drawer:setTextColor(120,120,120,255)	
				end
				drawer:drawText(tSetNameString[i], 10, ysize)
				ysize = ysize + 15	-- ����

			end
			drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15, 787, 952)
			ysize = ysize + 15	-- ����
			for i=0, #tSetEffectString do
				if tSetEffectString[i] == "" then
					break
				end
				drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15, 787, 952)
				if tbSetEffectcheck[i] then
					drawer:setTextColor(255,198,30,255)	
				else
					drawer:setTextColor(120,120,120,255)	
				end
				drawer:drawText(tSetEffectString[i], 10, ysize)
				ysize = ysize + 15	-- ����
			end	
		end
			
	end
--=================
-- ����
	drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, Term*3, 787, 925)
	
	drawer:setTextColor(255,255,255,255)
	for i = 0, #tPriceInfoTable do
		if tPriceInfoTable[i][PRICE_BCHECK] then	-- ������ ������
			
			local paymenttype = tPayMentType[tPriceInfoTable[i][PRICE_PAYMENTTYPE]]
			local TexY = tPayMentTypeImg[tPriceInfoTable[i][PRICE_PAYMENTTYPE]]
			drawer:drawTextureSA("UIData/Itemshop001.tga", 5, ysize, 19, 19, TexY, 788, 200, 200, 255, 0, 0) -- ���Ҽ��� ������
			if tStateCheck[2] or tStateCheck[3] or tStateCheck[4] then		-- ����
				
				local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tPriceInfoTable[i][PRICE_PRODUCTPRICE])
				drawer:drawTexture("UIData/skillitem001.tga", 32+Size, ysize+2, 10, 10, 777, 1013)	-- ȭ��ǥ
				
				drawer:drawText(tPriceInfoTable[i][PRICE_PRODUCTPRICE], 27, ysize+2)
				local aaa = tostring(tPriceInfoTable[i][PRICE_SALEPRICE]).." "..paymenttype.." ("..tPriceInfoTable[i][PRICE_PERIOD]..")"
				drawer:drawText(aaa, 32+Size+13, ysize+2)
			else
			
				local aaa = tPriceInfoTable[i][PRICE_SALEPRICE].." "..paymenttype.." ("..tPriceInfoTable[i][PRICE_PERIOD]..")"
				drawer:drawText(aaa, 27, ysize+2)
			end
		end
		ysize = ysize + Term
	end
	
	-- �������ϳ��� �پ��ִ� ȿ��
	if HaveItemState2 > 0 then
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15 * HaveItemState2, 787, 952)
		drawer:setTextColor(255,198,30,255)	
		drawer:drawText(ItemState2_String, 10, ysize)
		ysize = ysize + (15 * HaveItemState2)
	end

	if HaveAddSkill > 0 then
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 15 * HaveAddSkill, 787, 952)
		drawer:setTextColor(255,198,30,255)	
		drawer:drawText(AddSkill_String, 10, ysize)
		ysize = ysize + (15 * HaveAddSkill)
	end
	
if IsKoreanLanguage() == false then	
	--=========================
	drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 25, 787, 952)
	
	if IsThaiLanguage() then
		drawer:setTextColor(112,255,253,255)
		Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, PreCreateString_2315)
		drawer:drawText(PreCreateString_2315, 118 - Size/2, ysize +4)			-- �����Ѹ� �ŷ������ϴٰ� ����ش�.
	end
	ysize = ysize + 25	-- ����
	--=========================	
end
	
	if IsThaiLanguage() then
	-- ���� ����Ƚ��(�����Ұ�)
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, Term, 787, 952)
		drawer:setTextColor(255,255,255,255)
		local String = ""
		if tCostumTTInfo[6] == 0 then
			String = PreCreateString_2139
		else
			String = PreCreateString_2080.." ( "..tCostumTTInfo[7].." / "..tCostumTTInfo[6].." )"
		end
		Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, String)
		drawer:drawText(String, 118 - Size/2, ysize)
		ysize = ysize+Term
		drawer:setTextColor(255,84,95,255)
		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, Term, 787, 952)	
	
		Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "( "..PreCreateString_2290.." )" )
		drawer:drawText("( "..PreCreateString_2290.." )", 118 - Size/2, ysize)
	
		if tCostumTTInfo[14] == 1 then
			drawer:setTextColor(255,255,0,255)
			ysize = ysize+Term
	--		drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, 5, 787, 952)
	--		ysize = ysize + 5
			drawer:drawTexture("UIData/skillitem001.tga", 0, ysize, MainSizeX, Term, 787, 952)

				Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "( "..PreCreateString_2329.." )")
				drawer:drawText("( "..PreCreateString_2329.." )", 118 - Size/2, ysize)
				LineCount = LineCount+1
		end	
		drawer:drawTextureA("UIData/skillitem001.tga", 0, ysize+Term, MainSizeX, 5, 787, 1018, 255)
	else
		drawer:drawTextureA("UIData/skillitem001.tga", 0, ysize, MainSizeX, 5, 787, 1018, 255)
	end
	
end


--=========================--=========================
-- ��ų(��) ����
--=========================--=========================
function RenderRoomSkillToolTip(drawer)
	local ysize = 0
	FirstPosY = 16
	-- ���
	if ToolTipType == TYPE_TRADE then
		drawer:drawTexture("UIData/skillitem001.tga", 0, 0, MainSizeX, 134, 518, 592)
		drawer:drawTexture("UIData/skillitem001.tga", 0, 134, MainSizeX, 132, 518, 891)
	else
		drawer:drawTexture("UIData/skillitem001.tga", 0, 0, MainSizeX, 431, 518, 592)
	end
	
	-- ������ �̸�
	drawer:setTextColor(255,190,62,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	local nameAdjust = SummaryString(g_STRING_FONT_GULIMCHE, 12, tSkillTTInfo[1], 200)
	local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, nameAdjust)
	drawer:drawText(nameAdjust, 118 - Size/2, FirstPosY-3)
	-- ��ų ����
	drawer:setTextColor(210,210,210,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tSkillTTInfo[3])
	drawer:drawText(tSkillTTInfo[3], 118 - Size/2, FirstPosY+27)
	-- ������ ����
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tSkillTTInfo[4])
	drawer:drawText(tSkillTTInfo[4], 54 - Size/2, FirstPosY+9+Term*2)

	local promotionIndex= tSkillTTInfo[5]
	local attributeType = tSkillTTInfo[15]
	local style			= tSkillTTInfo[16]
	
	drawer:drawTextureSA("UIData/Skill_up2.tga", 140, FirstPosY+3+Term*2, 89, 35,  tAttributeImgTexXTable[style][attributeType], tAttributeImgTexYTable[style][attributeType],   170, 170,   255, 0, 0);
	drawer:drawTextureSA("UIData/Skill_up2.tga", 140, FirstPosY+3+Term*2, 89, 35,  promotionImgTexXTable[style], promotionImgTexYTable[promotionIndex],   170, 170,   255, 0, 0);
	
	-- ������ ���
	local color = tGradeColorTable[tSkillTTInfo[11] + 2]
	drawer:setTextColor(color[1],color[2],color[3],255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tSkillGradeStringTable[tSkillTTInfo[11]])
	drawer:drawText(tSkillGradeStringTable[tSkillTTInfo[11]], 54 - Size/2, FirstPosY+8+Term*3)
	
	--��ų ���
	if tSkillTTInfo[6] ~= 0 then
		drawer:setFont(g_STRING_FONT_GULIMCHE, 11)
		drawer:drawTexture("UIData/powerup.tga", 155, FirstPosY+6+Term*3, 29, 16, tGradeTexTable[tSkillTTInfo[6]], 486)			-- ������ �̹���
		drawer:setTextColor(tGradeTextColorTable[tSkillTTInfo[6]][1],
							tGradeTextColorTable[tSkillTTInfo[6]][2],
							tGradeTextColorTable[tSkillTTInfo[6]][3], 255)
		local Size = GetStringSize(g_STRING_FONT_GULIM, 11, "+"..tSkillTTInfo[6])
		drawer:drawText("+"..tSkillTTInfo[6], 170 - Size / 2, FirstPosY+9+Term*3)
		local pos = 0
		if ToolTipType == TYPE_TRADE then
			pos = FirstPosY - 3 +Term*11
		else
			pos = FirstPosY+Term*19
		end
		-- �߰� ��ų������
		drawer:setTextColor(87,242,9,255)
		local String	= string.format(PreCreateString_2155, tGradeferPersent[tSkillTTInfo[6]])
		drawer:drawText("[PvP Mode] "..String.."%", 5, pos)
		String	= string.format(PreCreateString_2155, tGradeferPersent[tSkillTTInfo[6]] * 10)
		drawer:drawText("[Arcade Mode]"..String.."%", 5, pos+Term-3)
	else
		drawer:setTextColor(255,255,255,255)
		drawer:drawText("-", 170, FirstPosY+8+Term*3)
	end
	-- ��밡��
	local useString = ""
	if tSkillTTInfo[10] == 0 then
		drawer:setTextColor(255,28,20,255)
		useString = PreCreateString_2280
	else
		drawer:setTextColor(255,255,255,255)
		useString = PreCreateString_2276
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, useString)
	drawer:drawText(useString, 54 - Size/2, FirstPosY+7+Term*4)
	-- �ŷ�����
	local tradeString = "";
	if tSkillTTInfo[9] == 0 then
		drawer:setTextColor(255,28,20,255)
		tradeString = PreCreateString_2281
	else
		drawer:setTextColor(255,255,255,255)
		tradeString = PreCreateString_2277
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tradeString)
	drawer:drawText(tradeString, 173 - Size/2, FirstPosY+7+Term*4)
	-- ���� �Ⱓ
	drawer:setTextColor(255,255,255,255)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, PreCreateString_1853.." : "..tSkillTTInfo[7])
	drawer:drawText(PreCreateString_1853.." : "..tSkillTTInfo[7], 118 - Size/2, FirstPosY+5+Term*5)
	-- ������ ����
	drawer:setTextColor(7,150,252,255)
	local aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, tSkillTTInfo[2], 200)
	if ToolTipType == TYPE_TRADE then
		drawer:drawText(aa, 12, FirstPosY+12+Term*8)
		ShowSkillCommand(drawer, tSkillTTInfo[8], tSkillTTInfo[13], 200, 200, 12, FirstPosY+8+Term*6, 25, 190)	
	else
		drawer:drawText(aa, 12, FirstPosY+12+Term*16)
		ShowSkillCommand(drawer, tSkillTTInfo[8], tSkillTTInfo[13], 200, 200, 12, FirstPosY+12+Term*14, 25, 190)
	end
	
	
end
--=========================--=========================
-- ��ų(����) ����
--=========================--=========================
function RenderShopSkillToolTip(drawer)
	local ysize = 0
	FirstPosY = 16
	-- ���
	drawer:drawTexture("UIData/skillitem001.tga", 0, 0, MainSizeX, 134, 518, 592)
	drawer:drawTexture("UIData/skillitem001.tga", 0, 134, MainSizeX, 100, 518, 891)
	drawer:drawTexture("UIData/skillitem001.tga", 0, 234, MainSizeX, 60, 518, 963)
--	drawer:drawTexture("UIData/skillitem001.tga", 0, 0, MainSizeX, 164, 518, 592)
--	drawer:drawTexture("UIData/skillitem001.tga", 0, 164, MainSizeX, 162, 518, 861)
	
	-- ������ �̸�
	drawer:setTextColor(255,190,62,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	local nameAdjust = SummaryString(g_STRING_FONT_GULIMCHE, 12, tSkillTTInfo[1], 200)
	local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, nameAdjust)
	drawer:drawText(nameAdjust, 118 - Size/2, FirstPosY-3)
	-- ��ų ����
	drawer:setTextColor(210,210,210,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tSkillTTInfo[3])
	drawer:drawText(tSkillTTInfo[3], 118 - Size/2, FirstPosY+27)
	-- ������ ����
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tSkillTTInfo[4])
	drawer:drawText(tSkillTTInfo[4], 54 - Size/2, FirstPosY+9+Term*2)

	local promotionIndex= tSkillTTInfo[5]
	local attributeType = tSkillTTInfo[15]
	local style			= tSkillTTInfo[16]
	
	drawer:drawTextureSA("UIData/Skill_up2.tga", 140, FirstPosY+3+Term*2, 89, 35,  tAttributeImgTexXTable[style][attributeType], tAttributeImgTexYTable[style][attributeType],   170, 170,   255, 0, 0);
	drawer:drawTextureSA("UIData/Skill_up2.tga", 140, FirstPosY+3+Term*2, 89, 35,  promotionImgTexXTable[style], promotionImgTexYTable[promotionIndex],   170, 170,   255, 0, 0);

--	drawer:drawTextureSA("UIData/skillitem001.tga", 140, FirstPosY+3+Term*2,   87, 35,   497 + (tSkillTTInfo[5] % 2) * 88, 35 * (tSkillTTInfo[5] / 2),   170, 170,   255, 0, 0);
	
	-- ������ ���
	local color = tGradeColorTable[tSkillTTInfo[11] + 2]
	drawer:setTextColor(color[1],color[2],color[3],255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tSkillGradeStringTable[tSkillTTInfo[11]])
	drawer:drawText(tSkillGradeStringTable[tSkillTTInfo[11]], 54 - Size/2, FirstPosY+8+Term*3)
	
	--��ų ���(������ �����.)
	drawer:setTextColor(255,255,255,255)
	drawer:drawText("-", 170, FirstPosY+8+Term*3)

--=================	
-- ���԰���, ��������(������ �� �ִ� �������� ������ �����ϴ�.)
	local PurchaseString = ""
	local PresentString = "";
	if tSkillTTInfo[12] == 0 then
		drawer:setTextColor(255,28,20,255)
		PurchaseString = PreCreateString_2282
		PresentString = PreCreateString_2283
	else
		drawer:setTextColor(255,255,255,255)
		PurchaseString = PreCreateString_2278
		PresentString = PreCreateString_2279
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, PurchaseString)
	drawer:drawText(PurchaseString, 54 - Size/2, FirstPosY+7+Term*4)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, PresentString)
	drawer:drawText(PresentString, 173 - Size/2, FirstPosY+7+Term*4)
	
	-- ��밡��
	local useString = ""
	if tSkillTTInfo[10] == 0 then
		drawer:setTextColor(255,28,20,255)
		useString = PreCreateString_2280
	else
		drawer:setTextColor(255,255,255,255)
		useString = PreCreateString_2276
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, useString)
	drawer:drawText(useString, 54 - Size/2, FirstPosY+7+Term*5)
	-- �ŷ�����
	local tradeString = "";
	if tSkillTTInfo[9] == 0 then
		drawer:setTextColor(255,28,20,255)
		tradeString = PreCreateString_2281
	else
		drawer:setTextColor(255,255,255,255)
		tradeString = PreCreateString_2277
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tradeString)
	drawer:drawText(tradeString, 173 - Size/2, FirstPosY+7+Term*5)

	
	LineCount = 11
	
	drawer:setTextColor(255,255,255,255)
	for i = 0, #tPriceInfoTable do
		if tPriceInfoTable[i][PRICE_BCHECK] then	-- ������ ������
			local paymenttype = tPayMentType[tPriceInfoTable[i][PRICE_PAYMENTTYPE]]
			local TexY = tPayMentTypeImg[tPriceInfoTable[i][PRICE_PAYMENTTYPE]]
			local PosX = 8
			if tPriceInfoTable[i][PRICE_PAYMENTTYPE] == 1 then
				PosX = 10
			end
			drawer:drawTextureSA("UIData/Itemshop001.tga", PosX, FirstPosY+(LineCount*Term)+10, 19, 19, TexY, 788, 200, 200, 255, 0, 0) -- ���Ҽ��� ������
			if tStateCheck[2] or tStateCheck[3] or tStateCheck[4] then		-- ����
				local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tPriceInfoTable[i][PRICE_PRODUCTPRICE])
				drawer:drawTexture("UIData/skillitem001.tga", 35+Size, FirstPosY+(LineCount*Term)+12, 10, 10, 777, 1013)	-- ȭ��ǥ
				
				drawer:drawText(tPriceInfoTable[i][PRICE_PRODUCTPRICE], 30, FirstPosY+(LineCount*Term)+12)
				local aaa = tostring(tPriceInfoTable[i][PRICE_SALEPRICE]).." "..paymenttype.." ("..tPriceInfoTable[i][PRICE_PERIOD]..")"
				drawer:drawText(aaa, 35+Size+13, FirstPosY+(LineCount*Term)+12)
			else
				local aaa = tPriceInfoTable[i][PRICE_SALEPRICE].." "..paymenttype.." ("..tPriceInfoTable[i][PRICE_PERIOD]..")"
				drawer:drawText(aaa, 30, FirstPosY+(LineCount*Term)+12)
			end
		end
		LineCount = LineCount+1
	end
	
	ShowSkillCommand(drawer, tSkillTTInfo[8], tSkillTTInfo[13], 200, 200, 12, FirstPosY+8+Term*6, 25, 190)	
	-- ������ ����
	drawer:setTextColor(7,150,252,255)
	local aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, tSkillTTInfo[2], 200)
	drawer:drawText(aa, 12, FirstPosY+8+Term*8)	
end
--=========================--=========================
-- ������(��) ����
--=========================--=========================
function RenderRoomItemToolTip(drawer, Type)
	FirstPosY = 16
	-- ���
	drawer:drawTextureA("UIData/skillitem001.tga", 0, 0, 236, FirstPosY, 787, 917, 255)
	-- ������ �̸�
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY, 236, Term+5, 787, 952)
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY + 13, 236, 5, 787, 912)
	drawer:setTextColor(255,190,62,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	
	local nameAdjust = SummaryString(g_STRING_FONT_GULIMCHE, 12, tItemTTInfo[1], 200)
	local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, nameAdjust)
	drawer:drawText(nameAdjust, 118 - Size/2, FirstPosY-3)
	
	-- ������ ����
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+3+Term, MainSizeX, Term, 787, 952)
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tItemTTInfo[3])
	drawer:drawText(tItemTTInfo[3], 54 - Size/2, FirstPosY+3+Term)
	-- ���� �Ⱓ
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tItemTTInfo[4])
	drawer:drawText(tItemTTInfo[4], 175 - Size/2, FirstPosY+3+Term)
	
	-- ��밡��
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+3+Term*2, MainSizeX, Term, 787, 952)
	local useString = ""
	if tItemTTInfo[6] == 0 then
		drawer:setTextColor(255,28,20,255)
		useString = PreCreateString_2280
	else
		drawer:setTextColor(255,255,255,255)
		useString = PreCreateString_2276
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, useString)
	drawer:drawText(useString, 54 - Size/2, FirstPosY+3+Term*2)
	-- �ŷ�����
	local tradeString = "";
	if tItemTTInfo[5] == 0 then
		drawer:setTextColor(255,28,20,255)
		tradeString = PreCreateString_2281
	else
		drawer:setTextColor(255,255,255,255)
		tradeString = PreCreateString_2277
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tradeString)
	drawer:drawText(tradeString, 173 - Size/2, FirstPosY+3+Term*2)
	-- �����ۼ���
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+3+Term*3, MainSizeX, 10+Term*2, 787, 952)
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+13+Term*5, MainSizeX, 69, 787, 924)
	drawer:drawTextureA("UIData/skillitem001.tga", 0, FirstPosY+2+Term*9, MainSizeX, 5, 787, 1018, 255)	-- �ϴ�
	drawer:setTextColor(7,150,252,255)
	drawer:drawText(tItemTTInfo[2], 12, FirstPosY+3+Term*3)

	if Type == KIND_ORB then
		local count = 0
		for i = #HotfixStat, 1, -1 do
			drawer:setTextColor(38,255,86,255)
			drawer:drawText(HotfixStat[i], 12, FirstPosY+2+Term*8 - ( count )*20 )
			count = count + 1
		end
	end
end
--=========================--=========================
-- ������(����) ����
--=========================--=========================
function RenderShopItemToolTip(drawer, Type)
	FirstPosY = 16
	-- ���
	drawer:drawTextureA("UIData/skillitem001.tga", 0, 0, MainSizeX, FirstPosY, 787, 917, 255)
	-- ������ �̸�
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY, MainSizeX, Term+5, 787, 952)
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY + 13, MainSizeX, 5, 787, 912)
	
	drawer:setTextColor(255,190,62,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	local nameAdjust = SummaryString(g_STRING_FONT_GULIMCHE, 12, tItemTTInfo[1], 200)
	local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, nameAdjust)
	drawer:drawText(nameAdjust, 118 - Size/2, FirstPosY-3)
	
	-- ������ ����
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+3+Term, MainSizeX, Term, 787, 952)
	drawer:setTextColor(255,255,255,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tItemTTInfo[3])
	drawer:drawText(tItemTTInfo[3], 54 - Size/2, FirstPosY+3+Term)
	
	--=================	
	-- ���԰���, ��������(������ �� �ִ� �������� ������ �����ϴ�.)
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+3+Term*2, MainSizeX, Term, 787, 952)
	local PurchaseString = ""
	local PresentString = "";
	if tItemTTInfo[7] == 0 then
		drawer:setTextColor(255,28,20,255)
		PurchaseString = PreCreateString_2282
		PresentString = PreCreateString_2283
	else
		drawer:setTextColor(255,255,255,255)
		PurchaseString = PreCreateString_2278
		PresentString = PreCreateString_2279
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, PurchaseString)
	drawer:drawText(PurchaseString, 54 - Size/2, FirstPosY+3+Term*2)
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, PresentString)
	drawer:drawText(PresentString, 173 - Size/2, FirstPosY+3+Term*2)
	
	
	-- ��밡��
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+3+Term*3, MainSizeX, Term, 787, 952)
	local useString = ""
	if tItemTTInfo[6] == 0 then
		drawer:setTextColor(255,28,20,255)
		useString = PreCreateString_2280
	else
		drawer:setTextColor(255,255,255,255)
		useString = PreCreateString_2276
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, useString)
	drawer:drawText(useString, 54 - Size/2, FirstPosY+3+Term*3)
	-- �ŷ�����
	local tradeString = "";
	if tItemTTInfo[5] == 0 then
		drawer:setTextColor(255,28,20,255)
		tradeString = PreCreateString_2281
	else
		drawer:setTextColor(255,255,255,255)
		tradeString = PreCreateString_2277
	end
	Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tradeString)
	drawer:drawText(tradeString, 173 - Size/2, FirstPosY+3+Term*3)
	
	
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+3+Term*4, MainSizeX, 10+Term*2, 787, 952)
	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+13+Term*6, MainSizeX, 9, 787, 924)
--	drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+2+Term*7, MainSizeX, 60, 787, 924)
--	drawer:drawTextureA("UIData/skillitem001.tga", 0, FirstPosY+2+Term*10, MainSizeX, 5, 787, 1018, 255)	-- �ϴ�
	
	LineCount = 4
	-- �����ۼ���	
	drawer:setTextColor(7,150,252,255)
	drawer:drawText(tItemTTInfo[2], 12, FirstPosY+3+Term*LineCount+5)
	
	if Type == KIND_ORB then
		drawer:setTextColor(38,255,86,255)
		drawer:drawText('Love', 12, FirstPosY+2+Term*8)
		--for i = #HotfixStat, 1, -1 do
		--	drawer:setTextColor(38,255,86,255)
			--drawer:drawText(HotfixStat, 12, FirstPosY+2+Term*8)
		--	drawer:drawText(HotfixStat[i], 12, FirstPosY+2+Term*8 - (i -1 )*20 )
			--drawer:drawText("love2", 12, FirstPosY+2+Term*8 + (i -1 )*20 )
		--end
	end
	LineCount = 7
	-- ������ ����
	drawer:setTextColor(255,255,255,255)
	for i = 0, #tPriceInfoTable do
			--DebugStr('11111111')
			--DebugStr('222222222:'..i)
		if tPriceInfoTable[i][PRICE_BCHECK] then	-- ������ ������
			--DebugStr('222222222:'..i)
			local paymenttype = tPayMentType[tPriceInfoTable[i][PRICE_PAYMENTTYPE]]
			local TexY = tPayMentTypeImg[tPriceInfoTable[i][PRICE_PAYMENTTYPE]]
			local PosX = 8
			if tPriceInfoTable[i][PRICE_PAYMENTTYPE] == 1 then
				PosX = 10
			end
			drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+2+Term*LineCount, MainSizeX, Term, 787, 924)
			drawer:drawTextureSA("UIData/Itemshop001.tga", PosX, FirstPosY+3+Term*LineCount+3, 19, 19, TexY, 788, 200, 200, 255, 0, 0) -- ���Ҽ��� ������
			

			--DebugStr('tStateCheck[2]:'..tostring(tStateCheck[2]))
			--DebugStr('tStateCheck[3]:'..tostring(tStateCheck[3]))
			--DebugStr('tStateCheck[4]:'..tostring(tStateCheck[4]))
			
			--16.04.21KSG
			--if tStateCheck[2] or tStateCheck[3] or tStateCheck[4] or  tStateCheck[5] then		-- ����
			if tStateCheck[2] or tStateCheck[4] or  tStateCheck[5] then		-- ����
				local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, tPriceInfoTable[i][PRICE_PRODUCTPRICE])
				drawer:drawTexture("UIData/skillitem001.tga", 35+Size, FirstPosY+3+Term*LineCount+5, 10, 10, 777, 1013)	-- ȭ��ǥ
				
				drawer:drawText(tPriceInfoTable[i][PRICE_PRODUCTPRICE], 30, FirstPosY+3+Term*LineCount+5)
				local aaa = tostring(tPriceInfoTable[i][PRICE_SALEPRICE]).." "..paymenttype.." ("..tPriceInfoTable[i][PRICE_PERIOD]..")"
				drawer:drawText(aaa, 35+Size+13, FirstPosY+3+Term*LineCount+5)
			else
				local aaa = tPriceInfoTable[i][PRICE_SALEPRICE].." "..paymenttype.." ("..tPriceInfoTable[i][PRICE_PERIOD]..")"
				drawer:drawText(aaa, 30, FirstPosY+3+Term*LineCount+5)
			end
			LineCount = LineCount+1
		end
		
	end
	if tItemTTInfo[9] ~= "" then
		drawer:drawTexture("UIData/skillitem001.tga", 0, FirstPosY+2+Term*LineCount, MainSizeX, 65, 787, 924)
		drawer:setTextColor(255, 169, 83,255)
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		drawer:drawText("�� Event", 12, FirstPosY+15+Term*LineCount)
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		drawer:setTextColor(235, 255, 107,255)
		drawer:drawText(tItemTTInfo[9], 12, FirstPosY+31+Term*LineCount)
		drawer:drawTextureA("UIData/skillitem001.tga", 0, FirstPosY+2+Term*LineCount+65, MainSizeX, 5, 787, 1018, 255)	-- �ϴ�
	else
		drawer:drawTextureA("UIData/skillitem001.tga", 0, FirstPosY+2+Term*LineCount, MainSizeX, 5, 787, 1018, 255)	-- �ϴ�
	end	
	
	

end



-- ������ �ѷ��� �� �ֵ��� ��Ʈ�����ۿ� ���� �������� ������ ���´�.
function SettingSetItemInfo(setTotalCount, setCurrentCount)
		

end







---------------------------------------------------------------------------------------------------
-- �����ڽ��� ������ �� ������ ������ ���
---------------------------------------------------------------------------------------------------
local RandomOpenItem_MaxCount = 10
local RandomOpenItem_XCount	  = 5
local RandomOpenItem_YCount	  = 2


-- ���� ������ ������ �� �ʿ��� ������ ����� ����.
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "randomItemItemListBack")
mywindow:setTexture("Enabled", "UIData/reward_item.tga", 0,0)
mywindow:setPosition(0,0)
mywindow:setSize(244, 173)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

RegistEscEventInfo("randomItemItemListBack", "HideRandomOpenItem")


-- ������ �̹�����
for i=0, (RandomOpenItem_XCount*RandomOpenItem_YCount)-1 do
	-- ������ �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "randomItemItemList_"..i)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0,0)
	mywindow:setTexture("Layered", "UIData/invisible.tga", 0,0)
	mywindow:setPosition(25 + (i % RandomOpenItem_XCount)*41, 51 + (i/RandomOpenItem_XCount)*41)
	mywindow:setSize(100, 100)
	mywindow:setScaleWidth(79)
	mywindow:setScaleHeight(79)
	mywindow:setVisible(true)
	mywindow:setLayered(true)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("randomItemItemListBack"):addChildWindow(mywindow)
	
	-- ������ ���콺 �̺�Ʈ
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "randomItemItemEventList_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0,0)
	mywindow:setPosition(25 + (i % RandomOpenItem_XCount)*41, 51 + (i/RandomOpenItem_XCount)*41)
	mywindow:setSize(31, 31)
	mywindow:setVisible(true)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("Index", tostring(i))	
	mywindow:subscribeEvent("MouseEnter", "RandomItemItemEnter")
	mywindow:subscribeEvent("MouseLeave", "RandomItemItemLeave")
	winMgr:getWindow("randomItemItemListBack"):addChildWindow(mywindow)

	-- ��ų ���� �׵θ� �̹���
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "randomItem_SkillLevelImage_"..i)
	mywindow:setTexture("Enabled", "UIData/invisible.tga", 0, 0)
	mywindow:setTexture("Disabled", "UIData/invisible.tga", 0, 0)
	mywindow:setPosition(25 + (i % RandomOpenItem_XCount)*41, 51 + (i/RandomOpenItem_XCount)*41)
	mywindow:setSize(29, 16)
	mywindow:setAlwaysOnTop(true)
	mywindow:setEnabled(false)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("randomItemItemListBack"):addChildWindow(mywindow)

	-- ��ų���� + ����
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "randomItem_SkillLevelText_"..i)
	mywindow:setTextColor(255,255,255,255)
	mywindow:setFont(g_STRING_FONT_GULIMCHE, 11)
	mywindow:setPosition(32 + (i % RandomOpenItem_XCount)*41, 51 + (i/RandomOpenItem_XCount)*41)
	mywindow:setSize(40, 20)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("randomItemItemListBack"):addChildWindow(mywindow)
	
	
	-- ������ ���� ī��Ʈ
	mywindow = winMgr:createWindow("TaharezLook/StaticText", "randomItem_ItemList_Count_"..i)
	mywindow:setPosition(12 + (i % RandomOpenItem_XCount)*41, 52 + (i/RandomOpenItem_XCount)*41)
	mywindow:setSize(45, 20)
	mywindow:setAlign(6)
	mywindow:setLineSpacing(2)
	mywindow:setViewTextMode(1)
	mywindow:setEnabled(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("randomItemItemListBack"):addChildWindow(mywindow)
		
	
	
	
	-- ����� ��������� ������ ����
	-- ������ ����
	-- ������ ���
	-- ������ �Ⱓ
	
	
	-- ���콺 ���� �̺�Ʈ(����)
	
	
	
	

end






-- ������ ���콺 �̺�Ʈ(in)
function RandomItemItemEnter(args)
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	local x, y = GetBasicRootPoint(EnterWindow)
	local index = tonumber(EnterWindow:getUserString("Index"))
	if index == -1 then
		return
	end
	local itemNumber, itemkind = GetRandomInfoToolTipInfo(index)
	local Kind = -1
	if itemkind == ITEMKIND_COSTUM then
		Kind = KIND_COSTUM
	elseif itemkind == ITEMKIND_SKILL then
		Kind = KIND_SKILL
	elseif itemkind == ITEMKIND_HOTPICKS then
		Kind = KIND_ORB
	else
		Kind = KIND_ITEM
	end
	
	GetToolTipBaseInfo(x + 40, y, 3, Kind, 0, itemNumber)	-- ������ ���� ������ �������ش�.
	SetShowToolTip(true)
end


-- ������ ���콺 �̺�Ʈ(out)
function RandomItemItemLeave(args)
	SetShowToolTip(false)
end





-- ������ �¿� ��ư
local BtnName  = {["err"]=0, [0]="randomItemItemList_LBtn", "randomItemItemList_RBtn"}
local BtnTexX  = {["err"]=0, [0]=20, 38}
local BtnPosX  = {["err"]=0, [0]=76, 150}
local BtnEvent = {["err"]=0, [0]="OnClickRandomItemItemList_PrevPage", "OnClickRandomItemItemList_NextPage"}
for i=0, #BtnName do
	mywindow = winMgr:createWindow("TaharezLook/Button", BtnName[i])
	mywindow:setTexture("Normal", "UIData/reward_item.tga", BtnTexX[i], 173)
	mywindow:setTexture("Hover", "UIData/reward_item.tga", BtnTexX[i], 195)
	mywindow:setTexture("Pushed", "UIData/reward_item.tga", BtnTexX[i], 217)
	mywindow:setTexture("PushedOff", "UIData/reward_item.tga", BtnTexX[i], 217)
	mywindow:setPosition(BtnPosX[i]-48, 139)
	mywindow:setSize(18, 22)
	mywindow:setSubscribeEvent("Clicked", BtnEvent[i])
	winMgr:getWindow("randomItemItemListBack"):addChildWindow(mywindow)
end


-- ������ �¹�ư Ŭ���̺�Ʈ
function OnClickRandomItemItemList_PrevPage()
	SetRandomItemDetailPage(0)
end

-- ������ ���ư Ŭ���̺�Ʈ
function OnClickRandomItemItemList_NextPage()
	SetRandomItemDetailPage(1)
end


-- ���� ������ / �ִ� ������
mywindow = winMgr:createWindow("TaharezLook/StaticText", "randomItemItemList_PageText")
mywindow:setPosition(34, 143)
mywindow:setSize(80, 20)
mywindow:setViewTextMode(1)
mywindow:setAlign(8)
mywindow:setLineSpacing(2)
mywindow:setEnabled(false)
mywindow:setZOrderingEnabled(false)
winMgr:getWindow("randomItemItemListBack"):addChildWindow(mywindow)



-- �ݱ� ��ư
mywindow = winMgr:createWindow("TaharezLook/Button", "randomItemItemList_CloseBtn")
mywindow:setTexture("Normal", "UIData/reward_item.tga", 56, 173)
mywindow:setTexture("Hover", "UIData/reward_item.tga", 56, 204)
mywindow:setTexture("Pushed", "UIData/reward_item.tga", 129, 173)
mywindow:setTexture("PushedOff", "UIData/reward_item.tga", 129, 173)
mywindow:setPosition(152, 133)
mywindow:setSize(73, 31)
mywindow:setSubscribeEvent("Clicked", "HideRandomOpenItem")
winMgr:getWindow("randomItemItemListBack"):addChildWindow(mywindow)



-- ������ ��ư



-- ������ ����


--[[
mywindow = winMgr:createWindow("TaharezLook/Button", "RandomItemListOpenButton")
mywindow:setTexture("Normal", "UIData/reward_item.tga", 0, 173)
mywindow:setTexture("Hover", "UIData/reward_item.tga", 0, 193)
mywindow:setTexture("Pushed", "UIData/reward_item.tga", 0, 213)
mywindow:setTexture("PushedOff", "UIData/reward_item.tga", 0, 233)
mywindow:setPosition(0, 0)
mywindow:setSize(20, 20)
mywindow:setSubscribeEvent("Clicked", "ShowRandomOpenItem")
root:addChildWindow(mywindow)
--]]

-- �����ִ� �������� ����� �������ش�.
function SettingRandomItemItemList(index, itemNumber, itemFilePath, itemFilePath2, grade, count)
	--winMgr:getWindow("randomItemItemEventList_"..index):setUserString("Index", tostring(itemNumber))
	winMgr:getWindow("randomItemItemList_"..index):setVisible(true)
	winMgr:getWindow("randomItemItemList_"..index):setScaleWidth(79)
	winMgr:getWindow("randomItemItemList_"..index):setScaleHeight(79)
	winMgr:getWindow("randomItemItemEventList_"..index):setVisible(true)
	winMgr:getWindow("randomItemItemList_"..index):setTexture("Disabled", itemFilePath, 0,0)
	if itemFilePath2 ~= "" then
		winMgr:getWindow("randomItemItemList_"..index):setLayered(true)
		winMgr:getWindow("randomItemItemList_"..index):setTexture("Layered", itemFilePath2, 0,0)	
	else
		winMgr:getWindow("randomItemItemList_"..index):setLayered(false)
	end
		
	if grade > 0 then
		winMgr:getWindow("randomItem_SkillLevelImage_"..index):setVisible(true)
		winMgr:getWindow("randomItem_SkillLevelImage_"..index):setTexture("Disabled", "UIData/powerup.tga", tGradeTexTable[grade], 486)
		winMgr:getWindow("randomItem_SkillLevelText_"..index):setTextColor(tGradeTextColorTable[grade][1], tGradeTextColorTable[grade][2], tGradeTextColorTable[grade][3], 255)
		winMgr:getWindow("randomItem_SkillLevelText_"..index):setText("+"..grade)
	else
		winMgr:getWindow("randomItem_SkillLevelImage_"..index):setVisible(false)
		winMgr:getWindow("randomItem_SkillLevelText_"..index):setText("")
	end
	if count > 1 then
		winMgr:getWindow("randomItem_ItemList_Count_"..index):setTextExtends("x"..count, g_STRING_FONT_GULIMCHE, 11, 255,255,255,255,    0, 0,0,0,255)
	else
		winMgr:getWindow("randomItem_ItemList_Count_"..index):clearTextExtends()
	end
end

function clearRandomItemItemList()
	-- ������ �̹�����
	for i=0, (RandomOpenItem_XCount*RandomOpenItem_YCount)-1 do
		-- ������ �̹���
		winMgr:getWindow("randomItemItemList_"..i):setVisible(false)
		-- ������ ���콺 �̺�Ʈ
		winMgr:getWindow("randomItemItemEventList_"..i):setVisible(false)
		winMgr:getWindow("randomItem_SkillLevelImage_"..i):setVisible(false)
		winMgr:getWindow("randomItem_SkillLevelText_"..i):setText("")
		winMgr:getWindow("randomItem_ItemList_Count_"..i):clearTextExtends()
	end
end

-- ���� �����ۿ��� ������ ����Ʈ�� �������� �������ش�.
function SettingRandomItemItemListPage(current, total)
	winMgr:getWindow("randomItemItemList_PageText"):setTextExtends(tostring(current).." / "..total, g_STRING_FONT_DODUMCHE, 13, 255,255,255,255,   0, 0,0,0,255)
end


-- ���� �������� ���� ������ �����۵��� �����ش�.
function ShowRandomOpenItem(itemNumber,x,y)
	root:addChildWindow(winMgr:getWindow("randomItemItemListBack"))
	winMgr:getWindow("randomItemItemListBack"):setPosition(x + 20,y + 90)
	winMgr:getWindow("randomItemItemListBack"):setVisible(true)
	ShowRandomItemDetailInfo(itemNumber, 1)
end

-- ���� �������� ���� ������ �����۵��� �����ش�.
function HideRandomOpenItem()
	if winMgr:getWindow("randomItemItemListBack") ~= nil then
		winMgr:getWindow("randomItemItemListBack"):setVisible(false)
	end
end






--------------------------------------------------------------------
-- ���Ƚ� ������ ��ȣ�� �˾ƿ´�.
--------------------------------------------------------------------
function SetRandomHotfixItemNumber(itemNumber)
	
	local a,b,c,d,e,f,g,h,i = GetHotfixItemNumber()
	a = itemNumber
	local thotfixNumber = {['err'] = 0, [0]=a,b,c,d,e,f,g,h,i}
	local Index = 1
	
	-- �ʱ�ȭ
	for i = 1, #tHotfixInfoTable do
		tHotfixInfoTable[i] =  {['err'] = 0, "", "", 0, 0,"",false, 0, 0, ""}		
	end
		
	for i = 0, #thotfixNumber do
		if thotfixNumber[i] ~= 0 then
			tHotfixInfoTable[Index][ITEM_NAME], tHotfixInfoTable[Index][ITEM_FILENAME], 
			tHotfixInfoTable[Index][ITEM_INDEX], tHotfixInfoTable[Index][ITEM_STAT],
			tHotfixInfoTable[Index][ITEM_INDEX2], tHotfixInfoTable[Index][ITEM_STAT2] = GetToolTipHotfixInfo(thotfixNumber[i])
			if tHotfixInfoTable[Index][ITEM_INDEX] == 3 or tHotfixInfoTable[Index][ITEM_INDEX] == 14 then		-- ũ��Ƽ��
				local aa = tHotfixInfoTable[Index][ITEM_STAT] / 10
				local bb = tHotfixInfoTable[Index][ITEM_STAT] % 10
				local statstring = tostring(aa).."."..bb
				tHotfixInfoTable[Index][ITEM_STATSTR] = tStatNameText[tHotfixInfoTable[Index][ITEM_INDEX]].." +"..statstring
			else
				tHotfixInfoTable[Index][ITEM_STATSTR] = tStatNameText[tHotfixInfoTable[Index][ITEM_INDEX]].." +"..tHotfixInfoTable[Index][ITEM_STAT]
			end				
			
			if tHotfixInfoTable[Index][ITEM_INDEX2] == 3 or tHotfixInfoTable[Index][ITEM_INDEX2] == 14 then		-- ũ��Ƽ��
				local cc = tHotfixInfoTable[Index][ITEM_STAT2] / 10
				local dd = tHotfixInfoTable[Index][ITEM_STAT2] % 10
				local statstring2 = tostring(cc).."."..dd
				tHotfixInfoTable[Index][ITEM_STATSTR2] = tStatNameText[tHotfixInfoTable[Index][ITEM_INDEX2]].." +"..statstring2
			else
				tHotfixInfoTable[Index][ITEM_STATSTR2] = tStatNameText[tHotfixInfoTable[Index][ITEM_INDEX2]].." +"..tHotfixInfoTable[Index][ITEM_STAT2]
			end				
			
			tHotfixInfoTable[Index][ITEM_CHECK]	  = true
			Index = Index + 1
		end
	end
	LineCount = LineCount + Index
end

--------------------------------------------------------------------
-- ������ �� �������� �������ش�.
--------------------------------------------------------------------
function SettingToolTiValueaddOrb(name, desc, bonetype, remaintime, level, grade, attach, time, kind, tooltiptype, 
							promotion, skillgrade, maxreform, currentreform, giftable, 
							tradeable, usable, propindex, AdapterAble, bSetParts, bEffectItem, itemtypeValue,
							AddSkillCount, attributeType, style, EventString, UiFileName, IScostumeavatar, itemNumber)
	
	
	if kind == KIND_COSTUM then
		
		tCostumeTTAddInfo[1] = UiFileName	-- ui fileName ���� ��
		tCostumeTTAddInfo[2] = IScostumeavatar -- 1�̸� �ڽ�Ƭ �ƹ�Ÿ , 0�̸� �Ϲݾƹ�Ÿ ��
		
		tCostumTTInfo[1]  = name
		tCostumTTInfo[2]  = desc
		if level < 1 then
			tCostumTTInfo[3] = "-"
		else
			tCostumTTInfo[3]  = "Level."..level
		end
		tCostumTTInfo[4]  = grade
		tCostumTTInfo[5]  = bonetype
		tCostumTTInfo[6]  = maxreform
		tCostumTTInfo[7]  = currentreform
		tCostumTTInfo[8]  = remaintime
		tCostumTTInfo[9]  = tradeable
		tCostumTTInfo[10] = usable
		tCostumTTInfo[11] = ""
		tCostumTTInfo[12] = time
		tCostumTTInfo[13] = giftable
		tCostumTTInfo[14] = AdapterAble
		tCostumTTInfo[15] = bSetParts
		tCostumTTInfo[16] = bEffectItem
		tCostumTTInfo[17] = itemtypeValue
		tCostumTTInfo[18] = AddSkillCount
		tCostumTTInfo[19] = skillgrade
		
		local Attach = attach
		
		for i = #tCostumAttachTable, 1, -1 do
			if Attach >= tCostumAttachTable[i] then
				if tCostumTTInfo[11] == "" then
					tCostumTTInfo[11] = tCostumKind[i]
				else
					tCostumTTInfo[11] = tCostumKind[i]..", "..tCostumTTInfo[11]
				end
				Attach	= Attach - tCostumAttachTable[i]
			end
		end		
		GetTotalStat()			-- ���� �˾ƿ�,
		if tCostumTTInfo[15] == 1 then
			GetSetPartsInfo()
		end
		-- �ΰ� ���ݿ� ���� ���� �˾ƿ´�.
		GetItemState2Info()
		LineCount = LineCount + tCostumTTInfo[16]
		GetAddSkillInfo()
		LineCount = LineCount + tCostumTTInfo[18]
		if tooltiptype ~= TYPE_SHOP then
			SetRandomHotfixItemNumber(itemNumber)	-- 
		else
			LineCount = LineCount + 7
		end
	elseif kind == KIND_SKILL then
		tSkillTTInfo[1]  = name
		tSkillTTInfo[3], tSkillTTInfo[2] = SkillDescDivide(desc)	-- ��Ʈ�� �ɰ��� ����.
		if level < 1 then
			tSkillTTInfo[4] = "-"
		else
			tSkillTTInfo[4]  = "Level."..level
		end		
		tSkillTTInfo[5]  = promotion
		tSkillTTInfo[6]  = skillgrade
		tSkillTTInfo[7]  = remaintime
		tSkillTTInfo[8]  = attach		-- Ŀ�ǵ�
		tSkillTTInfo[9]  = tradeable
		tSkillTTInfo[10] = usable
		tSkillTTInfo[11] = 0		-- 
		tSkillTTInfo[12] = giftable		-- 
		tSkillTTInfo[13] = propindex
		tSkillTTInfo[14] = AdapterAble
		tSkillTTInfo[15] = attributeType
		tSkillTTInfo[16] = style
		
		--DebugStr("tradeable : " .. tradeable)
		
		
	elseif kind == KIND_ITEM or kind == KIND_ORB then
		tItemTTInfo[1] = name
		local aa = AdjustString(g_STRING_FONT_GULIMCHE, 12, desc, 200)
		if style == ITEMKIND_TITLE then
			local bb = AdjustString(g_STRING_FONT_GULIMCHE, 12, bonetype, 200)
			tItemTTInfo[2] = aa.."\n"..bb
		else
			tItemTTInfo[2] = aa
		end	
		if level < 1 then
			tItemTTInfo[3] = "-"
		else
			tItemTTInfo[3]  = "Level."..level
		end		
		tItemTTInfo[4] = remaintime
		tItemTTInfo[5] = tradeable
		tItemTTInfo[6] = usable
		tItemTTInfo[7] = giftable
		tItemTTInfo[8] = AdapterAble
		if EventString ~= "" then
			tItemTTInfo[9] = AdjustString(g_STRING_FONT_GULIMCHE, 12, EventString, 200)
		else
			tItemTTInfo[9] = ""
		end
		
		
		GetHotfixStat()
	end
	ToolTipType = tooltiptype;
	SelectItem_kind = kind
	if tooltiptype == TYPE_SHOP then
		tPriceInfoTable = {['err'] = 0, [0]={['err'] = 0, [0]= false}, {['err'] = 0, [0]= false}, {['err'] = 0, [0]= false}}
	end
end
	
