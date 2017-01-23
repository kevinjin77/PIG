%Kevin Jin Random Program - The Game of PIG. Submitted May 29th, 2015.
%-----------------------------------------------------------------------------------------------------------
% Variable Declaration
%-----------------------------------------------------------------------------------------------------------
const pig_sound : string := "music/pig.wav"
var font1, font2, font3 : int
font1 := Font.New ("Palatino Linotype:16")
font2 := Font.New ("Monotype Corsiva:36")
font3 := Font.New ("Palatino Linotype:24:bold")
var roll, cpurolls : int := 0
var counter : int := 0
var players : int := 0
var name1, name2 : string
var cpuName : int
var score1, score2 : int := 0
var temp1, temp2 : int := 0
var pointsto : int := 0
var win1, win2 : boolean := false
var x, y, button : int
var pass, pig, firstroll, rules, finish, custom : boolean := false
var againID, playerID, titleID, name1ID, name2ID, pigID, instructionsID, modeID, pointstoID, winID, endID : int
againID := Pic.FileNew ("pictures/again.bmp")
titleID := Pic.FileNew ("pictures/titlescreen.bmp")
playerID := Pic.FileNew ("pictures/playerselect.bmp")
name1ID := Pic.FileNew ("pictures/nameselect1.bmp")
name2ID := Pic.FileNew ("pictures/nameselect2.bmp")
pigID := Pic.FileNew ("pictures/pig.bmp")
instructionsID := Pic.FileNew ("pictures/instructions.bmp")
modeID := Pic.FileNew ("pictures/gamemode.bmp")
pointstoID := Pic.FileNew ("pictures/pointsto.bmp")
winID := Pic.FileNew ("pictures/winner.bmp")
endID := Pic.FileNew ("pictures/end.bmp")
%-----------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------
% Music Player
%-----------------------------------------------------------------------------------------------------------
process PlaySound (file : string)
    Music.PlayFile (file)
end PlaySound
%-----------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------
% Title Screen
%-----------------------------------------------------------------------------------------------------------
proc titlescreen
    rules := false
    Pic.DrawSpecial (titleID, 0, 0, picCopy, picFadeIn, 500)
    loop
	mousewhere (x, y, button)
	if button = 1 and x > 278 and x < 356 and y > 133 and y < 188 then
	    exit
	elsif button = 1 and x > 216 and x < 414 and y > 63 and y < 120 then
	    rules := true
	    exit
	end if
    end loop
end titlescreen
%-----------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------
% Instructions
%-----------------------------------------------------------------------------------------------------------
proc instructions
    Pic.DrawSpecial (instructionsID, 0, 0, picCopy, picGrowCentreToEdgeNoBar, 500)
    loop
	mousewhere (x, y, button)
	if button = 1 and x > 548 and x < 620 and y > 9 and y < 50 then
	    exit
	end if
    end loop
end instructions
%-----------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------
% Single Player or Multiplayer?
%-----------------------------------------------------------------------------------------------------------
proc playerselect
    Pic.DrawSpecial (playerID, 0, 0, picCopy, picSlideRightToLeftNoBar, 500)
    loop
	mousewhere (x, y, button)
	if button = 1 and x > 117 and x < 275 and y > 162 and y < 246 then
	    players := 1
	    exit
	elsif button = 1 and x > 340 and x < 513 and y > 162 and y < 246 then
	    players := 2
	    exit
	end if
    end loop
end playerselect
%-----------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------
% Getting Names / Assigning Random Name to CPU
%-----------------------------------------------------------------------------------------------------------
proc nameselect
    if players = 1 then
	Pic.DrawSpecial (name1ID, 0, 0, picCopy, picSlideBottomToTopNoBar, 500)
	Text.LocateXY (300, 150)
	get name1
	randint (cpuName, 1, 5)
	if cpuName = 1 then
	    name2 := "John"
	elsif cpuName = 2 then
	    name2 := "Sarah"
	elsif cpuName = 3 then
	    name2 := "Michael"
	elsif cpuName = 4 then
	    name2 := "Pauline"
	else
	    name2 := "Max"
	end if
    elsif players = 2 then
	Pic.DrawSpecial (name2ID, 0, 0, picCopy, picSlideBottomToTopNoBar, 500)
	Text.LocateXY (150, 150)
	get name1 :*
	Text.LocateXY (430, 150)
	get name2 :*
    end if
    cls
    var width := Font.Width (name2 + ": 100 pts", font1)
