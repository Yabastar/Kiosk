local event = require("event")
local gpu = require("component").gpu

local windowX, windowY = 5, 5 -- Initial window position
local windowWidth, windowHeight = 20, 10 -- Window size
local dragging = false

-- Function to draw the window
function drawWindow()
    gpu.fill(windowX, windowY, windowWidth, windowHeight, " ") -- Clear the area of the window
    gpu.setBackground(0xFF0000) -- Red background
    gpu.setForeground(0xFFFFFF) -- White text color
    gpu.set(windowX, windowY, "Testing my window!")
end

-- Function to handle mouse events
function handleMouseEvent(_, _, x, y, button, _)
    if button == 0 and x >= windowX and x <= windowX + windowWidth and y >= windowY and y <= windowY + windowHeight then
        dragging = true
        local prevX, prevY = x, y
        while dragging do
            local _, _, curX, curY = event.pull("touch")
            windowX = windowX + (curX - prevX)
            windowY = windowY + (curY - prevY)
            prevX, prevY = curX, curY
            drawWindow()
        end
    end
end

-- Main function to run the example
function main()
    drawWindow()
    while true do
        handleMouseEvent(event.pull())
    end
end

main()
