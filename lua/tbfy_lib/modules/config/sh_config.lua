
TBFY_LIB.DataTypes = {
    ["bool"] = {
        send = function(value)
            net.WriteBool(value)
        end,
        receive = function()
            return net.ReadBool()
        end
    },
    ["number"] = {
        send = function(value)
            net.WriteUInt(value, 16)
        end,
        receive = function()
            return net.ReadUInt(16)
        end
    },
    ["string"] = {
        send = function(value)
            net.WriteString(value)
        end,
        receive = function()
            return net.ReadString()
        end
    },
    ["table"] = {
        send = function(values)
            net.WriteUInt(table.Count(values), 8)
            for k,v in pairs(values) do
                net.WriteUInt(k, 12)
            end
        end,
        receive = function()
            local amount = net.ReadUInt(8)
            local newTable = {}
            for i = 1, amount do
                newTable[net.ReadUInt(12)] = true
            end
            return newTable
        end
    }
}
TBFY_LIB.DataTypes["options"] = TBFY_LIB.DataTypes["string"]
TBFY_LIB.DataTypes["jobs"] = TBFY_LIB.DataTypes["table"]