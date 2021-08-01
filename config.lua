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
    -- }
}

Config.Rewards = {
    {
        name = 'soda', -- Choices are money, bank, black_money or an item name
        amount = math.random(1, 3) -- The random amount you take per cycle (MaxTake is how many times it cycles max)
    }
}

Config.VendingItems = {
    {
        name = "soda",
        price = 5
    }
}

Config.Dependencies = {
    {
        FivemTarget = false -- Set to 'true' if you are using fivem-target or 'false' for bt-target
    },
    {
        MythicNotify = false -- Set to 'true' if you are using mythic_notify
    },
    {
        CDKeymaster = false, -- Set to 'true' if you are using cd_keymaster
        RobbingTime = 10000 -- This is how long it takes to wait to "rob" the machine in ms, only used if Mhacking is false
    }
}

Config.Options = {
    {
        PoliceRequired = 1, -- Amount of Police required to hack an ATM
        BlipTimer = 45, -- Blip timer  until removed in seconds
        PhoneModel = -1038739674, -- The Phone model prop when hacking
        CooldownTime = 300, -- Cooldown in Seconds before someone can rob an ATM
        MaxChance = 100, -- Max number the chance can go up to (default 100)
        Chance = 100, -- The % Chance of notifying police when a robbery is started (25 = 25%)
        MinChance = 1, -- Minimum number the chance can be (Keep at 1 unless you know what you are doing)
        RobTime = 10, -- How long it takes to rob the atm per cycle in seconds
        MaxTake = 3 -- The amount of times the "Cycle" can happen (links with reward ammount)
    }
}

Config.Animations = {
    {
        name = "Robbing",
        dictionary = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
        animation = "machinic_loop_mechandplayer"
    },
    {
        name = "Buying",
        dictionary = "amb@medic@standing@kneel@base",
        animation = "base"       
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

GetDependency = function(Dependency)
    for k,v in pairs(Config.Dependencies) do
        if v[Dependency] then
            return v[Dependency]
        end
    end
end

GetOptions = function(Option)
    for k,v in pairs(Config.Options) do
        if v[Option] then
            return v[Option]
        end
    end
end
