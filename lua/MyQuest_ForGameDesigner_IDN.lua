------------------------------------------------------------------------

-- ����Ʈ�� ���� ��ġ�� �����Ѵ�

------------------------------------------------------------------------
local QUEST_TYPE_OCCUR		  = 1
local QUEST_TYPE_OCCUR_ACCEPT = 2
local QUEST_TYPE_COMPLETE	  = 3

------------------------------------------------------------------------

local MAX_QUESTNUMBER = 58				-- ����Ʈ�� ������ �����Ѵ�.

------------------------------------------------------------------------

tQuestTargetPos = {['err']=0, }
for i=1, MAX_QUESTNUMBER do
	tQuestTargetPos[i] = {['err']=0, }
end

-------------------------- ����Ʈ ������ġ ���� --------------------------


tQuestTargetPos[1][QUEST_TYPE_OCCUR]		= {['err']=0, 0, 0, 0}	-- 
tQuestTargetPos[1][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 0, 0, 0}	-- 
tQuestTargetPos[1][QUEST_TYPE_COMPLETE]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[2][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[2][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[2][QUEST_TYPE_COMPLETE]		= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[3][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[3][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[3][QUEST_TYPE_COMPLETE]		= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[4][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}		-- �����󸾽�
tQuestTargetPos[4][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 188, 4349, 0}		-- �����󸾽�
tQuestTargetPos[4][QUEST_TYPE_COMPLETE]		= {['err']=0, 188, 4349, 0}		-- �����󸾽�

tQuestTargetPos[5][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}		-- �����󸾽�
tQuestTargetPos[5][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -113, 4868, 0}	-- ���������̵�
tQuestTargetPos[5][QUEST_TYPE_COMPLETE]		= {['err']=0, 188, 4349, 0}		-- �����󸾽�

tQuestTargetPos[6][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[6][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[6][QUEST_TYPE_COMPLETE]		= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[7][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- ��Ű
tQuestTargetPos[7][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -113, 4868, 0}	-- ���������̵�
tQuestTargetPos[7][QUEST_TYPE_COMPLETE]		= {['err']=0, 777, 3604, 0}	-- ��Ű

tQuestTargetPos[8][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[8][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[8][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[9][QUEST_TYPE_OCCUR]		= {['err']=0, 1373, -2200, 0}	-- ������Ʈ
tQuestTargetPos[9][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 1373, -2200, 0}	-- ������Ʈ
tQuestTargetPos[9][QUEST_TYPE_COMPLETE]		= {['err']=0, 1373, -2200, 0}	-- ������Ʈ

tQuestTargetPos[10][QUEST_TYPE_OCCUR]		= {['err']=0, 1373, -2200, 0}	-- ������Ʈ
tQuestTargetPos[10][QUEST_TYPE_COMPLETE]		= {['err']=0, 1373, -2200, 0}	-- ������Ʈ

tQuestTargetPos[11][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[11][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2937, 2538, 0}        -- Ʈ���̴� ����
tQuestTargetPos[11][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[12][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[12][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2206, 2753, 0}        -- ���� ��Ż
tQuestTargetPos[12][QUEST_TYPE_COMPLETE]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[13][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[13][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2206, 2753, 0}        -- ���� ��Ż
tQuestTargetPos[13][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[14][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[14][QUEST_TYPE_OCCUR_ACCEPT] = {['err']=0, 2206, 2753, 0}        -- ���� ��Ż
tQuestTargetPos[14][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

--[[
tQuestTargetPos[13][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[13][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- ȣ�� �����̵�
tQuestTargetPos[13][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[14][QUEST_TYPE_OCCUR]		= {['err']=0, -2013, -810, 0}	-- ��ź(��ũ�� �̺�Ʈ)
tQuestTargetPos[14][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}    -- ���� ��Ż
tQuestTargetPos[14][QUEST_TYPE_COMPLETE]	= {['err']=0, -2013, -810, 0}	-- ��ź(��ũ�� �̺�Ʈ)

tQuestTargetPos[15][QUEST_TYPE_OCCUR]		= {['err']=0, -2013, -810, 0}	-- ��ź(��ũ�� �̺�Ʈ)
tQuestTargetPos[15][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -2013, -810, 0}	-- ��ź(��ũ�� �̺�Ʈ)
tQuestTargetPos[15][QUEST_TYPE_COMPLETE]	= {['err']=0, -2013, -810, 0}	-- ��ź(��ũ�� �̺�Ʈ)

tQuestTargetPos[16][QUEST_TYPE_OCCUR]		= {['err']=0, -2013, -810, 0}	-- ��ź(��ũ�� �̺�Ʈ)
tQuestTargetPos[16][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -2013, -810, 0}	-- ��ź(��ũ�� �̺�Ʈ)
tQuestTargetPos[16][QUEST_TYPE_COMPLETE]	= {['err']=0, -2013, -810, 0}	-- ��ź(��ũ�� �̺�Ʈ)
--]]
--[[
tQuestTargetPos[14][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[14][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}    -- ���� ��Ż     ��ź�� �̺�Ʈ
tQuestTargetPos[14][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
--]]
--[[
tQuestTargetPos[14][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[14][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[14][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
--]]
tQuestTargetPos[15][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[15][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -113, 4868, 0}	-- ���������̵�
tQuestTargetPos[15][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[16][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[16][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[16][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[17][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[17][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[17][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[18][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[18][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- ȣ�� �����̵�
tQuestTargetPos[18][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[19][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- ��Ű
tQuestTargetPos[19][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[19][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- ��Ű

tQuestTargetPos[20][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[20][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[20][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[21][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[21][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -113, 4868, 0}	-- ���������̵�
tQuestTargetPos[21][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[22][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[22][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[22][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[23][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[23][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[23][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[24][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[24][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- �ҷ� �����̵�
tQuestTargetPos[24][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[25][QUEST_TYPE_OCCUR]		= {['err']=0, 777, 3604, 0}	-- ��Ű
tQuestTargetPos[25][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[25][QUEST_TYPE_COMPLETE]	= {['err']=0, 777, 3604, 0}	-- ��Ű

tQuestTargetPos[26][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[26][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[26][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[27][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[27][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- ȣ�� �����̵�
tQuestTargetPos[27][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[28][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[28][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[28][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[29][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[29][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[29][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[30][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[30][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- �ҷ� �����̵�
tQuestTargetPos[30][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[31][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[31][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[31][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[32][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[32][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[32][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[33][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[33][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- ȣ�� �����̵�
tQuestTargetPos[33][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[34][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[34][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[34][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[35][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[35][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[35][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[36][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[36][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[37][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[37][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[37][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[38][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[38][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[38][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[39][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[39][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- �ҷ� �����̵�
tQuestTargetPos[39][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[40][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[40][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[40][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[41][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[41][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[41][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[42][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[42][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -1980, 3231, 0}	-- ȣ�� �����̵�
tQuestTargetPos[42][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[43][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[43][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[43][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[44][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[44][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[44][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[45][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[45][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- �ҷ� �����̵�
tQuestTargetPos[45][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[46][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[46][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[46][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[47][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[47][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[47][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[48][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[48][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- �ҷ� �����̵�
tQuestTargetPos[48][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[49][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[49][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[49][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[50][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[50][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[50][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[51][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[51][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 563, -1103, 0}	-- �ҷ� �����̵�
tQuestTargetPos[51][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[52][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[52][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[52][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[53][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[53][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[53][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[54][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[54][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[55][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[55][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[55][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ��������

tQuestTargetPos[56][QUEST_TYPE_OCCUR]		= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��
tQuestTargetPos[56][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, 2206, 2753, 0}	-- ���� ��Ż
tQuestTargetPos[56][QUEST_TYPE_COMPLETE]	= {['err']=0, 1195, 3357, 0}	-- ����Ŀ��

tQuestTargetPos[57][QUEST_TYPE_OCCUR]		= {['err']=0, 188, 4349, 0}	-- �����󸾽�
tQuestTargetPos[57][QUEST_TYPE_COMPLETE]	= {['err']=0, 188, 4349, 0}	-- �����󸾽�

tQuestTargetPos[58][QUEST_TYPE_OCCUR]		= {['err']=0, -2819, 2146, 0}	-- ��������
tQuestTargetPos[58][QUEST_TYPE_OCCUR_ACCEPT]	= {['err']=0, -3634, 1960, 0}	-- �����
tQuestTargetPos[58][QUEST_TYPE_COMPLETE]	= {['err']=0, -2819, 2146, 0}	-- ��������


--------------------------- ����Ʈ ������ġ �� ---------------------------


------------------------------------------------------------------------
-- ����Ʈ ������ �����Ѵ�.
------------------------------------------------------------------------

tQuestCondition = {['err']=0, }

for i=1, MAX_QUESTNUMBER do
	tQuestCondition[i] = {['err']=0, }
end


-------------------------- ����Ʈ ���� ���� --------------------------

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

--------------------------- ����Ʈ ���� �� ---------------------------



tZone6NpcVillageIndex = {["err"]=0, 2,3,4,5,9,10,11,21,23,25}	-- 6���� npc �ε��� (�� ���忡 ���ο� NPC �߰���, �ش� NPC �ε��� ��ȣ �߰�)
tZone3NpcVillageIndex = {["err"]=0, 12,15,16}					-- 3���� npc �ε��� (�� ���忡 ���ο� NPC �߰���, �ش� NPC �ε��� ��ȣ �߰�)

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
