Config = {}

Config.Locale = "en"

Config.RequiredItems = {
  {
    name = "lockpick", -- Item required to rob the vending machines
    quantity = 1
  }
}

Config.RemoveItems = {
  {
    name = "lockpick", -- Item that will be removed when stolen
    quantity = 1
  }
}

Config.Rewards = {
  {
    name = "soda", -- Choices are money, bank, black_money or an item name
    amount = math.random(1, 3) -- The random amount you take per cycle (MaxTake is how many times it cycles max)
  }
}

Config.Dependencies = {
  {
    FivemTarget = true -- Set to 'true' if you are using fivem-target
  },
  {
    Qtarget = false -- Set to 'true' if you are using Qtarget
  },
  {
    MythicNotify = false -- Set to 'true' if you are using mythic_notify
  },
  {
    MFinventory = false -- Set to 'true' if you are using MF-Inventory
  },
  {
    CDKeymaster = false, -- Set to 'true' if you are using cd_keymaster
    RobbingTime = 10000, -- This is how long it takes to wait to "rob" the machine in ms, only used if CDKeymaster is false
    CustomSettings = {
      settings = {
        handleEnd = true, --Send a result message if true and callback when message closed or callback immediately without showing the message
        speed = 10,
        scoreWin = 1000,
        scoreLose = -150,
        maxTime = 60000,
        maxMistake = 5,
        speedIncrement = 1
      },
      keys = {"a", "w", "d", "s", "g"}
    }
  }
}

Config.Options = {
  {
    CanRob = false, -- set to 'true' if you want to enable robbing vending machine's
    PoliceRequired = 1, -- Amount of Police required to hack a vending machine
    BlipTimer = 45, -- Blip timer  until removed in seconds
    PhoneModel = -1038739674, -- The Phone model prop when hacking
    CooldownTime = 300, -- Cooldown in Seconds before someone can rob a vending machine
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
    prop = "prop_vend_coffe_01",
    items = {
      {
        name = "coffee",
        label = "Coffee",
        price = 5
      },
      {
        name = "water",
        label = "Water Bottle",
        price = 5
      }
    }
  },
  {
    prop = "prop_vend_condom_01",
    items = {
      {
        name = "soda",
        label = "Soda",
        price = 5
      }
    }
  },
  {
    prop = "prop_vend_fags_01",
    items = {
      {
        name = "soda",
        label = "Soda",
        price = 5
      }
    }
  },
  {
    prop = "prop_vend_fridge01",
    items = {
      {
        name = "soda",
        label = "Soda",
        price = 5
      }
    }
  },
  {
    prop = "prop_vend_snak_01",
    items = {
      {
        name = "soda",
        label = "Soda",
        price = 5
      }
    }
  },
  {
    prop = "prop_vend_soda_02",
    items = {
      {
        name = "soda",
        label = "Soda",
        price = 5
      }
    }
  },
  {
    prop = "prop_vend_water_01",
    items = {
      {
        name = "soda",
        label = "Soda",
        price = 5
      }
    }
  },
  {
    prop = "prop_vend_snak_01_tu",
    items = {
      {
        name = "soda",
        label = "Soda",
        price = 5
      }
    }
  },
  {
    prop = "v_68_broeknvend",
    items = {
      {
        name = "soda",
        label = "Soda",
        price = 5
      }
    }
  },
  {
    prop = "prop_vend_soda_01",
    items = {
      {
        name = "soda",
        label = "Soda",
        price = 5
      }
    }
  },
  {
    prop = "ch_chint10_vending_smallroom_01",
    items = {
      {
        name = "soda",
        label = "Soda",
        price = 5
      }
    }
  }
}

