-- SGDN Nameserver
-- version: 1
-- This is a basic, canonical implementation
-- of version 1 of the server side of the SGDN protocol

-- Hostname for rednet, not too important
local hostname = "yourhostname"
-- An array of the gates to be served. An example gate is given.
local gates = {
    {
        group = "example",    --The name of the group (think .com)
        identifier = "example", -- An identifier for the gate (think www.google)
        name = "Your gate's name",
        address = {1,2,3,4,5,6,7,8,0},
        extensions = {
            -- The position of the gate. Comment out to ignore
            {
                name = "position",
                data = {100, 64, -100}
            },
            -- The dimension of the gate. Comment out to ignore
            {
                name = "dimension",
                data = "minecraft:overworld"
            },
            -- A short identifier for the gate for use by CLIs. Highly recommended
            {
                name = "short_identifier",
                data = "e"
            }
        }
    }
}

-- Register this server with rednet.lookup
-- so that others can find it via that method
rednet.host("SGDN", hostname)
-- Use peripheral.find to open all modems for rednet
peripheral.find("modem", rednet.open)

-- Logic for making a "pretty" output message
local requestsServed = 0

local function logQuery(id, message)
    requestsServed = requestsServed + 1
    term.setCursorPos(1,1)
    term.write("Served "..requestsServed.." requests")
end
term.setCursorPos(1,1)
term.write("Served 0 requests")

-- Main serving loop
while true do
    -- Wait for the next message on the SGDN protocol
    local id, message = rednet.receive("SGDN")
    -- If the message is on the right version and is serverbound
    if message and type("message") == "table" and message.direction == "server" then
        logQuery(id,message)    -- update output
        if message.version == 1 then
            -- Respond with a list of gates under this server
            rednet.send(id, {
                version = 1,
                direction = "client",
                gates = gates
            }, "SGDN")
        else
            --If the version isn't supported
            -- Respond with the server's version
            rednet.send(id, {
                version = 1,
                direction = "client"
            }, "SGDN")
        end
    end
end
