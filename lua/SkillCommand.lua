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
local SC_String_1		= PreCreateString_1260	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_31)	-- �뽬��						47
local SC_String_2		= PreCreateString_1261	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_32)	-- ���̺���
local SC_String_3		= PreCreateString_1262	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_33)	-- ������
local SC_String_4		= PreCreateString_1263	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_34)	-- ���帰���
local SC_String_5		= PreCreateString_1264	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_35)	-- ��������
local SC_String_6		= PreCreateString_1906	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_39)	-- ����������
local SC_String_7		= PreCreateString_1265	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_36)	-- 2�� �����̼�
local SC_String_9		= PreCreateString_1267	--GetSStringInfo(LAN_LUA_WND_MY_SKILL_38)	-- ���ݿ� ����


--------------------------------------------------------------------
-- Ŀ�ǵ忡���� ������ �������ش�.
--------------------------------------------------------------------
local SC_Attack		   = 0	-- Ÿ��
local SC_Grab		   = 1	-- ���
local SC_Special	   = 2	-- �ʻ��
local SC_TeamDouble	   = 3	-- ��,�������
local SC_Counterattack = 4	-- �ݰݱ�

-- Ÿ��
local SC_Nomal_Attack	= 0	-- �Ϲ�Ÿ��
local SC_High_Attack	= 1	-- ���Ÿ��
local SC_Middle_Attack	= 2	-- �ߴ�Ÿ��
local SC_Low_Attack		= 3	-- �ϴ�Ÿ��
local SC_Dash_Attack	= 4	-- �뽬Ÿ��
local SC_Sliding_Attack	= 5	-- �����̵�
local SC_Diving_Attack	= 6	-- ���̺�Ÿ��

-- ���
local SC_High_Grab		= 0 -- ������
local SC_Middle_Grab	= 1	-- �ߴ����
local SC_Low_Grab		= 2 -- �ϴ����
local SC_Dash_Grab		= 3	-- �뽬���
local SC_Diving_Grab	= 4	-- ���̺����
local SC_LieDown_Grab	= 5	-- �������
local SC_LieDown_Grab2	= 6	-- ��������

-- �ʻ��
local SC_Normal_Special = 0 -- �������� q�ʻ��
local SC_Combo_Special	= 1	-- w�ʻ��
local SC_Down_Special	= 2	-- ���������� q�ʻ��
local SC_Super_Special	= 3	-- e�ʻ��

--��, �������
local SC_Double_Attack	= 0	-- �������
local SC_Team_Attack	= 1	-- ������

-- �ݰݱ�
local SC_HighMid_CA		= 0	-- ���ߴܹݰݱ�
local SC_Low_CA			= 1	-- �ϴܹݰݱ�

local SC_tTable = {['err']=0, [0]={['err']=0, }, {['err']=0, }, {['err']=0, }, {['err']=0, }, {['err']=0, }}--[0] = 0,0,0,}
SC_tTable[SC_Attack]		= {['err']=0, }
SC_tTable[SC_Grab]			= {['err']=0, }
SC_tTable[SC_Special]		= {['err']=0, }
SC_tTable[SC_TeamDouble]	= {['err']=0, }
SC_tTable[SC_Counterattack] = {['err']=0, }

										--	0  1  2  3  4  5  6  7  8  9  
local SC_tPropIndexTable = {['err']=0, [0]= 0, 0, 1, 1, 2, 2, 3, 3,-1, 0,		-- 0
											0,-1, 1, 1,-1, 2, 2,-1,-1,-1,	-- 1
										   -1,-1,-1,-1,-1,-1, 5, 5, 5, 5,	-- 2
										    6, 6, 6, 6, 4, 3, 5, 4,-1, 0,	-- 3
										   -1, 0, 1, 1,-1,-1, 0, 2, 1, 3,	-- 4
										   -1,-1, 0, 1}						-- 5
										   


