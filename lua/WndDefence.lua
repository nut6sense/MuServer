-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()

local WINDOW_WIDTH	= 1024
local WINDOW_HEIGHT	= 768
local width, height = GetWindowSize()
local g_x = width / 2 
local g_y = height / 2 
local ToweSPMaxTime			= 0
local ToweSPMaxCount		= 0
local ToweSPMaxSpaceCount	= 0

local	WndDefence_String_01	= PreCreateString_4244	--GetSStringInfo(LAN_ZOMBI_DEFENSE_02)	-- %�� �ڿ� ��Ÿ���ϴ�.
local	WndDefence_String_02	= PreCreateString_4245	--GetSStringInfo(LAN_ZOMBI_DEFENSE_03)	-- ����
local	WndDefence_String_03	= PreCreateString_4246	--GetSStringInfo(LAN_ZOMBI_DEFENSE_04)	-- Ÿ���� ���� �ް� �ֽ��ϴ�.
local	WndDefence_String_04	= PreCreateString_4247	--GetSStringInfo(LAN_ZOMBI_DEFENSE_05)	-- ������ �ð����� �����Ͻÿ�.
local	WndDefence_String_05	= PreCreateString_4248	--GetSStringInfo(LAN_ZOMBI_DEFENSE_06)	-- %�� �Ŀ� ���������� ���� �˴ϴ�.
local	WndDefence_String_06	= PreCreateString_4249	--GetSStringInfo(LAN_ZOMBI_DEFENSE_07)	-- ���� ���۱���

local	MODE_TOOL	= 1
local	MODE_CLIENT = 2

local   MODE_AOS = IsAOS_Mode()

local ICON_MAX = Defence_GetItemMaxCount()


-- ä��â  �ʱ�  ����
function SetChatInitDefence()
	Chatting_SetChatWideType(2)
	Chatting_SetChatPosition(3, 462)
	Chatting_SetChatEditEvent(3)
	Chatting_SetChatTabDefault()
	Chatting_SetUsePartyAsTeam(true)
end

--------------------------------------------------------------------
-- %d���� Ÿ�� e�ʻ�⸦ ����߽��ϴ�.
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "WndDefence_TowerE_SkillUseName_Text")
mywindow:setProperty("FrameEnabled",		"false")
mywindow:setProperty("BackgroundEnabled",	"false")
mywindow:setPosition(g_x, g_y)
mywindow:setSize(200, 20)
mywindow:setLineSpacing(12)
mywindow:setViewTextMode(1)
mywindow:clearTextExtends()
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

function ShowNotifyTowerSkillUsePlayerName(name, alpha)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 20, name)
	winMgr:getWindow("WndDefence_TowerE_SkillUseName_Text"):setPosition(g_x-size/2, g_y+220)
	winMgr:getWindow("WndDefence_TowerE_SkillUseName_Text"):setTextExtends(name, g_STRING_FONT_GULIMCHE, 20,   255,255,255, alpha,   1,     50,200,255, alpha)
	winMgr:getWindow("WndDefence_TowerE_SkillUseName_Text"):setVisible(true)
end

function CloseNotifyTowerSkillUsePlayerName()
	winMgr:getWindow("WndDefence_TowerE_SkillUseName_Text"):clearTextExtends()
	winMgr :getWindow("WndDefence_TowerE_SkillUseName_Text"):setVisible(false)
end


-- �Ű�����(��Ʈ�̸�, ��Ʈũ��, �޼���)�� �Ѱ��ָ� ����� �����Ѵ�.
function GetStringSize(fontName, fontHeight, message)	
	local strSize = GetFontSize(fontName, fontHeight, message)	
	return strSize	
end

-- common_DrawOutlineText1
function WndDefence_DrawOutlineText1(drawer
		, text, posX, posY
		, outlineR,  outlineG, outlineB, outlineA
		, textR, textG, textB, textA)	
	
	drawer:setTextColor(outlineR, outlineG, outlineB, outlineA)
	
	drawer:drawText(text, posX - 1, posY - 1)
	drawer:drawText(text, posX - 1, posY + 0)
	drawer:drawText(text, posX - 1, posY + 1)
	drawer:drawText(text, posX + 0, posY - 1)
	drawer:drawText(text, posX + 0, posY + 1)
	drawer:drawText(text, posX + 1, posY - 1)
	drawer:drawText(text, posX + 1, posY + 0)
	drawer:drawText(text, posX + 1, posY + 1)
	
	drawer:setTextColor(textR, textG, textB, textA)		
	drawer:drawText(text, posX, posY)

end

-- common_DrawOutlineText2
function WndDefence_DrawOutlineText2(drawer
		, text, posX, posY
		, outlineR,  outlineG, outlineB, outlineA
		, textR, textG, textB, textA)	
	
	drawer:setTextColor(outlineR, outlineG, outlineB, outlineA)
	
	drawer:drawText(text, posX - 2, posY - 1)
	drawer:drawText(text, posX - 2, posY - 0)
	drawer:drawText(text, posX - 2, posY + 1)
	drawer:drawText(text, posX - 1, posY - 2)
	drawer:drawText(text, posX - 1, posY - 1)
	drawer:drawText(text, posX - 1, posY + 0)
	drawer:drawText(text, posX - 1, posY + 1)
	drawer:drawText(text, posX - 1, posY + 2)
	drawer:drawText(text, posX + 0, posY - 2)
	drawer:drawText(text, posX + 0, posY - 1)
	drawer:drawText(text, posX + 0, posY + 1)
	drawer:drawText(text, posX + 0, posY + 2)
	drawer:drawText(text, posX + 1, posY - 2)
	drawer:drawText(text, posX + 1, posY - 1)
	drawer:drawText(text, posX + 1, posY + 0)
	drawer:drawText(text, posX + 1, posY + 1)
	drawer:drawText(text, posX + 1, posY + 2)
	drawer:drawText(text, posX + 2, posY - 1)
	drawer:drawText(text, posX + 2, posY - 0)
	drawer:drawText(text, posX + 2, posY + 1)
	
	drawer:setTextColor(textR, textG, textB, textA)
	drawer:drawText(text, posX, posY)

end

-- NameColorByMaxHP
function NameColorByMaxHP(maxhp)

	local r = 255
	local g = 255
	local b = 255
		
	if 0 <= maxhp and maxhp < 3000 then
		g = 255
		b = 255
		
	elseif 3000 <= maxhp and maxhp < 12000 then
		g = 255 - ((maxhp*17)/1000)
		b = 255 - ((maxhp*17)/1000)
		
	else
		g = 0
		b = 0
	end
	
	return r, g, b
end



-- ĳ���� ���� ���� HP/SP ��
function Defence_RenderMyCharacter
			( deltatime
			, myslot
            , myteam
			, slot
			, team
			, friend
			, characterName
			, screenX
			, screenY
			, hp
			, sp
			, maxhp
			, maxsp
			)
	
	local MONSTER_RACING	= false
	local ARCADE			= 1		-- 0:����, 1:����, 2:���ͷ��̽�, 3:������, 4:������(������)
	local isPenalty			= false	-- �����̵�� ���Ƽ�� ����
	local penaltyValue		= 0		-- ���Ƽ ���� ����
	local showAllSP			= 0		-- ��� ���� sp����(���Ӹ� ����)
	local showAllItem		= 0		-- ��� ���� ������ ����(���Ӹ� ����)
	local _1stItemType		= 0
	local _2ndItemType		= 0
	
	
	-- ĳ���� ���� ���� HP/SP ��
	WndDefence_RenderCharacter(deltatime, myslot, myteam, slot, team, characterName, 
			screenX, screenY, hp, sp, maxhp, maxsp, friend, isPenalty, penaltyValue, 
			ARCADE, showAllSP, showAllItem, _1stItemType, _2ndItemType, MONSTER_RACING)
			
	-- �ڽ��� ĳ���� �ʻ�ȭ ( �ֻ�� ) -- bone �־����
	--RenderMyFace(myslot, 0, hp, sp, maxhp, maxsp, deltatime)
end


-- �ڽ��� ĳ���� �ʻ�ȭ ( �ֻ�� )
function RenderMyFace(slot, mybone, hp, sp, maxhp, maxsp, transform, deltatime)

	if maxhp <= 0 then
		return
	end
	
	if maxsp <= 0 then
		maxsp = 3000
	end
	
	----------------------------------
	-- ���� ������(HP, SP)
	----------------------------------
	local realwidth = 167
	
	-- ����
	drawer:drawTexture("UIData/mainBG_Button004.tga", 4, 4, 244, 86, 0, 426)
	
	-- �ʻ�� â( Q/W/E )
	drawer:drawTexture("UIData/mainBG_Button004.tga", 73, 37, 62, 18, 426, 225)

	if hp >= maxhp then
		hp = maxhp
	end
	
	if lasthp[slot] >= maxhp then
		lasthp[slot] = maxhp
	end

	-- ��ȭ�ϰ� �ִ� ������ ���
	computedOldHPrealwidth = lasthp[slot] * realwidth / maxhp
	computedOldSPrealwidth = lastsp[slot] * realwidth / maxsp
		
	
	-- SP �׸���
	drawer:drawTexture("UIData/mainBG_Button004.tga", 76, 24, computedOldSPrealwidth, 9, 244, 449) -- sp �޹��
	drawer:drawTexture("UIData/mainBG_Button004.tga", 76, 24, computedOldSPrealwidth, 9, 244, 485) -- sp �˸���
	

	-- ���� ������
	computedHPrealwidth = hp * realwidth / maxhp
	computedSPrealwidth = sp * realwidth / maxsp
	
	local lastGaugeEfeectTime = 0



	--------------------------------------
	-- HP �׸���
	-- hp 600������ �� �����Ÿ���
	--------------------------------------
	local warningHP = maxhp/10
	if hp > warningHP then
		drawer:drawTexture("UIData/mainBG_Button004.tga", 76, 9, computedHPrealwidth,		9, 244, 431)
	else
		lastGaugeEfeectTime = lastGaugeEfeectTime + deltatime
		lastGaugeEfeectTime = lastGaugeEfeectTime % 100
					
		if lastGaugeEfeectTime < 50 then
			drawer:drawTexture("UIData/mainBG_Button004.tga", 76, 9, computedHPrealwidth, 9, 244, 431)
		else
			drawer:drawTexture("UIData/mainBG_Button004.tga", 76, 9, computedHPrealwidth, 9, 244, 503)
		end
	end


	local playerHP = hp .. "/" .. maxhp	
	local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 10, playerHP)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 10)
	common_DrawOutlineText1(drawer, playerHP, 162 - (textSize/2), 9, 0,0,0,255, 255,255,255,255, WIDETYPE_0)

	
	if transform == 501 then
	 transform = 26
	elseif transform == 502 then
	 transform = 27
	elseif transform == 503 then
	 transform = 28
	elseif transform == 504 then
	 transform = 29
	elseif transform == 505 then
	 transform = 30
	elseif transform == 506 then
	 transform = 31
	elseif transform == 507 then
	 transform = 32
	end
	----------------------------------------
	--	�ɸ��� ��
	----------------------------------------
	-- ���� ������ ��
	if transform <= 0 then
		-- ��(�׾��� ��)
		if hp <= 0 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameImage.tga",  8, 8, 78, 96, 176, mybone*98, 200, 200, 255, 0, 0, 0, 0)
			
		-- ��(���)
		else
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameImage.tga",  8, 8, 78, 96, 0, mybone*98, 200, 200, 255, 0, 0, 0, 0)
		end
	else -- "������ ����"
		drawer:drawTextureWithScale_Angle_Offset("UIData/"..tTransformBigFileName[transform],  8, 8, 78, 96, tTransformBigTexX[transform], tTransformBigTexY[transform], 200, 200, 255, 0, 0, 0, 0)
	end

	
	-- �ɸ��� �̸�
	local FONT_SIZE = 12
	
	-- sp �׸���
	local LIMIT_Q = 1000
	local LIMIT_W = 2000
	local LIMIT_E = 3000
	
	if( 0 <= sp and sp < LIMIT_Q ) then	
		drawer:drawTexture("UIData/mainBG_Button004.tga", 76, 24, computedSPrealwidth, 9, 244, 494)		-- ȸ��
		
	-- Q
	elseif( LIMIT_Q <= sp and sp < LIMIT_W ) then	
		drawer:drawTexture("UIData/mainBG_Button004.tga", 76, 24, computedSPrealwidth, 9, 244, 467)		-- ���
	--	drawer:drawTexture("UIData/mainBG_Button004.tga", 76, 40, 21, 13, 426, 243)						-- Q�� �ҵ���
		
	-- Q, W
	elseif( LIMIT_W <= sp and sp < LIMIT_E ) then	
		drawer:drawTexture("UIData/mainBG_Button004.tga", 76, 24, computedSPrealwidth, 9, 244, 476)		-- �ʷ�
	--	drawer:drawTexture("UIData/mainBG_Button004.tga", 76, 40, 21, 13, 426, 243)						-- Q�� �ҵ���
	--	drawer:drawTexture("UIData/mainBG_Button004.tga", 93, 40, 21, 13, 447, 243)						-- W�� �ҵ���
		
	-- Q, W, E
	elseif( LIMIT_E <= sp ) then
		drawer:drawTexture("UIData/mainBG_Button004.tga", 76, 24, computedSPrealwidth, 9, 244, 485)	-- �Ķ�
	--	drawer:drawTexture("UIData/mainBG_Button004.tga", 76, 40, 21, 13, 426, 243)			-- Q�� �ҵ���
	--	drawer:drawTexture("UIData/mainBG_Button004.tga", 93, 40, 21, 13, 447, 243)			-- W�� �ҵ���
		drawer:drawTexture("UIData/mainBG_Button004.tga", 111, 40,  21, 13, 468, 243)	-- E�� �ҵ���
	end
	
	local playerSP = sp .. "/" .. maxsp	
	local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 10, playerSP)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 10)
	common_DrawOutlineText1(drawer, playerSP, 162 - (textSize/2), 24, 0,0,0,255, 255,255,255,255, WIDETYPE_0)
	
