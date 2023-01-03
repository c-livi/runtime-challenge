_c = os.clock()
function _parentpath(path)
	pattern1 = "^(.+)//"
 	pattern2 = "^(.+)\\"
    	if (string.match(path, pattern1) == nil) then
        	return string.match(path, pattern2)
    	else
        	return string.match(path, pattern1)
    	end
end
function _main()
	local hashset = {}
	local _dict = _parentpath(debug.getinfo(2, "S").source:sub(2):match("(.*/)")) .. "/englishwords.txt"
    	for line in io.lines(_dict) do
        	local _str = string.gsub(line, "\t", '')
        	if string.len(_str) == 5 then
            		hashset[_str] = true
        	end
    	end
    	return hashset
end
print(unpack(_main()), os.clock() - _c)
