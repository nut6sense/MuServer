-- Util function �迭 ������ �̸��� �� true, false�� ������ �ش� �����츦 �������ų� ������� �� �� �ִ�.
function ShowWindows(winNames, arg)
	for i=1, #winNames do
		winMgr:getWindow(winNames[i]):setProperty('Visible', arg);
	end
end