end



local tBuffItemTexturePosX	= { ['err']=0, [4]=156, [6]=234, [7]=273 }
--------------------------------------------------------------------------------------------------------
--	����� ���� ������ ó��
--------------------------------------------------------------------------------------------------------
function Defence_RenderMyBuff( ScreenX , ScreenY , index , itemType , remainTime )
	local remainUsableTick = remainTime / 60
	
	-- ������ �׸���
	imagePosX = (itemType % 10) * 29
	imagePosY = (itemType / 10) * 29
	
	drawer:drawTextureWithScale_Angle_Offset("UIData/zombi_item.tga", (index*32)+90 + ScreenX - 25  , ScreenY - 5	-- Screen Pos
																	, 29, 29													-- size
																	, 734+imagePosX, imagePosY						-- texture Pos
																	, 255, 255													-- scale
																	, 200														-- alpha
																	, 0 , 8, 100 , WIDETYPE_5)									-- other
	
	-- ���� �ð� �׸���
	local textSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, remainUsableTick)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	common_DrawOutlineText1(drawer, remainUsableTick, ScreenX+(index*32)+90-25 - textSize/2, ScreenY-8, 0,0,0,255, 255,255,255,255)
end




-- 0:����, 1:����, 2:���ͷ��̽�, 3:������
local MODE_BATTLE = 0
local MODE_ARCADE = 1
local MODE_SURVIVAL = 2
local MODE_GANGWAR = 3
local MODE_GANGWAR_OBSERVER = 4

lasthp		= { ["protectErr"]=0 }
lasthpTime	= { ["protectErr"]=0 }
lastsp		= { ["protectErr"]=0 }
lastspTime	= { ["protectErr"]=0 }

-- ĳ���� ���� ���� HP/SP ��
function WndDefence_RenderCharacter
			( deltatime
			, myslot
            , myteam
			, slot
			, team
			, characterName
			, screenX
			, screenY
			, hp			
			, sp
			, maxhp
			, maxsp
			, friend
			, isPenalty
			, penaltyValue
			, BATTLE_MODE
			, showAllSP
			, showAllItem
			, _1stItemType
			, _2ndItemType
			, MONSTER_RACING
			)
			
	drawer = CEGUI.WindowManager:getSingleton():getWindow("DefaultWindow"):getDrawer()
	
	if maxhp <= 0 then
		return
	end
	if maxsp <= 0 then
		maxsp = 3000
	end
	
	----------------------------------
	
	-- ��ȭ�ϰ� �ִ� ������ ���
	
	----------------------------------
	---------
	-- HP
	---------
	if (lasthp[slot] == nil) then
		lasthp[slot] = 0
	end
	
	if (lasthpTime[slot] == nil) then 
		lasthpTime[slot] = 0
	end
		
	lasthpTime[slot] = lasthpTime[slot] + deltatime
	changedHP		 = lasthpTime[slot] / 20
		
	lasthp[slot] = lasthp[slot] - changedHP
	
	if (lasthp[slot] < hp) then
		lasthp[slot] = hp
		lasthpTime[slot] = 0
	end
	
	---------
	-- SP
	---------
	if (lastsp[slot] == nil) then
		lastsp[slot] = 0
	end
	
	if (lastspTime[slot] == nil) then 
		lastspTime[slot] = 0
	end
				
	lastspTime[slot] = lastspTime[slot] + deltatime
	changedSP		 = lastspTime[slot] / 20

	lastsp[slot] = lastsp[slot] - changedSP	
	
	if (lastsp[slot] < sp) then
		lastsp[slot] = sp
		lastspTime[slot] = 0
	end
		
	
	
	----------------------------------

	-- �̴� HP ������

	----------------------------------
	local screenX	 = screenX - 40
	local screenY    = screenY - 20
	local realwidth  = 82
	local namewidth  = 1
	local nameheight = -5
	
	if hp >= maxhp then
		hp = maxhp
	end
	
	if lasthp[slot] >= maxhp then
		lasthp[slot] = maxhp
	end
	
	local computedHPrealwidth = hp * realwidth / maxhp
	local computedSPrealwidth = sp * realwidth / maxsp

	--�̴� ������ ����(��� sp�� ���ϰ��)
	if BATTLE_MODE == MODE_GANGWAR then
		if myteam == team then
			drawer:drawTexture("UIData/GameNewImage.tga", 0 + screenX+namewidth, 0 + screenY+nameheight, realwidth+4, 14, 603, 699)
		else
			drawer:drawTexture("UIData/GameNewImage.tga", 0 + screenX+namewidth, 0 + screenY+nameheight, realwidth+4, 7, 603, 699)
		end
	elseif BATTLE_MODE == MODE_GANGWAR_OBSERVER then
		drawer:drawTexture("UIData/GameNewImage.tga", 0 + screenX+namewidth, 0 + screenY+nameheight, realwidth+4, 14, 603, 699)
	else
		if slot < 8 then
			if showAllSP == 1 then
				drawer:drawTexture("UIData/GameNewImage.tga", 0 + screenX+namewidth, 0 + screenY+nameheight, realwidth+4, 14, 603, 699)
			else
			
				if myteam == team then
					drawer:drawTexture("UIData/GameNewImage.tga", 0 + screenX+namewidth, 0 + screenY+nameheight, realwidth+4, 14, 603, 699)
				else
					drawer:drawTexture("UIData/GameNewImage.tga", 0 + screenX+namewidth, 0 + screenY+nameheight, realwidth+4, 7, 603, 699)
				end
			end
		else
			drawer:drawTexture("UIData/GameNewImage.tga", 0 + screenX+namewidth, 0 + screenY+nameheight, realwidth+4, 7, 603, 699)
		end
	end
	
	--��ȭ �ϰ� �ִ� �̴� ������
	computedOldHPrealwidth = lasthp[slot] * realwidth / maxhp
	computedOldSPrealwidth = lastsp[slot] * realwidth / maxsp
		
	-- �Ʒ��� �ִ� HP��
	if myteam == team then
		drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 1 + screenY+nameheight, computedOldHPrealwidth, 8, 693, 769)
	else
		drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 1 + screenY+nameheight, computedOldHPrealwidth, 8, 605, 729)
	end
	
	-- SP��
	if BATTLE_MODE == MODE_GANGWAR then
		if myteam == team then
			drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedOldSPrealwidth, 8, 605, 745)
		end
	elseif BATTLE_MODE == MODE_GANGWAR_OBSERVER then
		drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedOldSPrealwidth, 8, 605, 745)
	else
		if slot < 8 then
			if showAllSP == 1 then
				drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedOldSPrealwidth, 8, 605, 745)
			else
				if myteam == team then
					drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedOldSPrealwidth, 8, 605, 745)
				end
			end
		end
	end
	
	-- ���Ƽ HP
	if isPenalty == 1 then
		local penaltyWidth = realwidth*(100-penaltyValue)/100
		local penaltyTexX = 935 + penaltyWidth
		local penaltyposX = 2 + screenX+namewidth + penaltyWidth
		local penaltySize = realwidth*penaltyValue/100
		drawer:drawTexture("UIData/GameNewImage.tga", penaltyposX, 1+screenY+nameheight, penaltySize+1, 8, penaltyTexX, 105)
	end
	
	-- ���� HP��
	if BATTLE_MODE == MODE_GANGWAR_OBSERVER then
		drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 1 + screenY+nameheight, computedHPrealwidth, 8, 605, 721)
	else
		if myteam == team then
			drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 1 + screenY+nameheight, computedHPrealwidth, 8, 693, 761)
		else
			drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 1 + screenY+nameheight, computedHPrealwidth, 8, 605, 721)
		end
	end
	
	--���� �̴� ������ 
	-- sp �׸���
	local LIMIT_Q = 1000
	local LIMIT_W = 2000
	local LIMIT_E = 3000
	if BATTLE_MODE == MODE_GANGWAR then
		if myteam == team then
			if( 0 <= sp and sp < LIMIT_Q ) then
				drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 745)
			elseif( LIMIT_Q <= sp and sp < LIMIT_W ) then
				drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 753)
			elseif( LIMIT_W <= sp and sp < LIMIT_E ) then
				drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 761)
			elseif( LIMIT_E <= sp ) then
				drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 769)
			end
		end
	elseif BATTLE_MODE == MODE_GANGWAR_OBSERVER then
		if( 0 <= sp and sp < LIMIT_Q ) then
			drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 745)
		elseif( LIMIT_Q <= sp and sp < LIMIT_W ) then
			drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 753)
		elseif( LIMIT_W <= sp and sp < LIMIT_E ) then
			drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 761)
		elseif( LIMIT_E <= sp ) then
			drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 769)
		end
	else
		if slot < 8 then
			if showAllSP == 1 then
				if( 0 <= sp and sp < LIMIT_Q ) then
					drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 745)
				elseif( LIMIT_Q <= sp and sp < LIMIT_W ) then
					drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 753)
				elseif( LIMIT_W <= sp and sp < LIMIT_E ) then
					drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 761)
				elseif( LIMIT_E <= sp ) then
					drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 769)
				end
			else
				if myteam == team then
					if( 0 <= sp and sp < LIMIT_Q ) then
						drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 745)
					elseif( LIMIT_Q <= sp and sp < LIMIT_W ) then
						drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 753)
					elseif( LIMIT_W <= sp and sp < LIMIT_E ) then
						drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 761)
					elseif( LIMIT_E <= sp ) then
						drawer:drawTexture("UIData/GameNewImage.tga", 2 + screenX+namewidth, 8 + screenY+nameheight, computedSPrealwidth, 8, 605, 769)
					end
				end
			end
		end
	end
	
	
	
	----------------------------------

	-- ĳ���Ͱ� ������ �ִ� ������

	----------------------------------
	local SHOW_Y = 45
	if MONSTER_RACING then
		SHOW_Y = 105
	end
	
	if showAllItem == 1 then
		if slot < 8 then
			if _1stItemType >= 0 then
				drawer:drawTexture("UIData/GameSlotItem.tga", 88+screenX+namewidth, screenY+nameheight, 14, 14, _1stItemType*14, SHOW_Y)
			end
			
			if _2ndItemType >= 0 then
				drawer:drawTexture("UIData/GameSlotItem.tga", 104+screenX+namewidth, screenY+nameheight, 14, 14, _2ndItemType*14, SHOW_Y)
			end
		end
	end


	
	
	
	----------------------------------

	-- �ɸ��� �̸�

	----------------------------------
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:setTextColor(255, 255, 255, 255)
	
	local r=255
	local g=255
	local b=255
	
	-- ������ ���
	if BATTLE_MODE == MODE_BATTLE then
	
		-- ������ ���
		if friend < 8 then
			
			if team == 0 then
				r = 254; g = 87; b = 87;	-- ������
			elseif team == 1 then				
				r = 97;	g = 161; b = 240;	-- �����
			end
			
		else
	
			if slot == myslot then
				r = 51; g = 204; b = 51;
			else
				r = 255; g = 255; b = 255;
			end
		end
	
	-- ������ ���
	elseif BATTLE_MODE == MODE_ARCADE then

		if team == 0 then
			if slot == myslot then
				r = 51; g = 204; b = 51;
			else
				r = 153; g = 204; b = 204;
			end
		else
			r, g, b = NameColorByMaxHP(maxhp)
		end
	elseif BATTLE_MODE == MODE_SURVIVAL then
		
		-- ������ ���
		if friend < 8 then
			
			if team == 0 then
				r = 254; g = 87; b = 87;	-- ������
			elseif team == 1 then				
				r = 97;	g = 161; b = 240;	-- �����
			end
			
		else
	
			if slot == myslot then
				r = 51; g = 204; b = 51;
			else
				r = 255; g = 255; b = 255;
			end
		end
		
	elseif BATTLE_MODE == MODE_GANGWAR then
		if hp > 0 then
			if team == 0 then
				r = 254; g = 87; b = 87;	-- ������
			elseif team == 1 then
				r = 97;	g = 161; b = 240;	-- �����
			end
		else
			r = 200; g = 200; b = 200;	-- ������� ȸ��
		end
	
	elseif BATTLE_MODE == MODE_GANGWAR_OBSERVER then
		if hp > 0 then
			if team == 0 then
				r = 254; g = 87; b = 87;	-- ������
			elseif team == 1 then
				r = 97;	g = 161; b = 240;	-- �����
			end
		else
			r = 200; g = 200; b = 200;	-- ������� ȸ��
		end
	end
	
	-- �̸�
	nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, characterName)
	common_DrawOutlineText1(drawer, characterName, (screenX + 43) - (nameSize/2), screenY-20, 0,0,0,255, r,g,b,255, WIDETYPE_0)
