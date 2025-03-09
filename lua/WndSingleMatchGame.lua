-----------------------------------------
-- Script Entry Point
-----------------------------------------
local guiSystem = CEGUI.System:getSingleton()
local winMgr	= CEGUI.WindowManager:getSingleton()
local root		= winMgr:getWindow("DefaultWindow")
local drawer	= root:getDrawer()
guiSystem:setGUISheet(root)
root:activate()


g_GAME_WIN_SIZEX, g_GAME_WIN_SIZEY = GetCurrentResolution()

-- ������ ���� �����̹��� �׸���
local ITEMSLOT_0	= 90
local ITEMSLOT_1	= 141
local ITEMSCALE_0	= 150
local ITEMSCALE_1	= 150
local g_itemSlotX_0 = ITEMSLOT_0
local g_itemSlotX_1 = ITEMSLOT_1
local g_itemScale_0 = ITEMSCALE_0
local g_itemScale_1 = ITEMSCALE_1
local g_itemSlotY	= 71
local g_itemEffectSlotX_0 = ITEMSLOT_0
local g_itemEffectSlotX_1 = ITEMSLOT_1


root:setSubscribeEvent("MouseButtonUp", "OnRootMouseButtonUp")
function OnRootMouseButtonUp(args)
	root:removeChildWindow(winMgr:getWindow('pu_btnContainer'))
end
--------------------------------------------------------------------

-- �����尩�� ��� +HP ǥ���ϱ�(MAX_COMBO : 32��)

--------------------------------------------------------------------
local tGainHPPosX		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainHPPosY		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainHPDamage		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainHPTime		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tDecreaseAlphaHP	= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }

function WndSingleMatchGame_StartEffectGainHP(characterIndex, comboIndex, x, y, damage)
	if characterIndex < 0 and characterIndex >= #tGainHPPosX then
		return
	end
	tGainHPPosX[characterIndex][comboIndex]			= x
	tGainHPPosY[characterIndex][comboIndex]			= y
	tGainHPDamage[characterIndex][comboIndex]		= damage
	tGainHPTime[characterIndex][comboIndex]			= 0
	tDecreaseAlphaHP[characterIndex][comboIndex]	= 255
end


function WndSingleMatchGame_EndEffectGainHP(characterIndex, comboIndex)
	if characterIndex < 0 and characterIndex >= #tGainHPPosX then
		return
	end
	tGainHPPosX[characterIndex][comboIndex]			= 0
	tGainHPPosY[characterIndex][comboIndex]			= 0
	tGainHPDamage[characterIndex][comboIndex]		= 0
	tGainHPTime[characterIndex][comboIndex]			= 0
	tDecreaseAlphaHP[characterIndex][comboIndex]	= 0	
end


function WndSingleMatchGame_RenderEffectGainHP(characterIndex, comboIndex, deltaTime)
	if characterIndex < 0 and characterIndex >= #tGainHPPosX then
		return
	end
	
	if tGainHPTime[characterIndex][comboIndex] == nil then
		return
	end
	
	if tDecreaseAlphaHP[characterIndex][comboIndex] <= 0 then
		return
	end
	
	tGainHPTime[characterIndex][comboIndex] = tGainHPTime[characterIndex][comboIndex] + deltaTime
	local gainTime = tGainHPTime[characterIndex][comboIndex] / 15
	
	if tDecreaseAlphaHP[characterIndex][comboIndex] > 0 then
		tDecreaseAlphaHP[characterIndex][comboIndex] = tDecreaseAlphaHP[characterIndex][comboIndex] - 3
	else
		tDecreaseAlphaHP[characterIndex][comboIndex] = 0
	end
		
	local x = tGainHPPosX[characterIndex][comboIndex] - 8
	local y = tGainHPPosY[characterIndex][comboIndex] - gainTime
	local damage = tGainHPDamage[characterIndex][comboIndex]
	local alpha  = tDecreaseAlphaHP[characterIndex][comboIndex]
		
	local _left, _right = DrawEachNumberA("UIData/GameNewImage.tga", damage, 8, x, y, 721, 693, 19, 25, 19, alpha)
	drawer:drawTextureA("UIData/GameNewImage.tga", _left-19, y+3, 16, 17, 699, 697, alpha)
end





--------------------------------------------------------------------

-- �������ݻ��� ��� -HP ǥ���ϱ�(�������� ���Ҷ����� -�������� ������)

--------------------------------------------------------------------
local tReflectDamagePosX	= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tReflectDamagePosY	= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tReflectDamageHp		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tReflectDamageTime	= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tReflectDamageAlpha	= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }

function WndSingleMatchGame_StartEffectReflectDamage(characterIndex, comboIndex, x, y, damage)
	if characterIndex < 0 and characterIndex >= #tReflectDamagePosX then
		return
	end
	tReflectDamagePosX[characterIndex][comboIndex]	= x
	tReflectDamagePosY[characterIndex][comboIndex]	= y
	tReflectDamageHp[characterIndex][comboIndex]	= damage
	tReflectDamageTime[characterIndex][comboIndex]	= 0
	tReflectDamageAlpha[characterIndex][comboIndex]	= 255
end


function WndSingleMatchGame_EndEffectReflectDamage(characterIndex, comboIndex)
	if characterIndex < 0 and characterIndex >= #tReflectDamagePosX then
		return
	end
	tReflectDamagePosX[characterIndex][comboIndex]	= 0
	tReflectDamagePosY[characterIndex][comboIndex]	= 0
	tReflectDamageHp[characterIndex][comboIndex]	= 0
	tReflectDamageTime[characterIndex][comboIndex]	= 0
	tReflectDamageAlpha[characterIndex][comboIndex]	= 0
end


function WndSingleMatchGame_RenderEffectReflectDamage(characterIndex, comboIndex, deltaTime)
	if characterIndex < 0 and characterIndex >= #tReflectDamagePosX then
		return
	end
	
	if tReflectDamageTime[characterIndex][comboIndex] == nil then
		return
	end
	
	if tReflectDamageAlpha[characterIndex][comboIndex] <= 0 then
		return
	end
	
	tReflectDamageTime[characterIndex][comboIndex] = tReflectDamageTime[characterIndex][comboIndex] + deltaTime
	local gainTime = tReflectDamageTime[characterIndex][comboIndex] / 15
	
	if tReflectDamageAlpha[characterIndex][comboIndex] > 0 then
		tReflectDamageAlpha[characterIndex][comboIndex] = tReflectDamageAlpha[characterIndex][comboIndex] - 3
	else
		tReflectDamageAlpha[characterIndex][comboIndex] = 0
	end
		
	local x = tReflectDamagePosX[characterIndex][comboIndex] - 8
	local y = tReflectDamagePosY[characterIndex][comboIndex] - gainTime
	local damage = tReflectDamageHp[characterIndex][comboIndex]
	local alpha  = tReflectDamageAlpha[characterIndex][comboIndex]
	
	local _left, _right = DrawEachNumberA("UIData/GameNewImage.tga", damage, 8, x, y, 32, 837, 19, 25, 19, alpha)
	drawer:drawTextureA("UIData/GameNewImage.tga", _left-19, y+2, 17, 17, 10, 841, alpha)
end





--------------------------------------------------------------------

-- SP�尩�� ��� +SP ǥ���ϱ�(MAX_COMBO : 32��)

