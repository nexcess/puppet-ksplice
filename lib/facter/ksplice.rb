if File.exist?('/usr/bin/uptrack-uname')
  Facter.add(:ksplice_kernelrelease) do
    setcode do
      Facter::Util::Resolution.exec('/usr/bin/uptrack-uname -r 2>/dev/null')
    end
  end

  Facter.add(:ksplice_kernelversion) do
    setcode do
      Facter.value(:ksplice_kernelrelease).split('-')[0]
    end
  end

  Facter.add(:ksplice_kernelmajversion) do
    setcode do
      Facter.value(:ksplice_kernelversion).split('.')[0..1].join('.')
    end
  end

  Facter.add(:ksplice_kernel_package_version) do
    setcode do
      Facter::Util::Resolution.exec('/usr/bin/uptrack-uname --package-version 2>/dev/null').split[2]
    end
  end
end