end


--------------------------------------------------------------------
-- ��Ƽ�� ���� �׸���
--------------------------------------------------------------------
local PartyLifeUiTick	= 250
local tFaceEffect		= { ["err"]=0, [0]=0, 0, 0 }

function WndDefence_RenderParty(slot, partyNum, level, name, bone, hp, sp, maxhp, maxsp, deltaTime, bDie, transform, point)
	
	local FONT_SIZE = 12
	
	if maxhp <= 0 then
		return
	end
	
	if maxsp <= 0 then
		maxsp = 3000
	end
	
	local teamRealWidth		= 83
	local teamHPWidth		= hp * teamRealWidth / maxhp
	local teamOldHPWidth	= lasthp[slot] * teamRealWidth / maxhp
	local teamSPWidth		= sp * teamRealWidth / maxsp
	local teamOldSPWidth	= lastsp[slot] * teamRealWidth / maxsp
	
--	DStr(hp)
--	DStr(teamHPWidth)
	
	-- ���� ���� 152(partyNum�� 0 ~ 2���� �´�, slot���� �ٸ���)
	local spacing = 72 * partyNum - 35

	-- ���� �̹���
	--drawer:drawTexture("UIData/GameNewImage.tga", 276+spacing, 4, 146, 57, 875, 3)
	drawer:drawTexture("UIData/mainBG_Button004.tga", 4, spacing+150 , 145, 60, 0, 366)
	
	-- HP, SP
	drawer:drawTexture("UIData/mainBG_Button004.tga", 58, spacing+170, teamHPWidth, 8, 145, 370)
	drawer:drawTexture("UIData/mainBG_Button004.tga", 58, spacing+170, teamOldHPWidth, 8, 145, 362)
	drawer:drawTexture("UIData/mainBG_Button004.tga", 58, spacing+182, teamSPWidth, 8, 145, 386)
	drawer:drawTexture("UIData/mainBG_Button004.tga", 58, spacing+182, teamOldSPWidth, 8, 145, 378)
	

	if transform == 501 then
	 transform = 26
	elseif transform == 502 then
	 transform = 27
	elseif transform == 503 then
	 transform = 28
	elseif transform == 504 then
	 transform = 29
	elseif transform == 505 then
	 transform = 30
	elseif transform == 506 then
	 transform = 31
	elseif transform == 507 then
	 transform = 32
	end

	
	----------------------------------------
	--	�ɸ��� ��
	----------------------------------------
	if transform <= 0 then
	
		-- ���� ������ ��
		if hp <= 0 then	
			-- ��(�׾��� ��)
			if bDie == 1 then
				tFaceEffect[partyNum] = tFaceEffect[partyNum] + deltaTime
				tFaceEffect[partyNum] = tFaceEffect[partyNum] % 200
				
				if tFaceEffect[partyNum] < 100 then
					drawer:drawTexture("UIData/GameImage.tga", 8, spacing+157, 46, 46, 49, 595+bone*49)
				end
			
			-- �� X��
			else
				drawer:drawTexture("UIData/GameImage.tga", 8, spacing+157, 46, 46, 98, 595+bone*49)
			end
			
		-- ��(���)
		else
			drawer:drawTexture("UIData/GameImage.tga", 8, spacing+157 , 46, 46, 0, 595+bone*49)
		end
	else
		if hp <= 0 then	
			
			-- ��(�׾��� ��)
			if bDie == 1 then
				tFaceEffect[partyNum] = tFaceEffect[partyNum] + deltaTime
				tFaceEffect[partyNum] = tFaceEffect[partyNum] % 200
				
				if tFaceEffect[partyNum] < 100 then
					drawer:drawTexture("UIData/"..tTransformSmallFileName[transform], 8, spacing+157, 46, 46, tTransformSmallTexX[transform]+49, tTransformSmallTexY[transform])
				end
			
			-- �� X��
			else
				drawer:drawTexture("UIData/"..tTransformSmallFileName[transform], 8, spacing+157, 46, 46, tTransformSmallTexX[transform]+98, tTransformSmallTexY[transform])
			end
			
		-- ��(���)
		else
			drawer:drawTexture("UIData/"..tTransformSmallFileName[transform], 8, spacing+157, 46, 46, tTransformSmallTexX[transform], tTransformSmallTexY[transform])
		end
	end
	
	
	-- ����
	drawer:setFont(g_STRING_FONT_GULIMCHE, FONT_SIZE)
	drawer:setTextColor(255,205,86,255)
	drawer:drawText("Lv."..level, 18,  spacing+155)
	
	-- �̸�
	drawer:setTextColor(255,255,255,255)
	drawer:drawText(name, 65, spacing+155)
	
	-- ����Ʈ
	drawer:drawTexture("UIData/zombi001.tga", 58, spacing+194, 16, 16, 995, 408, WIDETYPE_0)
	local PointText = CommatoMoneyStr(point)
	drawer:setTextColor(255,255,255,255)
	drawer:drawText(PointText, 80, spacing+198)
end




-- ������ ���� �ε���
local g_SelectedIndex = -1;

--------------------------------------------------------------------------------
-- �� ����â ����
--------------------------------------------------------------------------------
local GunWindow = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_SelectGun_Alpha")
GunWindow:setTexture("Enabled",		"UIData/invisible.TGA", 0, 0)
GunWindow:setTexture("Disabled",	"UIData/invisible.TGA", 0, 0)
GunWindow:setProperty("FrameEnabled", "False")
GunWindow:setProperty("BackgroundEnabled", "False")
GunWindow:setSize(688, 289) -- x485
GunWindow:setPosition( g_x - (485/2), g_y - (230) )
GunWindow:setZOrderingEnabled(false)
GunWindow:setVisible(false)
root:addChildWindow(GunWindow)