--------------------------------------------------------------------
local tGainSPPosX		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainSPPosY		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainSPDamage		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tGainSPTime		= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }
local tDecreaseAlphaSP	= { ["e"]=0, [0]={["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,}, {["e"]=0,} }

function WndSingleMatchGame_StartEffectGainSP(characterIndex, comboIndex, x, y, damage)
	if characterIndex < 0 and characterIndex >= #tGainSPPosX then
		return
	end
	tGainSPPosX[characterIndex][comboIndex]			= x
	tGainSPPosY[characterIndex][comboIndex]			= y
	tGainSPDamage[characterIndex][comboIndex]		= damage
	tGainSPTime[characterIndex][comboIndex]			= 0
	tDecreaseAlphaSP[characterIndex][comboIndex]	= 255
end


function WndSingleMatchGame_EndEffectGainSP(characterIndex, comboIndex)
	if characterIndex < 0 and characterIndex >= #tGainSPPosX then
		return
	end
	tGainSPPosX[characterIndex][comboIndex]			= 0
	tGainSPPosY[characterIndex][comboIndex]			= 0
	tGainSPDamage[characterIndex][comboIndex]		= 0
	tGainSPTime[characterIndex][comboIndex]			= 0
	tDecreaseAlphaSP[characterIndex][comboIndex]	= 0	
end


function WndSingleMatchGame_RenderEffectGainSP(characterIndex, comboIndex, deltaTime)
	if characterIndex < 0 and characterIndex >= #tGainSPPosX then
		return
	end
	
	if tGainSPTime[characterIndex][comboIndex] == nil then
		return
	end
	
	if tDecreaseAlphaSP[characterIndex][comboIndex] <= 0 then
		return
	end
	
	tGainSPTime[characterIndex][comboIndex] = tGainSPTime[characterIndex][comboIndex] + deltaTime
	local gainTime = tGainSPTime[characterIndex][comboIndex] / 15
	
	if tDecreaseAlphaSP[characterIndex][comboIndex] > 0 then
		tDecreaseAlphaSP[characterIndex][comboIndex] = tDecreaseAlphaSP[characterIndex][comboIndex] - 3
	else
		tDecreaseAlphaSP[characterIndex][comboIndex] = 0
	end
		
	local x = tGainSPPosX[characterIndex][comboIndex] - 8
	local y = tGainSPPosY[characterIndex][comboIndex] - gainTime
	local damage = tGainSPDamage[characterIndex][comboIndex]
	local alpha  = tDecreaseAlphaSP[characterIndex][comboIndex]
		
	local _left, _right = DrawEachNumberA("UIData/GameNewImage.tga", damage, 8, x, y, 33, 867, 19, 25, 19, alpha)
	drawer:drawTextureA("UIData/GameNewImage.tga", _left-19, y+3, 19, 25, 9, 867, alpha)
end





--------------------------------------------------------------------

-- ������ ����Ʈ(1�ʿ� �ѹ��� �����°Ŷ� ������ ������� �ٽ� �����ְ� �ݺ���)

--------------------------------------------------------------------
local tPoisonY		= { ["err"]=0, [0]=0, 0, 0, 0, 0, 0, 0, 0 }
local tPoisonAlpha	= { ["err"]=0, [0]=255, 255, 255, 255, 255, 255, 255, 255 }
function WndSingleMatchGame_InitPoisonEffect(index)
	if index < 0 and index >= #tPoisonY then
		return
	end
	
	tPoisonY[index]		= 0
	tPoisonAlpha[index] = 255
end


function WndSingleMatchGame_RenderPoisonEffect(index, x, y, damage, passTick)
	
	if index < 0 and index >= 8 then
		return
	end
	
	-- passTick �� ���� 58�� �Ѿ��
	local delay = 13
	if passTick > delay then
	
		tPoisonAlpha[index] = 255 - ((passTick-delay)*5)
		tPoisonY[index]		= (passTick-delay) * 2
		
		local _left, _right = DrawEachNumberA("UIData/GameNewImage.tga", damage, 8, x, y-tPoisonY[index], 32, 837, 19, 25, 19, tPoisonAlpha[index])
		drawer:drawTextureA("UIData/GameNewImage.tga", _left-19, y+2-tPoisonY[index], 17, 17, 10, 841, tPoisonAlpha[index])
	end
	
end




----------------------------------------------------

-- ��׶��� �׸���

----------------------------------------------------
function WndSingleMatchGame_RenderBackground(redPlayerIndex, bluePlayerIndex)
	if redPlayerIndex >= 0 then
		drawer:drawTexture("UIData/GameImage_dual.tga", 0, 0, 461, 100, 0, 0, WIDETYPE_0)
		drawer:drawTexture("UIData/GameImage_dual.tga", 74, 5, 378, 27, 0, 100, WIDETYPE_0)		-- hp�� ����
	end
	
	if bluePlayerIndex >= 0 then
		drawer:drawTexture("UIData/GameImage_dual.tga", 563, 0, 461, 100, 563, 0, WIDETYPE_1)
		drawer:drawTexture("UIData/GameImage_dual.tga", 570, 5, 378, 27, 0, 100, WIDETYPE_1)	-- hp�� ����
	end
end




--------------------------------------------------------------------

-- ���� �׸���

--------------------------------------------------------------------
function WndSingleMatchGame_StartGhost(downIndex, x, y, attackName1, attackName2)
	Common_StartGhost(downIndex, x, y, attackName1, attackName2)
end



function WndSingleMatchGame_EndGhost(downIndex)
	Common_EndGhost(downIndex)
end



function WndSingleMatchGame_RenderGhost(slot, x, y, deltaTime)
	Common_RenderGhost(slot, x, y, deltaTime)
end




--------------------------------------------------------------------

-- �ɸ��Ϳ� �������� �׸���(HP, SP ...)

--------------------------------------------------------------------
function WndSingleMatchGame_RenderCharacter
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
			, isPenalty
			, penaltyValue
			, showAllSP
			, showAllItem
			, _1stItemType
			, _2ndItemType
			, exceptE
			)
	
	local MONSTER_RACING = false
	local BATTLE = 5	-- 0:����, 1:����, 2:���ͷ��̽�, 3:������, 4:������(������), 5:�����
	Common_RenderCharacter(deltatime, myslot, myteam, slot, team, characterName, 
		screenX, screenY, hp, sp, maxhp, maxsp, friend, isPenalty, penaltyValue, 
		BATTLE, showAllSP, showAllItem, _1stItemType, _2ndItemType, MONSTER_RACING, exceptE)
end






-------------------------------------------------------------------------

--	��ŷ �κ�

-------------------------------------------------------------------------
local tRankOffsetX	= { ["err"]=0, 805, 805, 805, 805, 805, 805, 805, 805 }
local tRankOffsetY	= { ["err"]=0, 20, 20, 20, 20, 20, 20, 20, 20 }

-- ���� ���� ��ũ�� ����� ���Ѵ�.
function WndSingleMatchGame_BeforeRenderRank(myRank)

	-- �ʱ�ȭ
	for i=1, 8 do
		tRankOffsetX[i] = 805
		tRankOffsetY[i] = 20
	end
	
	-- 8���� ������ũ�� �����Ƿ� ���ɽ����� x��ǥ�� ^^
	if myRank ~= 8 then
		tRankOffsetX[myRank]	= 767
		tRankOffsetY[myRank+1]	= 26
	else
		tRankOffsetX[myRank]	= 767
	end
	
end



-- ���� ��ũ�� ������ ���ؼ� y��ġ�� ��ǥ�� �����Ѵ�.
function GetCurrentRankPosY(rank)
	local rankPos = -14
	
	for i=1, rank do
		rankPos = rankPos + tRankOffsetY[i]
	end
	
	return rankPos
end


g_lasthp		= { ["protectErr"]=0 }
g_lasthpTime	= { ["protectErr"]=0 }
g_lastsp		= { ["protectErr"]=0 }
g_lastspTime	= { ["protectErr"]=0 }

local gMyTeam = 0
local lastGaugeEfeectTime1 = 0
local lastGaugeEfeectTime2 = 0
local tPropertyItemTexY = {["err"]=0, [0]=560, 616, 672, 728, 784, 840}
function WndSingleMatchGame_RenderRank(slot, myslot, bone, bTeam, team, 
				disconnected, relay, network, INFINITE_PING, hp, sp, maxhp, maxsp, name, deltatime, 
				isGameOver, transform,
				itemType, exceptE, redPlayerIndex, bluePlayerIndex, showAllSP, showAllItem, itemType1, itemType2)

	
	if maxhp <= 0 then
		return
	end
	if maxsp <= 0 then
		maxsp = 3000
	end
	
	---------
	-- HP
	---------
	if (g_lasthp[slot] == nil) then
		g_lasthp[slot] = 0
	end
	
	if (g_lasthpTime[slot] == nil) then 
		g_lasthpTime[slot] = 0
	end
		
	g_lasthpTime[slot] = g_lasthpTime[slot] + deltatime
	changedHP		 = g_lasthpTime[slot] / 20
		
	g_lasthp[slot] = g_lasthp[slot] - changedHP
	
	if (g_lasthp[slot] < hp) then
		g_lasthp[slot] = hp
		g_lasthpTime[slot] = 0
	end
	
	---------
	-- SP
	---------
	if (g_lastsp[slot] == nil) then
		g_lastsp[slot] = 0
	end
	
	if (g_lastspTime[slot] == nil) then 
		g_lastspTime[slot] = 0
	end
				
	g_lastspTime[slot] = g_lastspTime[slot] + deltatime
	changedSP		 = g_lastspTime[slot] / 20

	g_lastsp[slot] = g_lastsp[slot] - changedSP	
	
	if (g_lastsp[slot] < sp) then
		g_lastsp[slot] = sp
		g_lastspTime[slot] = 0
	end
	
	local realHPwidth = 376
	local realSPWidth = 168
	

	if hp >= maxhp then
		hp = maxhp
	end
	
	if g_lasthp[slot] >= maxhp then
		g_lasthp[slot] = maxhp
	end
	
	
	--��ȭ�ϰ� �ִ� ������
	computedOldHPrealwidth = g_lasthp[slot] * realHPwidth / maxhp
	computedOldSPrealwidth = g_lastsp[slot] * realSPWidth / maxsp
	
	--���� ������
	computedHPrealwidth = hp * realHPwidth / maxhp
	computedSPrealwidth = sp * realSPWidth / maxsp
	
		
	------------------------------------------
	-- ���� ���� ������(HP, SP)
	------------------------------------------
	if slot == myslot then
		
		-- ���� �������� ���
		if slot == redPlayerIndex then
			gMyTeam = 0
			ITEMSLOT_0 = 90
			ITEMSLOT_1 = 141

			drawer:drawTexture("UIData/GameImage_dual.tga", 300, 30, 168, 28, 382, 209, WIDETYPE_0)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			drawer:setTextColor(255, 255, 255, 255)
			local NameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
			drawer:drawText(name, 446-NameSize, 40, WIDETYPE_0)
			
			drawer:drawTexture("UIData/GameImage_dual.tga", 130, 34, 174, 19, 786, 180, WIDETYPE_0)	-- sp�� ����
			drawer:drawTexture("UIData/GameImage_dual.tga", 75, 35, 53, 17, 718, 117, WIDETYPE_0)	-- Q,W,E ����
			--drawer:drawTexture("UIData/GameImage_dual.tga", 73, 53, 85, 35, 0, 291, WIDETYPE_0)		-- ������ ����	
		
			drawer:drawTexture("UIData/GameImage_dual.tga", 76, 7, computedOldHPrealwidth, 25, 0, 154, WIDETYPE_0)
			drawer:drawTexture("UIData/GameImage_dual.tga", 133, 37, computedOldSPrealwidth, 13, 786, 139, WIDETYPE_0)
			
			-- hp 600������ �� �����Ÿ���
			local warningHP = maxhp/10
			if hp > warningHP then
				drawer:drawTexture("UIData/GameImage_dual.tga", 76, 7, computedHPrealwidth, 25, 0, 129, WIDETYPE_0)
			else
				lastGaugeEfeectTime1 = lastGaugeEfeectTime1 + deltatime
				lastGaugeEfeectTime1 = lastGaugeEfeectTime1 % 100

				if lastGaugeEfeectTime1 < 50 then
					drawer:drawTexture("UIData/GameImage_dual.tga", 76, 7, computedHPrealwidth, 25, 0, 129, WIDETYPE_0)
				else
					drawer:drawTexture("UIData/GameImage_dual.tga", 76, 7, computedHPrealwidth, 25, 0, 179, WIDETYPE_0)
				end
			end
			
			-- sp �׸���
			local LIMIT_Q = 1000
			local LIMIT_W = 2000
			local LIMIT_E = 3000
			
			if( 0 <= sp and sp < LIMIT_Q ) then	
				drawer:drawTexture("UIData/GameImage_dual.tga", 133, 37, computedSPrealwidth, 13, 786, 139, WIDETYPE_0)	-- ȸ��
				
			-- Q
			elseif( LIMIT_Q <= sp and sp < LIMIT_W ) then	
				drawer:drawTexture("UIData/GameImage_dual.tga", 133, 37, computedSPrealwidth, 13, 786, 100, WIDETYPE_0)	-- ���
				drawer:drawTexture("UIData/GameImage_dual.tga", 76, 36, 15, 15, 719, 101, WIDETYPE_0)					-- Q�� �ҵ���
				
			-- Q, W
			elseif( LIMIT_W <= sp and sp < LIMIT_E ) then	
				drawer:drawTexture("UIData/GameImage_dual.tga", 133, 37, computedSPrealwidth, 13, 786, 113, WIDETYPE_0)	-- �ʷ�
				drawer:drawTexture("UIData/GameImage_dual.tga", 76, 36, 15, 15, 719, 101, WIDETYPE_0)					-- Q�� �ҵ���
				drawer:drawTexture("UIData/GameImage_dual.tga", 94, 36, 15, 15, 737, 101, WIDETYPE_0)					-- W�� �ҵ���
				
			-- Q, W, E
			elseif( LIMIT_E <= sp ) then
				if exceptE == 0 then
					drawer:drawTexture("UIData/GameImage_dual.tga", 133, 37, computedSPrealwidth, 13, 786, 126, WIDETYPE_0)	-- �Ķ�
				else
					drawer:drawTexture("UIData/GameImage_dual.tga", 133, 37, computedSPrealwidth, 13, 786, 113, WIDETYPE_0)	-- �ʷ�
				end		
				drawer:drawTexture("UIData/GameImage_dual.tga", 76, 36, 15, 15, 719, 101, WIDETYPE_0)		-- Q�� �ҵ���
				drawer:drawTexture("UIData/GameImage_dual.tga", 94, 36, 15, 15, 737, 101, WIDETYPE_0)		-- W�� �ҵ���
				if exceptE == 0 then
					drawer:drawTexture("UIData/GameImage_dual.tga", 112, 36, 15, 15, 755, 101, WIDETYPE_0)	-- E�� �ҵ���
				end
			end
			
			----------------------------------------
			--	�ɸ��� ��
			----------------------------------------
			
			-- ���� ������ ��
			if transform <= 0 then
				-- ��(�׾��� ��)
				if hp <= 0 then
					-- ��� ��
					drawer:drawTextureWithScale_Angle_Offset("UIData/GameImage.tga",  8, 8, 78, 96, 176, bone*98, 200, 200, 255, 0, 0, 0, 0, WIDETYPE_0)
					
				-- ��(���)
				else
					drawer:drawTextureWithScale_Angle_Offset("UIData/GameImage.tga",  8, 8, 78, 96, 0, bone*98, 200, 200, 255, 0, 0, 0, 0, WIDETYPE_0)
				end
			else
				-- ��(�׾��� ��)
				if hp <= 0 then
					-- ��� ��
					drawer:drawTextureWithScale_Angle_Offset("UIData/"..tTransformBigFileName[transform], 
								8, 8, 78, 96, tTransformBigTexX[transform]+176, tTransformBigTexY[transform], 200, 200, 255, 0, 0, 0, 0, WIDETYPE_0)
					
				-- ��(���)
				else
					drawer:drawTextureWithScale_Angle_Offset("UIData/"..tTransformBigFileName[transform],  
								8, 8, 78, 96, tTransformBigTexX[transform], tTransformBigTexY[transform], 200, 200, 255, 0, 0, 0, 0, WIDETYPE_0)
				end
			end	
		
		
		-- ���� ������� ���
		elseif slot == bluePlayerIndex then
			gMyTeam = 1
			ITEMSLOT_0 = 881
			ITEMSLOT_1 = 932
			
			drawer:drawTexture("UIData/GameImage_dual.tga", 560, 30, 168, 28, 550, 209, WIDETYPE_1)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			drawer:setTextColor(255, 255, 255, 255)
			drawer:drawText(name, 580, 40, WIDETYPE_1)
		
			drawer:drawTexture("UIData/GameImage_dual.tga", 720, 34, 174, 19, 786, 180, WIDETYPE_1)	-- sp�� ����
			drawer:drawTexture("UIData/GameImage_dual.tga", 895, 35, 53, 17, 718, 135, WIDETYPE_1)	-- Q,W,E ����
			--drawer:drawTexture("UIData/GameImage_dual.tga", 864, 53, 85, 35, 0, 291, WIDETYPE_1)	-- ������ ����
		
			drawer:drawTexture("UIData/GameImage_dual.tga", 948-computedOldHPrealwidth, 7, computedOldHPrealwidth, 25, realHPwidth-computedOldHPrealwidth, 154, WIDETYPE_1)
			drawer:drawTexture("UIData/GameImage_dual.tga", 891-computedOldSPrealwidth, 37, computedOldSPrealwidth, 13, 786+realSPWidth-computedOldSPrealwidth, 139, WIDETYPE_1)
		
			-- hp 600������ �� �����Ÿ���
			local warningHP = maxhp/10
			if hp > warningHP then
				drawer:drawTexture("UIData/GameImage_dual.tga", 948-computedHPrealwidth, 7, computedHPrealwidth, 25, realHPwidth-computedHPrealwidth, 129, WIDETYPE_1)
			else		
				lastGaugeEfeectTime2 = lastGaugeEfeectTime2 + deltatime
				lastGaugeEfeectTime2 = lastGaugeEfeectTime2 % 100

				if lastGaugeEfeectTime2 < 50 then
					drawer:drawTexture("UIData/GameImage_dual.tga", 948-computedHPrealwidth, 7, computedHPrealwidth, 25, realHPwidth-computedHPrealwidth, 129, WIDETYPE_1)
				else
					drawer:drawTexture("UIData/GameImage_dual.tga", 948-computedHPrealwidth, 7, computedHPrealwidth, 25, realHPwidth-computedHPrealwidth, 179, WIDETYPE_1)
				end
			end
			
			-- sp �׸���
			local LIMIT_Q = 1000
			local LIMIT_W = 2000
			local LIMIT_E = 3000
			
			if( 0 <= sp and sp < LIMIT_Q ) then	
				drawer:drawTexture("UIData/GameImage_dual.tga", 891-computedSPrealwidth, 37, computedSPrealwidth, 13, 786+realSPWidth-computedSPrealwidth, 139, WIDETYPE_1)	-- ȸ��
				
			-- Q
			elseif( LIMIT_Q <= sp and sp < LIMIT_W ) then	
				drawer:drawTexture("UIData/GameImage_dual.tga", 891-computedSPrealwidth, 37, computedSPrealwidth, 13, 786+realSPWidth-computedSPrealwidth, 100, WIDETYPE_1)	-- ���
				drawer:drawTexture("UIData/GameImage_dual.tga", 932, 36, 15, 15, 719, 101, WIDETYPE_1)					-- Q�� �ҵ���
				
			-- Q, W
			elseif( LIMIT_W <= sp and sp < LIMIT_E ) then	
				drawer:drawTexture("UIData/GameImage_dual.tga", 891-computedSPrealwidth, 37, computedSPrealwidth, 13, 786+realSPWidth-computedSPrealwidth, 113, WIDETYPE_1)	-- �ʷ�
				drawer:drawTexture("UIData/GameImage_dual.tga", 932, 36, 15, 15, 719, 101, WIDETYPE_1)					-- Q�� �ҵ���
				drawer:drawTexture("UIData/GameImage_dual.tga", 914, 36, 15, 15, 737, 101, WIDETYPE_1)					-- W�� �ҵ���
				
			-- Q, W, E
			elseif( LIMIT_E <= sp ) then
				if exceptE == 0 then
					drawer:drawTexture("UIData/GameImage_dual.tga", 891-computedSPrealwidth, 37, computedSPrealwidth, 13, 786+realSPWidth-computedSPrealwidth, 126, WIDETYPE_1)	-- �Ķ�
				else
					drawer:drawTexture("UIData/GameImage_dual.tga", 891-computedSPrealwidth, 37, computedSPrealwidth, 13, 786+realSPWidth-computedSPrealwidth, 113, WIDETYPE_1)	-- �ʷ�
				end		
				drawer:drawTexture("UIData/GameImage_dual.tga", 932, 36, 15, 15, 719, 101, WIDETYPE_1)		-- Q�� �ҵ���
				drawer:drawTexture("UIData/GameImage_dual.tga", 914, 36, 15, 15, 737, 101, WIDETYPE_1)		-- W�� �ҵ���
				if exceptE == 0 then
					drawer:drawTexture("UIData/GameImage_dual.tga", 896, 36, 15, 15, 755, 101, WIDETYPE_1)	-- E�� �ҵ���
				end
			end
		
			----------------------------------------
			--	�ɸ��� ��
			----------------------------------------
			-- ���� ������ ��
			if transform <= 0 then
				-- ��(�׾��� ��)
				if hp <= 0 then
					-- ��� ��
					drawer:drawTextureWithScale_Angle_Offset("UIData/GameImage.tga", 955, 8, 78, 96, 176, bone*98, 200, 200, 255, 0, 0, 0, 0, WIDETYPE_1)
					
				-- ��(���)
				else
					drawer:drawTextureWithScale_Angle_Offset("UIData/GameImage.tga", 955, 8, 78, 96, 0, bone*98, 200, 200, 255, 0, 0, 0, 0, WIDETYPE_1)
				end
			else
				-- ��(�׾��� ��)
				if hp <= 0 then
					-- ��� ��
					drawer:drawTextureWithScale_Angle_Offset("UIData/"..tTransformBigFileName[transform], 
								955, 8, 78, 96, tTransformBigTexX[transform]+176, tTransformBigTexY[transform], 200, 200, 255, 0, 0, 0, 0, WIDETYPE_1)
					
				-- ��(���)
				else
					drawer:drawTextureWithScale_Angle_Offset("UIData/"..tTransformBigFileName[transform],  
								955, 8, 78, 96, tTransformBigTexX[transform], tTransformBigTexY[transform], 200, 200, 255, 0, 0, 0, 0, WIDETYPE_1)
				end
			end
		end
	
	----------------------------
	-- ������� ���
	----------------------------
	else
		-- �������� ���
		if slot == redPlayerIndex then
			drawer:drawTexture("UIData/GameImage_dual.tga", 300, 30, 168, 28, 382, 209, WIDETYPE_0)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			drawer:setTextColor(255, 255, 255, 255)
			local NameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 12, name)
			drawer:drawText(name, 446-NameSize, 40, WIDETYPE_0)
			
			if showAllSP == 1 then
				drawer:drawTexture("UIData/GameImage_dual.tga", 130, 34, 174, 19, 786, 180, WIDETYPE_0)	-- sp�� ����
				drawer:drawTexture("UIData/GameImage_dual.tga", 75, 35, 53, 17, 718, 117, WIDETYPE_0)	-- Q,W,E ����
				drawer:drawTexture("UIData/GameImage_dual.tga", 133, 37, computedOldSPrealwidth, 13, 786, 139, WIDETYPE_0)
			end
			
			--[[
			if showAllItem == 1 then
				drawer:drawTexture("UIData/GameImage_dual.tga", 73, 53, 85, 35, 0, 291, WIDETYPE_0)		-- ������ ����
				
				-- ������ �׸���
				if itemType1 >= 0 then
					drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 90, 71, 43, 44, itemType1*47, 0,
																	150, 150, 255, 0, 8, 100, 0, WIDETYPE_0)
				end
				
				if itemType2 >= 0 then
					drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 141, 71, 43, 44, itemType2*47, 0,
																	150, 150, 255, 0, 8, 0, 0, WIDETYPE_0)
				end	
			end
			--]]
		
			drawer:drawTexture("UIData/GameImage_dual.tga", 76, 7, computedOldHPrealwidth, 25, 0, 154, WIDETYPE_0)
			
			-- hp 600������ �� �����Ÿ���
			local warningHP = maxhp/10
			if hp > warningHP then
				drawer:drawTexture("UIData/GameImage_dual.tga", 76, 7, computedHPrealwidth, 25, 0, 129, WIDETYPE_0)
			else
				lastGaugeEfeectTime1 = lastGaugeEfeectTime1 + deltatime
				lastGaugeEfeectTime1 = lastGaugeEfeectTime1 % 100

				if lastGaugeEfeectTime1 < 50 then
					drawer:drawTexture("UIData/GameImage_dual.tga", 76, 7, computedHPrealwidth, 25, 0, 129, WIDETYPE_0)
				else
					drawer:drawTexture("UIData/GameImage_dual.tga", 76, 7, computedHPrealwidth, 25, 0, 179, WIDETYPE_0)
				end
			end
			
			if showAllSP == 1 then
				-- sp �׸���
				local LIMIT_Q = 1000
				local LIMIT_W = 2000
				local LIMIT_E = 3000
				
				if( 0 <= sp and sp < LIMIT_Q ) then	
					drawer:drawTexture("UIData/GameImage_dual.tga", 133, 37, computedSPrealwidth, 13, 786, 139, WIDETYPE_0)	-- ȸ��
					
				-- Q
				elseif( LIMIT_Q <= sp and sp < LIMIT_W ) then	
					drawer:drawTexture("UIData/GameImage_dual.tga", 133, 37, computedSPrealwidth, 13, 786, 100, WIDETYPE_0)	-- ���
					drawer:drawTexture("UIData/GameImage_dual.tga", 76, 36, 15, 15, 719, 101, WIDETYPE_0)					-- Q�� �ҵ���
					
				-- Q, W
				elseif( LIMIT_W <= sp and sp < LIMIT_E ) then	
					drawer:drawTexture("UIData/GameImage_dual.tga", 133, 37, computedSPrealwidth, 13, 786, 113, WIDETYPE_0)	-- �ʷ�
					drawer:drawTexture("UIData/GameImage_dual.tga", 76, 36, 15, 15, 719, 101, WIDETYPE_0)					-- Q�� �ҵ���
					drawer:drawTexture("UIData/GameImage_dual.tga", 94, 36, 15, 15, 737, 101, WIDETYPE_0)					-- W�� �ҵ���
					
				-- Q, W, E
				elseif( LIMIT_E <= sp ) then
					if exceptE == 0 then
						drawer:drawTexture("UIData/GameImage_dual.tga", 133, 37, computedSPrealwidth, 13, 786, 126, WIDETYPE_0)	-- �Ķ�
					else
						drawer:drawTexture("UIData/GameImage_dual.tga", 133, 37, computedSPrealwidth, 13, 786, 113, WIDETYPE_0)	-- �ʷ�
					end		
					drawer:drawTexture("UIData/GameImage_dual.tga", 76, 36, 15, 15, 719, 101, WIDETYPE_0)		-- Q�� �ҵ���
					drawer:drawTexture("UIData/GameImage_dual.tga", 94, 36, 15, 15, 737, 101, WIDETYPE_0)		-- W�� �ҵ���
					if exceptE == 0 then
						drawer:drawTexture("UIData/GameImage_dual.tga", 112, 36, 15, 15, 755, 101, WIDETYPE_0)	-- E�� �ҵ���
					end
				end
			end
			
			----------------------------------------
			--	�ɸ��� ��
			----------------------------------------			
			-- ���� ������ ��
			if transform <= 0 then
				-- ��(�׾��� ��)
				if hp <= 0 then
					-- ��� ��
					drawer:drawTextureWithScale_Angle_Offset("UIData/GameImage.tga",  8, 8, 78, 96, 176, bone*98, 200, 200, 255, 0, 0, 0, 0, WIDETYPE_0)
					
				-- ��(���)
				else
					drawer:drawTextureWithScale_Angle_Offset("UIData/GameImage.tga",  8, 8, 78, 96, 0, bone*98, 200, 200, 255, 0, 0, 0, 0, WIDETYPE_0)
				end
			else
				-- ��(�׾��� ��)
				if hp <= 0 then
					-- ��� ��
					drawer:drawTextureWithScale_Angle_Offset("UIData/"..tTransformBigFileName[transform], 
								8, 8, 78, 96, tTransformBigTexX[transform]+176, tTransformBigTexY[transform], 200, 200, 255, 0, 0, 0, 0, WIDETYPE_0)
					
				-- ��(���)
				else
					drawer:drawTextureWithScale_Angle_Offset("UIData/"..tTransformBigFileName[transform],  
								8, 8, 78, 96, tTransformBigTexX[transform], tTransformBigTexY[transform], 200, 200, 255, 0, 0, 0, 0, WIDETYPE_0)
				end
			end	
		
		-- ������� ���
		elseif slot == bluePlayerIndex then
			drawer:drawTexture("UIData/GameImage_dual.tga", 560, 30, 168, 28, 550, 209, WIDETYPE_1)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			drawer:setTextColor(255, 255, 255, 255)
			drawer:drawText(name, 580, 40, WIDETYPE_1)
			
			if showAllSP == 1 then
				drawer:drawTexture("UIData/GameImage_dual.tga", 720, 34, 174, 19, 786, 180, WIDETYPE_1)	-- sp�� ����
				drawer:drawTexture("UIData/GameImage_dual.tga", 895, 35, 53, 17, 718, 135, WIDETYPE_1)	-- Q,W,E ����
				drawer:drawTexture("UIData/GameImage_dual.tga", 891-computedOldSPrealwidth, 37, computedOldSPrealwidth, 13, 786+realSPWidth-computedOldSPrealwidth, 139, WIDETYPE_1)
			end
			
			--[[
			if showAllItem == 1 then
				drawer:drawTexture("UIData/GameImage_dual.tga", 864, 53, 85, 35, 0, 291, WIDETYPE_1)	-- ������ ����
				
				-- ������ �׸���
				if itemType1 >= 0 then
					drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 881, 71, 43, 44, itemType1*47, 0,
																	150, 150, 255, 0, 8, 100, 0, WIDETYPE_1)
				end
				
				if itemType2 >= 0 then
					drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 932, 71, 43, 44, itemType2*47, 0,
																	150, 150, 255, 0, 8, 0, 0, WIDETYPE_1)
				end	
			end
			--]]
		
			drawer:drawTexture("UIData/GameImage_dual.tga", 948-computedOldHPrealwidth, 7, computedOldHPrealwidth, 25, realHPwidth-computedOldHPrealwidth, 154, WIDETYPE_1)			
		
			-- hp 600������ �� �����Ÿ���
			local warningHP = maxhp/10
			if hp > warningHP then
				drawer:drawTexture("UIData/GameImage_dual.tga", 948-computedHPrealwidth, 7, computedHPrealwidth, 25, realHPwidth-computedHPrealwidth, 129, WIDETYPE_1)
			else		
				lastGaugeEfeectTime2 = lastGaugeEfeectTime2 + deltatime
				lastGaugeEfeectTime2 = lastGaugeEfeectTime2 % 100

				if lastGaugeEfeectTime2 < 50 then
					drawer:drawTexture("UIData/GameImage_dual.tga", 948-computedHPrealwidth, 7, computedHPrealwidth, 25, realHPwidth-computedHPrealwidth, 129, WIDETYPE_1)
				else
					drawer:drawTexture("UIData/GameImage_dual.tga", 948-computedHPrealwidth, 7, computedHPrealwidth, 25, realHPwidth-computedHPrealwidth, 179, WIDETYPE_1)
				end
			end
			
			if showAllSP == 1 then
				-- sp �׸���
				local LIMIT_Q = 1000
				local LIMIT_W = 2000
				local LIMIT_E = 3000
				
				if( 0 <= sp and sp < LIMIT_Q ) then	
					drawer:drawTexture("UIData/GameImage_dual.tga", 891-computedSPrealwidth, 37, computedSPrealwidth, 13, 786+realSPWidth-computedSPrealwidth, 139, WIDETYPE_1)	-- ȸ��
					
				-- Q
				elseif( LIMIT_Q <= sp and sp < LIMIT_W ) then	
					drawer:drawTexture("UIData/GameImage_dual.tga", 891-computedSPrealwidth, 37, computedSPrealwidth, 13, 786+realSPWidth-computedSPrealwidth, 100, WIDETYPE_1)	-- ���
					drawer:drawTexture("UIData/GameImage_dual.tga", 932, 36, 15, 15, 719, 101, WIDETYPE_1)	-- Q�� �ҵ���
					
				-- Q, W
				elseif( LIMIT_W <= sp and sp < LIMIT_E ) then	
					drawer:drawTexture("UIData/GameImage_dual.tga", 891-computedSPrealwidth, 37, computedSPrealwidth, 13, 786+realSPWidth-computedSPrealwidth, 113, WIDETYPE_1)	-- �ʷ�
					drawer:drawTexture("UIData/GameImage_dual.tga", 932, 36, 15, 15, 719, 101, WIDETYPE_1)	-- Q�� �ҵ���
					drawer:drawTexture("UIData/GameImage_dual.tga", 914, 36, 15, 15, 737, 101, WIDETYPE_1)	-- W�� �ҵ���
					
				-- Q, W, E
				elseif( LIMIT_E <= sp ) then
					if exceptE == 0 then
						drawer:drawTexture("UIData/GameImage_dual.tga", 891-computedSPrealwidth, 37, computedSPrealwidth, 13, 786+realSPWidth-computedSPrealwidth, 126, WIDETYPE_1)	-- �Ķ�
					else
						drawer:drawTexture("UIData/GameImage_dual.tga", 891-computedSPrealwidth, 37, computedSPrealwidth, 13, 786+realSPWidth-computedSPrealwidth, 113, WIDETYPE_1)	-- �ʷ�
					end		
					drawer:drawTexture("UIData/GameImage_dual.tga", 932, 36, 15, 15, 719, 101, WIDETYPE_1)		-- Q�� �ҵ���
					drawer:drawTexture("UIData/GameImage_dual.tga", 914, 36, 15, 15, 737, 101, WIDETYPE_1)		-- W�� �ҵ���
					if exceptE == 0 then
						drawer:drawTexture("UIData/GameImage_dual.tga", 896, 36, 15, 15, 755, 101, WIDETYPE_1)	-- E�� �ҵ���
					end
				end
			end
		
			----------------------------------------
			--	�ɸ��� ��
			----------------------------------------
			-- ���� ������ ��
			if transform <= 0 then
				-- ��(�׾��� ��)
				if hp <= 0 then
					-- ��� ��
					drawer:drawTextureWithScale_Angle_Offset("UIData/GameImage.tga", 955, 8, 78, 96, 176, bone*98, 200, 200, 255, 0, 0, 0, 0, WIDETYPE_1)
					
				-- ��(���)
				else
					drawer:drawTextureWithScale_Angle_Offset("UIData/GameImage.tga", 955, 8, 78, 96, 0, bone*98, 200, 200, 255, 0, 0, 0, 0, WIDETYPE_1)
				end
			else
				-- ��(�׾��� ��)
				if hp <= 0 then
					-- ��� ��
					drawer:drawTextureWithScale_Angle_Offset("UIData/"..tTransformBigFileName[transform], 
								955, 8, 78, 96, tTransformBigTexX[transform]+176, tTransformBigTexY[transform], 200, 200, 255, 0, 0, 0, 0, WIDETYPE_1)
					
				-- ��(���)
				else
					drawer:drawTextureWithScale_Angle_Offset("UIData/"..tTransformBigFileName[transform],  
								955, 8, 78, 96, tTransformBigTexX[transform], tTransformBigTexY[transform], 200, 200, 255, 0, 0, 0, 0, WIDETYPE_1)
				end
			end
		end	
	end
