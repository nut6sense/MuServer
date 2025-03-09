-- Util function 배열 윈도우 이름을 과 true, false를 넣으면 해당 윈도우를 보여지거나 사라지게 할 수 있다.
function ShowWindows(winNames, arg)
	for i=1, #winNames do
		winMgr:getWindow(winNames[i]):setProperty('Visible', arg);
	end
end