--------------------------------------------------------------------------------
-- �� ���� ����â
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_SelectGun_Back")
window:setTexture("Enabled",	"UIData/zombi002.tga", 0, 0)
window:setTexture("Disabled",	"UIData/zombi002.tga", 0, 0)
window:setProperty("FrameEnabled", "False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(485, 289) -- x485
window:setPosition(0,0)
window:setZOrderingEnabled(false)
window:setVisible(true)
GunWindow:addChildWindow(window)


--------------------------------------------------------------------------------
-- �� ���� "�ִϸ��̼�" ����â
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_WeaponSelect_Main")
window:setTexture("Enabled",	"UIData/zombi002.tga", 0, 289)
window:setTexture("Disabled",	"UIData/zombi002.tga", 0, 289)
window:setProperty("FrameEnabled",		"False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(203, 246)
window:setPosition(481,43)
window:setZOrderingEnabled(false)
window:setVisible(true)
GunWindow:addChildWindow(window)


--------------------------------------------------------------------------------
-- ����, ��Ʋ��, ����ī ��ư 3��
--------------------------------------------------------------------------------
local tGunTexPosX = { ['err'] = 0 , 485, 631, 777 }
local tGunImgPosX = { ['err'] = 0 , 16,	 168, 320 } 
for i = 1 , 3 do
	local mywindow = winMgr:createWindow("TaharezLook/Button", "WndDefence_SelectGun_" .. i)
	mywindow:setTexture("Normal",	"UIData/zombi002.tga", tGunTexPosX[i], 0)
	mywindow:setTexture("Hover",	"UIData/zombi002.tga", tGunTexPosX[i], 178)
	mywindow:setTexture("Pushed",	"UIData/zombi002.tga", tGunTexPosX[i], 356)
	mywindow:setTexture("PushedOff","UIData/zombi002.tga", tGunTexPosX[i], 356)
	mywindow:setTexture("Enabled",	"UIData/zombi002.tga", tGunTexPosX[i], 0)
	mywindow:setTexture("Disabled",	"UIData/zombi002.tga", tGunTexPosX[i], 0)
	
	mywindow:setPosition( tGunImgPosX[i] , 61 )
	mywindow:setAlwaysOnTop(true)
	mywindow:setSize(145, 178)
	mywindow:setEnabled(true)
	mywindow:setUserString("GunIndex" , tostring(i) )
	mywindow:subscribeEvent("Clicked", "UserSelectGun")
	
	winMgr:getWindow("WndDefence_SelectGun_Back"):addChildWindow(mywindow)
end








--------------------------------------------------------------------------------
-- �Ϲ� / �ʻ�� ��
--------------------------------------------------------------------------------
for i=1, 2 do
	mywindow = winMgr:createWindow("TaharezLook/RadioButton", "Defence_Weapon_Tab_" .. i)
	
	mywindow:setTexture("Normal",			"UIData/zombi002.tga", 203 + ((i-1) * 56) , 341)
	mywindow:setTexture("Hover",			"UIData/zombi002.tga", 203 + ((i-1) * 56) , 315)
	mywindow:setTexture("Pushed",			"UIData/zombi002.tga", 203 + ((i-1) * 56) , 341)
	mywindow:setTexture("Disabled",			"UIData/zombi002.tga", 203 + ((i-1) * 56) , 341)

	mywindow:setTexture("SelectedNormal",	"UIData/zombi002.tga", 203 + ((i-1) * 56) , 289)
	mywindow:setTexture("SelectedHover",	"UIData/zombi002.tga", 203 + ((i-1) * 56) , 315)
	mywindow:setTexture("SelectedPushed",	"UIData/zombi002.tga", 203 + ((i-1) * 56) , 341)
	
	mywindow:setPosition(481 + ((i-1) * 56)  , 20)
	mywindow:setSize(56, 26)
	mywindow:setZOrderingEnabled(false)
	mywindow:setUserString("ItemTabIndex", i)
	mywindow:setSubscribeEvent("SelectStateChanged", "SelectWeaponTab")
	
	GunWindow:addChildWindow(mywindow)
end


function SelectWeaponTab(args)
	
	if g_SelectedIndex == -1 then
		return
	end
	
	local INTRODUCE_NORMAL  = 1
	local INTRODUCE_SPECIAL = 2
	
	-- 1. �̹��� ���½�Ų��.
	ResetWeaponAnimationInfo()
	
	-- 2. �� ���ÿ� ���� �ൿ�� ��Ų��.
	local EnterWindow = CEGUI.toWindowEventArgs(args).window
	
	if CEGUI.toRadioButton(EnterWindow):isSelected() then
		local tabIndex = tonumber(EnterWindow:getUserString("ItemTabIndex"));

		-- 1�� �� Ŭ�� -> �Ϲ��̹��� visible
		if tabIndex == INTRODUCE_NORMAL then
			winMgr:getWindow("Defence_Weapon_Introduce_Normal_" .. g_SelectedIndex):setVisible(true)	
			winMgr:getWindow("Defence_Weapon_Introduce_Normal_Caption_" .. g_SelectedIndex):setVisible(true)	
		
		-- 2�� �� Ŭ�� -> �ʻ��̹��� visible
		elseif tabIndex == INTRODUCE_SPECIAL then
			winMgr:getWindow("Defence_Weapon_Introduce_Special_" .. g_SelectedIndex):setVisible(true)
			winMgr:getWindow("Defence_Weapon_Introduce_Special_Caption_" .. g_SelectedIndex):setVisible(true)
		end
	end
	
	
end


----------------------------------------------------------------------
-- �Ϲ��̹��� 1,2,3 , �ʻ��̹��� 1,2,3
----------------------------------------------------------------------
for i = 1 , 3 do
	-- �Ϲ��ʻ�� 1,2,3
	local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_Weapon_Introduce_Normal_" .. i)
	mywindow:setTexture("Enabled",	"UIData/zombi002.tga", 0 + ( (i-1) * 177 ) , 740)
	mywindow:setTexture("Disabled", "UIData/zombi002.tga", 0 + ( (i-1) * 177 ) , 740)
	mywindow:setPosition(11 , 10)
	mywindow:setSize(177, 142)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("WndDefence_WeaponSelect_Main"):addChildWindow(mywindow)
	
	-- �Ϲ��ʻ�� '����' 1,2,3
	local mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_Weapon_Introduce_Normal_Caption_" .. i)
	mywindow:setTexture("Enabled",	"UIData/zombi002.tga", 0 + ( (i-1) * 203 ) , 535)
	mywindow:setTexture("Disabled", "UIData/zombi002.tga", 0 + ( (i-1) * 203 ) , 535)
	mywindow:setPosition(0 , 160)
	mywindow:setSize(203, 83)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("WndDefence_WeaponSelect_Main"):addChildWindow(mywindow)
	
	
	
	-- �ʻ��̹��� 1,2,3
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_Weapon_Introduce_Special_" .. i)
	mywindow:setTexture("Enabled",	"UIData/zombi002.tga", 0 + ( (i-1) * 177 ) , 882)
	mywindow:setTexture("Disabled", "UIData/zombi002.tga", 0 + ( (i-1) * 177 ) , 882)
	mywindow:setPosition(11 , 10)
	mywindow:setSize(177, 142)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("WndDefence_WeaponSelect_Main"):addChildWindow(mywindow)
	
	-- �ʻ��̹��� '����' 1,2,3
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "Defence_Weapon_Introduce_Special_Caption_" .. i)
	mywindow:setTexture("Enabled",	"UIData/zombi002.tga", 0 + ( (i-1) * 203 ) , 618)
	mywindow:setTexture("Disabled", "UIData/zombi002.tga", 0 + ( (i-1) * 203 ) , 618)
	mywindow:setPosition(0 , 160)
	mywindow:setSize(203, 83)
	mywindow:setVisible(false)
	mywindow:setAlwaysOnTop(true)
	mywindow:setZOrderingEnabled(false)
	winMgr:getWindow("WndDefence_WeaponSelect_Main"):addChildWindow(mywindow)
end

-- �ִϸ��̼� ���� �Լ�
function ResetWeaponAnimationInfo()
	for i = 1 , 3 do
		winMgr:getWindow("Defence_Weapon_Introduce_Normal_" .. i):setVisible(false)
		winMgr:getWindow("Defence_Weapon_Introduce_Special_" .. i):setVisible(false)
		
		
		winMgr:getWindow("Defence_Weapon_Introduce_Normal_Caption_" .. i):setVisible(false)
		winMgr:getWindow("Defence_Weapon_Introduce_Special_Caption_" .. i):setVisible(false)
	end
end

function SetCurrentAnimationInfo(index)
	ResetWeaponAnimationInfo()	-- �ִϸ��̼� ����
	winMgr:getWindow("Defence_Weapon_Introduce_Normal_" .. index):setVisible(true)
	winMgr:getWindow("Defence_Weapon_Introduce_Normal_Caption_" .. index):setVisible(true)
end






--------------------------------------------------------------------------------
-- �� ���� Ȯ�� ��ư
--------------------------------------------------------------------------------
local mywindow = winMgr:createWindow("TaharezLook/Button", "WndDefence_SelectGun_OK_Btn")
mywindow:setTexture("Normal",	"UIData/zombi002.tga", 923, 0)
mywindow:setTexture("Hover",	"UIData/zombi002.tga", 923, 34)
mywindow:setTexture("Pushed",	"UIData/zombi002.tga", 923, 68)
mywindow:setTexture("PushedOff","UIData/zombi002.tga", 923, 102)
mywindow:setTexture("Enabled",	"UIData/zombi002.tga", 923, 0)
mywindow:setTexture("Disabled",	"UIData/zombi002.tga", 923, 102)
mywindow:setPosition( (485/2)-(95/2) , 242 )
mywindow:setAlwaysOnTop(true)
mywindow:setSize(95, 34)
mywindow:setEnabled(false)
mywindow:subscribeEvent("Clicked", "SelectGunOkBtnEvent")
winMgr:getWindow("WndDefence_SelectGun_Back"):addChildWindow(mywindow)

-------------------------------------------
-- Name : UserSelectGun(args)
-- Desc : �� ���� ��ư Ŭ�� �̺�Ʈ
-------------------------------------------
function UserSelectGun(args)
	local local_window = CEGUI.toWindowEventArgs(args).window
	local index = tonumber(local_window:getUserString("GunIndex"))
	
	
	
	-- ���� üũ
	if index == 1 then
		PlayWave('sound/Zombie/Zombie_Select_Shotgun.wav');
	elseif index == 2 then
		PlayWave('sound/Zombie/Zombie_Select_Catling.wav');
	elseif index == 3 then
		PlayWave('sound/Zombie/Zone4_Zombie_Select_bazooka.wav');
	end
	
	-- ���õ� �� �ε��� ����
	g_SelectedIndex = index
	--DStr("g_SelectedIndex : " .. g_SelectedIndex)


	-- 1. ��ư ��Ȱ��ȭ		
	for i = 1 , 3 do
		if index == i then
			winMgr:getWindow("WndDefence_SelectGun_" .. index):setEnabled(false)
		else
			winMgr:getWindow("WndDefence_SelectGun_" .. i):setEnabled(true)
		end			
	end
	
	
	-- 2. ���õ� ��ư ���� ����
	winMgr:getWindow("WndDefence_SelectGun_" .. index):setTexture("Enabled",	"UIData/zombi002.tga", tGunTexPosX[index], 178)
	winMgr:getWindow("WndDefence_SelectGun_" .. index):setTexture("Disabled",	"UIData/zombi002.tga", tGunTexPosX[index], 178)
	
	-- 3. Ȯ�ι�ư Ȱ��ȭ
	winMgr:getWindow("WndDefence_SelectGun_OK_Btn"):setEnabled(true)
	
	
	---------------------------------------------------------------------------------------------------------------------------
	-- �ִϸ��̼� �� ���� ó�� �κ�.
	------------------------------------------------------------------------------------------------------------------------------
	winMgr:getWindow("Defence_Weapon_Tab_1"):setProperty("Selected" , "true")	-- �Ϲ� Ȱ��ȭ
	winMgr:getWindow("Defence_Weapon_Tab_2"):setProperty("Selected" , "false")	-- �ʻ� ��Ȱ��ȭ
	
	-- �̹��� ���� ( �Ϲ�����.. )
	SetCurrentAnimationInfo(g_SelectedIndex)
end



-- �� ����â �ѱ�
function ShowSelectGunWnd()
	winMgr:getWindow("WndDefence_SelectGun_Alpha"):setVisible(true)
end

--ShowSelectGunWnd()

-- �� ����â ����
function CloseSelectGunWindow()
	winMgr:getWindow("WndDefence_SelectGun_Alpha"):setVisible(false)
end

-- �� ����â Ȯ�ι�ư Ŭ��
function SelectGunOkBtnEvent()
	--DStr("�Ѽ���")
	RequestCreateWeapon(g_SelectedIndex)
	winMgr:getWindow("WndDefence_SelectGun_Alpha"):setVisible(false)
end


-- ��Ÿ�� �ؽ��� ��ġ
local tTexturePosX = { ['err']=0, }

-- ��Ÿ���� ���� �������� �˷��ش�
function ShowNotifyEndCoolTimeItem(itemType)
	
	local PositionX = g_x-(51/2)	-- ���� ���� ��ġ
	local PositionY = g_y-(80/2)
	
	local TexPosX	= 39	-- �ؽ��� ��ǥ
	local TexPosY	= 815
	
	local ScaleX	= 500	-- ������
	local ScaleY	= 500
	
	local Alpha		= 255	-- ����
	
	
	drawer:drawTextureWithScale_Angle_Offset("UIData/zombi001.tga", PositionX, PositionY,	-- ���� ������
																	51, 80,					-- ������
																	TexPosX, TexPosY,		-- �ؽ��� ������
																	ScaleX, ScaleY,			-- ������
																	Alpha,					-- ����
																	0,8,100 , WIDETYPE_5)	-- ��Ÿ ���
																	
																	
end





--------------------------------------------------------------------------------
-- Function : SettingDefenceItemIcon()
-- Desc		: ������ �������� ��ġ�� �����Ѵ�.
--------------------------------------------------------------------------------
local tKeyIndexText = {["err"]=0, [0]="1","2","3","4","5","6","7","8","9","0"}
function SettingDefenceItemIcon()
	
	-- 2. ������ �°� Draw
	for i = 0, ICON_MAX-1 do
		
		-- 3. �������� UI�� Position�� �޾ƿ´�.
		local ICON_BAR = 0
		local acquirePoint	= Defence_GetNeedPoint(i)
		local acquirePointText = CommatoMoneyStr(acquirePoint)
		local acquirePointtextSize = GetStringSize(g_STRING_FONT_GULIMCHE, 9, tostring(acquirePointText))
		
		--------------------------------------------------------------------------------
		-- ������ ������ �̹���
		--------------------------------------------------------------------------------
		local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_ItemIcon_" .. i)
		window:setTexture("Enabled",	"UIData/zombi001.tga", i*37, 784)
		window:setTexture("Disabled",	"UIData/zombi001.tga", i*37, 784)
		window:setProperty("FrameEnabled",		"False")
		window:setProperty("BackgroundEnabled", "False")
		window:setSize(37, 36)
	--	window:setPosition(525 + (i * 40) , 4)
	--	window:setPosition(10 + (i * 40) , 5)
		window:setPosition(9 + (i*40), 8)
		window:setZOrderingEnabled(false)
		window:setEnabled(false)
		window:setAlwaysOnTop(false)
		window:setVisible(true)
		winMgr:getWindow("MainBarExtend"):addChildWindow(window)
		
		--------------------------------------------------------------------------------
		-- ������ Ű �ε���
		--------------------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "WndDefence_KeyIndex_Text_" .. i)
		mywindow:setProperty("FrameEnabled",		"false")
		mywindow:setProperty("BackgroundEnabled",	"false")
	--	mywindow:setPosition(530 + (i * 40) , 8)
	--	mywindow:setPosition(15 + (i * 40) , 9)
		mywindow:setPosition(5 , 4)
		mywindow:setSize(40, 20)
		mywindow:setAlign(0)
		mywindow:setLineSpacing(12)
		mywindow:setViewTextMode(1)
		mywindow:setTextExtends(tKeyIndexText[i], g_STRING_FONT_GULIMCHE, 10,  255,255,255,255,    1,		0,0,0,255)
		mywindow:setVisible(true)
		winMgr:getWindow("WndDefence_ItemIcon_" .. i):addChildWindow(mywindow)
		
		--------------------------------------------------------------------------------
		-- �ʿ� ����Ʈ
		--------------------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "WndDefence_AcquirePoint_Text_" .. i)
		mywindow:setProperty("FrameEnabled",		"false")
		mywindow:setProperty("BackgroundEnabled",	"false")
	--	mywindow:setPosition(544 + (i * 40) - acquirePointtextSize/2 , 44)
	--	mywindow:setPosition(29 + (i * 40) - acquirePointtextSize/2 , 33)
		mywindow:setPosition(19 - acquirePointtextSize/2 , 26)
		mywindow:setSize(40, 20)
		mywindow:setAlign(0)
		mywindow:setLineSpacing(12)
		mywindow:setViewTextMode(1)
		mywindow:setTextExtends(acquirePointText, g_STRING_FONT_GULIMCHE, 9,  255,255,0,255,    1,		0,0,0,255)
		mywindow:setVisible(true)
		mywindow:setAlwaysOnTop(true)
		winMgr:getWindow("WndDefence_ItemIcon_" .. i):addChildWindow(mywindow)
		
			
		--------------------------------------------------------------------------------
		-- ��Ÿ�� ( ����â )
		--------------------------------------------------------------------------------
		window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_CoolTimeBtn_" .. i)
		window:setTexture("Enabled",	"UIData/zombi001.tga", 37, 884)
		window:setTexture("Disabled",	"UIData/zombi001.tga", 37, 884)
		window:setProperty("FrameEnabled",		"False")
		window:setProperty("BackgroundEnabled", "False")
		window:setSize(37, 36)
	--	window:setPosition(525 + (i * 40) , 4)
	--	window:setPosition(11 + (i * 40) , 6)
		window:setZOrderingEnabled(false)
		window:setEnabled(true)
		window:setVisible(false)
		winMgr:getWindow("WndDefence_ItemIcon_" .. i):addChildWindow(window)

		--------------------------------------------------------------------------------
		-- �� ���� ( ����â )
		--------------------------------------------------------------------------------
		window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_NoMoneyBtn_" .. i)
		window:setTexture("Enabled",	"UIData/zombi001.tga", 74, 884)
		window:setTexture("Disabled",	"UIData/zombi001.tga", 74, 884)
		window:setProperty("FrameEnabled",		"False")
		window:setProperty("BackgroundEnabled", "False")
		window:setSize(37, 36)
	--	window:setPosition(525 + (i * 40) , 4)
	--	window:setPosition(11 + (i * 40) , 6)
		window:setZOrderingEnabled(false)
		window:setEnabled(false)
		window:setVisible(false)
		winMgr:getWindow("WndDefence_ItemIcon_" .. i):addChildWindow(window)
		
		--------------------------------------------------------------------
		-- ���� ���� ��Ÿ�� �ؽ�Ʈ
		--------------------------------------------------------------------
		mywindow = winMgr:createWindow("TaharezLook/StaticText", "WndDefence_RemainTime_Text_" .. i)
		mywindow:setProperty("FrameEnabled",		"false")
		mywindow:setProperty("BackgroundEnabled",	"false")
	--	mywindow:setPosition(539 + (i * 40) , 16)
	--	mywindow:setPosition(24 + (i * 40) , 17)
		mywindow:setPosition(13 , 12)
		mywindow:setSize(40, 20)
		mywindow:setAlign(0)
		mywindow:setLineSpacing(12)
		mywindow:setViewTextMode(1)
		mywindow:addTextExtends("", g_STRING_FONT_GULIMCHE, 12,  255,0,0,255,    2,		0,0,0,255)
		mywindow:setVisible(true)
		winMgr:getWindow("WndDefence_ItemIcon_" .. i):addChildWindow(mywindow)
	end
