local term = require("term")
local event = require("event")

local windowX, windowY = 5, 5 -- Initial window position
local windowWidth, windowHeight = 20, 10 -- Window size
local dragging = false

-- Function to draw the window
function drawWindow()
    local myWindow = window.create(term.current(), windowX, windowY, windowWidth, windowHeight, true)
    myWindow.setBackgroundColor(colors.red)
    myWindow.clear()
    myWindow.setCursorPos(1, 1)
    myWindow.setTextColor(colors.white)
    myWindow.write("Testing my window!")
end

-- Function to handle mouse events
function handleMouseEvent(_, _, x, y, button, _)
    if button == 1 and x >= windowX and x <= windowX + windowWidth and y >= windowY and y <= windowY + windowHeight then
        dragging = true
        local prevX, prevY = x, y
        while dragging do
            local _, _, curX, curY = event.pull("touch")
            windowX = windowX + (curX - prevX)
            windowY = windowY + (curY - prevY)
            prevX, prevY = curX, curY
            term.clear()
            drawWindow()
        end
    end
end

-- Main function to run the example
function main()
    term.clear()
    drawWindow()
    while true do
        handleMouseEvent(event.pull())
    end
end

main()
