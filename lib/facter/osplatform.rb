Facter.add("osplatform") do
    setcode do
        os = Facter.value("osfamily")
        rel = Facter.value("operatingsystemrelease")
        maj = /^([0-9]+)(\.[0-9]+)+$/.match(rel)[1]
        case os
        when /RedHat/
            "el#{maj}"
        else
            "unknown"
        end
    end
end

