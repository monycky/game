local composer = require( "composer" )
 
local scene = composer.newScene()

local dragGameLevelBg
local dragGameLevelTitle
local backToActivities
local goToDragGameLevel

local circleHolder
local circle

local hitTestObjects = {}
local dragShape = {}
local alert = {}


local correct = 0


local function goToDragGameLevel()
    composer.gotoScene("src.scenes.drag.dragGameLevel", {effect = "slideLeft", time = 500})
end
 

function hitTestObjects(obj1, obj2)
        local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
        local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
        local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
        local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax
        return (left or right) and (up or down)
end


function dragShape(e)
    if(e.phase == 'began') then
        lastX = e.x - e.target.x
        lastY = e.y - e.target.y
    elseif(e.phase == 'moved') then
        e.target.x = e.x - lastX
        e.target.y = e.y - lastY
    elseif(e.target.name == 'circle' and e.phase == 'ended' and hitTestObjects(e.target, circleHolder)) then
        e.target.x = 100
        e.target.y = 180
        e.target:removeEventListener('touch', dragShape)
        correct = correct + 1
        elseif(e.target.name == 'pentagon' and e.phase == 'ended' and hitTestObjects(e.target, pHolder)) then
        e.target.x = 400
        e.target.y = 150
        e.target:removeEventListener('touch', dragShape)
        correct = correct + 1
    end
    
    if(e.phase == 'ended' and correct == 1) then
       -- alert()
    end
end


function alert()
    alertView = display.newText( "end level/next level", display.contentCenterX, display.contentCenterY, native.systemFont, 20 )
    transition.from(alertView, {time = 200, alpha = 0.1})
end




-- create()
function scene:create( event )

    local sceneGroup = self.view

    dragGameLevelBg = display.newImageRect("src/scenes/images/background.png", 1050, 700)
    sceneGroup:insert(dragGameLevelBg)

    dragGameLevelTitle = display.newText("", 235, 90, "", 30)
    dragGameLevelTitle:setFillColor(255, 255, 255)
    sceneGroup:insert(dragGameLevelTitle)

    backToHomeButton = display.newImage('src/scenes/images/withe-arrow.png', 5, 50) -- OK
    sceneGroup:insert(backToHomeButton)
    backToHomeButton:addEventListener("tap", goToDragGameLevel)
 
 
    circleHolder = display.newImage("src/scenes/images/hexagonHolder.png", 100, 180)
    sceneGroup:insert(circleHolder)

    circle = display.newImage("src/scenes/images/hexagon.png", 400, 180)
    sceneGroup:insert(circle)

    circle.name = 'circle'


    circle:addEventListener('touch', dragShape)
   
end
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
    
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
--    backToActivities:removeEventListener("tap", goToActivities)
      sceneGroup:remove(pHolder)
    end
end
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    sceneGroup:remove(dragGameLevel)
    sceneGroup:remove(circleHolder)
    sceneGroup:remove(pHolder)

end
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene
