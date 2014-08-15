
local config = {
    appModuleName             = "server",
    debug                     = true,

    MessageFormat             = "json",

    pushMessageChannelPattern = "channel.%s",
    sharedMemoryDictName      = "TestApp",

    redis = {
        host       = "127.0.0.1",
        port       = 6379,
        timeout    = 10 * 1000, -- 10 seconds
    },

    mysql = {
        host       = "127.0.0.1",
        port       = 3306,
        database   = "testdb",
        user       = "test",
        password   = "test",
        timeout    = 10 * 1000,
    },
}

return config
