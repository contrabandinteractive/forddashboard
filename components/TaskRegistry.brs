sub init()
    m.top.functionName = "taskRun"
end sub

sub taskRun()
    registrySection = CreateObject("roRegistrySection", "IGname")
    if Type(m.top.write) <> "roAssociativeArray"
        print "TaskRegistry.brs. taskRun(). m.top.write expecting roAssociativeArray, found: "; Type(m.top.write)
    else
        value = FormatJson(m.top.write)
        if value = ""
            print "TaskRegistry.brs. taskRun(). FormatJson error"
        else
            if not registrySection.Write("config", value)
                print "TaskRegistry.brs. taskRun(). roRegistrySection Write error"
            else if not registrySection.Flush()
                print "TaskRegistry.brs. taskRun(). roRegistrySection Flush error"
            end if
        end if
    end if
end sub