end




--------------------------------------------------------------------

-- ������

--------------------------------------------------------------------
local playerAlpha = 0
local playerAlphaFlag = 0
function WndSingleMatchGame_InitTeamState(deltaTime)
--[[
	drawer:drawTexture("UIData/GameImage_dual.tga", 4, 110, 168, 109, 382, 100, WIDETYPE_0)
	drawer:drawTexture("UIData/GameImage_dual.tga", 854, 110, 168, 109, 550, 100, WIDETYPE_1)

	playerAlphaFlag = playerAlphaFlag + deltaTime
	playerAlphaFlag = playerAlphaFlag % 1000
--]]
end

function WndSingleMatchGame_NotTeamState(count)
	--drawer:drawTexture("UIData/GameImage_dual.tga", 4, 113+(count*25), 168, 28, 550, 293, WIDETYPE_0)
	--drawer:drawTexture("UIData/GameImage_dual.tga", 854, 113+(count*25), 168, 28, 550, 293, WIDETYPE_1)
end

function WndSingleMatchGame_TeamState(deltaTime, count, enemyType, name, state, kill, killed, disconnect, playerState, playerReadyFlag)
--[[
	local posX = 6
	local posY = 111+(count*25)
	local WIDE = WIDETYPE_0
	if enemyType == 0 then
		posX = 6
		WIDE = WIDETYPE_0
		
		if playerState == 2 then
			drawer:drawTexture("UIData/GameImage_dual.tga", posX, posY, 168, 28, 382, 237, WIDETYPE_0)	-- ������
		else
			if disconnect == 1 then
				drawer:drawTexture("UIData/GameImage_dual.tga", posX, posY, 168, 28, 382, 237, WIDETYPE_0)
			else
				drawer:drawTexture("UIData/GameImage_dual.tga", posX, posY, 168, 28, 382, 209, WIDETYPE_0)
			end
		end
	else
		posX = 856
		WIDE = WIDETYPE_1
		
		if playerState == 2 then
			drawer:drawTexture("UIData/GameImage_dual.tga", posX, posY, 168, 28, 550, 237, WIDETYPE_1)	-- ������
		else
			if disconnect == 1 then
				drawer:drawTexture("UIData/GameImage_dual.tga", posX, posY, 168, 28, 550, 237, WIDETYPE_1)
			else
				drawer:drawTexture("UIData/GameImage_dual.tga", posX, posY, 168, 28, 550, 209, WIDETYPE_1)
			end
		end
	end
	
	local FONT_SIZE = 12
	
	drawer:setFont(g_STRING_FONT_GULIMCHE, FONT_SIZE)
	
	if playerState == 2 then
		drawer:setTextColor(200, 200, 200, 255)	-- ������
	else
		if disconnect == 1 then
			drawer:setTextColor(200, 200, 200, 255)
		else
			drawer:setTextColor(255, 255, 255, 255)
		end
	end
	
	-- �̸�
	nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, FONT_SIZE, name)
	drawer:drawText(name, posX+80-nameSize/2, posY+12, WIDE)
	
	------------------------------------
	-- ����	
	------------------------------------
	-- ���� ������̰� �����϶�
	if playerState == 0 then
		if playerReadyFlag == true then
			drawer:drawTexture("UIData/GameImage_dual.tga", posX+115, posY+6, 45, 17, 956, 100, WIDE)
		end
	
	-- ���� �÷������϶�
	elseif playerState == 1 then
		if disconnect == 0 then
			if playerAlphaFlag > 500 then
				drawer:drawTextureA("UIData/GameImage_dual.tga", posX, posY, 168, 28, 550, 265, 128, WIDE)
			end
		end
		
	-- ������
	elseif playerState == 2 then
	end
	
	if disconnect == 1 then
		drawer:drawTexture("UIData/GameNewImage.tga", posX+48, posY+8, 74, 14, 2, 190, WIDE)
	end
		
	-- ų, ���� ǥ��
	local KILL_POS_X = 142
	--kill = 3
	--killed = 3
	if kill > 0 then
		for i=1, kill do
			drawer:drawTexture("UIData/GameImage_dual.tga", posX+KILL_POS_X-((kill+killed-i)*11), posY, 21, 30, 597, 359, WIDE)
		end
	end	

	if killed > 0 then
		for i=1, kill do
			drawer:drawTexture("UIData/GameImage_dual.tga", posX+KILL_POS_X-((kill+killed-i)*11), posY, 21, 30, 597, 359, WIDE)
		end
	end
--]]
end


