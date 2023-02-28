ITEM_OWNER <- null;
ITEM_WEAPON <- null;
ITEM_PREPL_M <- null;
ITEM_PL_MODEL <- "models/player/custom_player/cjzlmap/bcy05/bcy05.mdl";
self.PrecacheModel("models/player/custom_player/cjzlmap/bcy05/bcy05.mdl");

function OnPostSpawn(){SetModel();}

function PickUpItem()
{
    ITEM_OWNER = activator;
    ITEM_PREPL_M = activator.GetModelName();
    ITEM_WEAPON = caller;
}

function SetModel()
{
    if(TestOnValid(ITEM_OWNER, 3))
    {
        if(TestValidMoveParent(ITEM_WEAPON, ITEM_OWNER))
        {
            if(ITEM_OWNER.GetModelName() != ITEM_PL_MODEL){ITEM_OWNER.SetModel(ITEM_PL_MODEL);}
        }
        else
        {
            if(TestOnValid(ITEM_OWNER, 3))
            {
                ITEM_OWNER.SetModel(ITEM_PREPL_M);
                ITEM_OWNER = null;
                printl("ITEM WAS DROPPED");
            }
        }
    }
    EntFireByHandle(self, "RunScriptCode", "SetModel();", FrameTime(), null, null);
}

function TestOnValid(handle, team)
{
    if(handle != null && handle.IsValid() && handle.GetTeam() == team && handle.GetHealth() > 0){return true;}
    return false;
}

function TestValidMoveParent(handle_move, owner)
{
    try
    {
        if(handle_move.GetMoveParent() != null && handle_move.GetMoveParent() == owner){return true;}
        else{return false;}
    }
    catch(error){return false;}
}
