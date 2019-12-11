
local function bin2hex(s)
    s=string.gsub(s,"(.)",function (x) return string.format("%02X ",string.byte(x)) end)
    return s
end
 
local h2b = {
    ["0"] = 0,
    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
    ["A"] = 10,
    ["B"] = 11,
    ["C"] = 12,
    ["D"] = 13,
    ["E"] = 14,
    ["F"] = 15
}
 
local function hex2bin( hexstr )
    local s = string.gsub(hexstr, "(.)(.)%s", function ( h, l )
         return string.char(h2b[h]*16+h2b[l])
    end)
    return s
end

local sock = assert(ngx.req.socket(true))
local data = sock:peek(15)
if not data then 
    ngx.log(ngx.ERR,"payload null")
    return
end

ngx.log(ngx.ERR,"data is:",data,"len:",string.len(data),"xxx:",bin2hex(data))


t = string.byte(string.sub(data,8,8))
s = string.sub(data,13,15)
if  not ( s == "Log" and t==1) then 
     ngx.log(ngx.ERR,"payload 13-15:",string.sub(data,13,15))
     ngx.exit(404)
end

