_c=os.clock()
function _parentpath(path)
	 pattern1 = "^(.+)//"
    pattern2 = "^(.+)\\"
    if (string.match(path,pattern1) == nil) then
        return string.match(path,pattern2)
    else
        return string.match(path,pattern1)
    end
end
function _read(file)
	local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end
function _strsplit(str,sep);
    if not sep then
        sep = "%s"
    end
    local t={}
    for _str in string.gmatch(str, "([^"..sep.."]+)") do
        table.insert(t, _str)
    end
    return t;
end
function _main()
	local _dict=_read(_parentpath(debug.getinfo(2, "S").source:sub(2):match("(.*/)")).."/englishwords.txt"
	_dict=_strsplit(_dict,[[
	]])
    local self={["_co0"]={{},false},["_co1"]={{},false}}
    local _co0=coroutine.create(function()
        for _,str in dict do
            if not string.len(str)>5 then table.insert(self["_co0"][1],str) end
        end
        self["_co0"][2]=true
    end)
    local _co1=coroutine.create(function()
        repeat c=os.clock() while os.clock()-c<.001 do end until self["_co0"][2]==true
        for _,str in self["_co0"][1] do
            if string.len(str)==5 then
                table.insert(self["_co1"][1],str)
            end
        end
        self["_co1"][2]=true
    end)
    coroutine.resume(_co0)coroutine.resume(_co1)
    repeat c=os.clock() while os.clock()-c<.001 do end until self["_co1"][2]==true
    return self["_co1"][1];
end
print(unpack(_main()), os.clock()-_c)