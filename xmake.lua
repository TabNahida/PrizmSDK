toolchain("sh3eb-elf-gcc")
    set_kind("standalone")

    local path = "/path/to/PrizmSDK"
    
    set_toolset("cc", "sh3eb-elf-gcc")
    set_toolset("cxx", "sh3eb-elf-gcc", "sh3eb-elf-g++")
    set_toolset("ld", "sh3eb-elf-ld")
    set_toolset("ar", "sh3eb-elf-ar")
    set_toolset("as", "sh3eb-elf-as")
    set_toolset("strip", "sh3eb-elf-strip")
    set_toolset("mkg3a", "mkg3a")

    set_sdkdir(path)
    set_bindir(path .. "/bin")
    
    on_load(function (toolchain)
        toolchain:add("cxflags", "-fno-exceptions", "-Os", "-Wall", "-ffunction-sections", "-fdata-sections")
        toolchain:add("includedirs", path .. "/include")
        toolchain:add("linkdirs", path .. "/lib")
        toolchain:add("ldflags", "-T" .. path .. "/toolchain/prizm.x", "-static", "-gc-sections")
    end)

toolchain_end()

add_syslinks("c")

target("example")
    set_kind("binary")
    
    set_toolchains("sh3eb-elf-gcc")

    add_files("src/*.cpp")
    add_includedirs("include")
    add_links("fxcg")

    after_build(function (target)
        local name = target:name()
        local targetdir = target:targetdir()
        if is_plat("windows") then
            os.exec("mkg3a -n\"basic:" .. name .. "\" " .. targetdir .."/" .. name .. ".exe")
        else
            os.exec("mkg3a -n\"basic:" .. name .. "\" " .. targetdir .."/" .. name)
        end
    end)

    on_clean(function (target)
        local targetdir = target:targetdir()
        os.rm("$(buildir)/**.obj")
        os.rm("$(buildir)/**.d")
        os.rm(targetdir .. "/*")
    end)
target_end()
