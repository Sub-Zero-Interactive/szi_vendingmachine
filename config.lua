Config = {}

Config.Locale = 'en'

Config.RequiredItems = {
    {
        name = 'lockpick', -- Item required to rob the vending machines
        quantity = 1
    }
}


Config.RemoveItems = {
    -- {
    --     name = 'lockpick' -- Uncomment these 3 lines to remove the item after robbing the vending machine
    -- }--,
}

Config.Rewards = {
    {
        name = 'soda', -- Choices are money, bank, black_money or an item name
        amount = math.random(1, 10), -- The random amount you take per cycle (MaxTake is how many times it cycles max)
        price = 5,
    }
}

Config.VendingMachineModels = {
    {
        prop = 'prop_vend_coffe_01'
    },
	{
        prop = 'prop_vend_condom_01'
    },
	{
        prop = 'prop_vend_fags_01'
    },
	{
        prop = 'prop_vend_fridge01'
    },
	{
        prop = 'prop_vend_snak_01'
    },
	{
        prop = 'prop_vend_soda_02'
    },
	{
        prop = 'prop_vend_water_01'
    },
	{
        prop = 'prop_vend_snak_01_tu'
    },
	{
        prop = 'v_68_broeknvend'
    },
	{
        prop = 'prop_vend_soda_01'
    },
	{
        prop = 'ch_chint10_vending_smallroom_01'
    }
}

Config.FivemTarget = true -- set to 'true' if you are using fivem-target or 'false' for bt-target

Config.PoliceRequired = 1 -- Amount of Police required to rob a vending machine
Config.CooldownTime =  300 -- Cooldown in Seconds before someone can rob a vending machine

Config.MaxChance = 100 -- Max number the chance can go up to (default 100)
Config.Chance =  15 -- The % Chance of notifying police when a robbery is started (25 = 25%)
Config.MinChance =  1 -- Minimum number the chance can be (Keep at 1 unless you know what you are doing)

Config.BlipTimer = 45 -- Blip timer  until removed in seconds

Config.MaxTake = 3 -- The amount of times the "Cycle" can happen (links with reward ammount)
Config.RobTime = 10 -- How long it takes to rob the vending machine per cycle in seconds

Config.RobbingDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@' 
Config.RobbingAnim = 'machinic_loop_mechandplayer'

Config.VendingDict = 'amb@medic@standing@kneel@base'
Config.VendingAnim = 'base'