function WndSingleMatchGame_KoState(enemyType, idx, playerResult, winLoseSize)
	local posX = 6
	local posY = 56
	local WIDE = WIDETYPE_0
	if enemyType == 0 then
		posX = 430-((winLoseSize-1)*11) + (idx*11)
		WIDE = WIDETYPE_0
	else
		posX = 570 + (idx*11)
		WIDE = WIDETYPE_1
	end
	
	-- �й�
	if playerResult == 0 then
		drawer:drawTexture("UIData/GameImage_dual.tga", posX, posY, 21, 30, 618, 359, WIDE)
	-- �¸�
	elseif playerResult == 1 then
		drawer:drawTexture("UIData/GameImage_dual.tga", posX, posY, 21, 30, 597, 359, WIDE)
	end	
end

-- ���� �÷������� ���� �˷��ֱ�
function WndSingleMatchGame_NotifyCurrentPlayer(playerState)
	--[[
	DebugStr("playerState : "..playerState)
	if playerState == 1 then
		DebugStr("adfsafasdffads")
		drawer:drawTextureA("UIData/GameImage_dual.tga", posX-2, posY+2, 168, 28, 550, 321, playerAlpha, WIDE)
	end
	--]]
end



----------------------------------------------------------

-- ���� �¸� ĳ����

----------------------------------------------------------
function WndSingleMatchGame_RenderWinPlayer(deltaTime, name, winTeam)
	if winTeam == 0 then
		drawer:drawTextureA("UIData/GameImage_dual.tga", 319, 200, 385, 114, 639, 367, 255, WIDETYPE_5)
	else
		drawer:drawTextureA("UIData/GameImage_dual.tga", 319, 200, 385, 114, 0, 235, 255, WIDETYPE_5)
	end
	
	drawer:setFont(g_STRING_FONT_GULIMCHE, 20)
	drawer:setTextColor(255, 255, 255, 255)
	local NameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 20, name)
	drawer:drawText(name, 512-NameSize/2, 275, WIDETYPE_5)
end


----------------------------------------------------------

-- �޺�ȿ�� �ֱ�

----------------------------------------------------------
local tComboEffectTexY = { ["err"]=0, 0, 38, 76 }
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndSingleMatchGame_Effect_combo")
mywindow:setPosition(400, 190)
mywindow:setSize(237, 37)
mywindow:setScaleWidth(255)
mywindow:setScaleHeight(255)
mywindow:setVisible(false)
mywindow:setTexture("Enabled", "UIData/GameNewImage2.tga", 646, 0)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
root:addChildWindow(mywindow)

winMgr:getWindow("sj_WndSingleMatchGame_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
winMgr:getWindow("sj_WndSingleMatchGame_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
winMgr:getWindow("sj_WndSingleMatchGame_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
winMgr:getWindow("sj_WndSingleMatchGame_Effect_combo"):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
winMgr:getWindow("sj_WndSingleMatchGame_Effect_combo"):setAlign(8)

local g_ComboEffectEnable = false
local g_ComboEffectAlpha = 255
local g_ComboEffectTime = 0
function WndSingleMatchGame_ComboEffect(state)
	g_ComboEffectEnable = true
	g_ComboEffectAlpha = 255
	
	if state >= 3 then
		state = 3
	end
	winMgr:getWindow("sj_WndSingleMatchGame_Effect_combo"):setTexture("Enabled", "UIData/GameNewImage2.tga", 646, tComboEffectTexY[state])
	winMgr:getWindow("sj_WndSingleMatchGame_Effect_combo"):setVisible(true)
	winMgr:getWindow("sj_WndSingleMatchGame_Effect_combo"):activeMotion("StampEffect")
end



----------------------------------------------------------

-- KOȿ�� �ֱ�

----------------------------------------------------------
-- �ִ� 32����� KO�� �Ҽ� �ִٰ� �����ؼ� 32����� ����
local g_KoEffectEnable = { ["err"]=0, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false
									, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false }
local g_KoEffectAlpha  = { ["err"]=0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
									, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
local g_KoEffectTime   = { ["err"]=0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
									, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
local g_KoEffectTexY   = { ["err"]=0, 0, 137, 274, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411
									, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411, 411 }
for i=1, #g_KoEffectEnable do
	mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndSingleMatchGame_Effect_ko"..i)
	mywindow:setWideType(5);
	mywindow:setPosition(190, 80)
	mywindow:setSize(646, 137)
	mywindow:setScaleWidth(255)
	mywindow:setScaleHeight(255)
	mywindow:setVisible(false)
	mywindow:setTexture("Enabled", "UIData/GameNewImage2.tga", 0, 0)
	mywindow:setProperty("BackgroundEnabled", "False")
	mywindow:setProperty("FrameEnabled", "False")
	root:addChildWindow(mywindow)

	winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Quintic_EaseIn", 700, 255, 3, true, false, 10)
	winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "xscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..i):addController("CommonAlertOkBoxCtrl0", "StampEffect", "yscale", "Elastic_EaseOut", 150, 255, 5, true, false, 10)
	winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..i):setAlign(8)
end

function WndSingleMatchGame_KoEffect(koCount)
	if koCount <= 0 then
		return
	end
		
	-- ������ ����Ǵ°� �ִٸ� ������ �����Ѵ�.
	for i=1, #g_KoEffectEnable do
		g_KoEffectEnable[i] = false
	end
	
	if koCount >= #g_KoEffectEnable then
		return
	end
	
	g_KoEffectEnable[koCount] = true
	g_KoEffectAlpha[koCount]  = 255
	
	winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..koCount):setTexture("Enabled", "UIData/GameNewImage2.tga", 0, g_KoEffectTexY[koCount])
	winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..koCount):setVisible(true)
	winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..koCount):activeMotion("StampEffect")
	
	if koCount == 1 then
		PlaySound('sound/System/System_KO.wav')
	elseif koCount == 2 then
		PlaySound('sound/System/System_DoubleKO.wav')
	elseif koCount == 3 then
		PlaySound('sound/System/System_TripleKO.wav')
	elseif koCount >= 4 then
		PlaySound('sound/System/System_FantasticKO.wav')
	end
end





----------------------------------------------------------

-- ���� ������ �׿����� Ȯ��

----------------------------------------------------------
function WndSingleMatchGame_RenderKillAndDead(bTeam, killEnemyType, deadEnemyType, count, killName, deadName)
	
	local firstPosX = 800
	local firstPosY = 220+(count*30)--200+(count*38)
	local killPosX	= GetStringSize(g_STRING_FONT_GULIMCHE, 12, killName)
	local summaryDeadName = SummaryString(g_STRING_FONT_GULIMCHE, 12, deadName, 70)
	
	-- ��� �ָ� �̹���
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	drawer:drawTexture("UIData/GameNewImage.tga", firstPosX, firstPosY, 216, 38, 303, 79, WIDETYPE_1)


	-- �ɸ��� �̸�
	if bTeam == 0 then
		common_DrawOutlineText1(drawer, killName, firstPosX+76-killPosX, firstPosY+12, 0,0,0,255, 102,204,102,255, WIDETYPE_1)
		common_DrawOutlineText1(drawer, summaryDeadName, firstPosX+138, firstPosY+12, 0,0,0,255, 200,200,200,255, WIDETYPE_1)
	else
		if killEnemyType == 0 then
			common_DrawOutlineText1(drawer, killName, firstPosX+76-killPosX, firstPosY+12, 0,0,0,255, 254,87,87,255, WIDETYPE_1)
		else
			common_DrawOutlineText1(drawer, killName, firstPosX+76-killPosX, firstPosY+12, 0,0,0,255, 97,161,240,255, WIDETYPE_1)
		end
		
		if deadEnemyType == 0 then
			common_DrawOutlineText1(drawer, summaryDeadName, firstPosX+138, firstPosY+12, 0,0,0,255, 254,87,87,255, WIDETYPE_1)
		else
			common_DrawOutlineText1(drawer, summaryDeadName, firstPosX+138, firstPosY+12, 0,0,0,255, 97,161,240,255, WIDETYPE_1)
		end
	end
end





----------------------------------------------------------

-- �̼� �׸��� (3����� ���̱�)

----------------------------------------------------------
--[[
local tMissionDesc = { ["err"]=0, [0]=-300, -300 }
local tMissionSucc = { ["err"]=0, [0]=-100, -100 }
local g_MissionEffectTime0 = 0
local g_MissionEffectTime1 = 0
local g_missionSound0 = true
local g_missionSound1 = true
local g_missionCompleteSound = true
function WndSingleMatchGame_RenderMission(deltaTime, ready, fight, bComplete, bSuccess0, bSuccess1, contents0, contents1, bLast1Min)
	
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	
	-- �̼� ���â
	drawer:drawTexture("UIData/GameNewImage.tga", 632, 716, 387, 48, 632, 256, WIDETYPE_4)

	-- �̼� ������
	local mission0_size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, contents0)
	local mission1_size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, contents1)
	local rightEmptyLine0 = 985 - mission0_size
	local rightEmptyLine1 = 985 - mission1_size
	local successPos0 = 990 - mission0_size - 80
	local successPos1 = 990 - mission1_size - 80
	
	-- �̼� ����
	if ready == 0 and fight == 0 then
	
		-- �̼� 0�� ����
		if rightEmptyLine0 <= tMissionDesc[0] then
			tMissionDesc[0] = rightEmptyLine0
			
			if bSuccess0 == 1 then
				drawer:setTextColor(102, 153, 102, 255)
				common_DrawOutlineText1(drawer, contents0, tMissionDesc[0], 723, 0,0,0,255, 102,204,102, 255, WIDETYPE_4)
			else
				if bLast1Min == 1 then
					g_MissionEffectTime0 = g_MissionEffectTime0 + deltaTime
					g_MissionEffectTime0 = g_MissionEffectTime0 % 400
								
					if g_MissionEffectTime0 < 200 then
						drawer:setTextColor(255, 255, 255, 255)
						drawer:drawText(contents0, tMissionDesc[0], 723, WIDETYPE_4)
					end
				else
					drawer:setTextColor(255, 255, 255, 255)
					drawer:drawText(contents0, tMissionDesc[0], 723, WIDETYPE_4)
				end
			end
			
		else
			drawer:setTextColor(255, 255, 255, 255)			
			drawer:drawText(contents0, tMissionDesc[0], 723, WIDETYPE_4)
		end
		
		-- �̼� 1�� ����
		if rightEmptyLine1 <= tMissionDesc[1] then
			tMissionDesc[1] = rightEmptyLine1
			
			if bSuccess1 == 1 then
				drawer:setTextColor(102, 153, 102, 255)
				common_DrawOutlineText1(drawer, contents1, tMissionDesc[1], 746, 0,0,0,255, 102,204,102,255, WIDETYPE_4)
			else
				if bLast1Min == 1 then
					g_MissionEffectTime1 = g_MissionEffectTime1 + deltaTime
					g_MissionEffectTime1 = g_MissionEffectTime1 % 400
								
					if g_MissionEffectTime1 < 200 then
						drawer:setTextColor(255, 255, 255, 255)
						drawer:drawText(contents1, tMissionDesc[1], 746, WIDETYPE_4)
					end
				else
					drawer:setTextColor(255, 255, 255, 255)
					drawer:drawText(contents1, tMissionDesc[1], 746, WIDETYPE_4)
				end	
			end
			
		else
			drawer:setTextColor(255, 255, 255, 255)
			drawer:drawText(contents1, tMissionDesc[1], 746, WIDETYPE_4)
		end
		
		tMissionDesc[0] = tMissionDesc[0] + (deltaTime*4)
		tMissionDesc[1] = tMissionDesc[1] + (deltaTime*4)
		
	end
	
	
	-- �̼� Complete
	if bComplete == 1 then
		if g_missionCompleteSound then
			g_missionCompleteSound = false
			PlaySound('sound/System/System_Complete.wav')
		end
		drawer:drawTexture("UIData/GameNewImage.tga", 850, 693, 169, 23, 761, 233, WIDETYPE_4)
	else
		drawer:drawTexture("UIData/GameNewImage.tga", 934, 693, 85, 23, 934, 233, WIDETYPE_4)
	end
	
	
	
	-- 1�� �̼� ����
	if bSuccess0 == 1 then
	
		if bComplete == 0 then
			if g_missionSound0 then
				g_missionSound0 = false
				PlaySound('sound/System/System_Succes.wav')
			end
		end
		
		drawer:drawTexture("UIData/GameNewImage.tga", 995, 718, 22, 21, 995, 187)
		
		if successPos0 <= tMissionSucc[0] then
			tMissionSucc[0] = successPos0
			drawer:drawTexture("UIData/GameNewImage.tga", tMissionSucc[0], 710, 59, 38, 880, 182, WIDETYPE_4)	-- success
		else
			drawer:drawTexture("UIData/GameNewImage.tga", tMissionSucc[0], 710, 59, 38, 880, 182, WIDETYPE_4)	-- success
		end
		
		tMissionSucc[0] = tMissionSucc[0] + (deltaTime*4)
	end
	
	
	
	-- 2�� �̼� ����
	if bSuccess1 == 1 then
	
		if bComplete == 0 then
			if g_missionSound1 then
				g_missionSound1 = false
				PlaySound('sound/System/System_Succes.wav')
			end
		end
		
		drawer:drawTexture("UIData/GameNewImage.tga", 995, 741, 22, 21, 995, 210, WIDETYPE_4)
		
		if successPos1 <= tMissionSucc[1] then
			tMissionSucc[1] = successPos1
			drawer:drawTexture("UIData/GameNewImage.tga", tMissionSucc[1], 733, 59, 38, 880, 182, WIDETYPE_4)	-- success
		else
			drawer:drawTexture("UIData/GameNewImage.tga", tMissionSucc[1], 733, 59, 38, 880, 182, WIDETYPE_4)	-- success
		end
		
		tMissionSucc[1] = tMissionSucc[1] + (deltaTime*4)
	end	
	
end
--]]



