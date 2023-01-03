_c = os.clock()
local parallel = require "parallel"
local mmap = require "mmap"

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
    local file = io.open(_dict, "r")
    local data = mmap.mmap(file:fileno(), 0, mmap.PROT_READ, mmap.MAP_SHARED)
    local threads = {}
    for i = 1, 3 do
        threads[i] = parallel.create(function()
            for line in data:gmatch("[^\r\n]+") do
                local _str = string.gsub(line, "\t", '')
                if string.len(_str) == 5 then
                    hashset[_str] = true
                end
            end
        end)
    end
    parallel.waitForAll(unpack(threads))
    data:close()
    file:close()
    return hashset
end

print(unpack(_main()), os.clock() - _c)