end


--------------------------------------------------------------------------------
-- Function : ResetItemIcons()
-- Desc		: ������,����â ����( �� �Լ��� �������� ����� )
--------------------------------------------------------------------------------
function ResetItemIcons()
	
	-- 1. �������� �� ������ �����´�
	local left_END  = g_x-(1024/2);
		
	-- 2. ������ �°� Draw
	for i = 0, ICON_MAX-1 do
	
		--------------------------------------------------------------------------------
		-- ������ ������ �̹���
		--------------------------------------------------------------------------------
		local realIndex = Defence_GetItemIconRealIndex(i)
		local posX = (realIndex % 10) * 39
		local posY = (realIndex / 10) * 39
		
		winMgr:getWindow("WndDefence_ItemIcon_" .. i):setTexture("Enabled",	"UIData/zombi_item.tga", posX, posY)
		winMgr:getWindow("WndDefence_ItemIcon_" .. i):setTexture("Disabled","UIData/zombi_item.tga", posX, posY)
		
		--------------------------------------------------------------------------------
		-- ������ ����â
		--------------------------------------------------------------------------------
		local posX1 = (realIndex % 10) * 101
		local posY1 = (realIndex / 10) * 156
		
		winMgr:getWindow("WndDefence_ItemHelpWnd_" .. i):setTexture("Enabled",	"UIData/zombi_tab.tga", posX1, posY1)
		winMgr:getWindow("WndDefence_ItemHelpWnd_" .. i):setTexture("Disabled",	"UIData/zombi_tab.tga", posX1, posY1)
		
		
		--------------------------------------------------------------------------------
		-- ������ ����
		--------------------------------------------------------------------------------
		local acquirePoint	= Defence_GetNeedPoint(i)
		local acquirePointText = CommatoMoneyStr(acquirePoint)
		local acquirePointtextSize = GetStringSize(g_STRING_FONT_GULIMCHE, 9, tostring(acquirePointText))
		winMgr:getWindow("WndDefence_AcquirePoint_Text_" .. i):setTextExtends(acquirePointText, g_STRING_FONT_GULIMCHE, 9,  255,255,0,255,    1,		0,0,0,255)
		
	end
end



--------------------------------------------------------------------------------
-- Function : ItemCoolTimeUpdate()
-- Desc		: ������ ��Ÿ�� ������Ʈ(1�ʸ��� ȣ��)
--------------------------------------------------------------------------------
function ItemCoolTimeUpdate()
		
	-- 1. ���Ұ� ������ UI �ٲٱ�
	ComputePossibleItem() -- lua Function
	
	-- 2. ��Ÿ�� �׸���
	for i =0 , ICON_MAX-1 do
		local ScaleValue, RemainTime = GetCurrentCoolTime(i)
		
		---------------------------------------------------------------------
		-- ��Ÿ�� �̹��� �����ϸ�
		---------------------------------------------------------------------
		winMgr:getWindow("WndDefence_CoolTimeBtn_" .. i):setScaleHeight(ScaleValue)
		
		---------------------------------------------------------------------
		-- ��Ÿ�� �ؽ�Ʈ ������
		---------------------------------------------------------------------
		if RemainTime > 0 then
			-- ��Ÿ�� ������
			winMgr:getWindow("WndDefence_RemainTime_Text_" .. i):clearTextExtends()
			winMgr:getWindow("WndDefence_RemainTime_Text_" .. i):addTextExtends(RemainTime, g_STRING_FONT_GULIMCHE, 12,  255,0,0,255,    2,		0,0,0,255)
			winMgr:getWindow("WndDefence_RemainTime_Text_" .. i):setVisible(true)
			winMgr:getWindow("WndDefence_NoMoneyBtn_" .. i):setVisible(false)
		else
			-- ��Ÿ�� ����
			winMgr:getWindow("WndDefence_RemainTime_Text_" .. i):clearTextExtends()
			winMgr:getWindow("WndDefence_RemainTime_Text_" .. i):addTextExtends(" " , g_STRING_FONT_GULIMCHE, 12,  255,0,0,255,    2,		0,0,0,255)
			winMgr:getWindow("WndDefence_RemainTime_Text_" .. i):setVisible(false)
		end
		
		winMgr:getWindow("WndDefence_CoolTimeBtn_" .. i):setEnabled(false)
		winMgr:getWindow("WndDefence_CoolTimeBtn_" .. i):setVisible(true)

		---------------------------------------------------------------------
		-- ������ ��� ī��Ʈ �׸��� debug��	
		---------------------------------------------------------------------
		--[[
		local useCount = GetItemUseCount(i)
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		drawer:setTextColor(255, 255, 255, 255)	
		drawer:drawText(useCount, (538+ ((i-1) * 40)) , height-200 , 6)
		]]--
	end	--  end of for
end -- end of function


-- ����Ʈ�� üũ�� ���ԺҰ� ������ ��󳻱�
function ComputePossibleItem()
	
	local myCurrnetPoint = GetMyPoint()
		
	-- �� ����Ʈ�� ������ ���Ѵ�.
	for i =0 , ICON_MAX-1 do 
		
		local NeedPoint = Defence_GetNeedPoint(i)
		
		if myCurrnetPoint < NeedPoint then
			winMgr:getWindow("WndDefence_NoMoneyBtn_" .. i):setVisible(true)	-- ����Ʈ ����!!
		else
			winMgr:getWindow("WndDefence_NoMoneyBtn_" .. i):setVisible(false)	-- ����Ʈ ���!!
		end
	end
end








--------------------------------------------------------------------------------
-- Function : SettingDefenceItemHelpWindow()
-- Desc		: ������ ����â�� �����Ѵ�
--------------------------------------------------------------------------------
function SettingDefenceItemHelpWindow()
	
	--------------------------------------------------------------------------------
	-- ������ ����â Ȯ��� ����
	--------------------------------------------------------------------------------
	local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_ItemHelpWnd_Extension1")
	window:setTexture("Enabled",	"UIData/zombi001.tga", 545, 0)
	window:setTexture("Disabled",	"UIData/zombi001.tga", 545, 0)
	window:setProperty("FrameEnabled",		"False")
	window:setProperty("BackgroundEnabled", "False")
	window:setScaleWidth(1200)
	window:setSize(101, 156)
	window:setPosition(-3 , height-274)
	window:setAlwaysOnTop(true)
	window:setZOrderingEnabled(false)
	window:setVisible(false)
	root:addChildWindow(window)

	local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_ItemHelpWnd_Extension2")
	window:setTexture("Enabled",	"UIData/zombi001.tga", 545, 0)
	window:setTexture("Disabled",	"UIData/zombi001.tga", 545, 0)
	window:setProperty("FrameEnabled",		"False")
	window:setProperty("BackgroundEnabled", "False")
	window:setScaleWidth(1200)
	window:setSize(101, 156)
	window:setPosition(g_x + (1024/2) - 30 , height-273)
	window:setEnabled(false)
	window:setAlwaysOnTop(true)
	window:setZOrderingEnabled(false)
	window:setVisible(false)
	root:addChildWindow(window)

	local left_END = g_x-(1024/2);
	for i=0, ICON_MAX-1 do
		
		local realIndex = Defence_GetItemIconRealIndex(i)
		local point = Defence_GetNeedPoint(i)
		local pointText = CommatoMoneyStr(point)
		local posX = (realIndex % 10) * 101
		local posY = (realIndex / 10) * 156
		local pointtextSize = GetStringSize(g_STRING_FONT_GULIMCHE, 11, tostring(pointText))
		
		--------------------------------------------------------------------------------
		-- ������ ����â
		--------------------------------------------------------------------------------
		local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_ItemHelpWnd_" .. i)
		window:setTexture("Enabled",	"UIData/zombi_tab.tga", posX, posY)
		window:setTexture("Disabled",	"UIData/zombi_tab.tga", posX, posY)
		window:setProperty("FrameEnabled",		"False")
		window:setProperty("BackgroundEnabled", "False")
		window:setSize(101, 156)
		window:setPosition((left_END) + i*101 + 7, 0)
		window:setAlwaysOnTop(true)
		window:setZOrderingEnabled(false)
		window:setVisible(false)
		root:addChildWindow(window)
		
		-- ����Ʈ �̹���
		window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_ItemHelpPointImage_" .. i)
		window:setTexture("Enabled",	"UIData/zombi001.tga", 1011, 410)
		window:setTexture("Disabled",	"UIData/zombi001.tga", 1011, 410)
		window:setProperty("FrameEnabled",		"False")
		window:setProperty("BackgroundEnabled", "False")
		window:setSize(13, 13)
		window:setPosition(50-pointtextSize, 132)
		window:setZOrderingEnabled(false)
		winMgr:getWindow("WndDefence_ItemHelpWnd_".. i):addChildWindow(window)
		
		-- ����Ʈ �ؽ�Ʈ
		window = winMgr:createWindow("TaharezLook/StaticText", "WndDefence_ItemHelpPointImage_Text_" .. i)
		window:setProperty("FrameEnabled",		"false")
		window:setProperty("BackgroundEnabled",	"false")
		window:setPosition(50-pointtextSize+16, 133)
		window:setSize(40, 20)
		window:setAlign(0)
		window:setLineSpacing(12)
		window:setViewTextMode(1)
		window:setTextExtends(pointText, g_STRING_FONT_GULIMCHE, 11,  255,255,0,255,    1,		0,0,0,255)
		window:setZOrderingEnabled(false)
		winMgr:getWindow("WndDefence_ItemHelpWnd_".. i):addChildWindow(window)
	end
end



--------------------------------------------------------------------------------
-- Function : ShowItemExplanation()
-- Desc		: ������ ����â ����
--------------------------------------------------------------------------------
function ShowItemExplanation()
	
	-- ������? Ŭ���̾�Ʈ����?
	local IsNowMode = Defence_GetCurrentMode()
	local MainPosY	= -1
	local SubPosY	= -1	
	
	if IsNowMode == MODE_CLIENT then
		if height <= 768 then
			PosY	= height - 155
			SubPosY = height - 155
		elseif height >= 1080 then
			PosY	= height - 160
			SubPosY = height - 160
		else
			PosY	= height - 182
			SubPosY = height - 182
		end
		
		-- ����
		for i = 0 , ICON_MAX-1 do
			winMgr:getWindow("WndDefence_ItemHelpWnd_".. i):setVisible(true)
			winMgr:getWindow("WndDefence_ItemHelpWnd_".. i):clearControllerEvent("BottonMenuUpEvent")
			winMgr:getWindow("WndDefence_ItemHelpWnd_".. i):clearActiveController()
			winMgr:getWindow("WndDefence_ItemHelpWnd_".. i):addController("DefenceController", "BottonMenuUpEvent", "y", "Sine_EaseInOut", 1200 , PosY, 1, true, false, 10)
			winMgr:getWindow("WndDefence_ItemHelpWnd_".. i):activeMotion("BottonMenuUpEvent")
		end
		
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension1"):setVisible(true)
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension1"):setScaleWidth(1200)
		winMgr:getWindow('WndDefence_ItemHelpWnd_Extension1'):clearControllerEvent("BottonMenuUpEvent")
		winMgr:getWindow('WndDefence_ItemHelpWnd_Extension1'):clearActiveController()
		winMgr:getWindow('WndDefence_ItemHelpWnd_Extension1'):addController("DefenceController", "BottonMenuUpEvent", "y", "Sine_EaseInOut", 1200 , SubPosY, 1, true, false, 10)
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension1"):activeMotion("BottonMenuUpEvent")
		
		
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension2"):setVisible(true)
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension2"):setScaleWidth(1200)
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension2"):clearControllerEvent("BottonMenuUpEvent")
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension2"):clearActiveController()
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension2"):addController("DefenceController", "BottonMenuUpEvent", "y", "Sine_EaseInOut", 1200 , SubPosY, 1, true, false, 10)
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension2"):activeMotion("BottonMenuUpEvent")
	else
		if height <= 768 then
			PosY	= height - 155
			SubPosY = height - 155
		elseif height >= 1080 then
			PosY	= height - 160
			SubPosY	= height - 160
		else
			PosY	= height - 182
			SubPosY = height - 182
		end
		
		-- ����
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension1"):setVisible(true)
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension1"):setPosition(-3 , SubPosY)
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension1"):setScaleWidth(1200)
		
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension2"):setVisible(true)
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension2"):setPosition(g_x + (1024/2) - 30 , SubPosY)
		winMgr:getWindow("WndDefence_ItemHelpWnd_Extension2"):setScaleWidth(1200)
		
		local left_END = g_x-(1024/2);
		for i = 0 , ICON_MAX-1 do
			winMgr:getWindow("WndDefence_ItemHelpWnd_".. i):setVisible(true)
			winMgr:getWindow("WndDefence_ItemHelpWnd_".. i):setPosition((left_END) + i*101 + 7, PosY)
		end
	end -- end of if
	
	
