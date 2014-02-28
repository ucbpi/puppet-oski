idx = 1
Facter.value("hostname").split("-").each do |segment|
  Facter.add("hostname_s#{idx}") do
    setcode do
      segment
    end
  end
  idx += 1
end
