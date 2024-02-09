Facter.add(:app) do
  setcode do
    if Facter.value(:hostname).include? "vtrustdb"
       'oracle'
    elsif Facter.value(:hostname).include? "vrepodb"
       'oracle'
    elsif Facter.value(:hostname).include? "app" 
       'tomcat'
    elsif Facter.value(:hostname).include? "vlog"
       'vlog'
    elsif Facter.value(:hostname).include? "vica"
       'vica'
    elsif Facter.value(:hostname).include? "vpca"
        'vpca'
    else 
       'eso'
    end
  end
end