end nameselect
%-----------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------
% Quick, Classic, or Custom Game Modes
%-----------------------------------------------------------------------------------------------------------
proc gamemode
    custom := false
    Pic.DrawSpecial (modeID, 0, 0, picCopy, picGrowUpperLeftToLowerRightNoBar, 500)
    loop
	mousewhere (x, y, button)
	if button = 1 and x > 40 and x < 226 and y > 143 and y < 268 then
	    pointsto := 50
	    exit
	elsif button = 1 and x > 246 and x < 413 and y > 151 and y < 261 then
	    pointsto := 100
	    exit
	elsif button = 1 and x > 430 and x < 618 and y > 129 and y < 280 then
	    custom := true
	    exit
	end if
    end loop
end gamemode
%-----------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------
% Player 1 Rolling Dice
%-----------------------------------------------------------------------------------------------------------
proc rolldice1
    var width := Font.Width (name2 + ": 100 pts", font1)
    for i : 1 .. 10
	randint (roll, 1, 6)
	Pic.ScreenLoad ("pictures/dice" + intstr (roll) + ".bmp", 20, 165, picCopy)
	View.Update
	delay (50)
	cls
    end for
	Pic.ScreenLoad ("pictures/dice" + intstr (roll) + ".bmp", 20, 165, picCopy)
    if roll = 1 then
	pig := true
	score1 := temp1
	Font.Draw (name1 + ": " + intstr (score1) + " pts", 10, 15, font1, black)
	Font.Draw (name2 + ": " + intstr (score2) + " pts", maxx - width, maxy - 30, font1, black)
    end if
    if pig = false then
	score1 += roll
	if score1 >= pointsto then
	    win1 := true
	end if
	Font.Draw (name1 + ": " + intstr (score1) + " pts", 10, 15, font1, black)
	Font.Draw (name2 + ": " + intstr (score2) + " pts", maxx - width, maxy - 30, font1, black)
	Pic.DrawSpecial (againID, 200, 173, picCopy, picFadeIn, 500)
    end if
end rolldice1
%-----------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------
% Player 2 Rolling Dice
%-----------------------------------------------------------------------------------------------------------
proc rolldice2
    var width := Font.Width (name2 + ": 100 pts", font1)
    for i : 1 .. 10
	randint (roll, 1, 6)
	Pic.ScreenLoad ("pictures/dice" + intstr (roll) + ".bmp", maxx - 125, 165, picCopy)
	View.Update
	delay (50)
	cls
    end for
	Pic.ScreenLoad ("pictures/dice" + intstr (roll) + ".bmp", maxx - 125, 165, picCopy)
    if roll = 1 then
	pig := true
	score1 := temp1
	Font.Draw (name1 + ": " + intstr (score1) + " pts", 10, 15, font1, black)
	Font.Draw (name2 + ": " + intstr (score2) + " pts", maxx - width, maxy - 30, font1, black)
    end if
    if pig = false then
	score2 += roll
	if score2 >= pointsto then
	    win2 := true
	end if
	Font.Draw (name1 + ": " + intstr (score1) + " pts", 10, 15, font1, black)
	Font.Draw (name2 + ": " + intstr (score2) + " pts", maxx - width, maxy - 30, font1, black)
	Pic.DrawSpecial (againID, 200, 173, picCopy, picFadeIn, 500)
    end if