--[[
    FOR USE WITH MF INVENTORY - ADD THE TABLES BELLOW TO YOUR CONFIG.SHOPS IN MF INVENTORY
    ADD ITEMS IN THIS PART
    -----------------------
    NOTE: IF USING THESE, DO NOT CHANGE THE CONFIG.VendingMachineModels TABLE
    -------------------------

  {
      identifier = "vending-machine |prop_vend_coffe_01",        -- Must be unique
      type = "shop",                        -- Must be "shop"
      label = "shop",                       -- Label for translation in NUI
      maxSlots = 25,                        -- Max slots, somewhat irrelevant. Ensure its atleast equal to the number of items for sale
      saveShop = false,                      -- Should this shop save to the database? Only relevant if you want persistent stock levels.
      buyAccounts = {                       -- Accounts that you can buy items with 
        'money'
      },
      items = {
        {
          name = "coffee",
          label = "Cup Of Coffee",
          price = 5,
          buyPrice = 0,
          weight = 1.0,
        },
        {
          name = "water",
          label = "Water Bottle",
          price = 5,
          buyPrice = 0,
          weight = 1.0,
        },
      }
    },
    {
      identifier = "vending-machine |prop_vend_condom_01",        -- Must be unique
      type = "shop",                        -- Must be "shop"
      label = "shop",                       -- Label for translation in NUI
      maxSlots = 25,                        -- Max slots, somewhat irrelevant. Ensure its atleast equal to the number of items for sale
      saveShop = false,                      -- Should this shop save to the database? Only relevant if you want persistent stock levels.
      buyAccounts = {                       -- Accounts that you can buy items with 
        'money'
      },
      items = {
        {
          name = "water",
          label = "Water Bottle",
          price = 5,
          buyPrice = 0,
          weight = 1.0,
        },
      }
    },
    {
      identifier = "vending-machine |prop_vend_fags_01",        -- Must be unique
      type = "shop",                        -- Must be "shop"
      label = "shop",                       -- Label for translation in NUI
      maxSlots = 25,                        -- Max slots, somewhat irrelevant. Ensure its atleast equal to the number of items for sale
      saveShop = false,                      -- Should this shop save to the database? Only relevant if you want persistent stock levels.
      buyAccounts = {                       -- Accounts that you can buy items with 
        'money'
      },
      items = {
        {
          name = "water",
          label = "Water Bottle",
          price = 5,
          buyPrice = 0,
          weight = 1.0,
        },
      }
    },
    {
      identifier = "vending-machine |prop_vend_fridge01",        -- Must be unique
      type = "shop",                        -- Must be "shop"
      label = "shop",                       -- Label for translation in NUI
      maxSlots = 25,                        -- Max slots, somewhat irrelevant. Ensure its atleast equal to the number of items for sale
      saveShop = false,                      -- Should this shop save to the database? Only relevant if you want persistent stock levels.
      buyAccounts = {                       -- Accounts that you can buy items with 
        'money'
      },
      items = {
        {
          name = "water",
          label = "Water Bottle",
          price = 5,
          buyPrice = 0,
          weight = 1.0,
        },
      }
    },
    {
      identifier = "vending-machine |prop_vend_snak_01",        -- Must be unique
      type = "shop",                        -- Must be "shop"
      label = "shop",                       -- Label for translation in NUI
      maxSlots = 25,                        -- Max slots, somewhat irrelevant. Ensure its atleast equal to the number of items for sale
      saveShop = false,                      -- Should this shop save to the database? Only relevant if you want persistent stock levels.
      buyAccounts = {                       -- Accounts that you can buy items with 
        'money'
      },
      items = {
        {
          name = "water",
          label = "Water Bottle",
          price = 5,
          buyPrice = 0,
          weight = 1.0,
        },
      }
    },
    {
      identifier = "vending-machine |prop_vend_soda_02",        -- Must be unique
      type = "shop",                        -- Must be "shop"
      label = "shop",                       -- Label for translation in NUI
      maxSlots = 25,                        -- Max slots, somewhat irrelevant. Ensure its atleast equal to the number of items for sale
      saveShop = false,                      -- Should this shop save to the database? Only relevant if you want persistent stock levels.
      buyAccounts = {                       -- Accounts that you can buy items with 
        'money'
      },
      items = {
        {
          name = "water",
          label = "Water Bottle",
          price = 5,
          buyPrice = 0,
          weight = 1.0,
        },
      }
    },
    {
      identifier = "vending-machine |prop_vend_water_01",        -- Must be unique
      type = "shop",                        -- Must be "shop"
      label = "shop",                       -- Label for translation in NUI
      maxSlots = 25,                        -- Max slots, somewhat irrelevant. Ensure its atleast equal to the number of items for sale
      saveShop = false,                      -- Should this shop save to the database? Only relevant if you want persistent stock levels.
      buyAccounts = {                       -- Accounts that you can buy items with 
        'money'
      },
      items = {
        {
          name = "water",
          label = "Water Bottle",
          price = 5,
          buyPrice = 0,
          weight = 1.0,
        },
      }
    },
    {
      identifier = "vending-machine |prop_vend_snak_01_tu",        -- Must be unique
      type = "shop",                        -- Must be "shop"
      label = "shop",                       -- Label for translation in NUI
      maxSlots = 25,                        -- Max slots, somewhat irrelevant. Ensure its atleast equal to the number of items for sale
      saveShop = false,                      -- Should this shop save to the database? Only relevant if you want persistent stock levels.
      buyAccounts = {                       -- Accounts that you can buy items with 
        'money'
      },
      items = {
        {
          name = "water",
          label = "Water Bottle",
          price = 5,
          buyPrice = 0,
          weight = 1.0,
        },
      }
    },
    {
      identifier = "vending-machine |v_68_broeknvend",        -- Must be unique
      type = "shop",                        -- Must be "shop"
      label = "shop",                       -- Label for translation in NUI
      maxSlots = 25,                        -- Max slots, somewhat irrelevant. Ensure its atleast equal to the number of items for sale
      saveShop = false,                      -- Should this shop save to the database? Only relevant if you want persistent stock levels.
      buyAccounts = {                       -- Accounts that you can buy items with 
        'money'
      },
      items = {
        {
          name = "water",
          label = "Water Bottle",
          price = 5,
          buyPrice = 0,
          weight = 1.0,
        },
      }
    },
    {
      identifier = "vending-machine |prop_vend_soda_01",        -- Must be unique
      type = "shop",                        -- Must be "shop"
      label = "shop",                       -- Label for translation in NUI
      maxSlots = 25,                        -- Max slots, somewhat irrelevant. Ensure its atleast equal to the number of items for sale
      saveShop = false,                      -- Should this shop save to the database? Only relevant if you want persistent stock levels.
      buyAccounts = {                       -- Accounts that you can buy items with 
        'money'
      },
      items = {
        {
          name = "water",
          label = "Water Bottle",
          price = 5,
          buyPrice = 0,
          weight = 1.0,
        },
      }
    },
    {
      identifier = "vending-machine |ch_chint10_vending_smallroom_01",        -- Must be unique
      type = "shop",                        -- Must be "shop"
      label = "shop",                       -- Label for translation in NUI
      maxSlots = 25,                        -- Max slots, somewhat irrelevant. Ensure its atleast equal to the number of items for sale
      saveShop = false,                      -- Should this shop save to the database? Only relevant if you want persistent stock levels.
      buyAccounts = {                       -- Accounts that you can buy items with 
        'money'
      },
      items = {
        {
          name = "water",
          label = "Water Bottle",
          price = 5,
          buyPrice = 0,
          weight = 1.0,
        },
      }
    },
--]]

GetDependency = function(Dependency)
  for k, v in pairs(Config.Dependencies) do
    if v[Dependency] then
      return v[Dependency]
    end
  end
end

GetOptions = function(Option)
  for k, v in pairs(Config.Options) do
    if v[Option] then
      return v[Option]
    end
  end
end
