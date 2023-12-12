local wibox = require("wibox")
local awful = require("awful")

local cpu_widget = wibox.widget.textbox()

local function update()
	awful.spawn.easy_async("sh -c 'top -bn1 | grep \"Cpu(s)\" | awk '{print $2+$4}' '", function(stdout)
        local cpu_usage = string.format("CPU: %.1f%%", tonumber(stdout))
        cpu_widget:set_text(cpu_usage)
    end)
end

--- initial update ---
update() 

--- continuous update ---
awful.widget.watch("sh -c 'top -bn1 | grep \"Cpu(s)\" | awk '{print $2+$4}' '", 5, function(widget, stdout)
    local cpu_usage = string.format("CPU: %.1f%%", tonumber(stdout))
    cpu_widget:set_text(cpu_usage)
end)

return cpu_widget