end rolldice2
%-----------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------
% Transition from Player 1's turn --> Player 2's turn
%-----------------------------------------------------------------------------------------------------------
proc transition1
    var width := Font.Width (name2 + ": 100 pts", font1)
    cls
    Font.Draw (name1 + ": " + intstr (score1) + " pts", 10, 15, font1, black)
    Font.Draw (name2 + ": " + intstr (score2) + " pts", maxx - width, maxy - 30, font1, black)
    setscreen ("offscreenonly")
    for xvalue : 20 .. maxx - 125
	Pic.ScreenLoad ("pictures/dice" + intstr (roll) + ".bmp", xvalue, 165, picCopy)
	View.UpdateArea (0,0,maxx,maxy)
	delay (2)
    end for
	setscreen ("nooffscreenonly")
    if pig then
	fork PlaySound (pig_sound)
	Pic.DrawSpecial (pigID, 0, 0, picCopy, picFadeIn, 500)
	delay (500)
	temp1 := score1
    end if
    setscreen ("offscreenonly")
    for xvalue2 : -500 .. 300
	drawfillbox (0 + xvalue2, 0 + xvalue2, maxx + xvalue2 +500, maxy + xvalue2, white)
	Font.Draw (name2 + "'s Turn", 230 + xvalue2, 200 + xvalue2, font2, black)
	View.UpdateArea (0,0,maxx,maxy)
	delay (2)
    end for
	setscreen ("nooffscreenonly")
end transition1
%-----------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------
% Transition from Player 2's turn --> Player 1's turn
%-----------------------------------------------------------------------------------------------------------
proc transition2
    var width := Font.Width (name2 + ": 100 pts", font1)
    cls
    Font.Draw (name1 + ": " + intstr (score1) + " pts", 10, 15, font1, black)
    Font.Draw (name2 + ": " + intstr (score2) + " pts", maxx - width, maxy - 30, font1, black)
    setscreen ("offscreenonly")
    for decreasing xvalue : maxx - 125 .. 20
	Pic.ScreenLoad ("pictures/dice" + intstr (roll) + ".bmp", xvalue, 165, picCopy)
	View.Update
	delay (2)
    end for
	setscreen ("nooffscreenonly")
    if pig then
	fork PlaySound (pig_sound)
	Pic.DrawSpecial (pigID, 0, 0, picCopy, picFadeIn, 500)
	delay (500)
	temp2 := score2
    end if
    setscreen ("offscreenonly")
    for decreasing xvalue2 : 300 .. -500
	drawfillbox (0 + xvalue2, 0 + xvalue2, maxx + xvalue2, maxy + xvalue2, white)
	Font.Draw (name1 + "'s Turn", 230 + xvalue2, 200 + xvalue2, font2, black)
	delay (2)
	View.Update
    end for
	setscreen ("nooffscreenonly")
end transition2
%-----------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------
% Player 1's Turn
%-----------------------------------------------------------------------------------------------------------
proc player1
    if win1 = false and win2 = false then
	rolldice1
	if pig = false then
	    loop
		if pig = false then
		    mousewhere (x, y, button)
		    if button = 1 and x > 210 and x < 335 and y > 180 and y < 218 and pig = false then
			exit
		    elsif button = 1 and x > 356 and x < 422 and y > 180 and y < 218 and pig = false then
			pass := true
			exit
		    end if
		end if
	    end loop
	end if
    end if
end player1
%-----------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------
% Player 2's turn
%-----------------------------------------------------------------------------------------------------------
proc player2
    if win1 = false and win2 = false then
	rolldice2
	if pig = false then
	    loop
		if pig = false then
		    mousewhere (x, y, button)
		    if button = 1 and x > 210 and x < 335 and y > 180 and y < 218 and pig = false then
			exit
		    elsif button = 1 and x > 356 and x < 422 and y > 180 and y < 218 and pig = false then
			pass := true
			exit
		    end if
		end if
	    end loop
	end if
    end if
end player2
%-----------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------
% CPU's Turn
%-----------------------------------------------------------------------------------------------------------
proc CPU
    if win1 = false and win2 = false then
	rolldice2
    end if
end CPU
%-----------------------------------------------------------------------------------------------------------

%-----------------------------------------------------------------------------------------------------------
% Program Start
%-----------------------------------------------------------------------------------------------------------
var program : int
program := Window.Open ("graphics:639;399")

