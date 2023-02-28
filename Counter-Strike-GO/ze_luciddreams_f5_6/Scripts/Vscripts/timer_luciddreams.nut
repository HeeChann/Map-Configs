GAME_TEXT_ENT <- null;
GAME_TEXT_CHANNEL <- 2;

Time <- 0.00;
Save_Time <- 0.00;
TimerTick <- true;
TimerText <- "|";
TimerText2 <- "seconds left |";

function OnPostSpawn() 
{
    GAME_TEXT_ENT = Entities.CreateByClassname("game_text");
    GAME_TEXT_ENT.__KeyValueFromString("targetname", "shop_control_gtext");
    GAME_TEXT_ENT.__KeyValueFromInt("channel", GAME_TEXT_CHANNEL);
    GAME_TEXT_ENT.__KeyValueFromVector("color", Vector(255, 255, 255));
    GAME_TEXT_ENT.__KeyValueFromFloat("y", 0.50);
    GAME_TEXT_ENT.__KeyValueFromFloat("x", -1.00);
    GAME_TEXT_ENT.__KeyValueFromInt("effect", 0);
    GAME_TEXT_ENT.__KeyValueFromInt("spawnflags", 1);
    GAME_TEXT_ENT.__KeyValueFromInt("fadein", 0);
    GAME_TEXT_ENT.__KeyValueFromInt("fadeout", 1);
    GAME_TEXT_ENT.__KeyValueFromInt("fxtime", 0);
    GAME_TEXT_ENT.__KeyValueFromFloat("holdtime", 1.00);
}

function TimerMap(time_n, x, y, r, g, b)
{
    if(GAME_TEXT_ENT == null || GAME_TEXT_ENT != null && !GAME_TEXT_ENT.IsValid())return;
    GAME_TEXT_ENT.__KeyValueFromFloat("holdtime", 1.00);
    TimerTick = true;
    Time = time_n;
    Save_Time = time_n;
    if(Time > 0.00){Time++;}
    StartTextHud();
    SetTextPos(x, y);
    SetTextColor(r, g, b);
}

function StopTimer(){TimerTick = false;}

function ResetTimer(){Time = Save_Time;}

function AddTime(t){Time += t;}

function StartTimer(){TimerTick = true;StartTextHud();}

function SetTextPos(x, y)
{
    if(GAME_TEXT_ENT != null && GAME_TEXT_ENT.IsValid())
    {
        GAME_TEXT_ENT.__KeyValueFromFloat("x", x);
        GAME_TEXT_ENT.__KeyValueFromFloat("y", y);
    }
}

function SetTextColor(r, g, b)
{
    local color = Vector(r, g, b);
    if(GAME_TEXT_ENT != null && GAME_TEXT_ENT.IsValid())
    {
        GAME_TEXT_ENT.__KeyValueFromVector("color", color);
        GAME_TEXT_ENT.__KeyValueFromVector("color2", color);
    }
}

function StartTextHud()
{
    if(TimerTick)
    {
        Time--;
        if(GAME_TEXT_ENT != null && GAME_TEXT_ENT.IsValid())
        {
            GAME_TEXT_ENT.__KeyValueFromString("message", TimerText+" "+Time+" "+TimerText2);
            if(Time <= 0)
            {
                GAME_TEXT_ENT.__KeyValueFromString("message", TimerText+" 0 "+TimerText2);
                GAME_TEXT_ENT.__KeyValueFromInt("holdtime", 0);
                EntFireByHandle(GAME_TEXT_ENT, "Display", "", 0.00, null, null);
                return;
            }
            EntFireByHandle(GAME_TEXT_ENT, "Display", "", 0.00, null, null);
        }
        else{printl("NOT EXIST TEXT ENTITIES");return;}
        EntFireByHandle(self, "RunScriptCode", "StartTextHud();", 1.00, null, null);
    }
}

TEXT_ARR <- [
    [" \x04[CREDITS] \x01Stripper by\x03 HeeChan", 0],
];

function CreditMessage(text_c, delay)
{
    if(text_c > (TEXT_ARR.len() - 1) || text_c < 0)
    return;
    ScriptPrintMessageChatAllDelay(text_c, delay);
}

function ScriptPrintMessageChatAllDelay(message, delay)
{
    EntFireByHandle(self, "RunScriptCode", "PrintMessageN("+TEXT_ARR[message][1]+");", delay, null, null);
}

function PrintMessageN(text)
{
    ScriptPrintMessageChatAll(""+TEXT_ARR[text][0]);
}