function ShowSkillCommand(drawer, attach, propindex, scalex, scaley, posx, posy, term, textCut)
	if #SC_tPropIndexTable < propindex then
		return
	end
	if attach == SC_Attack then			-- Ÿ��
		if SC_tPropIndexTable[propindex] == SC_Nomal_Attack then
			drawer:drawTextureSA("UIData/tutorial003.tga", posx,		posy,	29, 29,   791, 719,   scalex, scaley,   255, 0, 0);
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term,	posy,	29, 29,   791, 719,   scalex, scaley,   255, 0, 0);
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term*2, posy,   29, 29,   791, 719,   scalex, scaley,   255, 0, 0);
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term*3, posy,   29, 29,   911, 749,   scalex, scaley,   255, 0, 0);
		elseif SC_tPropIndexTable[propindex] == SC_High_Attack then
			drawer:drawTextureSA("UIData/tutorial003.tga", posx,		posy,   29, 29,   821, 719,   scalex, scaley,   255, 0, 0);	--��
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term,	posy,   29, 29,   731, 749,   scalex, scaley,   255, 0, 0);	--+
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term*2, posy,   29, 29,   791, 719,   scalex, scaley,   255, 0, 0);	--d
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term*3, posy,   29, 29,   911, 749,   scalex, scaley,   255, 0, 0);	--...
		elseif SC_tPropIndexTable[propindex] == SC_Middle_Attack then
			drawer:drawTextureSA("UIData/tutorial003.tga", posx,		posy,   29, 29,   791, 749,   scalex, scaley,   255, 0, 0);	--��
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term,	posy,   29, 29,   761, 749,   scalex, scaley,   255, 0, 0);	--��
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term*2, posy,   29, 29,   851, 749,   scalex, scaley,   255, 0, 0);	--��

			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term*3, posy,   29, 29,   731, 749,   scalex, scaley,   255, 0, 0);	--+
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term*4, posy,   29, 29,   791, 719,   scalex, scaley,   255, 0, 0);	--d
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term*5, posy,   29, 29,   911, 749,   scalex, scaley,   255, 0, 0);	--...
			
		elseif SC_tPropIndexTable[propindex] == SC_Low_Attack then
			drawer:drawTextureSA("UIData/tutorial003.tga", posx,		posy,   29, 29,   821, 749,   scalex, scaley,   255, 0, 0);	--��
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term,   posy,   29, 29,   731, 749,   scalex, scaley,   255, 0, 0);	--+
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term*2, posy,   29, 29,   791, 719,   scalex, scaley,   255, 0, 0);	--d
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term*3, posy,   29, 29,   911, 749,   scalex, scaley,   255, 0, 0);	--...
		elseif SC_tPropIndexTable[propindex] == SC_Dash_Attack then
			drawer:setTextColor(255,255,255,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..SC_String_1..")")
			drawer:drawText("("..SC_String_1..")", posx, posy+6)
			drawer:drawTextureSA("UIData/tutorial003.tga", posx + Size + 5, posy,   29, 29,   791, 719,   scalex, scaley,   255, 0, 0);
		elseif SC_tPropIndexTable[propindex] == SC_Sliding_Attack then
			drawer:setTextColor(255,255,255,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..SC_String_2..")")
			drawer:drawText("("..SC_String_2..")", posx, posy+6)
			drawer:drawTextureSA("UIData/tutorial003.tga", posx + Size + 5, posy,   29, 29,   791, 719,   scalex, scaley,   255, 0, 0);
		
		elseif SC_tPropIndexTable[propindex] == SC_Diving_Attack then
			drawer:setTextColor(255,255,255,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..SC_String_1..")")
			drawer:drawText("("..SC_String_1..")", posx, posy+6)
			drawer:drawTextureSA("UIData/tutorial003.tga", posx + Size + 5, posy,   29, 29,   761, 719,   scalex, scaley,   255, 0, 0);
		end
	elseif attach == SC_Grab then		-- ���
		if SC_tPropIndexTable[propindex] == SC_High_Grab then
			drawer:drawTextureSA("UIData/tutorial003.tga", posx,		posy,   29, 29,   791, 749,   scalex, scaley,   255, 0, 0);	--��
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term,   posy,   29, 29,   731, 749,   scalex, scaley,   255, 0, 0);	--+
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term*2, posy,   29, 29,   761, 719,   scalex, scaley,   255, 0, 0);	--s
		elseif SC_tPropIndexTable[propindex] == SC_Middle_Grab then
			drawer:drawTextureSA("UIData/tutorial003.tga", posx,		posy,   29, 29,   851, 749,   scalex, scaley,   255, 0, 0);	--��
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term,   posy,   29, 29,   731, 749,   scalex, scaley,   255, 0, 0);	--+
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term*2, posy,   29, 29,   761, 719,   scalex, scaley,   255, 0, 0);	--s
		elseif SC_tPropIndexTable[propindex] == SC_Low_Grab then
			drawer:drawTextureSA("UIData/tutorial003.tga", posx,		posy,   29, 29,   821, 749,   scalex, scaley,   255, 0, 0);	--��
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term,   posy,   29, 29,   731, 749,   scalex, scaley,   255, 0, 0);	--+
			drawer:drawTextureSA("UIData/tutorial003.tga", posx+term*2, posy,   29, 29,   761, 719,   scalex, scaley,   255, 0, 0);	--s
		elseif SC_tPropIndexTable[propindex] == SC_Dash_Grab then
			drawer:setTextColor(255,255,255,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..SC_String_1..")")
			drawer:drawText("("..SC_String_1..")", posx, posy+6)
			drawer:drawTextureSA("UIData/tutorial003.tga", posx + Size + 5,posy,   29, 29,   761, 719,   scalex, scaley,   255, 0, 0);
		elseif SC_tPropIndexTable[propindex] == SC_Diving_Grab then
			drawer:setTextColor(255,255,255,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..SC_String_2..")")
			drawer:drawText("("..SC_String_2..")", posx, posy+6)
			drawer:drawTextureSA("UIData/tutorial003.tga", posx + Size + 5,posy,   29, 29,   761, 719,   scalex, scaley,   255, 0, 0);
		elseif SC_tPropIndexTable[propindex] == SC_LieDown_Grab then
			drawer:setTextColor(255,255,255,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..SC_String_3..")")
			drawer:drawText("("..SC_String_3..")", posx, posy+6)
			drawer:drawTextureSA("UIData/tutorial003.tga", posx + Size + 5,posy,   29, 29,   761, 719,   scalex, scaley,   255, 0, 0);
		elseif SC_tPropIndexTable[propindex] == SC_LieDown_Grab2 then
			drawer:setTextColor(255,255,255,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..SC_String_4..")")
			drawer:drawText("("..SC_String_4..")", posx, posy+6)
			drawer:drawTextureSA("UIData/tutorial003.tga", posx + Size + 5,posy,   29, 29,   761, 719,   scalex, scaley,   255, 0, 0);
		end
	elseif attach == SC_Special then	-- �ʻ��
		if SC_tPropIndexTable[propindex] == SC_Normal_Special then
			drawer:setTextColor(255,255,255,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..SC_String_5..")")
			drawer:drawText("("..SC_String_5..")", posx, posy+6)
			drawer:drawTextureSA("UIData/tutorial003.tga", posx + Size + 5,posy,   29, 29,   851, 719,   scalex, scaley,   255, 0, 0);
		elseif SC_tPropIndexTable[propindex] == SC_Combo_Special then
			drawer:drawTextureSA("UIData/tutorial003.tga", posx,	posy,   29, 29,   881, 719,   scalex, scaley,   255, 0, 0);
		elseif SC_tPropIndexTable[propindex] == SC_Down_Special then
			drawer:setTextColor(255,255,255,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..SC_String_6..")")
			drawer:drawText("("..SC_String_6..")", posx, posy+6)
			drawer:drawTextureSA("UIData/tutorial003.tga", posx + Size + 5,posy,   29, 29,   851, 719,   scalex, scaley,   255, 0, 0);
		elseif SC_tPropIndexTable[propindex] == SC_Super_Special then
			drawer:drawTextureSA("UIData/tutorial003.tga", posx,	posy,   29, 29,   911, 719,   scalex, scaley,   255, 0, 0);
		end
		
	elseif attach == SC_TeamDouble then	-- ��, �������
		if SC_tPropIndexTable[propindex] == SC_Double_Attack then
			drawer:setTextColor(255,255,255,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..SC_String_7..")")
			drawer:drawText("("..SC_String_7..")",posx, posy+6)
			drawer:drawTextureSA("UIData/tutorial003.tga", posx + Size + 5, posy,   29, 29,   761, 719,   scalex, scaley,   255, 0, 0);	--s
		elseif SC_tPropIndexTable[propindex] == SC_Team_Attack then
			drawer:setTextColor(255,255,255,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local String = AdjustString(g_STRING_FONT_GULIM, 12, PreCreateString_2706, textCut)					-- ������ ����
			drawer:drawText(String, posx, posy)
		end
	elseif attach == SC_Counterattack then	-- �ݰ�
		if SC_tPropIndexTable[propindex] == SC_HighMid_CA or SC_tPropIndexTable[propindex] == SC_Low_CA then
			drawer:setTextColor(255,255,255,255)
			drawer:setFont(g_STRING_FONT_GULIMCHE, 12)
			local Size = GetStringSize(g_STRING_FONT_GULIMCHE, 12, "("..SC_String_9..")")
			drawer:drawText("("..SC_String_9..")", posx, posy+6)
			drawer:drawTextureSA("UIData/tutorial003.tga",posx + Size + 5, posy,   29, 29,   731, 719,   scalex, scaley,   255, 0, 0);
				
		end
	end
end
										   
											