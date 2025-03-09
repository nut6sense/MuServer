------------------------------------------------------------------------

-- Äù½ºÆ®ÀÇ ÁøÇà À§Ä¡¸¦ ¼¼ÆÃÇÑ´Ù

------------------------------------------------------------------------
local QUEST_TYPE_OCCUR		  = 1
local QUEST_TYPE_OCCUR_ACCEPT = 2
local QUEST_TYPE_COMPLETE	  = 3

------------------------------------------------------------------------

local MAX_QUESTNUMBER = 58				-- Äù½ºÆ®ÀÇ °¹¼ö¸¦ ¼¼ÆÃÇÑ´Ù.

------------------------------------------------------------------------

tQuestTargetPos = {['err']=0, }
for i=1, MAX_QUESTNUMBER do
	tQuestTargetPos[i] = {['err']=0, }
end

-------------------------- Äù½ºÆ® ÁøÇàÀ§Ä¡ ½ÃÀÛ --------------------------


tQuestTargetPos[1][QUEST_TYPE_OCCUR]		= {['err']=0, 0, 0, 0}	-- 
tQuestTargetPos[1][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 0, 0, 0}	-- 
tQuestTargetPos[1][QUEST_TYPE_COMPLETE]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[2][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[2][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[2][QUEST_TYPE_COMPLETE]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[3][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[3][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[3][QUEST_TYPE_COMPLETE]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[4][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}		-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[4][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 188, 4349, 0}		-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[4][QUEST_TYPE_COMPLETE]		= {['err']=0, 188, 4349, 0}		-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[5][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}		-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[5][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -113, 4868, 0}	-- °ø¿ø¾ÆÄÉÀÌµå
tQuestTargetPos[5][QUEST_TYPE_COMPLETE]		= {['err']=0, 188, 4349, 0}		-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[6][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[6][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[6][QUEST_TYPE_COMPLETE]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[7][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- À¯Å°
tQuestTargetPos[7][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -113, 4868, 0}	-- °ø¿ø¾ÆÄÉÀÌµå
tQuestTargetPos[7][QUEST_TYPE_COMPLETE]		= {['err']=0, 777, 3604, 0}	-- À¯Å°

tQuestTargetPos[8][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[8][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[8][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[9][QUEST_TYPE_OCCUR]		= {['err']=0, 1373, -2200, 0}	-- ·£µðÇÏÆ®
tQuestTargetPos[9][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 1373, -2200, 0}	-- ·£µðÇÏÆ®
tQuestTargetPos[9][QUEST_TYPE_COMPLETE]		= {['err']=0, 1373, -2200, 0}	-- ·£µðÇÏÆ®

tQuestTargetPos[10][QUEST_TYPE_OCCUR]		= {['err']=0, 1373, -2200, 0}	-- ·£µðÇÏÆ®
tQuestTargetPos[10][QUEST_TYPE_COMPLETE]		= {['err']=0, 1373, -2200, 0}	-- ·£µðÇÏÆ®

tQuestTargetPos[11][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[11][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2937, 2538, 0}        -- Æ®·¹ÀÌ´× ¼¾ÅÍ
tQuestTargetPos[11][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[12][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[12][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2206, 2753, 0}        -- ´ëÀü Æ÷Å»
tQuestTargetPos[12][QUEST_TYPE_COMPLETE]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[13][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[13][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2206, 2753, 0}        -- ´ëÀü Æ÷Å»
tQuestTargetPos[13][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[14][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[14][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2206, 2753, 0}        -- ´ëÀü Æ÷Å»
tQuestTargetPos[14][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

--[[
tQuestTargetPos[13][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[13][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- È£ÅÚ ¾ÆÄÉÀÌµå
tQuestTargetPos[13][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[14][QUEST_TYPE_OCCUR]		= {['err']=0, -2013, -810, 0}	-- »çÅº(¼ÛÅ©¶õ ÀÌº¥Æ®)
tQuestTargetPos[14][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}    -- ´ëÀü Æ÷Å»
tQuestTargetPos[14][QUEST_TYPE_COMPLETE]	= {['err']=0, -2013, -810, 0}	-- »çÅº(¼ÛÅ©¶õ ÀÌº¥Æ®)

tQuestTargetPos[15][QUEST_TYPE_OCCUR]		= {['err']=0, -2013, -810, 0}	-- »çÅº(¼ÛÅ©¶õ ÀÌº¥Æ®)
tQuestTargetPos[15][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -2013, -810, 0}	-- »çÅº(¼ÛÅ©¶õ ÀÌº¥Æ®)
tQuestTargetPos[15][QUEST_TYPE_COMPLETE]	= {['err']=0, -2013, -810, 0}	-- »çÅº(¼ÛÅ©¶õ ÀÌº¥Æ®)

tQuestTargetPos[16][QUEST_TYPE_OCCUR]		= {['err']=0, -2013, -810, 0}	-- »çÅº(¼ÛÅ©¶õ ÀÌº¥Æ®)
tQuestTargetPos[16][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -2013, -810, 0}	-- »çÅº(¼ÛÅ©¶õ ÀÌº¥Æ®)
tQuestTargetPos[16][QUEST_TYPE_COMPLETE]	= {['err']=0, -2013, -810, 0}	-- »çÅº(¼ÛÅ©¶õ ÀÌº¥Æ®)
--]]
--[[
tQuestTargetPos[14][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[14][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}    -- ´ëÀü Æ÷Å»     ÆøÅºÀü ÀÌº¥Æ®
tQuestTargetPos[14][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
--]]
--[[
tQuestTargetPos[14][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[14][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[14][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
--]]
tQuestTargetPos[15][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[15][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -113, 4868, 0}	-- °ø¿ø¾ÆÄÉÀÌµå
tQuestTargetPos[15][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[16][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[16][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[16][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[17][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[17][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[17][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[18][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[18][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- È£ÅÚ ¾ÆÄÉÀÌµå
tQuestTargetPos[18][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[19][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- À¯Å°
tQuestTargetPos[19][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[19][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- À¯Å°

tQuestTargetPos[20][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[20][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[20][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[21][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[21][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -113, 4868, 0}	-- °ø¿ø¾ÆÄÉÀÌµå
tQuestTargetPos[21][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[22][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[22][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[22][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[23][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[23][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[23][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[24][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[24][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- ÇÒ·½ ¾ÆÄÉÀÌµå
tQuestTargetPos[24][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[25][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- À¯Å°
tQuestTargetPos[25][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[25][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- À¯Å°

tQuestTargetPos[26][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[26][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[26][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[27][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[27][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- È£ÅÚ ¾ÆÄÉÀÌµå
tQuestTargetPos[27][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[28][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[28][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[28][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[29][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[29][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[29][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[30][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[30][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- ÇÒ·½ ¾ÆÄÉÀÌµå
tQuestTargetPos[30][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[31][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[31][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[31][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[32][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[32][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[32][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[33][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[33][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- È£ÅÚ ¾ÆÄÉÀÌµå
tQuestTargetPos[33][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[34][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[34][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[34][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[35][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[35][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[35][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[36][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[36][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[37][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[37][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[37][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[38][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[38][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[38][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[39][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[39][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- ÇÒ·½ ¾ÆÄÉÀÌµå
tQuestTargetPos[39][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[40][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[40][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[40][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[41][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[41][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[41][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[42][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[42][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- È£ÅÚ ¾ÆÄÉÀÌµå
tQuestTargetPos[42][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[43][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[43][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[43][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[44][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[44][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[44][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[45][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[45][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- ÇÒ·½ ¾ÆÄÉÀÌµå
tQuestTargetPos[45][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[46][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[46][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[46][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[47][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[47][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[47][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[48][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[48][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- ÇÒ·½ ¾ÆÄÉÀÌµå
tQuestTargetPos[48][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[49][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[49][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[49][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[50][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[50][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[50][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[51][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[51][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- ÇÒ·½ ¾ÆÄÉÀÌµå
tQuestTargetPos[51][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[52][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[52][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[52][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[53][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[53][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[53][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[54][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[54][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[55][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[55][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[55][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼

tQuestTargetPos[56][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç
tQuestTargetPos[56][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ´ëÀü Æ÷Å»
tQuestTargetPos[56][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ½ºÇÇÄ¿¸Ç

tQuestTargetPos[57][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼
tQuestTargetPos[57][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- ¾ÈÁ©¶ó¸¾½¼

tQuestTargetPos[58][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼
tQuestTargetPos[58][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- »ç³ÉÅÍ
tQuestTargetPos[58][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ¿¥¸¶¸¾½¼


--------------------------- Äù½ºÆ® ÁøÇàÀ§Ä¡ ³¡ ---------------------------


------------------------------------------------------------------------
-- Äù½ºÆ® Á¶°ÇÀ» ¼¼ÆÃÇÑ´Ù.
------------------------------------------------------------------------

tQuestCondition = {['err']=0, }

for i=1, MAX_QUESTNUMBER do
	tQuestCondition[i] = {['err']=0, }
end


-------------------------- Äù½ºÆ® Á¶°Ç ½ÃÀÛ --------------------------

tQuestCondition[1] = {['err']=0, [0]= 2787	, 0	, 0	, 0	, 0	}
tQuestCondition[2] = {['err']=0, [0]= 2788	, 0	, 0	, 0	, 0	}
tQuestCondition[3] = {['err']=0, [0]= 2789	, 0	, 0	, 0	, 0	}
tQuestCondition[4] = {['err']=0, [0]= 2834	, 0	, 0	, 0	, 0	}
tQuestCondition[5] = {['err']=0, [0]= 2835	, 0	, 0	, 0	, 0	}
tQuestCondition[6] = {['err']=0, [0]= 2852	, 0	, 0	, 0	, 0	}
tQuestCondition[7] = {['err']=0, [0]= 2859	, 0	, 0	, 0	, 0	}
tQuestCondition[8] = {['err']=0, [0]= 2868	, 0	, 0	, 0	, 0	}
tQuestCondition[9] = {['err']=0, [0]= 2836	, 0	, 0	, 0	, 0	}
tQuestCondition[10] = {['err']=0, [0]= 3366	, 0	, 0	, 0	, 0	}
tQuestCondition[11] = {['err']=0, [0]= 3373	, 0	, 0	, 0	, 0	}
tQuestCondition[12] = {['err']=0, [0]= 2833	, 0	, 0	, 0	, 0	}
tQuestCondition[13] = {['err']=0, [0]= 2888	, 0	, 0	, 0	, 0	}
tQuestCondition[14] = {['err']=0, [0]= 2875	, 0	, 0	, 0	, 0	}
tQuestCondition[15] = {['err']=0, [0]= 4368	, 0	, 0	, 0	, 0	}
tQuestCondition[16] = {['err']=0, [0]= 4372	, 0	, 0	, 0	, 0	}
tQuestCondition[17] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[18] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[19] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[20] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[21] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[22] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[23] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[24] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[25] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[26] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[27] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[28] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[29] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[30] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[31] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[32] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[33] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[34] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[35] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[36] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[37] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[38] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[39] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[40] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[41] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[42] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[43] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[44] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[45] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[46] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[47] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[48] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[49] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[50] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[51] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[52] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[53] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[54] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[55] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[56] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[57] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}
tQuestCondition[58] = {['err']=0, [0]= 0	, 0	, 0	, 0	, 0	}

--------------------------- Äù½ºÆ® Á¶°Ç ³¡ ---------------------------



tZone6NpcVillageIndex = {["err"]=0, 2,3,4,5,9,10,11,21,23,25}	-- 6±¸¿ª npc ÀÎµ¦½º (°¢ ±¤Àå¿¡ »õ·Î¿î NPC Ãß°¡½Ã, ÇØ´ç NPC ÀÎµ¦½º ¹øÈ£ Ãß°¡)
tZone3NpcVillageIndex = {["err"]=0, 12,15,16}					-- 3±¸¿ª npc ÀÎµ¦½º (°¢ ±¤Àå¿¡ »õ·Î¿î NPC Ãß°¡½Ã, ÇØ´ç NPC ÀÎµ¦½º ¹øÈ£ Ãß°¡)

local ZONE6 = 1
local ZONE3 = 2
function RegistNpcVillageIndex()
	for i=1, #tZone6NpcVillageIndex do
		RegistNpcVillageIndexMap(ZONE6, tZone6NpcVillageIndex[i])
	end
	
	for i=1, #tZone3NpcVillageIndex do
		RegistNpcVillageIndexMap(ZONE3, tZone3NpcVillageIndex[i])
	end
end
