#Custom facts to calculate shmall, hugepages and shmmax 
#gets the page size 
Facter.add(:page_size) do
    setcode do
        Facter::Core::Execution.execute('getconf PAGE_SIZE')
    end
end
#Gets the total memory in kb 
Facter.add(:mem_size) do
    setcode do
        Facter::Core::Execution.execute('grep MemTotal /proc/meminfo |  awk \'{print $2}\' ')
    end
end
#calculates hugepages, uses script from https://oracle-base.com/articles/linux/configuring-huge-pages-for-oracle-on-linux-64
#depends on bc and other oracle packages to work
Facter.add(:hugepages) do
    setcode do
        if File.exist? '/opt/service/scripts/hugepages.sh'
            Facter::Core::Execution.execute('/opt/service/scripts/hugepages.sh | awk \'{print $5}\' ')
        else 
            Facter::Core::Execution.execute('echo -1')
        end
    end
end