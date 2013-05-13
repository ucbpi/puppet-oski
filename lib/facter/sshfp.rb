Facter.add("ssh_dsa_fp") do
    confine :kernel => "Linux"
    fqdn=Facter.value("fqdn")
    setcode do
        fp = %x[ssh-keygen -f /etc/ssh/ssh_host_dsa_key.pub -r #{fqdn} | cut -d ' ' -f 6]
        if not fp 
            "unknown"
        else
            fp
        end 
    end
end

Facter.add(:ssh_rsa_fp) do
    confine :kernel => "Linux"
    setcode do
        fqdn=Facter.value("fqdn")
        fp = %x[ssh-keygen -f /etc/ssh/ssh_host_rsa_key.pub -r #{fqdn} | cut -d ' ' -f 6]
        if not fp
            "unknown"
        else
            fp
        end
    end
end