----------------------------------------------------------

-- ���۽� ���̵� ��/�ƿ� �׸���

----------------------------------------------------------
function RenderFadeInOut(remainTime, redLevel, blueLevel, redName, blueName, redStyle, blueStyle, redPromotion, bluePromotion, redAttribute, blueAttribute, round)

	local alpha = 255
	if remainTime <= 240 then
		alpha = 255 - ((240-remainTime) * 15)
	end
	if alpha <= 0 then
		alpha = 0
	end
		
	local RED_POS_X = 140
	local RED_POS_Y = 350
	local BLUE_POS_X = 930
	local BLUE_POS_Y = 350
	
	local WIDE_X = 1920-g_GAME_WIN_SIZEX
	local WIDE_Y = 1200-g_GAME_WIN_SIZEY
	drawer:drawTextureA("UIData/gameImage_vs.tga", 0, 0, g_GAME_WIN_SIZEX, g_GAME_WIN_SIZEY, WIDE_X/2, WIDE_Y/2-30, alpha, WIDETYPE_0)
	
	-- ����
	drawer:drawTextureA("UIData/Notice_up.tga", 320, 60, 301, 98, 505, 304, alpha, WIDETYPE_5)
	DrawEachNumberAS("UIData/Notice_up.tga", round, 1, 320+340, 106, 0, 402, 73, 98, 73, alpha, 255, 255, WIDETYPE_5)
	
	-- ������ ����
	--redName = "WWWWWWWWWWWW"
	local redText = "Lv."..redLevel.."  "..redName
	drawer:setFont(g_STRING_FONT_GULIMCHE, 22)
	drawer:setTextColor(255,255,255,alpha)
	local redNameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 22, redText)
	drawer:drawText(redText, RED_POS_X, RED_POS_Y, WIDETYPE_5)
	drawer:drawTextureSA("UIData/Skill_up2.tga", RED_POS_X-5, RED_POS_Y-50, 87, 35, 
			tAttributeImgTexXTable[redStyle][redAttribute], tAttributeImgTexYTable[redStyle][redAttribute], 350, 350, alpha, 0, 0, WIDETYPE_5)
	drawer:drawTextureSA("UIData/Skill_up2.tga", RED_POS_X-5, RED_POS_Y-50, 87, 35, 
			promotionImgTexXTable[redStyle], promotionImgTexYTable[redPromotion], 320, 320, alpha, 0, 0, WIDETYPE_5)
	
	-- ����� ����
	--blueName = "WWWWWWWWWWWW"
	--blueName = "�����ٶ󸶹�"
	local blueText = "Lv."..blueLevel.."  "..blueName
	local blueNameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 22, blueText)
	drawer:drawText(blueText, BLUE_POS_X-blueNameSize, BLUE_POS_Y, WIDETYPE_5)
	drawer:drawTextureSA("UIData/Skill_up2.tga", BLUE_POS_X-5-blueNameSize, BLUE_POS_Y-50, 87, 35, 
			tAttributeImgTexXTable[blueStyle][blueAttribute], tAttributeImgTexYTable[blueStyle][blueAttribute], 350, 350, alpha, 0, 0, WIDETYPE_5)
	drawer:drawTextureSA("UIData/Skill_up2.tga", BLUE_POS_X-5-blueNameSize, BLUE_POS_Y-50, 87, 35, 
			promotionImgTexXTable[blueStyle], promotionImgTexYTable[bluePromotion], 320, 320, alpha, 0, 0, WIDETYPE_5)
end


local g_readySound = true
local g_fightSound = true
function WndSingleMatchGame_InitStartInfo()
	g_readySound = true
	g_fightSound = true
end



----------------------------------------------------------

-- ready �׸���

----------------------------------------------------------
local tReadyDelta = { ["err"]=0, -410 }
local tFightDelta = { ["err"]=0, 0, 255 }
function WndSingleMatchGame_RenderBattleReady(deltaTime)
	
	--tReadyDelta[1] = tReadyDelta[1] + deltaTime*3
	--if tReadyDelta[1] >= 720 then
		drawer:drawTexture("UIData/Notice_up2.tga", 284, 316, 456, 137, 0, 137, WIDETYPE_5)
	--else
	--	drawer:drawTexture("UIData/GameNewImage.tga", -410+tReadyDelta[1], 200, 403, 89, 599, 406, WIDETYPE_5)
	--end
	
	-- ���� ����
	if g_readySound then
		g_readySound = false
		PlaySound('sound/System/System_READY.wav')
	end
	
	tFightDelta[1] = 0
	tFightDelta[2] = 255
	g_battleAlpha = 255
end






----------------------------------------------------------

-- fight �׸���

----------------------------------------------------------
local g_fightTime = 0
local g_fightAlpha = 0
local g_battleAlpha = 255
function WndSingleMatchGame_CallFight()
	 g_fightTime = 0
	 g_fightAlpha = 255
	 g_battleAlpha = 255
end
function WndSingleMatchGame_RenderBattleFight(deltaTime)
--[[
	tFightDelta[1] = tFightDelta[1] + deltaTime
	if tFightDelta[1] >= 400 then
		
		tFightDelta[2] = tFightDelta[2] - deltaTime/2
		if tFightDelta[2] <= 0 then
			tFightDelta[2] = 0
		end
	end
	
	-- ����Ʈ ����
	if g_fightSound then
		g_fightSound = false
		PlaySound('sound/System/System_FIGHT.wav')
	end
	
	drawer:drawTextureA("UIData/GameNewImage.tga", 290, 201, 425, 88, 599, 317, tFightDelta[2], WIDETYPE_5)
	tReadyDelta[1] = -410
--]]
	
	g_fightTime = g_fightTime + deltaTime
	local scale = Effect_Linear_EaseNone(g_fightTime, 0, 240-g_fightTime, 20)
	if scale < 0 then
		scale = 0
	end
	
	g_fightAlpha = g_fightAlpha - (deltaTime/5)
	if g_fightAlpha <= 0 then
		g_fightAlpha = 0
	end
	
	drawer:drawTextureA("UIData/Notice_up2.tga", 284, 316, 456, 137, 0, 0, g_fightAlpha, WIDETYPE_5)
	--drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", 520, 230, 425, 88, 599, 317,
	--									scale+255, scale+255, g_fightAlpha, 0, 8, 100, 0, WIDETYPE_5)
											
	-- ����Ʈ ����
	if g_fightSound then
		g_fightSound = false
		PlaySound('sound/System/System_FIGHT.wav')
	end
end


----------------------------------------------------------

-- �����Ȳ(����, ����� ����Ƚ��, ������ ����Ƚ��, ���� ų��, ���� ����Ƚ��)

----------------------------------------------------------
local last10secEffectTime = 0
function WndSingleMatchGame_RenderScore(deltaTime, min, sec, state, redWinCount, blueWinCount)
	
	------------------------------------
	-- ���� �޺�ȿ�� �ֱ��� ���İ� �ֱ�
	------------------------------------
	if g_ComboEffectEnable then
		g_ComboEffectTime = g_ComboEffectTime + deltaTime
		if g_ComboEffectTime >= 1200 then			
			g_ComboEffectAlpha = g_ComboEffectAlpha - deltaTime
			if g_ComboEffectAlpha <= 0 then
				g_ComboEffectTime = 0
				g_ComboEffectAlpha = 0
				g_ComboEffectEnable = false
				winMgr:getWindow("sj_WndSingleMatchGame_Effect_combo"):setVisible(false)
			end
			winMgr:getWindow("sj_WndSingleMatchGame_Effect_combo"):setAlpha(g_ComboEffectAlpha)
		end
	end
	
	
	
	------------------------------------
	-- KOȿ��
	------------------------------------
	for i=1, #g_KoEffectEnable do
		if g_KoEffectEnable[i] then
			g_KoEffectTime[i] = g_KoEffectTime[i] + deltaTime
			if g_KoEffectTime[i] >= 1200 then
				g_KoEffectAlpha[i] = g_KoEffectAlpha[i] - deltaTime
				if g_KoEffectAlpha[i] <= 0 then
					g_KoEffectEnable[i] = false
					g_KoEffectAlpha[i]  = 0
					g_KoEffectTime[i]   = 0
					
					if winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..i) then
						winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..i):setVisible(false)
					end
				end
				
				if winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..i) then
					winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..i):setAlpha(g_KoEffectAlpha[i])
				end
			end
		else
			g_KoEffectAlpha[i] = 0
			g_KoEffectTime[i]  = 0
			if winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..i) then
				winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..i):setVisible(false)
				winMgr:getWindow("sj_WndSingleMatchGame_Effect_ko"..i):setAlpha(g_KoEffectAlpha[i])
			end
		end
	end
	
	-- vs
	if state == 1 then
		drawer:drawTexture("UIData/GameImage_dual.tga", 465, 2, 94, 58, 786, 199, WIDETYPE_5)
	end
		
	-- �÷��̿��� �ð��� ���´�.
	if state == 2 or state == 3 then
		------------------------------------
		-- time
		------------------------------------
		-- ������ 10�� ������ ���
		if min >= 0 then
			if min == 0 and sec <= 9 then
				
				-- �����Ÿ��鼭 �ð� ���̱�
				last10secEffectTime = last10secEffectTime + deltaTime
				last10secEffectTime = last10secEffectTime % 100

				if last10secEffectTime < 50 then
					drawer:drawTexture("UIData/GameNewImage.tga", 492, 2, 41, 54, sec*41, 241, WIDETYPE_5)
				else
					drawer:drawTexture("UIData/GameNewImage.tga", 492, 2, 41, 54, sec*41, 299, WIDETYPE_5)
				end
				
			else
				-- ��
			--	drawer:drawTexture("UIData/GameNewImage.tga", 462, 7, 20, 26, 77, 704, WIDETYPE_5)
			--	drawer:drawTexture("UIData/GameNewImage.tga", 483, 7, 20, 26, 77+(min*20), 704, WIDETYPE_5)
			
				-- :
			--	drawer:drawTexture("UIData/GameNewImage.tga", 502, 7, 20, 26, 277, 704, WIDETYPE_5)
				
				-- ��
				--local ten = (sec/10)
				--local one = (sec%10)				
				--drawer:drawTexture("UIData/Notice_up.tga", 472, 2, 41, 54, (ten*41), 241, WIDETYPE_5)
				--drawer:drawTexture("UIData/Notice_up.tga", 510, 2, 41, 54, (one*41), 241, WIDETYPE_5)
				DrawEachNumberAS("UIData/Notice_up.tga", sec, 8, 512, 30, 0, 776, 36, 55, 36, 255, 255, 255, WIDETYPE_5)
			end	
		else	
			-- �����Ÿ��鼭 �ð� ���̱�
			last10secEffectTime = last10secEffectTime + deltaTime
			last10secEffectTime = last10secEffectTime % 100

			if last10secEffectTime < 50 then
				drawer:drawTexture("UIData/GameNewImage.tga", 492, 2, 41, 54, 41, 241, WIDETYPE_5)
			else
				drawer:drawTexture("UIData/GameNewImage.tga", 492, 2, 41, 54, 41, 299, WIDETYPE_5)
			end
		end
	end
	
	if state ~= 0 then
--		DrawEachNumberAS("UIData/numberUi001.tga", redWinCount, 2, 430, 80, 274, 521, 74, 66, 75, 255, 150, 150, WIDETYPE_0)	-- ������ ų��
--		DrawEachNumberAS("UIData/numberUi001.tga", blueWinCount, 1, 590, 80, 274, 455, 74, 66, 75, 255, 150, 150, WIDETYPE_1)	-- ����� ų��
	end
end