end

function CloseItemExplanation()
	-- �ݱ�
	for i = 0 , ICON_MAX-1 do
		winMgr:getWindow("WndDefence_ItemHelpWnd_".. i):setVisible(false)
	end
	
	winMgr:getWindow("WndDefence_ItemHelpWnd_Extension1"):setVisible(false)
	winMgr:getWindow("WndDefence_ItemHelpWnd_Extension2"):setVisible(false)
end





--------------------------------------------------------------------------------
-- [���] ����00 �̹���
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_Round_Img")
window:setTexture("Enabled",	"UIData/zombi001.tga", 281, 259)
window:setTexture("Disabled",	"UIData/zombi001.tga", 281, 259)
window:setProperty("FrameEnabled", "False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(275, 85)
window:setPosition(g_x - (275/2) - 50 , g_y - 200)
window:setEnabled(false)
window:setAlwaysOnTop(true)
window:setZOrderingEnabled(false)
window:setAlpha(0)
window:addController("MainRoundEvent", "MainRoundEvent", "alpha", "Sine_EaseInOut", 0, 255,   10,		false, false, 10)
window:addController("MainRoundEvent", "MainRoundEvent", "alpha", "Sine_EaseInOut", 255, 255, 20,		false, false, 10)
window:addController("MainRoundEvent", "MainRoundEvent", "alpha", "Sine_EaseInOut", 255, 0,   10,		false, false, 10)
root:addChildWindow(window)


--------------------------------------------------------------------------------
-- [���] ���� �ѹ� 2�� 
--------------------------------------------------------------------------------
local tRoundCountPosX = { ["err"]=0, [0]=0, 51,102,153,204,255,306,357,408,459 }

for i = 0 , #tRoundCountPosX do
	local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_Round1_" .. i)
	window:setTexture("Enabled",	"UIData/zombi001.tga", tRoundCountPosX[i], 344)
	window:setTexture("Disabled",	"UIData/zombi001.tga", tRoundCountPosX[i], 344)
	window:setProperty("FrameEnabled",		"False")
	window:setProperty("BackgroundEnabled", "False")
	window:setSize(51, 80)
	window:setPosition(g_x + 100 , g_y - 200)
	window:setEnabled(false)
	window:setAlwaysOnTop(true)
	window:setZOrderingEnabled(false)
	window:setAlpha(0)
	window:addController("RoundNumEvent1_" .. i, "RoundNumEvent1_" .. i, "alpha", "Sine_EaseInOut", 0, 255,   10,		false, false, 10)
	window:addController("RoundNumEvent1_" .. i, "RoundNumEvent1_" .. i, "alpha", "Sine_EaseInOut", 255, 255, 20,		false, false, 10)
	window:addController("RoundNumEvent1_" .. i, "RoundNumEvent1_" .. i, "alpha", "Sine_EaseInOut", 255, 0,   10,		false, false, 10)
	root:addChildWindow(window)



	local window2 = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_Round2_" .. i)
	window2:setTexture("Enabled",	"UIData/zombi001.tga", tRoundCountPosX[i], 344)
	window2:setTexture("Disabled",	"UIData/zombi001.tga", tRoundCountPosX[i], 344)
	window2:setProperty("FrameEnabled", "False")
	window2:setProperty("BackgroundEnabled", "False")
	window2:setSize(51, 80)
	window2:setPosition(g_x + 151 , g_y - 200)
	window2:setEnabled(false)
	window2:setAlwaysOnTop(true)
	window2:setZOrderingEnabled(false)
	window2:setAlpha(0)
	window2:addController("RoundNumEvent2_" .. i, "RoundNumEvent2_" .. i, "alpha", "Sine_EaseInOut", 0, 255,   10,		false, false, 10)
	window2:addController("RoundNumEvent2_" .. i, "RoundNumEvent2_" .. i, "alpha", "Sine_EaseInOut", 255, 255, 20,		false, false, 10)
	window2:addController("RoundNumEvent2_" .. i, "RoundNumEvent2_" .. i, "alpha", "Sine_EaseInOut", 255, 0,   10,		false, false, 10)
	root:addChildWindow(window2)
	
	--DStr("i : " .. i)
end

--------------------------------------------------------------------------------
-- [���] Start �̹���
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_Start_Img")
window:setTexture("Enabled",	"UIData/zombi001.tga", 0, 259)
window:setTexture("Disabled",	"UIData/zombi001.tga", 0, 259)
window:setProperty("FrameEnabled", "False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(281, 85)
window:setPosition(g_x - (281/2) , g_y-100)
window:setZOrderingEnabled(false)
window:setEnabled(false)
window:setAlpha(0)
window:addController("StartEvent", "StartEvent", "alpha", "Sine_EaseInOut", 0, 255,   10,		false, false, 3)
window:addController("StartEvent", "StartEvent", "alpha", "Sine_EaseInOut", 255, 255, 20,		false, false, 10)
window:addController("StartEvent", "StartEvent", "alpha", "Sine_EaseInOut", 255, 0,   10,		false, false, 10)
root:addChildWindow(window)



-- [����]�� ROUND �̹��� ������
function ShowNotifyMainRoundImg(isFirstStage, RoundCnt)
	-- ���� �̹��� ������
	winMgr:getWindow("WndDefence_Round_Img"):activeMotion("MainRoundEvent")

	-- �ѹ� ���� �۾�
--	local RoundCnt	= GetCurrentRoundNumber()
	local One		= (RoundCnt / 10)
	local Two		= (RoundCnt % 10)
	--DStr("111 One : " .. One)
	--DStr("111 Two : " .. Two)

	-- ���� �ѹ� ������
	winMgr:getWindow("WndDefence_Round1_" .. One):activeMotion("RoundNumEvent1_" .. One)
	winMgr:getWindow("WndDefence_Round2_" .. Two):activeMotion("RoundNumEvent2_" .. Two)
	
	-- ��ŸƮ ������( ù���϶��� ���´� )
	if isFirstStage == true then
		winMgr:getWindow("WndDefence_Start_Img"):activeMotion("StartEvent")
	end
	
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------
-- [���] ����00 ���� �̹���
--------------------------------------------------------------------------------
local SMainAlpha = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_Center_Small_Alpha")
SMainAlpha:setTexture("Enabled",	"UIData/invisible.tga", 0, 971)
SMainAlpha:setTexture("Disabled",	"UIData/invisible.tga", 0, 971)
SMainAlpha:setProperty("FrameEnabled",		"False")
SMainAlpha:setProperty("BackgroundEnabled", "False")
SMainAlpha:setSize(260, 80)
SMainAlpha:setPosition( g_x-(190/2) + 5 , (height-height)+57 )
SMainAlpha:setZOrderingEnabled(false)
SMainAlpha:setVisible(true)
root:addChildWindow(SMainAlpha)

--------------------------------------------------------------------------------
-- [���] ����00
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_Round_Small")
window:setTexture("Enabled",	"UIData/zombi001.tga", 281, 259)
window:setTexture("Disabled",	"UIData/zombi001.tga", 281, 259)
window:setProperty("FrameEnabled",		"False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(275, 85)
window:setPosition(10,0)
window:setScaleHeight(100)
window:setScaleWidth(100)
window:setZOrderingEnabled(false)
window:setVisible(false)
SMainAlpha:addChildWindow(window)


local tRoundNumber_Position = { ['err']= 0 , [0] = 0, 51, 102, 153, 204, 255, 306, 357, 408, 459 }
function ShowNotifySmallRoundImg()
	local window_local = winMgr:getWindow("WndDefence_Round_Small")
	if window_local ~= nil then
		if window_local:isVisible() == false then
			window_local:setVisible(true)
		end
	end
	
	
	-- ���� ���� ���� �޾Ƴ���
	local RoundCnt = GetCurrentRoundNumber()
	
	-- ���� ��󳻱�
	local Number_One = (RoundCnt / 10)
	local Number_Two = (RoundCnt % 10)
	
	--DStr("2222 Number_One : " .. Number_One)
	--DStr("2222 Number_Two : " .. Number_Two)
	
	local posX = g_x + 45
	local posY = 75
	
	drawer:drawTextureWithScale_Angle_Offset("UIData/zombi001.tga" , posX,    posY, 51, 80, tRoundNumber_Position[Number_One], 344,   100, 100, 255, 0, 8, 100,WIDETYPE_5)
	drawer:drawTextureWithScale_Angle_Offset("UIData/zombi001.tga" , posX+20, posY, 51, 80, tRoundNumber_Position[Number_Two], 344,   100, 100, 255, 0, 8, 100,WIDETYPE_5)
--																���������� ,������, ��ǥ,          	 ������,������,����,����,?,?
end


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------




--------------------------------------------------------------------------------
-- ���� �̹���!
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_Fail")
window:setTexture("Enabled",	"UIData/zombi001.tga", 556, 259)
window:setTexture("Disabled",	"UIData/zombi001.tga", 556, 259)
window:setProperty("FrameEnabled", "False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(435, 85)
window:setPosition((g_x)-(435/2), g_y)
window:setZOrderingEnabled(false)
window:setVisible(false)
root:addChildWindow(window)







--------------------------------------------------------------------------------
-- Ÿ�� hp ����
--------------------------------------------------------------------------------
local TowerBack = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_TowerHP_Back")
TowerBack:setTexture("Enabled",		"UIData/zombi001.tga", 0, 0)
TowerBack:setTexture("Disabled",	"UIData/zombi001.tga", 0, 0)
TowerBack:setProperty("FrameEnabled",		"False")
TowerBack:setProperty("BackgroundEnabled",	"False")
TowerBack:setSize(377, 39)
TowerBack:setWideType(7)
TowerBack:setPosition( (1024/2)-(377/2) , 669 )
TowerBack:setZOrderingEnabled(true)
TowerBack:setEnabled(false)
TowerBack:setVisible(false)
TowerBack:setAlwaysOnTop(false)
root:addChildWindow(TowerBack)
TowerBack:moveToBack()

--------------------------------------------------------------------------------
-- Ÿ�� hp
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_TowerHP")
window:setTexture("Enabled",	"UIData/zombi001.tga", 9, 39)
window:setTexture("Disabled",	"UIData/zombi001.tga", 9, 39)
window:setProperty("FrameEnabled",		"False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(368, 20)
window:setPosition(4, 16)
window:setZOrderingEnabled(false)
window:setVisible(true)
TowerBack:addChildWindow(window)

local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_TowerHP1")
window:setTexture("Enabled",	"UIData/zombi001.tga", 9, 70)
window:setTexture("Disabled",	"UIData/zombi001.tga", 9, 70)
window:setProperty("FrameEnabled",		"False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(368, 20)
window:setPosition(4, 16)
window:setZOrderingEnabled(false)
window:setVisible(false)
TowerBack:addChildWindow(window)

--------------------------------------------------------------------------------
-- Ÿ�� sp
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_TowerSP_MAX_AIN")
window:setTexture("Enabled",	"UIData/zombi001.tga", 646, 0)
window:setTexture("Disabled",	"UIData/zombi001.tga", 646, 0)
window:setProperty("FrameEnabled",		"False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(378, 37)
window:setPosition(-1, -9)
window:setAlwaysOnTop(false)
window:setZOrderingEnabled(false)
window:setVisible(false)
TowerBack:addChildWindow(window)

--------------------------------------------------------------------------------
-- Ÿ�� sp
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_TowerSP")
window:setTexture("Enabled",	"UIData/zombi001.tga", 25, 59)
window:setTexture("Disabled",	"UIData/zombi001.tga", 25, 59)
window:setProperty("FrameEnabled",		"False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(352, 11)
window:setPosition(12, 4)
window:setZOrderingEnabled(false)
window:setVisible(true)
TowerBack:addChildWindow(window)

--------------------------------------------------------------------------------
-- Ÿ�� sp
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_TowerSP_MAX")
window:setTexture("Enabled",	"UIData/zombi001.tga", 510, 344)
window:setTexture("Disabled",	"UIData/zombi001.tga", 510, 344)
window:setProperty("FrameEnabled",		"False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(75, 24)
window:setPosition(150, -2)
window:setZOrderingEnabled(false)
window:setVisible(false)
TowerBack:addChildWindow(window)


--------------------------------------------------------------------
-- HP/MAXHP
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "WndDefence_TowerHPText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setSize(40, 20)
mywindow:setAlign(0)
mywindow:setLineSpacing(12)
mywindow:setViewTextMode(1)
mywindow:setPosition(125 , 5)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:addTextExtends(" ", g_STRING_FONT_GULIMCHE, 11, 255, 255, 0, 255, 1, 0, 0, 0, 255)
winMgr:getWindow("WndDefence_TowerHP"):addChildWindow(mywindow)

--------------------------------------------------------------------
-- SP/MAX SP
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "WndDefence_TowerSPText")
mywindow:setProperty("FrameEnabled", "false")
mywindow:setProperty("BackgroundEnabled", "false")
mywindow:setSize(40, 20)
mywindow:setAlign(0)
mywindow:setLineSpacing(12)
mywindow:setViewTextMode(1)
mywindow:setPosition(135 , 0)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:addTextExtends(" ", g_STRING_FONT_GULIMCHE, 11, 255, 255, 0, 255, 1, 0, 0, 0, 255)
winMgr:getWindow("WndDefence_TowerSP"):addChildWindow(mywindow)

--  Ÿ���� hp������
local g_Effect = false
local EffectGauge = 0
local g_HP = GetDefence_TowerHP()
function RenderTowerHPGauge(deltaTime)
	winMgr:getWindow("WndDefence_TowerHP_Back"):setVisible(true)
	winMgr:getWindow("WndDefence_TowerHP"):setVisible(true)
	winMgr:getWindow("WndDefence_TowerSP"):setVisible(true)
	
	local MaxHp, MaxSp, hp, sp = GetDefenceTowerHpSp()
	
	if hp <= 0 then
		return
	end
	
	local computeCurrentHP = hp * 368 / MaxHp
	local computeCurrentSP = sp * 352 / MaxSp
	
	if g_HP ~= hp then
		g_Effect = true 
		g_HP = hp
	end
	if g_Effect then
		EffectGauge = EffectGauge + deltaTime
		if EffectGauge >= 400 then
			g_Effect = false
			EffectGauge = 0
		end
	end

	local _EffectGauge = EffectGauge % 60
	if _EffectGauge > 30 then
		winMgr:getWindow("WndDefence_TowerHP1"):setVisible(true)
	else
		winMgr:getWindow("WndDefence_TowerHP1"):setVisible(false)
	end
	winMgr:getWindow("WndDefence_TowerHP1"):setSize(computeCurrentHP, 20)
	winMgr:getWindow("WndDefence_TowerHP"):setSize(computeCurrentHP, 20)
	winMgr:getWindow("WndDefence_TowerSP"):setSize(computeCurrentSP, 11)
	
	-- HP Text
	local textHP = CommatoMoneyStr(hp)
	local textHP1 = "Tower HP : " .. textHP
	winMgr:getWindow("WndDefence_TowerHPText"):clearTextExtends()
	winMgr:getWindow("WndDefence_TowerHPText"):addTextExtends(textHP1, g_STRING_FONT_GULIMCHE, 11, 255, 255, 255, 255, 1, 0, 0, 0, 255)
	
	-- SP Text
	local textSP = CommatoMoneyStr(sp)
	local textSP1 = "Tower SP : " .. sp
	
	if sp >= 10 then
		winMgr:getWindow("WndDefence_TowerSPText"):setPosition(132, 0)
	elseif sp >= 100 then
		winMgr:getWindow("WndDefence_TowerSPText"):setPosition(130, 0)
	elseif sp >= 1000 then
		winMgr:getWindow("WndDefence_TowerSPText"):setPosition(128, 0)
	elseif sp >= 10000 then
		winMgr:getWindow("WndDefence_TowerSPText"):setPosition(126, 0)
	end
	
	winMgr:getWindow("WndDefence_TowerSPText"):clearTextExtends()
	winMgr:getWindow("WndDefence_TowerSPText"):addTextExtends(textSP1, g_STRING_FONT_GULIMCHE, 11, 255, 255, 255, 255, 1, 0, 0, 0, 255)
end

function TowerSPMaxAnimation(DeltaTime)
	local NowTime	= DeltaTime - ToweSPMaxTime
	
	winMgr:getWindow("WndDefence_TowerSPText"):setVisible(false)
	winMgr:getWindow("WndDefence_TowerSP_MAX_AIN"):setVisible(true)
	winMgr:getWindow("WndDefence_TowerSP_MAX"):setVisible(true)

	winMgr:getWindow("WndDefence_TowerSP_MAX_AIN"):setTexture("Enabled",	"UIData/zombi001.tga", 646, 0 + (ToweSPMaxCount * 37))
	winMgr:getWindow("WndDefence_TowerSP_MAX_AIN"):setTexture("Disabled",	"UIData/zombi001.tga", 646, 0 + (ToweSPMaxCount * 37))
	
	if ToweSPMaxSpaceCount <= 6 then
		winMgr:getWindow("WndDefence_TowerSP_MAX"):setTexture("Enabled",	"UIData/zombi001.tga", 510 + (ToweSPMaxSpaceCount * 75), 344)
		winMgr:getWindow("WndDefence_TowerSP_MAX"):setTexture("Disabled",	"UIData/zombi001.tga", 510 + (ToweSPMaxSpaceCount * 75), 344)
	else
		winMgr:getWindow("WndDefence_TowerSP_MAX"):setTexture("Enabled",	"UIData/zombi001.tga", 510 + ((ToweSPMaxSpaceCount - 7) * 75), 368)
		winMgr:getWindow("WndDefence_TowerSP_MAX"):setTexture("Disabled",	"UIData/zombi001.tga", 510 + ((ToweSPMaxSpaceCount - 7) * 75), 368)
	end
	
	if NowTime >= 70 then
		ToweSPMaxCount		= ToweSPMaxCount + 1
		ToweSPMaxSpaceCount = ToweSPMaxSpaceCount + 1
		ToweSPMaxTime		= DeltaTime
	end
	
	if ToweSPMaxSpaceCount == 11 then
		ToweSPMaxSpaceCount = 0
	end
	
	if ToweSPMaxCount == 7 then
		ToweSPMaxCount = 0
	end
end

function SetSpMaxAniTime(nNumber)

	if nNumber == 0 then
		winMgr:getWindow("WndDefence_TowerSP_MAX_AIN"):setVisible(false)
		winMgr:getWindow("WndDefence_TowerSP_MAX"):setVisible(false)
		winMgr:getWindow("WndDefence_TowerSPText"):setVisible(true)
		ToweSPMaxCount		= 0
		ToweSPMaxSpaceCount = 0
	end
	
	ToweSPMaxTime = nNumber
	
end


--------------------------------------------------------------------------------
-- Danger �̺�Ʈ
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_Danger")
window:setTexture("Enabled",	"UIData/zombi001.tga", 0, 115)
window:setTexture("Disabled",	"UIData/zombi001.tga", 0, 115)
window:setProperty("FrameEnabled",		"False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(414, 98)
window:setWideType(6)
window:setPosition(300, (height-height)+100)
window:setEnabled(false)
window:setAlwaysOnTop(true)
window:setZOrderingEnabled(false)
window:setAlpha(0)
window:addController("DangerEvent", "DangerEvent", "alpha", "Sine_EaseInOut", 0, 255, 3,	false, false, 10)
window:addController("DangerEvent", "DangerEvent", "alpha", "Sine_EaseInOut", 255, 255, 5, false, false, 10)
window:addController("DangerEvent", "DangerEvent", "alpha", "Sine_EaseInOut", 255, 0, 3,	false, false, 10)
window:addController("DangerEvent", "DangerEvent", "alpha", "Sine_EaseInOut", 0, 255, 3,	false, false, 10)
window:addController("DangerEvent", "DangerEvent", "alpha", "Sine_EaseInOut", 255, 255, 5, false, false, 10)
window:addController("DangerEvent", "DangerEvent", "alpha", "Sine_EaseInOut", 255, 0, 3,	false, false, 10)
window:addController("DangerEvent", "DangerEvent", "alpha", "Sine_EaseInOut", 0, 255, 3,	false, false, 10)
window:addController("DangerEvent", "DangerEvent", "alpha", "Sine_EaseInOut", 255, 255, 10, false, false, 10)
window:addController("DangerEvent", "DangerEvent", "alpha", "Sine_EaseInOut", 255, 0, 10,	false, false, 10)

root:addChildWindow(window)

function NotifyDangerMessage()
	--DStr("NotifyDangerMessage����")
	PlayWave('sound/Zombie/Zombie_TimeAttack.wav');
	
	winMgr:getWindow("WndDefence_Danger"):clearActiveController()
	winMgr:getWindow("WndDefence_Danger"):activeMotion("DangerEvent")
end


--------------------------------------------------------------------
-- %d�� �Ŀ� ���� ��Ÿ���ϴ�
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "WndDefence_CommingSoonZombie_Text")
mywindow:setProperty("FrameEnabled",		"false")
mywindow:setProperty("BackgroundEnabled",	"false")
mywindow:setPosition(g_x - 150 , 100)
mywindow:setSize(40, 20)
mywindow:setAlign(0)
mywindow:setLineSpacing(12)
mywindow:setViewTextMode(1)
mywindow:addTextExtends("", g_STRING_FONT_GULIMCHE, 25,  255,228,0,255,    2,		0,0,0,255)
mywindow:setVisible(false)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
root:addChildWindow(mywindow)

function NotifyCommingSoonZombieMessage(num)

	if num <= 0 then
		winMgr:getWindow("WndDefence_CommingSoonZombie_Text"):clearTextExtends()
		winMgr:getWindow("WndDefence_CommingSoonZombie_Text"):addTextExtends("", g_STRING_FONT_GULIMCHE, 25,	255, 228, 0, 255, 1,0, 0, 0, 255)
		winMgr:getWindow("WndDefence_CommingSoonZombie_Text"):setVisible(false)
		return
	end
	
	local alpha		 = 255 / num
	local lastText	 = 0
	local resultText = 0	
	
	if IsKoreanLanguage() then
		lastText		= "�� �ڿ� ��Ÿ���ϴ�!"
		resultText		= "���� " .. num .. lastText
	--0426KSG����
	--elseif IsEngLanguage() then
	--	lastText		=  WndDefence_String_01
	--	resultText		=  lastText.." "..num.."sec"
	else -- �±�
		local firstText =  WndDefence_String_02 -- ����
		lastText		=  WndDefence_String_01 -- %d�� ��Ÿ���ϴ�.
		resultText		=  firstText .. " " .. num .. " " .. lastText
	end
		
	winMgr:getWindow("WndDefence_CommingSoonZombie_Text"):clearTextExtends()
	winMgr:getWindow("WndDefence_CommingSoonZombie_Text"):addTextExtends(resultText, g_STRING_FONT_GULIMCHE, 25,  255,228,0,255,    2,		0,0,0,255)
	winMgr:getWindow("WndDefence_CommingSoonZombie_Text"):setVisible(true)
	
end


--[[
--------------------------------------------------------------------------------
-- ��ųâ �ѹ� ( 0�� ~ 9�� ) ���� ����.
--------------------------------------------------------------------------------
local g_CurrentSkillNumber = -1

for i=0 , 10 do
	local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_SkillBar_Number_" .. i)
	window:setTexture("Enabled",	"UIData/zombi001.tga", 934 + (i*9) , 920)
	window:setTexture("Disabled",	"UIData/zombi001.tga", 934 + (i*9) , 920)
	window:setProperty("FrameEnabled", "False")
	window:setProperty("BackgroundEnabled", "False")
	window:setPosition(928, 16)
	window:setSize(9, 12)
	window:setZOrderingEnabled(false)
	window:setVisible(false)
	winMgr:getWindow("MainBarExtend"):addChildWindow(window)
	
	-- 0���� Default�� �����ص�.
	if i == 0 then
		g_CurrentSkillNumber = i; -- 0�� �־��ش�.
		window:setVisible(true)
	end
end


-- ��ų �ѹ� ������Ʈ
function UpdateSkillBarNumber(num)
	if num >= 10 and num < 0 then
		return
	end
	winMgr:getWindow("WndDefence_SkillBar_Number_" .. num ):setVisible(true)
end
]]--

--------------------------------------------------------------------------------
-- My Zen Image
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_Zen_Image")
window:setTexture("Enabled", "UIData/zombi001.tga", 995, 408)
window:setTexture("Disabled","UIData/zombi001.tga", 995, 408)
window:setProperty("FrameEnabled",		"False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(16, 16)
--window:setWideType(7)
window:setPosition(80 , 65)
window:setZOrderingEnabled(false)
window:setVisible(true)
root:addChildWindow(window)

--------------------------------------------------------------------
-- (Ŭ���̾�Ʈ ����) ���� ����Ʈ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "OnlyClient_MyPoint")
mywindow:setProperty("FrameEnabled",		"false")
mywindow:setProperty("BackgroundEnabled",	"false")
--mywindow:setPosition(width-120 , height - 73)
mywindow:setPosition(25 , 0)
mywindow:setAlign(0)
mywindow:setSize(40, 20)
mywindow:setLineSpacing(12)
mywindow:setViewTextMode(1)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addTextExtends(" ", g_STRING_FONT_GULIMCHE, 11, 255, 255, 0, 255, 1, 0, 0, 0, 255)
winMgr:getWindow("WndDefence_Zen_Image"):addChildWindow(mywindow)

--------------------------------------------------------------------------------
-- My Zen Image
--------------------------------------------------------------------------------
local window = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_Zen_Image2")
window:setTexture("Enabled", "UIData/zombi001.tga", 995, 408)
window:setTexture("Disabled","UIData/zombi001.tga", 995, 408)
window:setProperty("FrameEnabled",		"False")
window:setProperty("BackgroundEnabled", "False")
window:setSize(16, 16)
window:setWideType(7)
window:setPosition(916 , 683)
window:setZOrderingEnabled(false)
window:setVisible(true)
root:addChildWindow(window)

--------------------------------------------------------------------
-- (Ŭ���̾�Ʈ ����) ���� ����Ʈ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "OnlyClient_MyPoint2")
mywindow:setProperty("FrameEnabled",		"false")
mywindow:setProperty("BackgroundEnabled",	"false")
--mywindow:setPosition(width-120 , height - 73)
mywindow:setPosition(20 , 0)
mywindow:setAlign(0)
mywindow:setSize(40, 20)
mywindow:setLineSpacing(12)
mywindow:setViewTextMode(1)
mywindow:setVisible(true)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:addTextExtends(" ", g_STRING_FONT_GULIMCHE, 11, 255, 255, 0, 255, 1, 0, 0, 0, 255)
winMgr:getWindow("WndDefence_Zen_Image2"):addChildWindow(mywindow)

function ShowMyPoint()
	local point = GetMyPoint()
	local pointText = CommatoMoneyStr(point)
	
	winMgr:getWindow("OnlyClient_MyPoint"):clearTextExtends()
	winMgr:getWindow("OnlyClient_MyPoint"):addTextExtends(pointText, g_STRING_FONT_GULIMCHE, 15, 255, 255, 0, 255, 1, 0, 0, 0, 255)
	winMgr:getWindow("OnlyClient_MyPoint"):setVisible(true)
	
	winMgr:getWindow("OnlyClient_MyPoint2"):clearTextExtends()
	winMgr:getWindow("OnlyClient_MyPoint2"):addTextExtends(pointText, g_STRING_FONT_GULIMCHE, 15, 255, 255, 0, 255, 1, 0, 0, 0, 255)
	winMgr:getWindow("OnlyClient_MyPoint2"):setVisible(true)
end


--------------------------------------------------------------------------------------------------
-- Ÿ�� ���� ī��Ʈ ������ ( 60�� �ڿ� ���������� ���� �˴ϴ�. ) ( ������ �ð����� �����Ͻÿ� )
--------------------------------------------------------------------------------------------------
-- ������ �ð����� �����Ͻÿ�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "WndDefence_TimeAttackMessage_Text")
mywindow:setProperty("FrameEnabled",		"false")
mywindow:setProperty("BackgroundEnabled",	"false")
mywindow:setSize(40, 20)
mywindow:setAlign(0)
mywindow:setLineSpacing(12)
mywindow:setViewTextMode(1)
mywindow:setPosition(g_x - 150 , 200)
mywindow:setVisible(false)
mywindow:addTextExtends(" ", g_STRING_FONT_GULIMCHE, 11, 255, 255, 0, 255, 1, 0, 0, 0, 255)
root:addChildWindow(mywindow)

-- 60�� �ڿ� ���������� ����˴ϴ�
mywindow = winMgr:createWindow("TaharezLook/StaticText", "WndDefence_TimeAttackRemainTime_Text")
mywindow:setProperty("FrameEnabled",		"false")
mywindow:setProperty("BackgroundEnabled",	"false")
mywindow:setSize(40, 20)
mywindow:setAlign(0)
mywindow:setLineSpacing(12)
mywindow:setViewTextMode(1)
mywindow:setPosition(g_x - 180 , 235)
mywindow:setVisible(false)
mywindow:addTextExtends(" ", g_STRING_FONT_GULIMCHE, 11, 255, 255, 0, 255, 1, 0, 0, 0, 255)
root:addChildWindow(mywindow)

function ShowNotify_TimeAttackCount(currentTick)
	local text1 = WndDefence_String_04
	local text2	= currentTick .. WndDefence_String_05
	
	winMgr:getWindow("WndDefence_TimeAttackMessage_Text"):clearTextExtends()
	winMgr:getWindow("WndDefence_TimeAttackMessage_Text"):addTextExtends(text1, g_STRING_FONT_GULIMCHE, 25, 255, 255, 0, 255, 1, 0, 0, 0, 255)
	winMgr:getWindow("WndDefence_TimeAttackMessage_Text"):setVisible(true)
	
	winMgr:getWindow("WndDefence_TimeAttackRemainTime_Text"):clearTextExtends()
	winMgr:getWindow("WndDefence_TimeAttackRemainTime_Text"):addTextExtends(text2, g_STRING_FONT_GULIMCHE, 25, 255, 255, 0, 255, 1, 0, 0, 0, 255)
	winMgr:getWindow("WndDefence_TimeAttackRemainTime_Text"):setVisible(true)
	
end


--------------------------------------------------------------------
-- "Ÿ���� ���� �ް� �ֽ��ϴ�" 
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "WndDefence_TowerUnderAttack_Text")
mywindow:setProperty("FrameEnabled",		"false")
mywindow:setProperty("BackgroundEnabled",	"false")
mywindow:setSize(40, 20)
mywindow:setAlign(0)
mywindow:setLineSpacing(12)
mywindow:setViewTextMode(1)
mywindow:setPosition(g_x - 140 , 135)
mywindow:setVisible(false)
mywindow:addTextExtends(" ", g_STRING_FONT_GULIMCHE, 11, 255, 255, 0, 255, 1, 0, 0, 0, 255)
root:addChildWindow(mywindow)

function ShowNotify_TowerUnderAttack(alpha)
	local text = WndDefence_String_03

	winMgr:getWindow("WndDefence_TowerUnderAttack_Text"):clearTextExtends()
	winMgr:getWindow("WndDefence_TowerUnderAttack_Text"):addTextExtends(text, g_STRING_FONT_GULIMCHE, 25,   255,255,0, alpha,   1,     0,0,0, alpha)
	winMgr:getWindow("WndDefence_TowerUnderAttack_Text"):setVisible(true)
end

function CloseNotify_TowerUnderAttack()
	winMgr:getWindow("WndDefence_TowerUnderAttack_Text"):clearTextExtends()
	winMgr:getWindow("WndDefence_TowerUnderAttack_Text"):setVisible(false)
end



--------------------------------------------------------------------
-- �ѱ⼱�� ī��Ʈ
--------------------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticText", "WndDefence_WeaponSelect_Time")
mywindow:setProperty("FrameEnabled",		"false")
mywindow:setProperty("BackgroundEnabled",	"false")
mywindow:setPosition(g_x-100 , (height - height) + 580)
mywindow:setSize(40, 20)
mywindow:setAlign(0)
mywindow:setLineSpacing(12)
mywindow:setViewTextMode(1)
mywindow:addTextExtends(" ", g_STRING_FONT_GULIMCHE, 11, 255, 255, 0, 255, 1, 0, 0, 0, 255)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

function NotifyWeaponSelectTime(number)
	local text = WndDefence_String_06..number
	
	winMgr:getWindow("WndDefence_WeaponSelect_Time"):clearTextExtends()
	winMgr:getWindow("WndDefence_WeaponSelect_Time"):addTextExtends(text, g_STRING_FONT_GULIMCHE, 25, 255, 255, 0, 255, 1, 0, 0, 0, 255)
	winMgr:getWindow("WndDefence_WeaponSelect_Time"):setVisible(true)
end

function CloseWeaponSelectTime()
	winMgr:getWindow("WndDefence_WeaponSelect_Time"):clearTextExtends()
	winMgr:getWindow("WndDefence_WeaponSelect_Time"):setVisible(false)
end


--[[
ShowNotify_TowerUnderAttack(255)
ShowNotify_TimeAttackCount(60)
NotifyWeaponSelectTime(3)
--NotifyCommingSoonZombieMessage(10)
NotifyDangerMessage()
ShowSelectGunWnd()
]]--



local WATCHING_WHO = PreCreateString_2488	--GetSStringInfo(LAN_CLUBWAR_PLAY_OBSERVER)	-- %s ������
function WndDefence_DrawWatchingCharacter(team, characterName)
	
	drawer:drawTexture("UIData/fightClub_005.tga", 257, 210, 514, 41, 0, 220, WIDETYPE_5)
	
	drawer:setFont(g_STRING_FONT_GULIMCHE, 16)
	if team == 0 then
		drawer:setTextColor(254,87,87,255)
	else
		drawer:setTextColor(97,161,240,255)
	end
	
	local szName = string.format(WATCHING_WHO, characterName)
	local size = GetStringSize(g_STRING_FONT_GULIMCHE, 16, szName)
	drawer:drawText(szName, 512-size/2, 223, WIDETYPE_5)
end


local effectEnableEnterTime = 0
function WndDefence_DrawNotifyEnableEnter(deltaTime)
	drawer:drawTexture("UIData/fightClub_005.tga", 257, 166, 514, 41, 0, 220, WIDETYPE_5)
	
	effectEnableEnterTime = effectEnableEnterTime + deltaTime
	effectEnableEnterTime = effectEnableEnterTime % 400
	if effectEnableEnterTime < 200 then
		drawer:drawTexture("UIData/fightClub_005.tga", 257, 162, 514, 41, 0, 261, WIDETYPE_5)
	end
end



--------------------------------------------------------------------------------
-- ���۹� ui
--------------------------------------------------------------------------------
local howtoplayWnd = winMgr:createWindow("TaharezLook/StaticImage", "WndDefence_HowToPlay_Img")
howtoplayWnd:setTexture("Enabled",	"UIData/F1-Help_zombie.tga", 0, 0)
howtoplayWnd:setTexture("Disabled",	"UIData/F1-Help_zombie.tga", 0, 0)
howtoplayWnd:setProperty("FrameEnabled",		"False")
howtoplayWnd:setProperty("BackgroundEnabled",	"False")

howtoplayWnd:setWideType(6)
howtoplayWnd:setPosition(0,0)
howtoplayWnd:setSize(1024, 768)

howtoplayWnd:setVisible(false)
howtoplayWnd:setAlwaysOnTop(true)
howtoplayWnd:setZOrderingEnabled(false)
root:addChildWindow(howtoplayWnd)

function ShowDefence_HowToPlay()
	local local_window = winMgr:getWindow("WndDefence_HowToPlay_Img")
	
	-- ����ó��
	if local_window == nil then
		DStr("���������� nil.. ���ϵ�")
		return
	end
	
	-- �Ѷ�. ����������, ����.
	if local_window:isVisible() == false then
		local_window:setVisible(true)
	else
		local_window:setVisible(false)
	end
end


-----------------------------------------------------------------
-- Debug ��
-- WndDefence_Debug : 
-----------------------------------------------------------------
function WndDefence_Debug(currentTime)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 24)
	drawer:setTextColor(255, 255, 255, 255)	
end

function WndDefence_Debug2(hp, x, y, currentAction)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 10)
	drawer:setTextColor(255, 255, 255, 255)	
	drawer:drawText("HP : "..hp, x-30, y+20)
	drawer:drawText("ACTION : "..currentAction, x-30, y+35)
end
-----------------------------------------------------------------
-----------------------------------------------------------------