setscreen ("nobuttonbar")

loop
    titlescreen
    if rules then
	instructions
    end if
    playerselect
    nameselect
    gamemode
    if custom then
	Pic.DrawSpecial (pointstoID, 120, 120, picCopy, picFadeIn, 500)
	Text.LocateXY (280,170)
	get pointsto
    end if
%-----------------------------------------------------------------------------------------------------------
% Single Player Mode
%-----------------------------------------------------------------------------------------------------------
    if players = 1 then 
	loop
	    pass := false
	    pig := false
	    loop
		player1
		if win1 or win2 then
		    exit
		end if
		if pass then
		    temp1 := score1
		    transition1
		    exit
		end if
		if roll = 1 then
		    score1 := temp1
		    cls
		    transition1
		    exit
		end if
	    end loop
	    pass := false
	    pig := false
%-----------------------------------------------------------------------------------------------------------
% CPU AI
%-----------------------------------------------------------------------------------------------------------
	    if score2 > score1 then
		cpurolls := 4
	    else
		cpurolls := 6
	    end if
	    for i : 1 .. cpurolls
		CPU
		if win1 or win2 then
		    exit
		end if
		if roll = 1 then
		    score2 := temp2
		    cls
		    transition2
		    exit
		end if
		if score2 - temp2 >= 20 then
		    delay (300)
		    Pic.ScreenLoad ("pictures/holdcpu.bmp",200,173,picCopy)
		    delay (500)
		    transition2
		    temp2 := score2
		    exit
		end if
		if i not = cpurolls then
		    delay (300)
		    Pic.ScreenLoad ("pictures/againcpu.bmp",200,173,picCopy)
		    delay (500)
		else
		    delay (300)
		    Pic.ScreenLoad ("pictures/holdcpu.bmp",200,173,picCopy)
		    delay (500)
		    transition2
		    temp2 := score2
		end if
	    end for
		if win1 or win2 then
		exit
	    end if
	end loop
    end if
%-----------------------------------------------------------------------------------------------------------
% Multiplayer Mode
%-----------------------------------------------------------------------------------------------------------
    if players = 2 then
	loop
	    pass := false
	    pig := false
	    loop
		player1
		if win1 or win2 then
		    exit
		end if
		if pass then
		    temp1 := score1
		    transition1
		    exit
		end if
		if roll = 1 then
		    score1 := temp1
		    cls
		    transition1
		    exit
		end if
	    end loop
	    pass := false
	    pig := false
	    loop
		player2
		if win1 or win2 then
		    exit
		end if
		if pass then
		    temp2 := score2
		    transition2
		    exit
		end if
		if roll = 1 then
		    score2 := temp2
		    cls
		    transition2
		    exit
		end if
	    end loop
	    if win1 or win2 then
		exit
	    end if
	end loop
    end if
%-----------------------------------------------------------------------------------------------------------
% Winner Winner Chicken Dinner
%-----------------------------------------------------------------------------------------------------------
    Pic.DrawSpecial (winID, 0, 0, picCopy, picFadeIn, 1000)
    if win1 then
	var width1 := Font.Width (name1 + " wins!", font3) 
	Font.Draw (name1 + " wins!", round (maxx / 2 - width1 / 2), 320, font3, black) 
    elsif win2 then
	var width2 := Font.Width (name2 + " wins!", font3) 
	Font.Draw (name2 + " wins!", round (maxx / 2 - width2 / 2), 320, font3, black) 
    end if
    loop
	mousewhere (x, y, button)
	if button = 1 and x > 37 and x < 130 and y > 158 and y < 238 then
	    win1 := false
	    win2 := false
	    score1 := 0 
	    score2 := 0
	    temp1 := 0 
	    temp2 := 0
	    exit
	elsif button = 1 and x > 512 and x < 601 and y > 166 and y < 225 then
	    finish := true
	    exit
	end if
    end loop
    if finish then 
	exit 
    end if
end loop
%-----------------------------------------------------------------------------------------------------------
% Exit Program
%-----------------------------------------------------------------------------------------------------------
Window.Close (program)