function RenderIntroTimeBack()
	local round = 1
	local WIDE_X = 1920-g_GAME_WIN_SIZEX
	local WIDE_Y = 1200-g_GAME_WIN_SIZEY
	drawer:drawTextureA("UIData/gameImage_vs.tga", 0, 0, g_GAME_WIN_SIZEX, g_GAME_WIN_SIZEY, WIDE_X/2, WIDE_Y/2-30, 255, WIDETYPE_0)
	
	-- ����
	drawer:drawTextureA("UIData/Notice_up.tga", 320, 60, 301, 98, 505, 304, 255, WIDETYPE_5)
	DrawEachNumberAS("UIData/Notice_up.tga", round, 1, 320+340, 106, 0, 402, 73, 98, 73, 255, 255, 255, WIDETYPE_5)
end

function RenderIntroTime(enemyType, level, name, style, promotion, attribute)
	
	-- ����
	local POS_X = 140
	local POS_Y = 350	
	local _Text = "Lv."..level.."  "..name
	drawer:setFont(g_STRING_FONT_GULIMCHE, 22)
	drawer:setTextColor(255,255,255,255)
	local nameSize = GetStringSize(g_STRING_FONT_GULIMCHE, 22, _Text)
	if enemyType == 0 then
		POS_X = 140
	else
		POS_X = 930 - nameSize
	end
	drawer:drawText(_Text, POS_X, POS_Y, WIDETYPE_5)
	drawer:drawTextureSA("UIData/Skill_up2.tga", POS_X-5, POS_Y-50, 87, 35, 
			tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute], 350, 350, 255, 0, 0, WIDETYPE_5)
	drawer:drawTextureSA("UIData/Skill_up2.tga", POS_X-5, POS_Y-50, 87, 35, 
			promotionImgTexXTable[style], promotionImgTexYTable[promotion], 320, 320, 255, 0, 0, WIDETYPE_5)
	
end






----------------------------------------------------------

-- �޺�, ������

----------------------------------------------------------

function WndSingleMatchGame_ComboAndDamage(deltaTime, isCombo, currentCombo, isAccumulate, accumDamage, 
							teamAttackCount, doubleAttackCount, isTeamAttack, isDoubleAttack, currentAttackCount)
	Common_ComboAndDamage(deltaTime, isCombo, currentCombo, isAccumulate, accumDamage, 
			teamAttackCount, doubleAttackCount, isTeamAttack, isDoubleAttack, currentAttackCount)
end










----------------------------------------------------

-- ������

----------------------------------------------------
--[[
function WndSingleMatchGame_RenderStartItemSlot(bSlot0, bSlot1, bSlot2)
end




-- ������ �׸���
function WndSingleMatchGame_RenderItem(bChanged, itemType_0, itemType_1, tick, CHANGED_TICK)

	if CHANGED_TICK == 0 then
		return
	end
	
	-- ������ ������ ���
	if bChanged == 1 then
		local spacing = 60 / CHANGED_TICK
		
		-- ���� 0��°
		if g_itemSlotX_0 + (tick * spacing) >= ITEMSLOT_1 then
			g_itemSlotX_0 = ITEMSLOT_1
			g_itemScale_0 = ITEMSCALE_1
		else
			g_itemSlotX_0 = g_itemSlotX_0 + (tick * spacing)
			g_itemScale_0 = g_itemScale_0 - (tick * spacing)
		end
			
		-- ���� 1��°
		if g_itemSlotX_1 - (tick * spacing) <= ITEMSLOT_0 then
			g_itemSlotX_1 = ITEMSLOT_0
			g_itemScale_1 = ITEMSCALE_0
		else
			g_itemSlotX_1 = g_itemSlotX_1 - (tick * spacing)
			g_itemScale_1 = g_itemScale_1 + (tick * spacing)
		end
		
		g_itemEffectSlotX_0 = g_itemSlotX_0
		g_itemEffectSlotX_1 = g_itemSlotX_1
		
	else
		-- ���� ������ �Ϸ�ǰų�, �������� ���� ��� ���� ��ġ�� �׷��ش�.
		g_itemSlotX_0 = ITEMSLOT_0
		g_itemSlotX_1 = ITEMSLOT_1
		
		g_itemScale_0 = ITEMSCALE_0
		g_itemScale_1 = ITEMSCALE_1
		
	end
	
	
	-- ������ �׸���
	if gMyTeam == 0 then
		if itemType_0 >= 0 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", g_itemSlotX_0, g_itemSlotY, 43, 44, itemType_0*47, 0,
															g_itemScale_0, g_itemScale_0, 255, 0, 8, 100, 0, WIDETYPE_0)
		end
		
		if itemType_1 >= 0 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", g_itemSlotX_1, g_itemSlotY, 43, 44, itemType_1*47, 0,
															g_itemScale_1, g_itemScale_1, 255, 0, 8, 0, 0, WIDETYPE_0)
		end	
	else
		if itemType_0 >= 0 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", g_itemSlotX_0, g_itemSlotY, 43, 44, itemType_0*47, 0,
															g_itemScale_0, g_itemScale_0, 255, 0, 8, 100, 0, WIDETYPE_1)
		end
		
		if itemType_1 >= 0 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", g_itemSlotX_1, g_itemSlotY, 43, 44, itemType_1*47, 0,
															g_itemScale_1, g_itemScale_1, 255, 0, 8, 0, 0, WIDETYPE_1)
		end	
	end
end



-- ������ �Ծ��� �� ȿ�� �׸���
function WndSingleMatchGame_RenderEffectGetItem(slot, state)

	local itemPosX = 0
	if gMyTeam == 0 then
		if slot == 0 then
			itemPosX = g_itemEffectSlotX_0
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", ITEMSLOT_0, g_itemSlotY, 41, 45, 554+(state*46), 162,
															ITEMSCALE_0, ITEMSCALE_0, 255, 0, 8, 100, 0, WIDETYPE_0)
		elseif slot == 1 then
			itemPosX = g_itemEffectSlotX_1
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", ITEMSLOT_1, g_itemSlotY, 41, 45, 554+(state*46), 162,
															ITEMSCALE_1, ITEMSCALE_1, 255, 0, 8, 100, 0, WIDETYPE_0)
		end
	else
		if slot == 0 then
			itemPosX = g_itemEffectSlotX_0
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", ITEMSLOT_0, g_itemSlotY, 41, 45, 554+(state*46), 162,
															ITEMSCALE_0, ITEMSCALE_0, 255, 0, 8, 100, 0, WIDETYPE_1)
		elseif slot == 1 then
			itemPosX = g_itemEffectSlotX_1
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", ITEMSLOT_1, g_itemSlotY, 41, 45, 554+(state*46), 162,
															ITEMSCALE_1, ITEMSCALE_1, 255, 0, 8, 100, 0, WIDETYPE_1)
		end
	end
end



-- ��Ҷ�, ���Ժ����� �Ϸ�Ǿ��� ��� ��ġ �ʱ�ȭ
function WndSingleMatchGame_InitEffectGetItem()

	g_itemEffectSlotX_0 = ITEMSLOT_0
	g_itemEffectSlotX_1 = ITEMSLOT_1

end



-- ������ ���� �̹���(����� 0������ �׵θ�)
function WndSingleMatchGame_RenderEndItemSlot()

--	drawer:drawTextureWithScale_Angle_Offset("UIData/GameNewImage.tga", ITEMSLOT_0, g_itemSlotY, 57, 59, 658, 100,
--														330, 330, 255, 0, 8, 100, 0)
end


-- ������ ü���� ������ ��
function WndSingleMatchGame_RenderSlotChangeCount(slotChangeCount)
	if gMyTeam == 0 then
		drawer:drawTexture("UIData/GameSlotItem.tga", 110, g_itemSlotY+8, 10, 11, 15, 261, WIDETYPE_0)	-- X
		DrawEachNumberWide("UIData/GameSlotItem.tga", slotChangeCount, 8, 110, g_itemSlotY+21, 28, 261, 12, 14, 15, WIDETYPE_0)
	else
		drawer:drawTexture("UIData/GameSlotItem.tga", 902, g_itemSlotY+8, 10, 11, 15, 261, WIDETYPE_1)	-- X
		DrawEachNumberWide("UIData/GameSlotItem.tga", slotChangeCount, 8, 902, g_itemSlotY+21, 28, 261, 12, 14, 15, WIDETYPE_1)
	end
end



-- �������� ������� �� �����ֱ�
function WndSingleMatchGame_ItemUseEffect(type, tick)

	local alpha
	if 0 <= tick and tick <= 60 then
		alpha = 255
	elseif 60 < tick and tick < 89 then
		alpha = 255 - ((tick-60)*8)
	elseif tick <= 90 then
		alpha = 0
	end
	
	local y = 200
	
	-- ����� �� �ֺ�ȿ�� �׸���
	if tick <= 20 then
		local _tick = tick/5
		if _tick == 0 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 47, 49, 60, 139, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_5)
		elseif _tick == 1 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 71, 73, 110, 127, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_5)
		elseif _tick == 2 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 519, y, 107, 109, 179, 109, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_5)
		elseif _tick == 3 then
			drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 39, 41, 296, 141, 510, 510, alpha, 0, 8, 100, 0, WIDETYPE_5)
		end
	end
	
	-- ���Ǵ� ������ �׸���
	drawer:drawTextureWithScale_Angle_Offset("UIData/GameSlotItem.tga", 516, y, 43, 44, type*47, 0,
														350, 350, alpha, 0, 8, 100, 0, WIDETYPE_5)
	
	-- ���Ǵ� ������ �̸�
	drawer:drawTextureA("UIData/GameSlotItem.tga", 450, y+30, 128, 19, 399, 142+(type*19), alpha, WIDETYPE_5)
end
--]]



----------------------------------------------------

-- �Ӽ� ������

----------------------------------------------------
local tItemDescEnum = {["err"]=0, [0]=LAN_CLUBWAR_PLAY_ITEMEX1_SHIELD, LAN_CLUBWAR_PLAY_ITEMEX2_PWUP, LAN_CLUBWAR_PLAY_ITEMEX3_BLOW,
					LAN_CLUBWAR_PLAY_ITEMEX4_RECOVER, LAN_CLUBWAR_PLAY_ITEMEX5_METEO, LAN_CLUBWAR_PLAY_ITEMEX5_TOWER}

-- ������ �׸���
--[[
function WndSingleMatchGame_RenderPropertyItem(itemType, myHP, myDiedTime)

	-- ������ �׸���
	if myHP <= 0 then
		if myDiedTime > 0 then
			drawer:drawTexture("UIData/fightClub_005.tga", 100, 64, 167, 62, 705, 0)			
		else
			drawer:drawTexture("UIData/fightClub_005.tga", 100, 64, 60, 62, 541, 0)
			drawer:drawTexture("UIData/fightClub_005.tga", 164, 64, 104, 62, 601, 0)
		end
	end
	
	drawer:drawTexture("UIData/fightClub_005.tga", 100, 64, 60, 62, 541, 0)
	drawer:drawTexture("UIData/fightClub_005.tga", 164, 64, 104, 62, 601, 0)
	
	if itemType >= 0 then
		drawer:drawTexture("UIData/fightClub_005.tga", 103, 67, 54, 56, 510, tPropertyItemTexY[itemType])
		
		-- ������ ����
		drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
		drawer:setTextColor(255,255,255,255)
		local szItemDesc = GetSStringInfo(tItemDescEnum[itemType])
		DebugStr('GetSStringInfo�� �����ϰ� �ֽ��ϴ�'..tItemDescEnum[itemType])	
		drawer:drawText(szItemDesc, 169, 68)
	end
end
--]]



----------------------------------------------------------

-- ���ӿ��� �׸���

----------------------------------------------------------
local g_gameoverSound = true
local tBlackImage = { ["err"]=0, -85 }
function WndSingleMatchGame_RenderGameOver(deltaTime)
	
	-- GAMEOVER �̹���
	if tBlackImage[1] >= 340 then
		tBlackImage[1] = 340
		drawer:drawTexture("UIData/GameNewImage2.tga", 189, tBlackImage[1], 650, 77, 11, 590, WIDETYPE_5)
	else
		tBlackImage[1] = tBlackImage[1] + (deltaTime/2)
		drawer:drawTexture("UIData/GameNewImage2.tga", 189, tBlackImage[1], 650, 77, 11, 590, WIDETYPE_5)
		
		if g_gameoverSound then
			g_gameoverSound = false
			PlaySound('sound/System/System_GAMEOVER.wav')
		end
	end
end




----------------------------------------------------------

-- E �ʻ�� ���� �˷��ֱ�

----------------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndSingleMatchGame_NotifyExceptE")
mywindow:setTexture("Enabled", "UIData/LobbyImage_new.tga", 998, 369)
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setProperty("FrameEnabled", "False")
mywindow:setWideType(5);
mywindow:setPosition(494, 226)
mywindow:setSize(26, 26)
mywindow:setVisible(false)
root:addChildWindow(mywindow)

function WndSingleMatchGame_ShowExceptE()
	winMgr:getWindow("sj_WndSingleMatchGame_NotifyExceptE"):setVisible(true)
	winMgr:getWindow("sj_WndSingleMatchGame_NotifyExceptE"):setScaleWidth(400)
	winMgr:getWindow("sj_WndSingleMatchGame_NotifyExceptE"):setScaleHeight(400)
	winMgr:getWindow("sj_WndSingleMatchGame_NotifyExceptE"):clearControllerEvent("notifyExceptE")
	winMgr:getWindow("sj_WndSingleMatchGame_NotifyExceptE"):addController("notifyExceptE", "notifyExceptE", "alpha", "Sine_EaseInOut", 255, 0, 10, false, false, 10)
	winMgr:getWindow("sj_WndSingleMatchGame_NotifyExceptE"):activeMotion("notifyExceptE")
end

function WndSingleMatchGame_HideExceptE()
	winMgr:getWindow("sj_WndSingleMatchGame_NotifyExceptE"):setVisible(false)
end


-- 15���� ä�� �ʱ�ȭ
local tShowText		 = { ["err"]=0 }
local tShowTextColor = { ["err"]=0 }
local tShowTextType  = { ["err"]=0 }

function WndSingleMatchGame_ClearChatting()

	for i=1, table.getn(tShowText) do
		table.remove(tShowText,  i)		-- ä�ó���
		table.remove(tShowTextColor, i)	-- ä�û���
		table.remove(tShowTextType, i)	-- ä��Ÿ��(�Ϲ�, �����)
	end
	
end

-- ������ ä�ó��� ����
function GetUserChat()
	for i=1, table.getn(tShowText) do
		WndSingleMatchGame_UserChattingSave(tShowText[i], tShowTextColor[i])
	end
end



------------------------------------------------

--	��ǳ�� �׸���

------------------------------------------------
function WndSingleMatchGame_OnDrawBoolean(str_chat, px, py, chatBubbleType)
	
	local real_str_chat = str_chat;
	if string.len(real_str_chat) <= 0 then
		return
	end
		
	if 0 > chatBubbleType or chatBubbleType > MAX_CHAT_BUBBLE_NUM then
		return
	end
	
	local alpha  = 255
	local UNIT   = tChatBubbleSize[chatBubbleType]		-- 1edge�� ������
	local UNIT2X = UNIT*2								-- 1edge�� ������ * 2
	local texX_L = tChatBubbleTexX[chatBubbleType]		-- �ؽ�ó ���� x��ġ
	local texY_L = tChatBubbleTexY[chatBubbleType]		-- �ؽ�ó ���� y��ġ
	local texX_R = texX_L+(UNIT*2)						-- �ؽ�ó ������ x��ġ
	local texY_R = texY_L+(UNIT*2)						-- �ؽ�ó ������ y��ġ
	local r,g,b  = GetChatBubbleColor(chatBubbleType)	-- �ؽ�Ʈ ����(0:���, 1:������)
	local posX	 = tChatBubblePosX[chatBubbleType]		-- ��ǳ�� x��ġ
	local posY	 = tChatBubblePosY[chatBubbleType]		-- ��ǳ�� y��ġ
	local tailTexX = tChatBubbleTailTexX[chatBubbleType]
	local tailTexY = tChatBubbleTailTexY[chatBubbleType]
	local tailSizX = tChatBubbleTailSizX[chatBubbleType]
	local tailSizY = tChatBubbleTailSizY[chatBubbleType]
	local tailPosType = tChatBubbleTailPosType[chatBubbleType]
	local tailPosY = tChatBubbleTailPosY[chatBubbleType]
	local textPosY = tChatTextPosY[chatBubbleType]
	
	local twidth, theight = GetBooleanTextSize(real_str_chat, g_STRING_FONT_GULIMCHE, 14)
	local AREA_X = twidth
	local AREA_Y = theight
	
	-- ��� ���� �ϱ�
	local DIV_X = twidth  / UNIT
	local DIV_Y = theight / UNIT
	local X = px-(UNIT2X+UNIT+(DIV_X*UNIT))/2 + posX
	local Y = py-AREA_Y-(UNIT*3) + posY
	
	-- ������ 4����
	drawer = root:getDrawer()
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y,					 UNIT, UNIT, texX_L, texY_L, alpha)-- ���� ��
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y,					 UNIT, UNIT, texX_R, texY_L, alpha)-- ������ ��
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y+UNIT2X+(DIV_Y*UNIT), UNIT, UNIT, texX_L, texY_R, alpha)-- ���� �Ʒ�
	drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y+UNIT2X+(DIV_Y*UNIT), UNIT, UNIT, texX_R, texY_R, alpha)-- ������ �Ʒ�
	
	-- ���� ����
	for i=0, DIV_X do
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y,						UNIT, UNIT, texX_L+UNIT, texY_L, alpha)-- ������
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y+UNIT2X+(DIV_Y*UNIT),	UNIT, UNIT, texX_L+UNIT, texY_R, alpha)-- �Ʒ�����
		
		-- ���
		for j=0, DIV_Y do
			drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(i*UNIT), posY+Y+UNIT+(j*UNIT), UNIT, UNIT, texX_L+UNIT, texY_L+UNIT, alpha)
		end
	end
	
	-- ���� ����
	for i=0, DIV_Y do
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X,					 posY+Y+UNIT+(i*UNIT), UNIT, UNIT, texX_L, texY_L+UNIT, alpha)-- ���ʶ���
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT2X+(DIV_X*UNIT), posY+Y+UNIT+(i*UNIT), UNIT, UNIT, texX_R, texY_L+UNIT, alpha)-- �����ʶ���
	end
	
	-- ��ǳ�� ���� �׸���
	if tailPosType == 0 then
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+(UNIT+(DIV_X*UNIT)/2), posY+Y+UNIT2X+(DIV_Y*UNIT)+tailPosY, tailSizX, tailSizY, tailTexX, tailTexY, alpha)
	elseif tailPosType == 1 then
		drawer:drawTextureA("UIData/gamedesign.tga", posX+X+UNIT+(DIV_X*UNIT), posY+Y+UNIT2X+(DIV_Y*UNIT)+tailPosY, tailSizX, tailSizY, tailTexX, tailTexY, alpha)
	end
	
	-- �ؽ�Ʈ �׸���
	drawer:setTextColor(r,g,b,255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
	drawer:drawText(real_str_chat, X+UNIT+2, Y+UNIT+textPosY)
end






--[[
----------------------------------------------------

-- Last 3

----------------------------------------------------
tLast3 = { ["protectErr"]=0, -425 }
function WndSingleMatchGame_RenderLast3(deltaTime, effect, section)
	if section == 0 then
		if tLast3[1] >= 330 then
			tLast3[1] = 330
		else
			tLast3[1] = tLast3[1] + deltaTime*2
		end
	elseif section == 1 then
		tLast3[1] = 330
	else
		tLast3[1] = tLast3[1] + deltaTime*2
	end
	
	if effect == 0 then
		drawer:drawTexture("UIData/GameImage_new.tga", tLast3[1], 270, 91, 88, 599, 676)
	else
		drawer:drawTexture("UIData/GameImage_new.tga", tLast3[1], 270, 91, 88, 599, 764)
	end
	
	drawer:drawTexture("UIData/GameImage_new.tga", tLast3[1]+91, 270, 334, 88, 690, 764)
end



----------------------------------------------------

-- Last 1

----------------------------------------------------
tLast1 = { ["protectErr"]=0, -425 }
function WndSingleMatchGame_RenderLast1(deltaTime, effect, section)
	if section == 0 then
		if tLast1[1] >= 330 then
			tLast1[1] = 330
		else
			tLast1[1] = tLast1[1] + deltaTime*2
		end
	elseif section == 1 then
		tLast1[1] = 330
	else
		tLast1[1] = tLast1[1] + deltaTime*2
	end
	
	if effect == 0 then
		drawer:drawTexture("UIData/GameImage_new.tga", tLast1[1], 270, 91, 88, 599, 676)
	else
		drawer:drawTexture("UIData/GameImage_new.tga", tLast1[1], 270, 91, 88, 599, 764)
	end
	
	drawer:drawTexture("UIData/GameImage_new.tga", tLast1[1]+91, 270, 334, 88, 690, 676)
end
--]]





----------------------------------------------------

-- Last 1��

----------------------------------------------------
local g_last1MinEffect  = 0
local g_last1MinTime	= 0
local g_last1Min		= true
local g_last1MinPos		= 0
local g_last1MinSound	= true

function WndSingleMatchGame_InitLast1MinData()
	g_last1MinEffect= 0
	g_last1MinTime	= 0
	g_last1Min		= true
	g_last1MinPos	= 0
	g_last1MinSound	= true
end

function WndSingleMatchGame_RenderLast1Min(deltaTime)

	if g_last1Min == false then
		return
	end
	
	if g_last1MinSound then
		PlaySound("sound/siren.wav")
		g_last1MinSound = false
	end
	
	
	g_last1MinTime = g_last1MinTime + deltaTime
		
	-- 1500������ ����� ����.
	if 0 <= g_last1MinTime and g_last1MinTime <= 1500 then	
		g_last1MinPos = Effect_Elastic_EaseOut(g_last1MinTime, -600, 860, 1500, 0, 0)
			
	-- ���Ŀ� 800�� �Ǹ� �������.
	elseif 1500 < g_last1MinTime and g_last1MinTime <= 2300 then	
		g_last1MinPos = Effect_Back_EaseIn(g_last1MinTime-1500, 250, 1600, 800, 0)
	
	-- 2300�� ������ �����
	else	
		g_last1MinTime	= 2400
		g_last1Min		= false
		g_last1MinPos	= 2000
		EndLast1Min()
		return		
	end
	
	-- ���̷�
	g_last1MinEffect = g_last1MinEffect + deltaTime
	g_last1MinEffect = g_last1MinEffect % 200
	if g_last1MinEffect < 100 then
		drawer:drawTexture("UIData/GameNewImage.tga", g_last1MinPos, 270, 87, 88, 640, 498, WIDETYPE_5)
	else
		drawer:drawTexture("UIData/GameNewImage.tga", g_last1MinPos, 270, 87, 88, 640, 586, WIDETYPE_5)
	end

	-- LAST
	drawer:drawTexture("UIData/GameNewImage.tga", g_last1MinPos+90, 270, 302, 88, 0, 739, WIDETYPE_5)
	
	-- 1��
	drawer:drawTexture("UIData/GameNewImage.tga", g_last1MinPos+400, 270, 208, 93, 252, 827, WIDETYPE_5)
end





----------------------------------------------------

-- Last 10��

----------------------------------------------------
local g_last10Effect	= 0
local g_last10SecTime	= 0
local g_last10Sec		= true
local g_last10SecPos	= 0
local g_last10SecSound	= true

function WndSingleMatchGame_InitLast10SecData()
	g_last10Effect	= 0
	g_last10SecTime	= 0
	g_last10Sec		= true
	g_last10SecPos	= 0
	g_last10SecSound= true
end

function WndSingleMatchGame_RenderLast10Sec(deltaTime)

	if g_last10Sec == false then
		return
	end
	
	if g_last10SecSound then
		PlaySound("sound/siren.wav")
		g_last10SecSound = false
	end
	
	g_last10SecTime = g_last10SecTime + deltaTime
	
	-- 1500������ ����� ����.
	if 0 <= g_last10SecTime and g_last10SecTime <= 1500 then	
		g_last10SecPos = Effect_Elastic_EaseOut(g_last10SecTime, -600, 800, 1500, 0, 0)
	
	-- ���Ŀ� 800�� �Ǹ� �������.
	elseif 1500 < g_last10SecTime and g_last10SecTime <= 2300 then	
		g_last10SecPos = Effect_Back_EaseIn(g_last10SecTime-1500, 190, 1600, 800, 0)
		
	-- 2300�� ������ �����
	else	
		g_last10SecTime = 2400
		g_last10Sec		= false
		g_last10SecPos	= 2000
		EndLast10Sec()
		return
	end	
	
	-- ���̷�
	g_last10Effect = g_last10Effect + deltaTime
	g_last10Effect = g_last10Effect % 200
	if g_last10Effect < 100 then
		drawer:drawTexture("UIData/GameNewImage.tga", g_last10SecPos, 270, 87, 88, 640, 498, WIDETYPE_5)
	else
		drawer:drawTexture("UIData/GameNewImage.tga", g_last10SecPos, 270, 87, 88, 640, 586, WIDETYPE_5)
	end

	-- LAST 10��
	drawer:drawTexture("UIData/GameNewImage.tga", g_last10SecPos+90, 270, 600, 88, 0, 739, WIDETYPE_5)

end





----------------------------------------------------

-- �÷��̾� ������(����Ʈ �÷��̾� ������)

----------------------------------------------------
local IMAGE_POSX = 211
local IMAGE_POSY = 140
function WndSingleMatchGame_UserBattleInfo_bestPlayer(bMe1, bMe2, bMe3, bMe4, bMe5, bMe6, bMe7, bMe8, 
										attack, grab, doubleAtk, teamAtk, evade, superE, combo, itemUse)

	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_DODUMCHE, 12)
		
	-- ���
	drawer:drawTexture("UIData/myinfo2.tga", IMAGE_POSX, IMAGE_POSY, 602, 528, 0, 475)
	
	-- Ÿ��¯
	if bMe1 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	local size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, attack)
	drawer:drawText(attack, IMAGE_POSX+216-size/2, IMAGE_POSY+376)
	
	-- ���¯
	if bMe2 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, grab)
	drawer:drawText(grab, IMAGE_POSX+216-size/2, IMAGE_POSY+406)
	
	-- �������¯
	if bMe3 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, doubleAtk)
	drawer:drawText(doubleAtk, IMAGE_POSX+216-size/2, IMAGE_POSY+436)
	
	-- ������¯
	if bMe4 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, teamAtk)
	drawer:drawText(teamAtk, IMAGE_POSX+216-size/2, IMAGE_POSY+466)
	
	-- �ݰ�¯
	if bMe5 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, evade)
	drawer:drawText(evade, IMAGE_POSX+490-size/2, IMAGE_POSY+376)
	
	-- E�ʻ��¯
	if bMe6 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, superE)
	drawer:drawText(superE, IMAGE_POSX+490-size/2, IMAGE_POSY+406)
	
	-- �޺�¯
	if bMe7 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, combo)
	drawer:drawText(combo, IMAGE_POSX+490-size/2, IMAGE_POSY+436)
	
	-- ������¯
	if bMe8 == 1 then	drawer:setTextColor(255, 200, 80, 255)
	else				drawer:setTextColor(255, 255, 255, 255)
	end
	size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, itemUse)
	drawer:drawText(itemUse, IMAGE_POSX+490-size/2, IMAGE_POSY+466)
end




----------------------------------------------------

-- �÷��̾� ������(���� KO��Ų ���� ������)

----------------------------------------------------
tUserPosY = {["err"]=0, [0]=80, 110, 140, 170, 200, 210, 240, 270}

function WndSingleMatchGame_UserBattleInfo_whoMeDown(index, clubImageName, level, ladder, name, style, koNum, showRevenge, promotion, attribute)
	
	if 0 > index then
		return
	end
	
	if index >= 8 then
		return
	end
	
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_DODUMCHE, 12)
	
	-- Ŭ��
	--drawer:drawTexture("UIData/myinfo2.tga", IMAGE_POSX+105, IMAGE_POSY+tUserPosY[index], 24, 24, 689, 475)
	if clubImageName > 0 then
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..clubImageName..".tga", IMAGE_POSX+105, IMAGE_POSY+tUserPosY[index], 32, 32, 0, 0, 183, 183, 255, 0, 0)
	end
	-- ����
	if index == 0 then
		common_DrawOutlineText1(drawer, "Lv."..level, IMAGE_POSX+149, IMAGE_POSY+tUserPosY[index]+5, 220,0,0,255, 255,255,255,255)
	else	
		drawer:drawText("Lv."..level, IMAGE_POSX+149, IMAGE_POSY+tUserPosY[index]+5)
	end
	
	-- ����
	drawer:drawTexture("UIData/numberUi001.tga", IMAGE_POSX+190, IMAGE_POSY+tUserPosY[index], 47, 21, 113, 600+21*ladder)
	
	-- �̸�	
	if index == 0 then		
		local size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, name)
		common_DrawOutlineText1(drawer, name, IMAGE_POSX+302-size/2, IMAGE_POSY+tUserPosY[index]+5, 220,0,0,255, 255,255,255,255)
	else	
		local size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, name)
		drawer:drawText(name, IMAGE_POSX+302-size/2, IMAGE_POSY+tUserPosY[index]+5)
	end
		
	-- Ŭ����
	drawer:drawTexture("UIData/Skill_up2.tga", IMAGE_POSX+370, IMAGE_POSY+tUserPosY[index]-4,  89, 35,  tAttributeImgTexXTable[style][attribute], tAttributeImgTexYTable[style][attribute], 200, 200, 255, 0,0)
	drawer:drawTexture("UIData/Skill_up2.tga", IMAGE_POSX+370, IMAGE_POSY+tUserPosY[index]-4,  89, 35,  promotionImgTexXTable[style], promotionImgTexYTable[promotion], 200, 200, 255, 0,0)
	
	-- KO���� Ƚ��
	if index == 0 then
		size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, tostring(koNum))
		common_DrawOutlineText1(drawer, tostring(koNum), IMAGE_POSX+512-size/2, IMAGE_POSY+tUserPosY[index]+5, 220,0,0,255, 255,255,255,255)
	else
		size = GetStringSize(g_STRING_FONT_DODUMCHE, 112, tostring(koNum))
		drawer:drawText(tostring(koNum), IMAGE_POSX+512-size/2, IMAGE_POSY+tUserPosY[index]+5)
	end
	
	if showRevenge == 1 then
		if index == 0 then
			-- ������� �̹���
			drawer:drawTexture("UIData/myinfo2.tga", IMAGE_POSX+14, IMAGE_POSY+tUserPosY[index]-3, 86, 27, 602, 475)
		end
	end
end





----------------------------------------------------

-- ����

----------------------------------------------------
function WndSingleMatchGame_RenderHelp(bHelp)
--[[
	-- ���� ��ư
	drawer:drawTexture("UIData/bunhae_002.tga", 274, 5, 60, 27, 0, 82)
	
	-- ���� ������
	if bHelp == 1 then
		drawer:drawTexture("UIData/other001.tga", 4, 132, 565, 306, 0, 0)
	end
--]]
end





----------------------------------------------------

-- ���� �ֿ�� �ִ��� �˷��ֱ�

----------------------------------------------------
function WndSingleMatchGame_NotifyPickupWeapon(weaponIndex, weaponPosX, weaponPosY)
	if weaponIndex >= 0 then
		drawer:drawTexture("UIData/GameNewImage.tga", weaponPosX-40, weaponPosY-80, 84, 62, 474, 883)
	end
end


----------------------------------------------------

-- �Ӽ� ������ �ֿ�� �ִ��� �˷��ֱ�

----------------------------------------------------
function WndSingleMatchGame_NotifyPickupPropertyItem(weaponIndex, weaponPosX, weaponPosY)
	drawer:drawTexture("UIData/GameNewImage.tga", weaponPosX-40, weaponPosY-130, 84, 62, 474, 883)
end



----------------------------------------------------

-- �����ð� ���� �˸���

----------------------------------------------------
mywindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_game_battletimeExtendNotify")
mywindow:setTexture("Enabled", "UIData/GameNewImage2.tga", 841, 136)
mywindow:setTexture("Disabled", "UIData/GameNewImage2.tga", 841, 136)
mywindow:setProperty("FrameEnabled", "False")
mywindow:setProperty("BackgroundEnabled", "False")
mywindow:setWideType(5);
mywindow:setPosition(431, 60)
mywindow:setSize(183, 101)
mywindow:setZOrderingEnabled(false)
mywindow:setEnabled(false)
mywindow:setVisible(false)
mywindow:setAlign(8);
root:addChildWindow(mywindow)

-- �����ð� ���� �������� �ִ� ������ ����
function SetBattletimeExtendAction(bVisible)
	local mywindow = winMgr:getWindow("sj_game_battletimeExtendNotify")
	if mywindow then
		mywindow:setVisible(bVisible)
		if bVisible then
			mywindow:addController("notifyController", "notifyAction", "xscale", "Elastic_EaseOut", 1, 260, 9, true, true, 10)
			mywindow:addController("notifyController", "notifyAction", "yscale", "Elastic_EaseOut", 1, 260, 9, true, true, 10)
			mywindow:activeMotion("notifyAction")
		else
			mywindow:clearControllerEvent("notifyAction")
			mywindow:clearActiveController()
		end
	end	
end

local BT_EXTEND_STATE_IN = 0
local BT_EXTEND_STATE_NOTIFY = 1
local BT_EXTEND_STATE_OUT = 2
local BT_EXTEND_STATE_END = 3
local g_battleTimeExtendState = BT_EXTEND_STATE_END
local g_battleTimeExtendPosX = -1100
local g_battletimeExtendTime = 0

-- �����ð� ������ ����� ���
function SetBattleTimeExtendNotify()
	g_battleTimeExtendState = BT_EXTEND_STATE_IN
	g_battleTimeExtendPosX = -1100
	g_battletimeExtendTime = 0
end

-- ������ �����ð� ���� �������� ����� ��� ��� ĳ���Ϳ��� �˷��ش�.
function ShowBattleTimeExtendNotify(deltaTime, notifyMsg)

	-- ���ʿ��� ���´�.
	if g_battleTimeExtendState == BT_EXTEND_STATE_IN then
		g_battleTimeExtendPosX = g_battleTimeExtendPosX + (deltaTime * 3)
		if g_battleTimeExtendPosX >= 0 then
			g_battleTimeExtendPosX = 0
			g_battleTimeExtendState = BT_EXTEND_STATE_NOTIFY
		end
	
	-- ����� �˷��ش�.
	elseif g_battleTimeExtendState == BT_EXTEND_STATE_NOTIFY then
		g_battletimeExtendTime = g_battletimeExtendTime + deltaTime
		if g_battletimeExtendTime >= 5000 then
			g_battletimeExtendTime = 5000
			g_battleTimeExtendState = BT_EXTEND_STATE_OUT
		end
	
	-- ���������� ����.
	elseif g_battleTimeExtendState == BT_EXTEND_STATE_OUT then
		g_battleTimeExtendPosX = g_battleTimeExtendPosX + (deltaTime * 3)
		if g_battleTimeExtendPosX >= 1100 then
			g_battleTimeExtendPosX = 1100
			g_battleTimeExtendState = BT_EXTEND_STATE_END
		end
		
	-- ��
	elseif g_battleTimeExtendState == BT_EXTEND_STATE_END then
		return
	end
	
	drawer:drawTexture("UIData/GameNewImage2.tga", g_battleTimeExtendPosX, 200, 1024, 112, 0, 803, WIDETYPE_5)
	
	drawer:setTextColor(255, 255, 255, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 22)
	local msgSize = GetStringSize(g_STRING_FONT_GULIMCHE, 22, notifyMsg)
	
	local visibleTime = g_battletimeExtendTime % 200
	if visibleTime < 100 then
		drawer:drawText(notifyMsg, g_battleTimeExtendPosX+512-msgSize/2, 246, WIDETYPE_5)
	end
	
end




----------------------------------------------------

-- �����

----------------------------------------------------
function WndSingleMatchGame_Debug(i, count, hp, name, myIndex)
	
--	drawer:setTextColor(255, 255, 0, 255)
--	drawer:setFont(g_STRING_FONT_GULIMCHE, 14)
--	drawer:drawText(i.." : "..name, 280, 100+(count*18))
	
--	if i == myIndex then
--		drawer:drawText("myIndex : "..myIndex, 430, 100+(count*18))
--	end
--	DrawEachNumber("UIData/dungeonmsg.tga", hp, 1, 380, 100+(count*18), 516, 224, 12, 14, 15)
end



-- ����� 2
function WndSingleMatchGame_Debug2(i, name, atkDamage, grabDamage, superEDamage, doubleAtkCount, teamAtkCount, evadeCount, comboCount, itemUseCount, whoMeDown)
	drawer:setTextColor(255, 255, 0, 255)
	drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
	--[[
	local TEX_X = 190
	local TEX_Y = 660
	local text = "�г���         Ÿ��     ���    E�ʻ��    �������    ������    �ݰ�    �޺�    ���ۻ��    ����KOȽ��"
	drawer:drawText(text, TEX_X, TEX_Y-20)
	
	drawer:drawText(tostring(name), TEX_X, TEX_Y+i*15)
	drawer:drawText(tostring(atkDamage), TEX_X+90, TEX_Y+i*15)
	drawer:drawText(tostring(grabDamage), TEX_X+146, TEX_Y+i*15)
	drawer:drawText(tostring(superEDamage), TEX_X+193, TEX_Y+i*15)
	drawer:drawText(tostring(doubleAtkCount), TEX_X+260, TEX_Y+i*15)
	drawer:drawText(tostring(teamAtkCount), TEX_X+332, TEX_Y+i*15)
	drawer:drawText(tostring(evadeCount), TEX_X+392, TEX_Y+i*15)
	drawer:drawText(tostring(comboCount), TEX_X+440, TEX_Y+i*15)
	drawer:drawText(tostring(itemUseCount), TEX_X+488, TEX_Y+i*15)
	drawer:drawText(tostring(whoMeDown), TEX_X+560, TEX_Y+i*15)
	--]]
end





----------------------------------------------------

-- ���÷��� ������ ���̴� ��ư(ä���̵�)

----------------------------------------------------
--[[
mywindow = winMgr:createWindow("TaharezLook/Button", "sj_WndSingleMatchGame_movetoChannel")
mywindow:setTexture("Normal", "UIData/CreateCharacterNewImage.tga", 849, 0)
mywindow:setTexture("Hover", "UIData/CreateCharacterNewImage.tga", 849, 49)
mywindow:setTexture("Pushed", "UIData/CreateCharacterNewImage.tga", 849, 98)
mywindow:setTexture("PushedOff", "UIData/CreateCharacterNewImage.tga", 849, 0)
mywindow:setPosition(854, 700)
mywindow:setSize(147, 49)
mywindow:setAlwaysOnTop(true)
mywindow:setZOrderingEnabled(false)
mywindow:setVisible(false)
mywindow:subscribeEvent("Clicked", "Goto_WndSelectChannel")
root:addChildWindow(mywindow)




function VisibleButton(isVisible)

	winMgr:getWindow("sj_WndSingleMatchGame_movetoChannel"):setVisible(isVisible)

end
--]]

function WndSingleMatchGame_ShowEmblemKey(LeftEmblem, RightEmblem)
	if LeftEmblem > 0 then 
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..LeftEmblem..".tga", 310 , 12, 32, 32, 0, 0, 350, 350, 255, 0, 0, WIDETYPE_5)
		--DebugStr('LeftEmblem:'..LeftEmblem)
	end
	
	if RightEmblem > 0 then
		drawer:drawTextureSA(GetClubDirectory(GetLanguageType())..RightEmblem..".tga", 670 , 12 , 32, 32, 0, 0, 350, 350, 255, 0, 0, WIDETYPE_5)
		--DebugStr('RightEmblem:'..RightEmblem)
	end
end




----------------------------------------------------

-- ���� ����â

----------------------------------------------------
quitwindow = winMgr:createWindow("TaharezLook/StaticImage", "sj_WndSingleMatchGame_exitBackWindow")
quitwindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 515, 311)
quitwindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 515, 311)
quitwindow:setProperty("FrameEnabled", "False")
quitwindow:setProperty("BackgroundEnabled", "False")
quitwindow:setWideType(5)
quitwindow:setPosition(342, 314)
quitwindow:setSize(340, 141)
quitwindow:setAlpha(0)
quitwindow:setZOrderingEnabled(true)
quitwindow:setVisible(false)
root:addChildWindow(quitwindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_WndSingleMatchGame_exitOkBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 838, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 838, 27)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 838, 54)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 839, 0)
mywindow:setPosition(50, 100)
mywindow:setSize(90, 27)
mywindow:setAlpha(0)
mywindow:subscribeEvent("Clicked", "WndSingleMatchGame_QuitOK")
quitwindow:addChildWindow(mywindow)

mywindow = winMgr:createWindow("TaharezLook/Button", "sj_WndSingleMatchGame_exitCancelBtn")
mywindow:setTexture("Normal", "UIData/LobbyImage_new002.tga", 928, 0)
mywindow:setTexture("Hover", "UIData/LobbyImage_new002.tga", 928, 27)
mywindow:setTexture("Pushed", "UIData/LobbyImage_new002.tga", 928, 54)
mywindow:setTexture("PushedOff", "UIData/LobbyImage_new002.tga", 928, 0)
mywindow:setPosition(200, 100)
mywindow:setSize(90, 27)
mywindow:setAlpha(0)
mywindow:subscribeEvent("Clicked", "WndSingleMatchGame_QuitCancel")
quitwindow:addChildWindow(mywindow)


function WndSingleMatchGame_SetEscape(before30sec)
	if before30sec == 1 then
		quitwindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 684, 677)
		quitwindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 684, 677)
	elseif before30sec == 2 then
		quitwindow:setTexture("Enabled", "UIData/LobbyImage_new002.tga", 684, 536)
		quitwindow:setTexture("Disabled", "UIData/LobbyImage_new002.tga", 684, 536)
	end
end

-- ����� ����Ͽ� ���ķ� ��Ÿ���� ��� ��ư �̹������� ������ ���� �̹����� �׸��� �ʴ´�;;
local g_escapeAlpha = 0
function WndSingleMatchGame_Escape(bFlag, deltaTime)
	
	if bFlag > 0 then
		quitwindow:setVisible(true)
		g_escapeAlpha = g_escapeAlpha + deltaTime
		if g_escapeAlpha >= 255 then
			g_escapeAlpha = 255
		end
	else
		g_escapeAlpha = g_escapeAlpha - deltaTime
		if g_escapeAlpha <= 0 then
			g_escapeAlpha = 0
			quitwindow:setVisible(false)
		end
	end
	
	winMgr:getWindow("sj_WndSingleMatchGame_exitBackWindow"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_WndSingleMatchGame_exitOkBtn"):setAlpha(g_escapeAlpha)
	winMgr:getWindow("sj_WndSingleMatchGame_exitCancelBtn"):setAlpha(g_escapeAlpha)
end


root:subscribeEvent("KeyUp", "OnSingleMatchGameKeyUp");
function OnSingleMatchGameKeyUp(args)	
	local keyEvent = CEGUI.toKeyEventArgs(args);
	if keyEvent.scancode == 40 or keyEvent.scancode == 39 or keyEvent.scancode == 38 or keyEvent.scancode == 37 then 
		if winMgr:getWindow('doChatting'):isActive() == true or winMgr:getWindow('PrivateChatting'):isActive() == true then
			winMgr:getWindow("doChatting"):setText("")
			winMgr:getWindow("doChatting"):setVisible(false)
			Chatting_SetChatEditVisible(false)
			return
		end
	end
end


-- ä��â  �ʱ�  ����
function SetChatInitSingleMatchGame()
	Chatting_SetChatWideType(2)
	Chatting_SetChatPosition(3, 527)
	Chatting_SetChatEditEvent(3)
	Chatting_SetChatTabDefault()
end



--winMgr:getWindow("sj_SingleMatchGame_inputChatWindow"):setVisible(false)